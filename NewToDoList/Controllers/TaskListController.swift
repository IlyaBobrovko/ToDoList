//
//  ViewController.swift
//  NewToDoList
//
//  Created by Bobrovko Ilya on 07.12.2020.
//

import UIKit


protocol CheckBoxListener {
    func checkButtonTapped(cell: TaskViewCell)
}

protocol DeleteTaskListener {
    func deleteTask(index: IndexPath)
}

class TaskListController: UIViewController, CheckBoxListener, DeleteTaskListener {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataManager = CoreDataManager()
    private let taskTableSource = TaskTableSource()
        

    //private let tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = taskTableSource
        taskTableSource.delegate = self
        taskTableSource.cellDelegate = self
        //print(dataManager.tasks.count)
        
        taskTableSource.setData(tasks: dataManager.fetchData())  // Первый вызов метода fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EditSegue" else { return }
        let navigationVC = segue.destination as! UINavigationController
        let detailsVC = navigationVC.topViewController as! TaskDetailsController
                
        let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! TaskViewCell
        print(cell.titleLabel.text as Any)
        print(cell.taskID as Any)
        detailsVC.preset(taskID: cell.taskID)

        //detailVC.title = "Editing"
        //detailVC.cellIndex = index.row
    }
    
    @IBAction func uwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "CancelSegue" else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func updateTable() {
        taskTableSource.setData(tasks: dataManager.fetchData())
        tableView.reloadData()
    }
    
    
    //MARK: - Delegate methods
    
    func deleteTask(index: IndexPath) {
        let cell = tableView.cellForRow(at: index) as! TaskViewCell
        dataManager.deleteTask(id: cell.taskID)
    }

    func checkButtonTapped(cell: TaskViewCell) {
        let task = dataManager.getTask(id: cell.taskID)
        task?.isDone.toggle()
        dataManager.updateData()
        tableView.reloadRows(at: [tableView.indexPath(for: cell)!], with: .fade)
    }
    
}

