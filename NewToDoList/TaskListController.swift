//
//  ViewController.swift
//  NewToDoList
//
//  Created by Bobrovko Ilya on 07.12.2020.
//

import UIKit


protocol CheckBoxListener {
    func checkButtonTapped(cell: CustomViewCell)
}

protocol DeleteTaskListener {
    func deleteTask(index: IndexPath)
}

class TaskListController: UIViewController, CheckBoxListener, DeleteTaskListener {
    
// should be private
    private let dataManager = CoreDataManager()
    private let taskTableSource = TaskTableSource()
    
    @IBOutlet weak var tableView: UITableView!
    
    //private let tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = taskTableSource
        taskTableSource.delegate = self
        //print(dataManager.tasks.count)
        
        taskTableSource.setData(tasks: dataManager.fetchData())  // Первый вызов метода fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EditSegue" else { return }
        let navigationVC = segue.destination as! UINavigationController
        let detailVC = navigationVC.topViewController as! TaskDetailsController
                
        let cell = tableView.cellForRow(at: tableView.indexPathForSelectedRow!) as! CustomViewCell
        print(cell.titleLabel.text as Any)
        print(cell.taskID as Any)
        detailVC.preset(taskID: cell.taskID)

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
    
    func deleteTask(index: IndexPath) {
        let cell = tableView.cellForRow(at: index) as! CustomViewCell
        dataManager.deleteTask(id: cell.taskID)
    }

    func checkButtonTapped(cell: CustomViewCell) {
        print("log000000")
        let task = dataManager.getTask(id: cell.taskID)
        task?.isDone.toggle()
        dataManager.updateData()
        //print("check box on task with id:\(taskID) tapped")

        //let image = UIImage(systemName: task!.isDone ? "checkmark.circle.fill" : "circle")
        //cell.checkButton.setImage(image, for: .normal)
        tableView.reloadRows(at: [tableView.indexPath(for: cell)!], with: .fade)
    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dataManager.tasks.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomViewCell
//        cell.titleLabel.text = dataManager.tasks[indexPath.row].title
//        //
//        cell.detailsLabel.text = dataManager.tasks[indexPath.row].details
//        let image = UIImage(systemName: dataManager.tasks[indexPath.row].isDone ? "checkmark.circle.fill" : "circle")
//        cell.checkButton.setImage(image, for: .normal)
//        cell.tag = indexPath.row
//
//        cell.delegate = self
//        //print(dataManager.tasks[indexPath.row].isDone)
//        return cell
//    }
//
//    
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            //tableView.deleteRows(at: [indexPath], with: .middle)
//            dataManager.deleteObject(index: indexPath.row)
//            tableView.reloadData()
//        }
//    }

}

