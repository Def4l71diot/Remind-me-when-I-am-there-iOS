//
//  MainViewController.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/27/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.showLoadingIndicator()
        let dispatch = DispatchTime.now() + .seconds(4)
        weak var weakSelf = self
        DispatchQueue.main.asyncAfter(deadline: dispatch) {
            weakSelf?.hideLoadingIndicator()
        }
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
