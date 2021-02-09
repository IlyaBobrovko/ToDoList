//
//  ViewController.swift
//  NewToDoList
//
//  Created by Bobrovko Ilya on 07.12.2020.
//

import UIKit


class TaskListController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let dataManager = CoreDataManager()

    private var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        updateTable()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EditSegue" else { return }
        
        let navigationVC = segue.destination as! UINavigationController
        let detailsVC = navigationVC.topViewController as! TaskDetailsController
                
        let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! TaskViewCell
        detailsVC.presetTask(id: cell.taskID)
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "CancelSegue" else { return }
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func updateTable() {
        tasks = dataManager.fetchData()
        tableView.reloadData()
    }
    
}

//MARK: - TaskViewCellDelegate

extension TaskListController: TaskViewCellDelegate {
    
    func checkBoxTapped(cell: TaskViewCell) {
        let task = dataManager.getTask(id: cell.taskID)
        task?.isDone.toggle()
        dataManager.saveContext()
        tableView.reloadRows(at: [tableView.indexPath(for: cell)!], with: .fade)
    }
}


//MARK: - UITableViewDataSource

extension TaskListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! TaskViewCell
        cell.bind(task: tasks[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            let cell = tableView.cellForRow(at: indexPath) as! TaskViewCell
            dataManager.deleteTask(id: cell.taskID)
            tableView.deleteRows(at: [indexPath], with: .middle)
        }
    }
}
