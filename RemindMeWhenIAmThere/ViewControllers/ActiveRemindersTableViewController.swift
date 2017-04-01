//
//  ActiveRemindersTableViewController.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/2/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import UIKit

class ActiveRemindersTableViewController: UIViewController, UITableViewDataSource {
    let reminderCellIdentifier = "reminder-cell"
    
    @IBOutlet weak var remindersTableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refreshReminders), for: UIControlEvents.valueChanged)
        remindersTableView.dataSource = self
        remindersTableView.addSubview(self.refreshControl)
        
        self.remindersTableView.register(UITableViewCell.self, forCellReuseIdentifier: reminderCellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.remindersTableView.dequeueReusableCell(withIdentifier: reminderCellIdentifier)!
        cell.textLabel?.text = "Reminder \(indexPath.row)"
        return cell
    }
    
    func refreshReminders() {
        let timeout = DispatchTime.now() + .seconds(5)
        weak var weakSelf = self
        DispatchQueue.main.asyncAfter(deadline: timeout) {
            weakSelf?.refreshControl.endRefreshing()
        }
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
