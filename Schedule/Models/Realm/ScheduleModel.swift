//
//  ScheduleModel.swift
//  Schedule
//
//  Created by justSmK on 01.02.2022.
//

import RealmSwift

class ScheduleModel: Object {
    @Persisted var scheduleDate: Date?
    @Persisted var scheduleTime: Date?
    @Persisted var scheduleName: String = "Unknown"
    @Persisted var scheduleType: String = "Unknown"
    @Persisted var scheduleBuilding: String = "Unknown"
    @Persisted var scheduleAudience: String = "Unknown"
    @Persisted var scheduleTeacher: String = "Unknown"
    @Persisted var scheduleColor: String = "5E5CE6"
    @Persisted var scheduleRepeat: Bool = true
    @Persisted var scheduleWeekday: Int = 1
}

