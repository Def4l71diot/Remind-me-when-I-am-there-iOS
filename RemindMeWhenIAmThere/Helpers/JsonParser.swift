//
//  JsonParser.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/28/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//
import Foundation

class JsonParser: BaseJsonParser {
    
    func serializeJson(fromData data: Any) throws -> Data {
        return try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
    }
    
    func deserializeJson(json: Data) throws -> Any {
        return try JSONSerialization.jsonObject(with: json, options: .allowFragments)
    }
}
