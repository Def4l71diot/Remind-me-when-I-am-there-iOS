//
//  AddReminderViewController.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/2/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import UIKit

class AddReminderViewController: UIViewController {
    let saveLocalReminderButtonName = "Save"
    let sendReminderToBuddyButtonName = "Send"
    
    @IBOutlet weak var createReminderButton: UIBarButtonItem!
    
    @IBOutlet weak var forBuddySwitch: UISwitch!
    
    @IBOutlet weak var reminderTitle: UITextField!
    @IBOutlet weak var reminderTaskDescription: UITextView!
    
    
    @IBOutlet weak var forLocationSwitch: UISwitch!
    @IBOutlet weak var locationName: UITextField!
    @IBOutlet weak var pickerStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUi()
    }
    
    func configureUi() {
        self.reminderTaskDescription.layer.cornerRadius = 5
        self.reminderTaskDescription.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        self.reminderTaskDescription.layer.borderWidth = 0.5
        self.reminderTaskDescription.clipsToBounds = true
        
        
        self.pickerStartButton.layer.borderColor = UIColor.lightGray.cgColor
        self.pickerStartButton.layer.borderWidth = 0.8
        self.pickerStartButton.layer.cornerRadius = 21
        
        self.createReminderButton.title = saveLocalReminderButtonName
        self.locationName.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func forBuddySwitchValueChanged() {
        if(self.forBuddySwitch.isOn) {
            self.createReminderButton.title = sendReminderToBuddyButtonName
        } else {
            self.createReminderButton.title = saveLocalReminderButtonName
        }
    }
    
    @IBAction func forLocationSwitchChangedValue() {
        if(self.forLocationSwitch.isOn) {
            self.animateSetView(view: self.locationName, hidden: false)
        } else {
            self.animateSetView(view: self.locationName, hidden: true)
        }
    }
    

}
