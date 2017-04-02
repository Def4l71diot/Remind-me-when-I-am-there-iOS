//
//  ActiveRemindersTableViewController.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/2/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import UIKit

class ActiveRemindersTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let reminderCellNibName = "ReminderTableViewCell"
    let reminderCellIdentifier = "reminder-cell"
    let reminderSectionsCount = 1
    let cellToTableViewScaleCoef: CGFloat = 6

    @IBOutlet weak var noRemindersLabel: UILabel!
    @IBOutlet weak var remindersTableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    var localRemindersData: BaseLocalRemindersData?
    var activeReminders: [BaseReminder] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadReminders()
    }
    
    func setupTableView() {
        self.refreshControl.addTarget(self, action: #selector(loadReminders), for: UIControlEvents.valueChanged)
        self.remindersTableView.dataSource = self
        self.remindersTableView.delegate = self
        self.remindersTableView.addSubview(self.refreshControl)
        self.remindersTableView.rowHeight = self.remindersTableView.frame.height / cellToTableViewScaleCoef
        self.remindersTableView.register(UINib(nibName: reminderCellNibName, bundle: nil), forCellReuseIdentifier: reminderCellIdentifier)
    }
    
    func setupAddReminderNavbarItem() {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return reminderSectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.activeReminders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.remindersTableView.dequeueReusableCell(withIdentifier: reminderCellIdentifier) as! ReminderTableViewCell
        let reminder = activeReminders[indexPath.row]
        cell.title.text = reminder.title
        cell.taskDescription.text = reminder.taskDescription
        cell.additionalInfo.text = reminder.date?.getLocalDateString() ?? reminder.locationName ?? ""
        
        if(reminder.date != nil) {
            cell.reminderIcon.image = #imageLiteral(resourceName: "Reminder-Date-100")
        } else {
            cell.reminderIcon.image = #imageLiteral(resourceName: "Reminder-Location-100")
        }
        
        if(reminder.fromUser != nil) {
            cell.fromUser.text = reminder.fromUser
            cell.fromUser.isHidden = false
        } else {
            cell.fromUser.isHidden = true
        }
        
        return cell
    }
    
    func loadReminders() {
        if(!self.refreshControl.isRefreshing) {
            self.refreshControl.beginRefreshing()
        }
        

        self.activeReminders = self.localRemindersData?.getActiveReminders() ?? []

        self.remindersTableView.reloadData()
        self.refreshControl.endRefreshing()
        
        self.checkRemindersCount()
    }
    
    func checkRemindersCount() {
        if(self.activeReminders.isEmpty) {
            self.noRemindersLabel.isHidden = false
            self.remindersTableView.separatorStyle = .none
        } else {
            self.noRemindersLabel.isHidden = true
            self.remindersTableView.separatorStyle = .singleLine
        }
    }
    
    func navigateToReminderCreator() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
