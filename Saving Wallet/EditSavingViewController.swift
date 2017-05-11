//
//  EditSavingViewController.swift
//  Saving Wallet
//
//  Created by Hansen on 5/11/17.
//  Copyright © 2017 Bang Mobile. All rights reserved.
//

import UIKit
import RealmSwift

class EditSavingViewController: UIViewController {

    @IBOutlet weak var txtSaving: UITextField!
    
    let realm = try! Realm()
    var save: Savings?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        save = realm.objects(Savings.self).first
        
        if save != nil {
            txtSaving.text = "\(save!.value)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func btnSetClick(_ sender: UIButton) {
        if !(txtSaving.text!.isEmpty) {
            save = Savings()
            save!.id = 0
            save!.value = Double(txtSaving.text!)!
            try! realm.write {
                realm.add(save!, update: true)
            }
            performSegue(withIdentifier: "backToSavings", sender: self)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Saving Target must be filled", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
}
