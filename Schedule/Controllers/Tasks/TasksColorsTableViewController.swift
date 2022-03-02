//
//  TasksColorsTableViewController.swift
//  Schedule
//
//  Created by justSmK on 31.01.2022.
//

import UIKit

class TasksColorsTableViewController: UITableViewController {
    
    private let idTasksColorCell = "idTasksColorCell"
    private let idTasksScheduleHeader = "idTasksScheduleHeader"
    
    private let headerNameArray = [
        "RED",
        "ORANGE",
        "YELLOW",
        "GREEN",
        "BLUE",
        "INDIGO",
        "VIOLET"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Color Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(
            ColorsTableViewCell.self,
            forCellReuseIdentifier: idTasksColorCell
        )
        tableView.register(
            HeaderOptionsTableViewCell.self,
            forHeaderFooterViewReuseIdentifier: idTasksScheduleHeader
        )
    }
    
    private func setColor(color: String) {
        let taskOptions = self.navigationController?.viewControllers[1] as? TasksOptionsTableViewController
        taskOptions?.hexColorCell = color
        taskOptions?.tableView.reloadRows(at: [[3, 0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: idTasksColorCell,
            for: indexPath) as! ColorsTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: idTasksScheduleHeader) as! HeaderOptionsTableViewCell
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
        switch indexPath.section {
        case 0 : setColor(color: "FF2600")
        case 1 : setColor(color: "FF9300")
        case 2 : setColor(color: "FFFB00")
        case 3 : setColor(color: "00F900")
        case 4 : setColor(color: "0433FF")
        case 5 : setColor(color: "5E5CE6")
        case 6 : setColor(color: "942192")
        default:
            setColor(color: "FFFFFF")
        }
    }
    
}



