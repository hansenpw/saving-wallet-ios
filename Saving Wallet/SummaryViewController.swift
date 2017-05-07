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
//        setupChartToo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupChartToo()
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
    
    func setupChartToo() {
//        let today = Date()
//        let calendar = NSCalendar.current
//        
//        let component = calendar.dateComponents([.year, .month], from: today)
//        let start = calendar.date(from: component)!
//        print("\(start)")
//        
//        var component2 = DateComponents()
//        component2.month = 1
//        component2.day = -1
//        let end = calendar.date(byAdding: component2, to: start)!
//        print("\(end)")
        
        let start = Date().startOfMonth()
        let end = Date().endOfMonth()
        
        var i = 0
//        var dataEntries: [BarChartDataEntry] = []
        var chartDataSets: [BarChartDataSet] = []
        let realm = try! Realm()
        
        let data1 = realm.objects(Expenses.self).filter("category = 'Income' AND date > %@ AND date < %@", start, end).sum(ofProperty: "value") as Double
        
        let dataEntry1 = [BarChartDataEntry(x: Double(i), y: data1)]
//        dataEntries.append(dataEntry1)
        
        let chartDataSet1 = BarChartDataSet(values: dataEntry1, label: "Income")
        chartDataSet1.setColor(.green)
        chartDataSets.append(chartDataSet1)
        i += 1
        
        let data2 = realm.objects(Expenses.self).filter("category = 'Food' AND date > %@ AND date < %@", start, end).sum(ofProperty: "value") as Double
        
        let dataEntry2 = [BarChartDataEntry(x: Double(i), y: data2)]
//        dataEntries.append(dataEntry2)
        
        let chartDataSet2 = BarChartDataSet(values: dataEntry2, label: "Food")
        chartDataSet2.setColor(.brown)
        chartDataSets.append(chartDataSet2)
        i += 1
        
        let data3 = realm.objects(Expenses.self).filter("category = 'Transport' AND date > %@ AND date < %@", start, end).sum(ofProperty: "value") as Double
        
        let dataEntry3 = [BarChartDataEntry(x: Double(i), y: data3)]
//        dataEntries.append(dataEntry3)
        
        let chartDataSet3 = BarChartDataSet(values: dataEntry3, label: "Transport")
        chartDataSet3.setColor(.red)
        chartDataSets.append(chartDataSet3)
        i += 1
        
        let data4 = realm.objects(Expenses.self).filter("category = 'Needs' AND date > %@ AND date < %@", start, end).sum(ofProperty: "value") as Double
        
        let dataEntry4 = [BarChartDataEntry(x: Double(i), y: data4)]
//        dataEntries.append(dataEntry4)
        
        let chartDataSet4 = BarChartDataSet(values: dataEntry4, label: "Needs")
        chartDataSet4.setColor(.blue)
        chartDataSets.append(chartDataSet4)
        i += 1
        
        let data5 = realm.objects(Expenses.self).filter("category = 'Others' AND date > %@ AND date < %@", start, end).sum(ofProperty: "value") as Double
        
        let dataEntry5 = [BarChartDataEntry(x: Double(i), y: data5)]
//        dataEntries.append(dataEntry5)
        
        let chartDataSet5 = BarChartDataSet(values: dataEntry5, label: "Others")
        chartDataSets.append(chartDataSet5)
        i += 1
        
        let chartData = BarChartData(dataSets: chartDataSets)
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

extension Date {
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
}
