//
//  ContactModel.swift
//  Schedule
//
//  Created by justSmK on 02.02.2022.
//

import RealmSwift

class ContactModel: Object {
    @Persisted var contactName: String = "Unknown"
    @Persisted var contactPhone: String = "Unknown"
    @Persisted var contactMail: String = "Unknown"
    @Persisted var contactType: String = "Unknown"
    @Persisted var contactImage: Data?
}

