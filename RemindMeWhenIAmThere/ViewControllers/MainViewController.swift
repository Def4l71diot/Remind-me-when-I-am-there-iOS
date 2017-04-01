//
//  MainViewController.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/27/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var usersData: BaseUsersData?
    var userAuthManager: BaseUserAuthManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let dbContext = delegate.persistentContainer.viewContext
//        let reminderFactory = ReminderFactory()
//        let localRemindersData = LocalRemindersData(withDbContext: dbContext, andReminderFactory: reminderFactory)
//        
        //                for i in 0..<10 {
        //                    let newDate = Date()
        //                    let reminder =
        //                        reminderFactory.getLocalReminder(
        //                            withTitle: "Reminder \(i)",
        //                            andTaskDescription: "Description \(i)",
        //                            forDate: newDate)
        //                    let saveResult = localRemindersData.add(reminder)
        //                    print(saveResult)
        //                }
        //        for i in 0..<10 {
        //            let reminder =
        //                reminderFactory
        //                    .getLocalReminder(
        //                        withTitle: "Location Reminder \(i)",
        //                        taskDescription: "Location Reminder Desc \(i)",
        //                        latitude: Double(i + i),
        //                        longitude: Double(i*i),
        //                        andLocationName: "Location Name \(i)")
        //            let saveResult = localRemindersData.add(reminder)
        //            print(saveResult)
        
        //}
//                        let allReminders = localRemindersData.getAll()
        //        allReminders.forEach() {
        //            print("\($0.title) \($0.taskDescription) \($0.isActive) \($0.isCompleted)  \($0.date?.getLocalDateString())")
        //        }
        //
        //        let reminder = allReminders[0]
        //        print("First Reminder \(reminder.title)")
        //
        //        let reminderById = localRemindersData.getById(id: reminder.id!)!
        //
//                var counter = 0
//                        allReminders.forEach() {
//                            $0.isActive = true
//                            counter += 1
//                            if($0.title.contains("1")) {
//                                $0.isActive = false
//                            }
//        
//                            if(counter % 3 == 0) {
//                                $0.isCompleted = true
//                            }
//                            $0.date = Date()
//                            let updated = localRemindersData.update($0)
//                            print(updated)
//                        }
        
//        let activeReminders = localRemindersData.getActiveReminders()
//        activeReminders.forEach() {
//            print("\($0.title) \($0.taskDescription) \($0.isActive) \($0.isCompleted)  \($0.date?.getLocalDateString())")
//            
//        }
//        let activeGeoReminders = localRemindersData.getActiveGeoReminders()
//        activeGeoReminders.forEach() {
//            print("\($0.title) \($0.taskDescription) \($0.isActive) \($0.isCompleted)  \($0.date?.getLocalDateString()) \($0.locationName!)")
//            
//        }
        //        let jsonParser = JsonParser()
        //        let apiConfig = ApiConfig()
        //        let userFactory = UserFactory()
        //        self.userAuthManager = UserAuthManager(withUserFactory: userFactory)
        //        let httpRequester = HttpRequester(withJsonParser: jsonParser)
        //        self.usersData = UsersData(withHttpRequester: httpRequester, apiConfig: apiConfig, andUserFactory: userFactory)
        //
        //        let user = userFactory.getLoginUser(withUsername: "Pesho69", andPassword: "123456")
        //
        //        weak var weakSelf = self
        //
        //        if((self.userAuthManager?.isLoggedIn())!) {
        //            let localUser = self.userAuthManager?.getUser()
        //            self.usersData?.searchUsers(withNameContaining: "k", authToken: localUser!.authToken!)
        //            { users, errorMessage in
        //                if(errorMessage != nil) {
        //                    print("ERROR SEARCHING: \(errorMessage!)")
        //                    return
        //                }
        //
        //                users.forEach() {
        //                    print("\($0.username!) (\($0.firstName!))")
        //                }
        //            }
        //        }
        
        
        //        self.usersData?.login(user: user)
        //        { loggedInUser, errorMessage in
        //            if(errorMessage != nil) {
        //                print("ERROR: \(errorMessage!)")
        //                return
        //            }
        //
        //            print("Username: \((loggedInUser?.username)!) FirstName: \((loggedInUser?.firstName)!) AuthToken: \((loggedInUser?.authToken)!) Email: \((loggedInUser?.email)!)")
        //
        //            weakSelf?.userAuthManager?.setUser(loggedInUser: loggedInUser!)
        //
        //            let currentUser = weakSelf?.userAuthManager?.getUser()
        //            let a = 5
        //        }
        //
        //        let registerUser = userFactory.getRegisterUser(withUsername: "Talanta", password: "123456", email: "teamvinkel23@mail.bg", andFirstName: "Toteto")
        //        self.usersData?.register(user: registerUser)
        //        { registeredUser, errorMessage in
        //            if(errorMessage != nil) {
        //                print("ERROR CREATING: \(errorMessage!)")
        //                return
        //            }
        //
        //            let user = registeredUser!
        //            let b = 5
        //
        //        }
        
        //        self.usersData?.resetPassword(forEmail: "teamvinkel23@mail.bg")
        //        { sentResetEmailSuccessfuly, errorMessage in
        //            if(errorMessage != nil) {
        //                print("ERROR RESETTING: \(errorMessage!)")
        //                return
        //            }
        //
        //            print(sentResetEmailSuccessfuly)
        //        }
        
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
