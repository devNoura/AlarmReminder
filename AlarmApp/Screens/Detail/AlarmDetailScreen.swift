//
//  AlarmDetailScreen.swift
//  AlarmApp
//
//  Created by Noura Mohammad Althrowi on 16/06/1444 AH.
//

import SwiftUI

enum Day: String, CaseIterable, Identifiable {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
    
    var id: String {
        self.rawValue
    }
    //app
    var title: String {
        switch self {
        case .sunday:
            return "Sun"
        case .monday:
            return "Mon"
        case .tuesday:
            return "Tue"
        case .wednesday:
            return "Wed"
        case .thursday:
            return "Thu"
        case .friday:
            return "Fri"
        case .saturday:
            return "Sat"
            
        }
    }
}

struct AlarmDetailScreen: View {
    
    @Binding var names: [Date]
    
    
    @State var selectedDate: Date = Date()
    @State var selectedDays: [Day] = []
    @State var showTaskList: Bool = false
    @State var isSnoozed: Bool = false
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 40) {
                    
                    datePicker
                    
                    daySelectionView
                    
                    VStack(spacing: 25) {
                        taskSection
                        
                        saperator
                        
                        snoozeSection
                        
                        saperator
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 30)
                .foregroundColor(Color("text"))
            }
            
            .navigationTitle("Add Alarm")
            .navigationBarTitleDisplayMode(.inline)
            
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    cancelButton
                    
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton
                }
            }
            .background(Color("back"))
            .foregroundColor(Color("text"))
            .sheet(isPresented: $showTaskList) {
                TasksListScreen(alarmId: "")
            }
        }
    }
    
    private var saperator: some View {
        Rectangle()
            .fill(Color("text"))
            .frame(height: 2)
    }
    
    private var snoozeSection: some View {
        Toggle("Snooze", isOn: $isSnoozed)
    }
    
    private var taskSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Tasks")
                .font(.system(size: 20, weight: .medium, design: .default))
            
            Button {
                showTaskList = true
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(.title2))
                    
                    Text("Manage Tasks")
                        .font(.system(size: 18, weight: .regular, design: .default))
                }
            }
        }
        .foregroundColor(Color("text"))
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var daySelectionView: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                ForEach(Day.allCases) { tappedDay in
                    Button(tappedDay.title) {
                        if selectedDays.contains(tappedDay) {
                            selectedDays.removeAll { dayFromArray in
                                tappedDay == dayFromArray
                            }
                        } else {
                            selectedDays.append(tappedDay)
                        }
                    }
                    .foregroundColor(Color("text"))
                    .frame(width: 50, height: 50, alignment: .center)
                    .background {
                        if selectedDays.contains(tappedDay) {
                            Circle()
                                .fill(Color("circle"))
                        }
                    }
                    .contentShape(Circle())
                }
            }
        }
    }
    
    private var datePicker: some View {
        VStack {
            Text("Choose Time")
                .font(.system(size: 20, weight: .medium, design: .default))
            
            
            DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                .labelsHidden()
                .datePickerStyle(.wheel)
                .preferredColorScheme(.light)
                .colorMultiply(Color("text"))
                .colorInvert()
            
            
            
        }
    }
    
    private var saveButton: some View {
        Button("Save") {
            names.append(selectedDate)
            let alermObject = AlarmObject(context: managedObjectContext)
            alermObject.date = selectedDate
//            alermObject.days = selectedDays
//            alermObject.task =
            
            DatabaseManager.shared.save()
            
            // handle tap save
        }
        .foregroundColor(Color("text"))
    }
    
    private var cancelButton: some View {
        Button("Cancel") {
            dismiss()
        }
        .foregroundColor(Color("text"))
    }
}

struct AlarmDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        AlarmDetailScreen(names: .constant([Date()]))
    }
}
