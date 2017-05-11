//
//  SavingsViewController.swift
//  Saving Wallet
//
//  Created by Hansen on 5/7/17.
//  Copyright © 2017 Bang Mobile. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class SavingsViewController: UIViewController {

    @IBOutlet weak var txtSavings: UILabel!
    @IBOutlet weak var pieChart: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let realm = try! Realm()
        let saving = realm.objects(Savings.self).first
        var total = 0.0
        if saving != nil {
            total = saving!.value
            txtSavings.text = "Rp. \(total)"
        } else {
            txtSavings.text = "Rp. 0"
        }
        
        let save = realm.objects(Expenses.self).filter("category = 'Saving' AND date > %@ AND date < %@", Date().startOfMonth(), Date().endOfMonth()).sum(ofProperty: "value") as Double
        
        var dataEntry: [PieChartDataEntry] = []
        
        let entry1 = PieChartDataEntry(value: save, label: "Saving")
        let entry2 = PieChartDataEntry(value: total - save, label: "Remaining")
        dataEntry.append(entry1)
        dataEntry.append(entry2)
        
        let set1 = PieChartDataSet(values: dataEntry, label: nil)
        set1.setColors(UIColor.green, UIColor.red)
        
        let chartData = PieChartData(dataSet: set1)
        pieChart.data = chartData
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backToSavings(sender: UIStoryboardSegue) {}

}
