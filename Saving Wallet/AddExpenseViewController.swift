//
//  ViewController.swift
//  Saving Wallet
//
//  Created by Hansen on 4/1/17.
//  Copyright © 2017 Bang Mobile. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class AddExpenseViewController: UIViewController {

    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnAddClicked(_ sender: UIButton) {
        if txtTitle.text!.isEmpty {
            let alert = UIAlertController(title: "Data Incomplete", message: "Title must be filled", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        } else if txtValue.text!.isEmpty {
            let alert = UIAlertController(title: "Data Incomplete", message: "Value must be filled", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Confirmation", message: "Are you sure all data is valid?", preferredStyle: .alert)
            let action = UIAlertAction(title: "NO", style: .cancel, handler: nil)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (ok) in
//                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//                    return
//                }
//                
//                let managedContext = appDelegate.persistentContainer.viewContext
//                
//                let entity = NSEntityDescription.entity(forEntityName: "Expense", in: managedContext)
//                
//                let expense = NSManagedObject(entity: entity!, insertInto: managedContext)
//                
//                expense.setValue(self.txtTitle.text!, forKey: "title")
//                expense.setValue(Int64(self.txtValue.text!), forKey: "value")
//                
//                expense.setValue(self.datePicker.date, forKey: "date")
//                
//                do {
//                    try managedContext.save()
//                    self.dismiss(animated: true, completion: nil)
//                } catch let error as NSError {
//                    print("Fail to save expense. \(error)")
//                }
                
                let realm = try! Realm()
                
                let ex = Expenses()
                ex.id = realm.objects(Expenses.self).count + 1
                ex.title = self.txtTitle.text!
                ex.value = Int(self.txtValue.text!)!
                
                try! realm.write {
                    realm.add(ex)
                }
                self.performSegue(withIdentifier: "backToMainList", sender: self)
            })
            alert.addAction(action)
            alert.addAction(ok)
            present(alert, animated: true)
        }
    }

}

