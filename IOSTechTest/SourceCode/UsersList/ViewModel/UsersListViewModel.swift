//
//  UsersListViewModel.swift
//  Created by GaliSrikanth on 16/10/24.

import Foundation

class UsersListViewModel: ObservableObject {
    let recordsCount: Int = 10
    var pageNumber: Int = 1
    
    //Publishers
    @Published var usersListArray: [UserModel] = [UserModel]()
    @Published var isLoading = false
}

// MARK: - GetUsersList -
extension UsersListViewModel {
    func getUsers() async {
        do {
            DispatchQueue.main.async {
                self.isLoading = true
            }
            let urlStr = ApiEndPoints.usersList.endPoint + "?results=\(recordsCount)" + "&page=\(pageNumber)"
            let usersResponseModel: UsersResponseModel = try await ApiManager.shared.request(WithUrlStr: urlStr,
                                                                                             WithRequestType: .get)
            DispatchQueue.main.async {
                self.isLoading = false
                self.usersListArray.append(contentsOf: (usersResponseModel.results ?? []))
                if (usersResponseModel.results ?? []).isEmpty == false {
                    self.pageNumber += 1
                }
            }
        } catch {
            DispatchQueue.main.async {
                self.isLoading = false
            }
            print(error.localizedDescription)
        }
    }
}
