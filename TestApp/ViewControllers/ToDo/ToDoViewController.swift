//
//  ToDoViewController.swift
//  TestApp
//
//  Created by Mahmutović Edin on 25/10/2018.
//  Copyright © 2018 Adin Halilovic. All rights reserved.
//

import UIKit
import CoreData

protocol ToDoViewControllerDelegate {
    var onRefresh: () -> Void { get set }
}

class ToDoViewController: UIViewController {

    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var tasks: [TaskModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        commonInit()
        loadData()        
    }
    
    func commonInit() {
        tableView.register(UINib(nibName: "TaskCell", bundle: nil), forCellReuseIdentifier: "TaskCell")
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTable), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    func loadData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let tasksFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Tasks")
        tasks = []
        do {
            let result = try managedContext.fetch(tasksFetch) as! [Tasks]
            result.forEach{ task in
                tasks.append(TaskModel(title: task.title, description: task.task_desc, isDone: task.task_done))
            }
            tasks.reverse()
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @objc func reloadTable() {
        loadData()
        self.tableView.reloadData()
    }
    
    // MARK: Actions
    @IBAction func btnAddPressed(_ sender: Any) {
        
    }
}

// MARK: TableViewDelegate
extension ToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for:  indexPath) as! TaskCell
        
        cell.cellText.text = tasks[indexPath.row].title
        cell.setSelectedCircle(selected: tasks[indexPath.row].isDone)
        return cell
    }
    
    
}
