//
//  Savings.swift
//  Saving Wallet
//
//  Created by Hansen on 5/11/17.
//  Copyright © 2017 Bang Mobile. All rights reserved.
//

import RealmSwift

class Savings: Object {
    dynamic var id = 0
    dynamic var value = 0.0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
