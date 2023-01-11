//
//  tasks.swift
//  AlarmApp
//
//  Created by Noura Mohammad Althrowi on 17/06/1444 AH.
//

import SwiftUI

class Task: Identifiable, ObservableObject {
    var uniqueId: String
    @Published var title: String
    @Published var isCompleted: Bool
    @Published var isFocused: Bool
    
    init(uniqueId: String = UUID().uuidString, title: String, isCompleted: Bool = false, isFocused: Bool = false) {
        self.title = title
        self.isCompleted = isCompleted
        self.isFocused = isFocused
        self.uniqueId = uniqueId
    }
    
    init(from task: TaskObject) {
        self.title = task.wrappedTitle
        self.isCompleted = task.isCompleted
        self.isFocused = false
        self.uniqueId = task.wrappedUniqueId
    }
}

struct TasksListScreen: View {
    let alarmId: String
    
    @State var tasks: [Task] = []
    
    @Environment(\.dismiss) private var dismiss
    var listUpdatePublisher = NotificationCenter.default.publisher(for: .init("UpdateTaskList"))
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(self.tasks) { task in
                        TaskCell(task: task, alarmId: alarmId)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.horizontal, .top])
            }
//            .onTapGesture {
//                tasks.append(Task(title: "", isFocused: true))
//            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        tasks.append(Task(title: "", isFocused: true))
                    } label: {
                        Image(systemName: "plus")
                    }
                    .foregroundColor(Color("text"))
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Color("text"))
                }
            }
            .background(Color("back"))
        }
        .onAppear {
            let dbTasks = DatabaseManager.shared.fetchAllTasks()
            self.tasks = dbTasks.map({ Task(from: $0) })
        }
        .onReceive(listUpdatePublisher) { _ in
            let dbTasks = DatabaseManager.shared.fetchAllTasks()
            self.tasks = dbTasks.map({ Task(from: $0) })
        }
    }
}

struct TaskCell: View {
    @ObservedObject var task: Task
    let alarmId: String
    
    @FocusState var showKeyboard: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "circle")
                .resizable()
                .frame(width: 20, height: 20)
            TextField("", text: $task.title)
                .focused($showKeyboard)
                .onSubmit {
                    DatabaseManager.shared.createTask(taskModel: task, alarmId: alarmId)
                }
                .frame(maxWidth: .infinity)
            
            Spacer(minLength: 0)
            
            Button {
                DatabaseManager.shared.deleteTask(uniqueId: task.uniqueId)
                NotificationCenter.default.post(name: .init("UpdateTaskList"), object: nil)
            } label: {
                Image(systemName: "trash")
            }
        }
        .foregroundColor(Color("text"))
        .onAppear {
            showKeyboard = task.isFocused
            task.isFocused = false
        }
    }
}
    
struct tasks_Previews: PreviewProvider {
    static var previews: some View {
        TasksListScreen(alarmId: "")
    }
}
