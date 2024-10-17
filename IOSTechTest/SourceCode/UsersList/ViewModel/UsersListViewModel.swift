//
//  UsersListViewModel.swift
//  Created by GaliSrikanth on 16/10/24.

import Foundation

class UsersListViewModel: ObservableObject {
    let recordsCount: Int = 10
    var pageNumber: Int = 1
    
    //Service
    let apiService: UsersListUseCase
    
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
    
    init(WithApiService apiService: UsersListUseCase) {
        self.apiService = apiService
    }
}

// MARK: - GetUsersList -
extension UsersListViewModel {
    
    //This function calls asynchrosly and get Users
    //Parameters: This takes data from the viewmodel properties like records and pagenumbers
    //Retuns: Once execution is finished it will either throw the error or the expected decodable model
    //ErrorHandling: If we receive any kind of error we can customize the control flow based on requirement
    func getUsers() async {
        do {
            DispatchQueue.main.async {
                self.isLoading = true
            }
            let usersResponseModel: UsersResponseModel = try await apiService.getUsersRequest(WithRecords: recordsCount,
                                                                                              WithPageNum: pageNumber)
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
