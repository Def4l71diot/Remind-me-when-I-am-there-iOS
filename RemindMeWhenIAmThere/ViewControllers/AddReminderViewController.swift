//
//  AddReminderViewController.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/2/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import UIKit
import SearchTextField
import LocationPicker
import DateTimePicker
import CoreLocation

class AddReminderViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    let invalidTitleMessage = "The title must not be empty!"
    let invalidDescriptionMessage = "The description must not be empty!"
    let invalidDateMessage = "The date for the reminder is not set!"
    let invalidLocationMessage = "You have not set the location for the reminder!"
    let invalidLocationNameMessage = "You must not leave the location name empty!"
    let invalidReceiverMessage = "Please enter your buddy's username!"
    let saveLocalReminderButtonName = "Save"
    let sendReminderToBuddyButtonName = "Send"
    let enterLocationNameString = "Please enter a location name!"
    let locationNamePlaceholder = "Location Name"
    let okString = "OK"
    
    @IBOutlet weak var createReminderButton: UIBarButtonItem!
    
    @IBOutlet weak var forBuddySwitch: UISwitch!
    
    @IBOutlet weak var buddyName: SearchTextField!
    @IBOutlet weak var reminderTitle: UITextField!
    @IBOutlet weak var reminderTaskDescription: UITextView!
    
    @IBOutlet weak var forLocationSwitch: UISwitch!
    @IBOutlet weak var pickerStartButton: UIButton!
    
    var userAuthManager: BaseUserAuthManager?
    var usersData: BaseUsersData?
    var reminderFactory: BaseReminderFactory?
    var localRemindersData: BaseLocalRemindersData?
    var remindersScheduler: BaseScheduler?
    
    var reminderDate: Date?
    var reminderLocation: Location?
    var reminderLocationName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUi()
    }
    
    func configureUi() {
        self.buddyName.delegate = self
        self.reminderTitle.delegate = self
        self.reminderTaskDescription.delegate = self
        
        self.buddyName.isUserInteractionEnabled = false
        
        self.reminderTaskDescription.layer.cornerRadius = 5
        self.reminderTaskDescription.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        self.reminderTaskDescription.layer.borderWidth = 0.5
        self.reminderTaskDescription.clipsToBounds = true
        
        
        self.pickerStartButton.layer.borderColor = UIColor.lightGray.cgColor
        self.pickerStartButton.layer.borderWidth = 0.8
        self.pickerStartButton.layer.cornerRadius = 21
        
        self.createReminderButton.title = saveLocalReminderButtonName
        self.buddyName.isHidden = true
        
        if (self.userAuthManager?.isLoggedIn())! {
            self.forBuddySwitch.isEnabled = true
        } else {
            self.forBuddySwitch.isEnabled = false
        }
        
        self.configSearchBox()
    }
    
    func configSearchBox() {
        self.buddyName.theme = SearchTextFieldTheme.lightTheme()
        self.buddyName.theme.font = UIFont.systemFont(ofSize: 12)
        self.buddyName.theme.bgColor = .white
        self.buddyName.theme.borderColor = UIColor(red:0.95, green:0.35, blue:0.14, alpha: 1.0)
        self.buddyName.theme.separatorColor = UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 0.5)
        
        self.buddyName.comparisonOptions = [.caseInsensitive]
        
        self.buddyName.highlightAttributes = [
            NSBackgroundColorAttributeName: UIColor(red:0.95, green:0.35, blue:0.14, alpha:1.0),
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 12)]
        
    }
    
    @IBAction func createReminder(_ sender: Any) {
        
        self.showLoadingIndicator()
        
        let reminderTitle = self.reminderTitle?.text
        let reminderTaskDescription = self.reminderTaskDescription?.text
        let buddyName = self.buddyName.text
        
        guard reminderTitle != nil, !(reminderTitle?.isEmpty)! else {
            self.hideLoadingIndicator()
            self.showErrorMessage(message: invalidTitleMessage)
            return
        }
        
        guard reminderTaskDescription != nil, !(reminderTaskDescription?.isEmpty)! else {
            self.hideLoadingIndicator()
            self.showErrorMessage(message: invalidDescriptionMessage)
            return
        }
        
        if(self.forLocationSwitch.isOn) {
            guard self.reminderLocation != nil else {
                self.hideLoadingIndicator()
                self.showErrorMessage(message: invalidLocationMessage)
                return
            }
            
            guard self.reminderLocationName != nil, !(self.reminderLocationName?.isEmpty)! else {
                self.hideLoadingIndicator()
                self.showErrorMessage(message: invalidLocationNameMessage)
                return
            }
        } else {
            guard self.reminderDate != nil else {
                self.hideLoadingIndicator()
                self.showErrorMessage(message: invalidDateMessage)
                return
            }
        }
        
        var reminderToCreate: BaseReminder
        
        if(self.forBuddySwitch.isOn) {
            guard buddyName != nil, !(buddyName?.isEmpty)! else {
                self.hideLoadingIndicator()
                self.showErrorMessage(message: invalidReceiverMessage)
                return
            }
            
            if(self.forLocationSwitch.isOn) {
                reminderToCreate =
                    (self.reminderFactory?
                        .getRemoteReminder(
                            withTitle: reminderTitle!,
                            taskDescription: reminderTaskDescription!,
                            latitude: (reminderLocation?.coordinate.latitude)!,
                            longitude: (reminderLocation?.coordinate.longitude)!,
                            andLocationName: reminderLocationName!,
                            forUser: buddyName!))!
            } else {
                reminderToCreate =
                    (self.reminderFactory?
                        .getRemoteReminder(
                            withTitle: reminderTitle!,
                            andTaskDescription: reminderTaskDescription!,
                            forDate: reminderDate!,
                            forUser: buddyName!))!
            }
            
        } else {
            if(self.forLocationSwitch.isOn) {
                reminderToCreate =
                    (self.reminderFactory?
                        .getLocalReminder(
                            withTitle: reminderTitle!,
                            taskDescription: reminderTaskDescription!,
                            latitude: (reminderLocation?.coordinate.latitude)!,
                            longitude: (reminderLocation?.coordinate.longitude)!,
                            andLocationName: reminderLocationName!))!
            } else {
                reminderToCreate =
                    (self.reminderFactory?
                        .getLocalReminder(withTitle: reminderTitle!, andTaskDescription: reminderTaskDescription!, forDate: reminderDate!))!
            }
        }
        
        if(self.forBuddySwitch.isOn) {
            // Remote
            
        } else {
            _ = self.localRemindersData?.add(reminderToCreate)
            self.hideLoadingIndicator()
            _ = self.navigationController?.popViewController(animated: true)
            
            if(self.forLocationSwitch.isOn) {
                
            } else {
                self.remindersScheduler?.setReminderWithDate(reminderwithDate: reminderToCreate)
            }
        }
        
    }
    
    @IBAction func forBuddySwitchValueChanged() {
        if(self.forBuddySwitch.isOn) {
            self.createReminderButton.title = sendReminderToBuddyButtonName
            self.animateSetView(view: self.buddyName, hidden: false)
            self.buddyName.isUserInteractionEnabled = true
            self.loadBuddiesForAutocomplete()
        } else {
            self.buddyName.isUserInteractionEnabled = false
            self.animateSetView(view: self.buddyName, hidden: true)
            self.createReminderButton.title = saveLocalReminderButtonName
        }
    }
    
    @IBAction func pickDataOrLocationAction() {
        if(self.forLocationSwitch.isOn) {
            self.showLocationPicker()
        } else {
            self.showDatePicker()
        }
    }
    
    func showDatePicker() {
        weak var weakSelf = self
        let picker = DateTimePicker.show()
        picker.highlightColor = UIColor(red:0.95, green:0.35, blue:0.14, alpha: 1.0)
        
        if(self.reminderDate != nil) {
            picker.selectedDate = self.reminderDate!
        }
        
        picker.completionHandler = { date in
            weakSelf?.reminderDate = date
        }
    }
    
    func showLocationPicker() {
        let locationPicker = LocationPickerViewController()
        locationPicker.currentLocationButtonBackground = UIColor(red:0.95, green:0.35, blue:0.14, alpha: 1.0)
        weak var weakSelf = self
        locationPicker.completion = { location in
            weakSelf?.reminderLocation = location
            
            if(location != nil) {
                weakSelf?.promtUserForLocationName()
            }
        }
        
        if(self.reminderLocation != nil) {
            locationPicker.location = self.reminderLocation
        }
        self.navigationController?.pushViewController(locationPicker, animated: true)
    }
    
    func promtUserForLocationName() {
        weak var weakSelf = self
        let alert = UIAlertController(title: enterLocationNameString, message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: okString, style: .default)
        { alertAction in
            let locationNameTextField = alert.textFields?[0]
            weakSelf?.reminderLocationName = locationNameTextField?.text
        }
        
        alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
            textField.placeholder = weakSelf?.locationNamePlaceholder
        })
        
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func loadBuddiesForAutocomplete() {
        self.buddyName.showLoadingIndicator()
        
        weak var weakSelf = self
        let authToken = self.userAuthManager?.getUser()?.authToken
        
        self.usersData?.getBuddies(withAuthToken: authToken!)
        { buddies, errorMessage in
            if(errorMessage != nil) {
                DispatchQueue.main.async {
                    weakSelf?.showErrorMessage(message: errorMessage!)
                    return
                }
            }
            
            DispatchQueue.main.async {
                weakSelf?.buddyName.filterStrings(buddies)
                weakSelf?.buddyName.stopLoadingIndicator()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextFieldTag = textField.tag + 1
        let nextResponder = textField.superview?.viewWithTag(nextFieldTag) as UIResponder!
        
        if(nextResponder != nil) {
            nextResponder?.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String) -> Bool {
        
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        } else {
            return true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
