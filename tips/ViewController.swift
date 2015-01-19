//
//  ViewController.swift
//  tips
//
//  Created by Sergey Serebryakov on 1/16/15.
//  Copyright (c) 2015 megaserg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    let DEFAULTS_BILL_AMOUNT_KEY = "last_bill_amount"
    let DEFAULTS_LAST_TIP_KEY = "last_tip_index"
    let DEFAULTS_BILL_DATE_KEY = "bill_amount_changed_date"

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var hidableView: UIView!
    
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var tipCaptionLabel: UILabel!
    @IBOutlet weak var totalCaptionLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!
    
    var viewIsHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let lastEditDate = defaults.objectForKey(DEFAULTS_BILL_DATE_KEY) as NSDate?
        let currentDate = NSDate()
        
        if (lastEditDate != nil && currentDate.timeIntervalSinceDate(lastEditDate!) < 15) {
            let billAmountText = defaults.objectForKey(DEFAULTS_BILL_AMOUNT_KEY) as NSString
            billField.text = billAmountText
            tipControl.selectedSegmentIndex = defaults.integerForKey(DEFAULTS_LAST_TIP_KEY)
            updateTipLabels(billAmountText)
        } else {
            billField.text = ""
            tipControl.selectedSegmentIndex = defaults.integerForKey(DEFAULTS_TIP_KEY)
            tipLabel.text = "$0.00"
            totalLabel.text = "$0.00"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        let billAmountText = billField.text as NSString
        defaults.setObject(billAmountText, forKey: DEFAULTS_BILL_AMOUNT_KEY)
        defaults.setObject(tipControl.selectedSegmentIndex, forKey: DEFAULTS_LAST_TIP_KEY)
        defaults.setObject(NSDate(), forKey: DEFAULTS_BILL_DATE_KEY)
        defaults.synchronize()

        updateTipLabels(billAmountText)
    }
    
    func updateTipLabels(billAmount: NSString) {
        if billAmount != "" {
            let tipPercentages = [0.18, 0.20, 0.22]
            let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
            
            let value = billAmount.doubleValue
            let tip = value * tipPercentage
            let total = value + tip
            
            tipLabel.text = String(format: "$%.2f", tip)
            totalLabel.text = String(format: "$%.2f", total)
            
            if viewIsHidden {
                showHidableView()
                viewIsHidden = false
            }
        } else {
            if !viewIsHidden {
                hideHidableView()
                viewIsHidden = true
            }
        }
    }
    
    func showHidableView() {
        animateView(0, finishVal: 1)
    }
    
    func hideHidableView() {
        animateView(1, finishVal: 0)
    }
    
    func animateView(startVal: CGFloat, finishVal: CGFloat) {
        self.hidableView.alpha = startVal
        UIView.animateWithDuration(0.4, animations: {
            self.hidableView.alpha = finishVal
        })
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let bgColors = [UIColor.whiteColor(), UIColor.darkGrayColor(), UIColor.greenColor()]
        let fgColors = [UIColor.blackColor(), UIColor.whiteColor(), UIColor.orangeColor()]
        let ttColors = [view.tintColor, UIColor.lightGrayColor(), UIColor.redColor()]
        
        let colorIndex = defaults.integerForKey(DEFAULTS_COLOR_KEY)
        let bgColor = bgColors[colorIndex]
        let fgColor = fgColors[colorIndex]
        let ttColor = ttColors[colorIndex]
        
        view.backgroundColor = bgColor
        hidableView.backgroundColor = bgColor
        
        billAmountLabel.textColor = fgColor
        tipCaptionLabel.textColor = fgColor
        totalCaptionLabel.textColor = fgColor
        
        tipLabel.textColor = fgColor
        totalLabel.textColor = fgColor
        
        dividerView.backgroundColor = fgColor
        
        tipControl.tintColor = ttColor
    }
}

