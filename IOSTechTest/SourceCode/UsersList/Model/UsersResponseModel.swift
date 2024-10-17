//
//  UsersResponseModel.swift
//  Created by GaliSrikanth on 16/10/24.

import Foundation

struct UsersResponseModel: Codable {
    let results: [UserModel]?
}

struct UserModel: Codable, Identifiable, Equatable {
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
        return lhs.email == rhs.email
    }
    
    var id: String {
        UUID().uuidString
    }
    let name: NameModel?
    let location: LocationModel?
    let email: String?
    let phone: String?
    let gender: String?
    let dob: DobModel?
    let picture: PictureModel?
    
    enum CodingKeys: String, CodingKey {
        case name
        case location
        case email
        case phone
        case gender
        case dob
        case picture
    }
}

struct NameModel: Codable {
    let title: String?
    let first: String?
    let last: String?
}

struct LocationModel: Codable {
    let street: StreetModel?
    let city: String?
    let state: String?
    let country: String?
}

struct StreetModel: Codable {
    let number: Int?
    let name: String?
}

struct DobModel: Codable {
    let age: Int?
}

struct PictureModel: Codable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}
