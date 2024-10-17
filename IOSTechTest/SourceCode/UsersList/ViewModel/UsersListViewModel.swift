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
    @Published var errorMsg = "" {
        didSet {
            if errorMsg.isEmpty == false {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.errorMsg = ""
                }
            }
        }
    }
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
                
                if self.usersListArray.isEmpty {
                    self.errorMsg = AppConstants.noData
                } else {
                    self.errorMsg = ""
                }
            }
        }
        catch ApiErrors.invalidUrl {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMsg = AppConstants.invalidUrl
            }
        }
        catch ApiErrors.invalidResponse {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMsg = AppConstants.invalidResponse
            }
        }
        catch ApiErrors.decodingError {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMsg = AppConstants.decodingError
            }
        }
        catch {
            DispatchQueue.main.async {
                self.isLoading = false
                self.errorMsg = AppConstants.unKnownException
            }
        }
    }
}
