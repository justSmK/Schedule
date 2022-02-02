//
//  TaskModel.swift
//  Schedule
//
//  Created by justSmK on 02.02.2022.
//

import RealmSwift

class TaskModel: Object {
    @Persisted var taskDate: Date?
    @Persisted var taskName: String = "Unknown"
    @Persisted var taskDescription: String = "Unknown"
    @Persisted var taskColor: String = "5E5CE6"
    @Persisted var taskReady: Bool = false
}

