//
//  DetailViewController.swift
//  NewToDoList
//
//  Created by Bobrovko Ilya on 08.12.2020.
//
import UIKit

class TaskDetailsController: UITableViewController {
    
    private let dataManager = CoreDataManager()
    
    var editingTask: Task?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextField: UITextField!
    

    @IBAction func updateSaveButtonState(_ sender: Any) {
        let titleIsEmpty = titleTextField.text?.isEmpty ?? true
        let detailsIsEmpty = detailsTextField.text?.isEmpty ?? true
        saveButton.isEnabled = !(titleIsEmpty || detailsIsEmpty)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        updateSaveButtonState(self)
        
        titleTextField.text = editingTask?.title
        detailsTextField.text = editingTask?.details
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SaveSegue"  else { return }
        let listVC = segue.destination as! TaskListController
        if let task = editingTask {
            task.title = titleTextField.text
            task.details = detailsTextField.text
            dataManager.saveContext()
        } else {
            dataManager.addTask(title: titleTextField.text, details: detailsTextField.text)
        }
        
        listVC.updateTable()
    }
    
    
    func presetTask(id: String) {
        self.title = "Editing"
        editingTask = dataManager.getTask(id: id)
    }
    
}
