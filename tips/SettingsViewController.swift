//
//  SettingsViewController.swift
//  tips
//
//  Created by Sergey Serebryakov on 1/16/15.
//  Copyright (c) 2015 megaserg. All rights reserved.
//

import UIKit

// Global constants
let DEFAULTS_TIP_KEY = "default_tip_percentage_index"
let DEFAULTS_COLOR_KEY = "background_color_index"

class SettingsViewController: UIViewController {

    var defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var colorControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tipControl.selectedSegmentIndex = defaults.integerForKey(DEFAULTS_TIP_KEY)
        colorControl.selectedSegmentIndex = defaults.integerForKey(DEFAULTS_COLOR_KEY)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onTipControlValueChanged(sender: AnyObject) {
        defaults.setInteger(tipControl.selectedSegmentIndex, forKey: DEFAULTS_TIP_KEY)
    }
    
    @IBAction func onColorControlValueChanged(sender: AnyObject) {
        defaults.setInteger(colorControl.selectedSegmentIndex, forKey: DEFAULTS_COLOR_KEY)
    }
    
    @IBAction func onSettingsDone(sender: AnyObject) {
        defaults.synchronize()
        dismissViewControllerAnimated(true, completion: nil)
    }
}
