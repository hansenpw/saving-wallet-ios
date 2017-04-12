//
//  ExpenseTableViewController.swift
//  Saving Wallet
//
//  Created by Hansen on 4/1/17.
//  Copyright © 2017 Bang Mobile. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class ExpenseTableViewController: UITableViewController {
    
    let realm = try! Realm()
    let results = try! Realm().objects(Expenses.self).sorted(byKeyPath: "id", ascending: false)
    
    var notificationToken: NotificationToken? = nil
    
//    var expenses : [Expense] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Observe Results Notifications
        notificationToken = results.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                // Results are now populated and can be accessed without blocking the UI
                tableView.reloadData()
                break
            case .update(_, let deletions, let insertions, let modifications):
                // Query results have changed, so apply them to the UITableView
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }), with: .automatic)
                tableView.endUpdates()
                break
            case .error(let error):
                // An error occurred while opening the Realm file on the background worker thread
                fatalError("\(error)")
                break
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    deinit {
        notificationToken?.stop()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
//        let managedContext = appDelegate.persistentContainer.viewContext
        
//        let fetchResult = NSFetchRequest<Expense>(entityName: "Expense")
        
//        do {
//            expenses = try managedContext.fetch(fetchResult)
//        } catch let error as NSError {
//            print("Could not fetch data. \(error).")
//        }
        
//        let ex = Expenses()
//        ex.id = 2
//        ex.title = "title"
//        ex.value = 20000
//        
//        try! realm.write {
//            realm.add(ex)
//        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return results.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpenseCell", for: indexPath)

        // Configure the cell...
//        cell.textLabel?.text = expenses[indexPath.row].value(forKeyPath: "title") as? String
//        cell.detailTextLabel?.text = "Rp. " + ((expenses[indexPath.row].value(forKeyPath: "value") as? Int64)?.description)!
        
        let object = results[indexPath.row]
        
        cell.textLabel?.text = object.title
        cell.detailTextLabel?.text = object.value.description

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            try! realm.write {
                realm.delete(results[indexPath.row])
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backToMainList(sender: UIStoryboardSegue) {}

}
