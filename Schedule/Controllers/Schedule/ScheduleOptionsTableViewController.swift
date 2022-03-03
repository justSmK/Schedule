//
//  ScheduleOptionsTableViewController.swift
//  Schedule
//
//  Created by justSmK on 28.01.2022.
//

import UIKit

class ScheduleOptionsTableViewController: UITableViewController {
    
    private let idOptionsScheduleCell = "idOptionsScheduleCell"
    private let idOptionsScheduleHeader = "idOptionsScheduleHeader"
    
    private let headerNameArray = [
        "DATE AND TIME",
        "LESSON",
        "TEACHER",
        "COLOR",
        "PERIOD"
    ]
    
    var cellNameArray = [
        ["Date", "Time"],
        ["Name", "Type", "Building", "Audience"],
        ["Teacher Name"],
        [""],
        ["Repeate every week"]
    ]
    
    var scheduleModel = ScheduleModel()
    var editModel: Bool = false
    
    var hexColorCell = "ADB5BD"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.register(
            OptionsTableViewCell.self,
            forCellReuseIdentifier: idOptionsScheduleCell
        )
        tableView.register(
            HeaderOptionsTableViewCell.self,
            forHeaderFooterViewReuseIdentifier: idOptionsScheduleHeader
        )
        
        title = "Options Schedule"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonTapped)
        )
    }
    
    @objc private func saveButtonTapped() {
        
        if cellNameArray[0][0] == "Date" ||
            cellNameArray[0][1] == "Time" ||
            cellNameArray[1][0] == "Name" {
            alertOK(title: "Error", message: "Required fields: Date, Time, Name")
        } else if editModel == false {
            setModel()
            scheduleModel.scheduleColor = hexColorCell
            RealmManager.shared.saveScheduleModel(model: scheduleModel)
            scheduleModel = ScheduleModel()
            
            cellNameArray = [
                ["Date", "Time"],
                ["Name", "Type", "Building", "Audience"],
                ["Teacher Name"],
                [""],
                ["Repeate every week"]
            ]
            
            alertOK(title: "Success", message: nil)
            hexColorCell = "ADB5BD"
            cellNameArray[2][0] = "Teacher Name"
            tableView.reloadData()
        } else {
            RealmManager.shared.updateScheduleModel(
                model: scheduleModel,
                nameArray: cellNameArray,
                hexColor: hexColorCell,
                scheduleRepeat: scheduleModel.scheduleRepeat
            )
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setModel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.date(from: cellNameArray[0][0])
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.date(from: cellNameArray[0][1])
        
        scheduleModel.scheduleDate = dateString
        scheduleModel.scheduleTime = timeString
        scheduleModel.scheduleName = cellNameArray[1][0]
        scheduleModel.scheduleType = cellNameArray[1][1]
        scheduleModel.scheduleBuilding = cellNameArray[1][2]
        scheduleModel.scheduleAudience = cellNameArray[1][3]
        
        let calendar = Calendar.current
        let component = calendar.dateComponents([.weekday], from: dateString!)
        guard let weekday = component.weekday else { return }
        let numberWeekday = weekday
        scheduleModel.scheduleWeekday = numberWeekday
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 4
        case 2: return 1
        case 3: return 1
        case 4: return 1
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: idOptionsScheduleCell,
            for: indexPath) as! OptionsTableViewCell
        cell.cellScheduleConfigure(
            nameArray: cellNameArray,
            indexPath: indexPath,
            hexColor: hexColorCell,
            editModel: editModel
        )
        cell.switchRepeatDelegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsScheduleHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath {
        case [0, 0]:
            alertDate(label: cell.nameCellLabel) { (numberWeekday, date) in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"
                let dateString = dateFormatter.string(from: date)
                
                self.cellNameArray[0][0] = dateString
            }
        case [0, 1]:
            alertTime(label: cell.nameCellLabel) { (time) in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let timeString = dateFormatter.string(from: time)
                
                self.cellNameArray[0][1] = timeString
            }
        case [1, 0]:
            alertForCellName(
                label: cell.nameCellLabel,
                name: "Name Lesson",
                placeHolder: "Enter name lesson") {text in
                self.cellNameArray[1][0] = text
            }
        case [1, 1]:
            alertForCellName(
                label: cell.nameCellLabel,
                name: "Type lesson",
                placeHolder: "Enter type lesson") {text in
                self.cellNameArray[1][1] = text
            }
        case [1, 2]:
            alertForCellName(
                label: cell.nameCellLabel,
                name: "Building number",
                placeHolder: "Enter number of building") {text in
                self.cellNameArray[1][2] = text
            }
        case [1, 3]:
            alertForCellName(
                label: cell.nameCellLabel,
                name: "Auidience number",
                placeHolder: "Enter number of auidience") {text in
                self.cellNameArray[1][3] = text
            }
        case [2, 0]:
            pushControllers(vc: TeachersTableViewController())
        case [3, 0]:
            pushControllers(vc: ScheduleColorsTableViewController())
        default: print("Tap OptionsTableView")
        }
    }
    
    private func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ScheduleOptionsTableViewController: SwitchRepeatProtocol {
    func switchRepeat(value: Bool) {
        scheduleModel.scheduleRepeat = value
    }
}
