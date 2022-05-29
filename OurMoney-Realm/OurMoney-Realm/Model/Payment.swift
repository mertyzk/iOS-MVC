//
//  Payment.swift
//  OurMoney-Realm
//
//  Created by Macbook Air on 28.05.2022.
//

import Foundation
import RealmSwift

class Payment: Object {
    @objc dynamic var payerName : String = ""
    @objc dynamic var desc : String = ""
    @objc dynamic var quantity : Int = -1
    var activity = LinkingObjects(fromType: Activity.self, property: "payments")
}
