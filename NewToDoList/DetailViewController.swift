//
//  DetailViewController.swift
//  NewToDoList
//
//  Created by Bobrovko Ilya on 08.12.2020.
//
import UIKit

class DetailViewController: UITableViewController {
    
    private let dataManager = CoreDataManager()
    
    //var editingTask = Task()
    var cellIndex: Int!
    //var titleText: String?
    //var detailsText: String?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState(self)
        guard cellIndex != nil else { return }
        titleTextField.text = dataManager.fetchData()[cellIndex].title
        detailsTextField.text = dataManager.fetchData()[cellIndex].details
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SaveSegue"  else { return }
        let listVC = segue.destination as! ViewController
        if let index = cellIndex {
            print("index = \(index)")
            let task = dataManager.fetchData()[index]
            task.title = titleTextField.text
            task.details = detailsTextField.text
        } else {
            dataManager.addObject(title: titleTextField.text, details: detailsTextField.text)
        }
        dataManager.saveContext()
        //listVC.dataManager.fetchData()
        listVC.tableView.reloadData()
    }
    
    func preset(index: Int) {
        self.title = "Editing"
        cellIndex = index
    }
    @IBAction func updateSaveButtonState(_ sender: Any) {
        let titleIsEmpty = titleTextField.text?.isEmpty ?? true
        let detailsIsEmpty = detailsTextField.text?.isEmpty ?? true
        saveButton.isEnabled = !(titleIsEmpty || detailsIsEmpty)
    }
    
}
