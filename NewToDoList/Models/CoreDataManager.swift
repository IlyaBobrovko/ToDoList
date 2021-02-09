//
//  CoreDataManager.swift
//  NewToDoList
//
//  Created by Bobrovko Ilya on 07.12.2020.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("save context error..")
            }
        }
    }

    func fetchData() -> [Task] {
        do {
            let sort = NSSortDescriptor(key: "title", ascending: true)
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
            fetchRequest.sortDescriptors = [sort]
            
            var data = try context.fetch(Task.fetchRequest()) as! [Task]
            data.sort{ $0.title! < $1.title! }
            return data
        } catch {
            print("fetch data error..")
            return []
        }
    }
    
    // remove this func
    func updateData() {
        saveContext()
    }
    
    func deleteTask(id: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let objects = try context.fetch(fetchRequest) as! [Task]
            if let object = objects.first {
                context.delete(object)
                saveContext()
            }
        } catch  {
            print("fetch data error..")
        }
    }
    
    func getTask(id: String) -> Task? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        
        do {
            let objects = try context.fetch(fetchRequest) as! [Task]
            if let object = objects.first {
                return object
            } else {
                return nil
            }
        } catch {
            print("fetch data error..")
            return nil
        }
    }
    
    func addTask(title: String?, details: String?) {
        let task = Task(entity: Task.entity(), insertInto: self.context)
        task.title = title
        task.details = details
        task.id = String(Int(NSDate().timeIntervalSince1970))
        saveContext()
    }

}
