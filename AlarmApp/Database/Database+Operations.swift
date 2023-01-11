//
//  Database+Operations.swift
//  AlarmApp
//
//  Created by Noura Mohammad Althrowi on 17/06/1444 AH.
//

import CoreData

extension DatabaseManager {
    // Task
    func createTask(taskModel: Task, alarmId: String) {
        let task = TaskObject(context: viewContext)
        task.title = taskModel.title
        task.isCompleted = taskModel.isCompleted
        task.alarmId = alarmId
        task.uniqueId = taskModel.uniqueId
        
        save()
    }
    
    func fetchAllTasks() -> [TaskObject] {
        let fetchRequest = TaskObject.fetchRequest()
        guard let tasks = try? viewContext.fetch(fetchRequest) else { return [] }
        return tasks
    }
    
    func deleteTask(uniqueId: String) {
        let fetchRequest = TaskObject.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(TaskObject.uniqueId), uniqueId)
//        fetchRequest.predicate = NSPredicate(format: "uniqueId == %@", uniqueId)
        
        guard let tasks = try? viewContext.fetch(fetchRequest), let myTask = tasks.first else { return }
        viewContext.delete(myTask)
        save()
    }
}
