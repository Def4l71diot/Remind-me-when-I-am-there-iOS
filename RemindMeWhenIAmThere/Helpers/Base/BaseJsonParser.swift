//
//  BaseJsonParser.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/29/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

protocol BaseJsonParser {
    func serializeJson(fromData data: Any) throws -> Data
    
    func deserializeJson(json: Data) throws -> Any
}
