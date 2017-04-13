//
//  Expense.swift
//  Saving Wallet
//
//  Created by Hansen on 4/10/17.
//  Copyright © 2017 Bang Mobile. All rights reserved.
//

import RealmSwift

class Expenses: Object {
    dynamic var id = 0
    dynamic var title = ""
    dynamic var value = 0.0
    dynamic var date = NSDate()
}
