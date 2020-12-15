//
//  ViewController.swift
//  NewToDoList
//
//  Created by Bobrovko Ilya on 07.12.2020.
//

import UIKit


protocol CustomCellListener {
    func checkButtonTapped(cell: CustomViewCell)
}

class ViewController: UIViewController, UITableViewDataSource, CustomCellListener {
    
// should be private
    private let dataManager = CoreDataManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    //private let tasks: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        print(dataManager.fetchData().count)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EditSegue" else { return }
        let navigationVC = segue.destination as! UINavigationController
        let detailVC = navigationVC.topViewController as! DetailViewController
        
        detailVC.preset(index: tableView.indexPathForSelectedRow!.row)

        //detailVC.title = "Editing"
        //detailVC.cellIndex = index.row
    }
    
    @IBAction func uwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "CancelSegue" else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    // найти нормальное решение для индекса
    func checkButtonTapped(cell: CustomViewCell) {
        dataManager.fetchData()[cell.tag].isDone = !dataManager.fetchData()[cell.tag].isDone
        print("CHECK \(dataManager.fetchData()[cell.tag].isDone) for cell \(cell.tag)")
        let image = UIImage(systemName: dataManager.fetchData()[cell.tag].isDone ? "checkmark.circle.fill" : "circle")
        cell.checkButton.setImage(image, for: .normal)
        dataManager.saveContext()
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.fetchData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomViewCell
        cell.titleLabel.text = dataManager.fetchData()[indexPath.row].title
        cell.detailsLabel.text = dataManager.fetchData()[indexPath.row].details
        let image = UIImage(systemName: dataManager.fetchData()[indexPath.row].isDone ? "checkmark.circle.fill" : "circle")
        cell.checkButton.setImage(image, for: .normal)
        cell.tag = indexPath.row
        
        cell.delegate = self
        //print(dataManager.tasks[indexPath.row].isDone)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //tableView.deleteRows(at: [indexPath], with: .middle)
            dataManager.deleteObject(index: indexPath.row)
            tableView.reloadData()
        }
    }

}

