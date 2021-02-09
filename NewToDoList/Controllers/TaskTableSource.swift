//
//  TasksDataSource.swift
//  NewToDoList
//
//  Created by Bobrovko Ilya on 16.12.2020.
//

import Foundation
import UIKit


class TaskTableSource : NSObject, UITableViewDataSource {
    
    private var tasks: [Task]!
    var delegate: DeleteTaskListener!
    var cellDelegate: CheckBoxListener!
    
    func setData(tasks: [Task]) {
        self.tasks = tasks
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! TaskViewCell
        cell.bind(task: tasks[indexPath.row])
        cell.delegate = cellDelegate
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            delegate.deleteTask(index: indexPath)
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
    }
}
