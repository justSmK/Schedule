//
//  TasksOptionsTableViewController.swift
//  Schedule
//
//  Created by justSmK on 31.01.2022.
//

import UIKit

class TasksOptionsTableViewController: UITableViewController {
    
    private let idOptionsTasksCell = "idOptionsTasksCell"
    private let idOptionsTasksHeader = "idOptionsTasksHeader"
    
    private let headerNameArray = ["DATE",
                           "LESSON",
                           "TASK",
                           "COLOR"]
    
    private let cellNameArray = ["Date",
                         "Lesson",
                         "Task",
                         ""]
    
    var hexColorCell = "5E5CE6"
    
    private var taskModel = TaskModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Options Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsTasksCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsTasksHeader)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveButtonTapped))
    }
    
    @objc private func saveButtonTapped() {
        
        if taskModel.taskDate == nil || taskModel.taskName == "Unknown" {
            alertOK(title: "Error", message: "Required fields: Date, Lesson")
        } else {
            taskModel.taskColor = hexColorCell
            RealmManager.shared.saveTaskModel(model: taskModel)
            taskModel = TaskModel()
            alertOK(title: "Success", message: nil)
            hexColorCell = "5E5CE6"
            tableView.reloadData()
        }
    }
    
    private func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsTasksCell, for: indexPath) as! OptionsTableViewCell
        cell.cellTasksConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsTasksHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0: alertDate(label: cell.nameCellLabel) { (numberWeekday, date) in
            self.taskModel.taskDate = date
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Name Lesson", placeHolder: "Enter name lesson") {text in
            self.taskModel.taskName = text
        }
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Name Task", placeHolder: "Enter name task") {text in
            self.taskModel.taskDescription = text
        }
        case 3: pushControllers(vc: TasksColorsTableViewController())
        default: print("Tap OptionsTableView")
        }
    }
}

