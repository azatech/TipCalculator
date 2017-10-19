//
//  ViewController.swift
//  TipCalculator
//
//  Created by Azat IOS on 19.10.17.
//  Copyright © 2017 azatech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var billTotalLabel: UILabel!
    
    @IBOutlet weak var totalTextField: UITextField!
    
    @IBOutlet weak var taxPercentLabel: UILabel!
    @IBOutlet weak var taxPctSlider: UISlider!

    @IBOutlet weak var resultsTextView: UITextView!


    /////1111

    class TipCalculatorModel {
        var total: Double
        var taxPct: Double
        var subtotal: Double {
            get {
                return total / (taxPct + 1)
            }
        }

        init(total: Double, taxPct: Double) {
            self.total = total
            self.taxPct = taxPct
        }

        func calcTipWithTipPct(tipPct: Double) -> Double {
            return subtotal * tipPct
        }

        func returnPossibleTips() -> [Int: Double] {

            let possibleTipsInferred = [0.15, 0.18, 0.20]
            let possibleTipsExplicit:[Double] = [0.15, 0.18, 0.20]

            var retval = [Int: Double]()
            for possibleTip in possibleTipsInferred {
                let intPct = Int(possibleTip*100)
                retval[intPct] = calcTipWithTipPct(tipPct: possibleTip)
            }
            return retval
        }
    }

    //// 2222
    let tipCalc = TipCalculatorModel(total: 0, taxPct: 0.06)

    func refreshUI() {
        // 1
        totalTextField.text = String(format: "%0.2f", tipCalc.total)
        // 2
        taxPctSlider.value = Float(tipCalc.taxPct) * 100.0
        // 3
        taxPercentLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        // 4
        resultsTextView.text = ""
    }



    override func viewDidLoad() {
        super.viewDidLoad()

        
        refreshUI()




    }
    @IBAction func calculateTapped(_ sender: Any) {
        

        // 1
        tipCalc.total = Double((totalTextField.text as! NSString).doubleValue)
        // 2
        let possibleTips = tipCalc.returnPossibleTips()
        var results = ""
        // 3
        for (tipPct, tipValue) in possibleTips {
            // 4
            results += "\(tipPct)%: \(tipValue)\n"


        }
        results += "\n Don't be greedy!\nLeave 20% tips 😁"
        // 5
        resultsTextView.text = results
        totalTextField.resignFirstResponder()
    }
    @IBAction func taxPercentageChanged(_ sender: Any) {
        tipCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
//        totalTextField.resignFirstResponder()
    }

    @IBAction func viewTapped(_ sender: Any) {
        totalTextField.resignFirstResponder()
    }
    

}

