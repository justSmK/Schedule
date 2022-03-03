//
//  RealmManager.swift
//  Schedule
//
//  Created by justSmK on 01.02.2022.
//

import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    // Schedule Model
    
    func saveScheduleModel(model: ScheduleModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteScheduleModel(model: ScheduleModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    // Task Model
    
    func saveTaskModel(model: TaskModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteTaskModel(model: TaskModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    func updateReadyButtonTaskModel(task: TaskModel, bool: Bool) {
        try! localRealm.write {
            task.taskReady = bool
        }
    }
    
    // Contacts Model
    
    func saveContactModel(model: ContactModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func deleteContactModel(model: ContactModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
    //
    
    func updateContactModel(model: ContactModel, nameArray: [String], imageData: Data?) {
        try! localRealm.write {
            model.contactName = nameArray[0]
            model.contactPhone = nameArray[1]
            model.contactMail = nameArray[2]
            model.contactType = nameArray[3]
            model.contactImage = imageData
        }
    }
    
    func updateTaskModel(model: TaskModel, nameArray: [String], hexColor: String) {
        try! localRealm.write {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormatter.date(from: nameArray[0])
            
            model.taskDate = dateString
            model.taskName = nameArray[1]
            model.taskDescription = nameArray[2]
            model.taskColor = hexColor
        }
    }
    
    func updateScheduleModel(model: ScheduleModel, nameArray: [[String]], hexColor: String, scheduleRepeat: Bool) {
        try! localRealm.write {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let dateString = dateFormatter.date(from: nameArray[0][0])
            dateFormatter.dateFormat = "HH:mm"
            let timeString = dateFormatter.date(from: nameArray[0][1])
            
            model.scheduleDate = dateString
            model.scheduleTime = timeString
            model.scheduleName = nameArray[1][0]
            model.scheduleType = nameArray[1][1]
            model.scheduleBuilding = nameArray[1][2]
            model.scheduleAudience = nameArray[1][3]
            model.scheduleColor = hexColor
            
            let calendar = Calendar.current
            let component = calendar.dateComponents([.weekday], from: dateString!)
            guard let weekday = component.weekday else { return }
            let numberWeekday = weekday
            model.scheduleWeekday = numberWeekday
            
            model.scheduleRepeat = scheduleRepeat
            
        }
    }

}
