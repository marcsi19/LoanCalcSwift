//
//  ViewController.swift
//  LoanCalculatorSwift
//
//  Created by Mariann on 11/4/18.
//  Copyright © 2018 Mariann. All rights reserved.
//

import UIKit

let formatter = NumberFormatter()
var interesToSave: Double = 1
var fullAmountToSave: Double = 1
var monthTermToSave: Int = 1
var monthlyPaymentToSave: Double = 1

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var _monthlyBreakDownArray: [Calculator.BreakDown] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _monthlyBreakDownArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    }

    @IBOutlet weak var RealTotal: UITextField!
    @IBOutlet weak var interest: UITextField!
    @IBOutlet weak var termMonth: UITextField!
    @IBOutlet weak var monthlyPay: UILabel!
    @IBOutlet weak var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tblView.delegate = self
        tblView.dataSource = self
    }


    @IBAction func LoanTotal(_ sender: Any) {
        let totalLoan = RealTotal.text == "" ? 1 : Double(RealTotal.text!)!
        let intresting = interest.text == "" ? 1 : Double(interest.text!)!
        let totalTerm = termMonth.text == "" ? 1 : Int(termMonth.text!)!
        let results = Calculator.sharedInstance.calPayment(fullAmount: totalLoan, interest: intresting, month: totalTerm)
        interesToSave = intresting
        fullAmountToSave = totalLoan
        monthTermToSave = totalTerm
        monthlyPaymentToSave = results.0

        monthlyPay.text = String(Double(round(100*results.0)/100))

        _monthlyBreakDownArray = results.1
        tblView.reloadData()

    }


}


