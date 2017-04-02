//
//  ReminderTableViewCell.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/2/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {
    let imagetoCellScaleCoef: CGFloat = 0.4
    let labelToCellHeightScaleCoef: CGFloat = 3
    let labelToCellWidthScaleCoef: CGFloat = 3.5
    
    @IBOutlet weak var reminderIcon: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var taskDescription: UILabel!
    @IBOutlet weak var additionalInfo: UILabel!
    @IBOutlet weak var fromUser: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.reminderIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let reminderIconSide = self.frame.size.height * imagetoCellScaleCoef
        self.reminderIcon.frame.size = CGSize(width: reminderIconSide, height: reminderIconSide)
        self.reminderIcon.contentMode = .scaleAspectFit

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
