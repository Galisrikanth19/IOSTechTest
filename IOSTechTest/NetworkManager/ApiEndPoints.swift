//
//  ApiEndPoints.swift
//  Created by GaliSrikanth on 16/10/24.

import Foundation

struct ApiBaseUrls {
    static let baseUrl = "https://randomuser.me/"
}

enum ApiEndPoints: String {
    case usersList = "api/"
    
    var endPoint: String {
        return ApiBaseUrls.baseUrl + self.rawValue
    }
}
