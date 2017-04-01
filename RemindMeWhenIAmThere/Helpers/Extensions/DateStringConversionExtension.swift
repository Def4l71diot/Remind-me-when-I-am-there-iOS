//
//  DateToStringExtension.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 4/1/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation


let dateFormatString = "dd/MM/yyyy HH:mm"

extension Date {
    func getLocalDateString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatString
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

extension String {
    func getAsDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatString
        let date = dateFormatter.date(from: self)!
        return date
    }
}
