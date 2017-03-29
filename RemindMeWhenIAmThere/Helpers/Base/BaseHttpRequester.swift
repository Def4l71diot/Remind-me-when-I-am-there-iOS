//
//  BaseHttpRequester.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/28/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//

import Foundation

protocol BaseHttpRequester {
    func get(
        toUrl urlString: String,
        withHeaders headers: Dictionary<String, String>?,
        completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
    
    func getJson(
        toUrl urlString: String,
        withHeaders headers: Dictionary<String, String>?,
        completionHandler: @escaping (Any?, HTTPURLResponse?, Error?) -> Void)
    
    func post(
        toUrl urlString: String,
        withBody body: Data?,
        andHeaders headers: Dictionary<String, String>?,
        completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
    
    func postJson(
        toUrl urlString: String,
        withBody body: Any?,
        andHeaders headers: Dictionary<String, String>?,
        completionHandler: @escaping (Any?, HTTPURLResponse?, Error?) -> Void)
    
    func put(
        toUrl urlString: String,
        withBody body: Data?,
        andHeaders headers: Dictionary<String, String>?,
        completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
    
    func putJson(
        toUrl urlString: String,
        withBody body: Any?,
        andHeaders headers: Dictionary<String, String>?,
        completionHandler: @escaping (Any?, HTTPURLResponse?, Error?) -> Void)
}
