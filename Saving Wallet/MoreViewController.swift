//
//  MoreViewController.swift
//  Saving Wallet
//
//  Created by Hansen on 4/27/17.
//  Copyright © 2017 Bang Mobile. All rights reserved.
//

import UIKit
import RealmSwift

class MoreViewController: UIViewController {
    
    @IBOutlet weak var btnDelete: UIView!
    @IBOutlet weak var btnAbout: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        btnDelete.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(deleteTap)))
        
        btnAbout.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(aboutTap)))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func deleteTap() {
        let alert = UIAlertController(title: "Delete Confirmation", message: "Are you sure to delete all data?", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Yes", style: .default, handler: { (ok) in
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
        })
        alert.addAction(ok)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func aboutTap() {
        let alert = UIAlertController(title: "About", message: "Made by Bang Mobile 2017", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
