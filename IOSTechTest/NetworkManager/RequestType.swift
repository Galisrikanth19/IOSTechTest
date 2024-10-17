//
//  RequestType.swift
//  Created by GaliSrikanth on 16/10/24.

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    
    var value: String {
        return self.rawValue
    }
}
