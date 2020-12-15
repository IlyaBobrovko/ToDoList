//
//  Task+CoreDataProperties.swift
//  NewToDoList
//
//  Created by Bobrovko Ilya on 09.12.2020.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var details: String?
    @NSManaged public var title: String?
    @NSManaged public var isDone: Bool

}

extension Task : Identifiable {

}
