//
//  SummaryViewController.swift
//  Saving Wallet
//
//  Created by Hansen on 4/27/17.
//  Copyright © 2017 Bang Mobile. All rights reserved.
//

import UIKit
import RealmSwift
import Charts

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var barView: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupChart()
    }
    
    func setupChart() {
        let realm = try! Realm()
        let data = realm.objects(Expenses.self)
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<data.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: data[i].value)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Expenses")
        let chartData = BarChartData(dataSet: chartDataSet)
        barView.data = chartData
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

}
