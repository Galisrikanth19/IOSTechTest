//
//  UserDetailsViewModel.swift
//  Created by GaliSrikanth on 17/10/24.

import Foundation

class UserDetailsViewModel: ObservableObject {
    @Published var userModel: UserModel
    
    init(userModel: UserModel) {
        self.userModel = userModel
    }
}
