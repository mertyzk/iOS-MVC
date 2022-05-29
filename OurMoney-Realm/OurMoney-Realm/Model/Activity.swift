//
//  Activity.swift
//  OurMoney-Realm
//
//  Created by Macbook Air on 28.05.2022.
//

import Foundation
import RealmSwift

class Activity : Object {
    @objc dynamic var Name : String = ""
    @objc dynamic var IsItOver : Bool = false
    let payments = List<Payment>()
}
