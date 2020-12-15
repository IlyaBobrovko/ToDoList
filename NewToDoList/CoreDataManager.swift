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
    
//    private var Qcontext: NSManagedObjectContext = {
//        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    } ()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //var tasks = [Task]()
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("save context error..")
            }
        }
    }
    
//    func fetchData() {
//        do {
//            let data = try context.fetch(Task.fetchRequest())
//            tasks = data as! [Task]
//            tasks.sort{ $0.title! < $1.title! }
//        } catch {
//            print("fetch data error..")
//        }
//    }

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
    
    func deleteObject(index: Int) {
        context.delete(fetchData()[index])
        saveContext()
        //fetchData() //fix
    }
    
    func addObject(title: String?, details: String?) {
        let task = Task(entity: Task.entity(), insertInto: self.context)
        task.title = title
        task.details = details
        saveContext()
    }
}
