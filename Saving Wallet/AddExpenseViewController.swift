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

class AddExpenseViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtValue: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    let kategori = ["Income", "Saving", "Food", "Transport", "Needs", "Loan", "Others"]
    
    var id = -1
    var exp = Expenses()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
        
        if id != -1 {
            let realm = try! Realm()
            exp = realm.objects(Expenses.self).filter("id == \(id)").first!
            txtTitle.text = exp.title
            txtValue.text = "\(exp.value)"
            //            txtCategory.text = exp.category
            categoryPicker.selectRow(kategori.index(of: exp.category)!, inComponent: 0, animated: true)
            datePicker.date = exp.date as Date
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kategori.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return kategori[row]
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
        } else if id == -1 {
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
                ex.value = Double(self.txtValue.text!)!
                ex.date = self.datePicker.date as NSDate
                //                ex.category = self.txtCategory.text!
                ex.category = self.kategori[self.categoryPicker.selectedRow(inComponent: 0)]
                
                try! realm.write {
                    realm.add(ex)
                }
                self.performSegue(withIdentifier: "backToMainList", sender: self)
            })
            alert.addAction(action)
            alert.addAction(ok)
            present(alert, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Confirmation", message: "Are you sure all data is valid?", preferredStyle: .alert)
            let action = UIAlertAction(title: "NO", style: .cancel, handler: nil)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (ok) in
                
                let realm = try! Realm()
                
                self.exp.title = self.txtTitle.text!
                self.exp.value = Double(self.txtValue.text!)!
                self.exp.date = self.datePicker.date as NSDate
                //                self.exp.category = self.txtCategory.text!
                self.exp.category = self.kategori[self.categoryPicker.selectedRow(inComponent: 0)]
                
                try! realm.write {
                    realm.add(self.exp, update: true)
                }
                
                self.performSegue(withIdentifier: "backToMainList", sender: self)
            })
            
            alert.addAction(action)
            alert.addAction(ok)
            present(alert, animated: true)
        }
    }
    
}

