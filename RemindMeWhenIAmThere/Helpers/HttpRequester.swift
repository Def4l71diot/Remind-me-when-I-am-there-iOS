//
//  HttpRequester.swift
//  RemindMeWhenIAmThere
//
//  Created by Lyubomir on 3/28/17.
//  Copyright © 2017 Vinkelton. All rights reserved.
//
import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class HttpRequester: BaseHttpRequester {
    let contentTypeHeaderKeyName = "Content-Type"
    let contentTypeJsonHeaderValue = "application/json"
    
    var jsonParser: BaseJsonParser
    
    init(withJsonParser jsonParser: BaseJsonParser) {
        self.jsonParser = jsonParser
    }
    
    func makeRequest(
        httpMethod method: HttpMethod,
        toUrl urlString: String,
        withBody body: Data?,
        andHeaders headers: Dictionary<String, String>?,
        completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        
        
        let targetUrl = URL(string: urlString)
        
        var httpRequest = URLRequest(url: targetUrl!)
        httpRequest.httpMethod = method.rawValue
        
        if(headers != nil) {
            headers?.forEach(){httpRequest.setValue($0.value, forHTTPHeaderField: $0.key)}
        }
        
        if(body != nil) {
            httpRequest.httpBody = body
        }
        
        let httpTask = URLSession.shared.dataTask(with: httpRequest)
        { responseBody, response, error in
            if(error != nil) {
                completionHandler(nil, nil, error)
                return
            }
            
            let httpResponse = response as! HTTPURLResponse
            
            completionHandler(responseBody, httpResponse, nil)
            
        }
        
        httpTask.resume()
        
    }
    
    func get(
        toUrl urlString: String,
        withHeaders headers: Dictionary<String, String>?,
        completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        
        self.makeRequest(
            httpMethod: .get,
            toUrl: urlString,
            withBody: nil,
            andHeaders: headers,
            completionHandler: completionHandler)
    }
    
    func getJson(
        toUrl urlString: String,
        withHeaders headers: Dictionary<String, String>?,
        completionHandler: @escaping (Any?, HTTPURLResponse?, Error?) -> Void) {
        
        weak var weakSelf = self
        
        self.get(toUrl: urlString, withHeaders: headers)
        { responseBody, response, error in
            if(error != nil) {
                completionHandler(nil, nil, error)
                return
            }
            
            do {
                
                let parsedResponse = try weakSelf?.handleJsonDeserialization(responseBody: responseBody, response: response)
                
                completionHandler(parsedResponse, response, nil)
            } catch let jsonParsingError {
                completionHandler(nil, nil, jsonParsingError)
            }
        }
    }
    
    func post(
        toUrl urlString: String,
        withBody body: Data?,
        andHeaders headers: Dictionary<String, String>?,
        completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        
        self.makeRequest(
            httpMethod: .post,
            toUrl: urlString,
            withBody: body,
            andHeaders: headers,
            completionHandler: completionHandler)
    }
    
    func postJson(
        toUrl urlString: String,
        withBody body: Any?,
        andHeaders headers: Dictionary<String, String>?,
        completionHandler: @escaping (Any?, HTTPURLResponse?, Error?) -> Void) {
        
        var jsonHeaders = headers ?? [:]
        var jsonBody: Data? = nil
        
        jsonHeaders[contentTypeHeaderKeyName] = contentTypeJsonHeaderValue
        
        if(body != nil) {
            do {
                jsonBody = try self.jsonParser.serializeJson(fromData: body!)
            } catch let jsonParsingError {
                completionHandler(nil, nil, jsonParsingError)
                return
            }
        }
        
        weak var weakSelf = self
        
        self.post(
            toUrl: urlString,
            withBody: jsonBody,
            andHeaders: jsonHeaders)
        { responseBody, response, error in
            if(error != nil) {
                completionHandler(nil, nil, error)
                return
            }
            
            do {
                let parsedResponse = try weakSelf?.handleJsonDeserialization(responseBody: responseBody, response: response)
                
                completionHandler(parsedResponse, response, nil)
            } catch let jsonParsingError {
                completionHandler(nil, nil, jsonParsingError)
            }
        }
        
    }
    
    func put(
        toUrl urlString: String,
        withBody body: Data?,
        andHeaders headers: Dictionary<String, String>?,
        completionHandler: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        
        self.makeRequest(
            httpMethod: .put,
            toUrl: urlString,
            withBody: body,
            andHeaders: headers,
            completionHandler: completionHandler)
    }
    
    func putJson(
        toUrl urlString: String,
        withBody body: Any?,
        andHeaders headers: Dictionary<String, String>?,
        completionHandler: @escaping (Any?, HTTPURLResponse?, Error?) -> Void) {
        
        var jsonHeaders = headers ?? [:]
        var jsonBody: Data? = nil
        
        jsonHeaders[contentTypeHeaderKeyName] = contentTypeJsonHeaderValue
        
        if(body != nil) {
            do {
                jsonBody = try self.jsonParser.serializeJson(fromData: body!)
            } catch let jsonParsingError {
                completionHandler(nil, nil, jsonParsingError)
                return
            }
        }
        
        weak var weakSelf = self
        
        self.put(
            toUrl: urlString,
            withBody: jsonBody,
            andHeaders: jsonHeaders)
        { responseBody, response, error in
            if(error != nil) {
                completionHandler(nil, nil, error)
                return
            }
            
            do {
                let parsedResponse = try weakSelf?.handleJsonDeserialization(responseBody: responseBody, response: response)
                
                completionHandler(parsedResponse, response, nil)
            } catch let jsonParsingError {
                completionHandler(nil, nil, jsonParsingError)
            }
        }
    }
    
    func handleJsonDeserialization(responseBody: Data?, response: HTTPURLResponse?) throws -> Any? {
        if let contentTypeString = response?.allHeaderFields[contentTypeHeaderKeyName] as? String {
            if(contentTypeString.contains(contentTypeJsonHeaderValue)) {
                return try self.jsonParser.deserializeJson(json: responseBody!)
            } else {
                return responseBody
            }
        } else {
            return nil
        }
    }
}























