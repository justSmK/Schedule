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
    
    private let headerNameArray = [
        "DATE",
        "LESSON",
        "TASK",
        "COLOR"
    ]
    
    var cellNameArray = [
        "Date",
        "Lesson",
        "Task",
        ""
    ]
    
    var hexColorCell = "FFFFFF"
    
    var taskModel = TaskModel()
    var editModel: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Options Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(
            OptionsTableViewCell.self,
            forCellReuseIdentifier: idOptionsTasksCell
        )
        tableView.register(
            HeaderOptionsTableViewCell.self,
            forHeaderFooterViewReuseIdentifier: idOptionsTasksHeader
        )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonTapped)
        )
    }
    
    @objc private func saveButtonTapped() {
        
        if cellNameArray[0] == "Date" ||
            cellNameArray[1] == "Lesson" {
            alertOK(
                title: "Error",
                message: "Required fields: Date, Lesson"
            )
        } else if editModel == false {
            setModel()
            taskModel.taskColor = hexColorCell
            RealmManager.shared.saveTaskModel(model: taskModel)
            taskModel = TaskModel()
            
            cellNameArray = ["Date", "Lesson", "Task", ""]
            
            alertOK(title: "Success", message: nil)
            hexColorCell = "FFFFFF"
            tableView.reloadData()
        } else {
            RealmManager.shared.updateTaskModel(
                model: taskModel,
                nameArray: cellNameArray,
                hexColor: hexColorCell
            )
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setModel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.date(from: cellNameArray[0])
        
        taskModel.taskDate = dateString
        taskModel.taskName = cellNameArray[1]
        taskModel.taskDescription = cellNameArray[2]
        taskModel.taskColor = cellNameArray[3]
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
        let cell = tableView.dequeueReusableCell(
            withIdentifier: idOptionsTasksCell,
            for: indexPath) as! OptionsTableViewCell
        
        cell.cellTasksConfigure(
            nameArray: cellNameArray,
            indexPath: indexPath,
            hexColor: hexColorCell
        )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: idOptionsTasksHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(
            nameArray: headerNameArray,
            section: section
        )
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0: alertDate(label: cell.nameCellLabel) { (numberWeekday, date) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormatter.string(from: date)
            self.cellNameArray[0] = dateString
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Name Lesson", placeHolder: "Enter name lesson") {text in
            self.cellNameArray[1] = text
        }
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Name Task", placeHolder: "Enter name task") {text in
            self.cellNameArray[2] = text
        }
        case 3: pushControllers(vc: TasksColorsTableViewController())
        default: print("Tap OptionsTableView")
        }
    }
}

