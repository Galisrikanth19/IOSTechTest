//
//  UsersListService.swift
//  Created by GaliSrikanth on 17/10/24.

import Foundation

protocol UsersListUseCase {
    func getUsersRequest<T: Codable>(WithRecords recordsCount: Int,
                                     WithPageNum pageNumber: Int) async throws -> T
}

class UsersListService {
    let apiManager: ApiManager
    
    init(WithApiManager apiManager: ApiManager = ApiManager.shared) {
        self.apiManager = apiManager
    }
}

extension UsersListService: UsersListUseCase {
    func getUsersRequest<T: Codable>(WithRecords recordsCount: Int,
                                     WithPageNum pageNumber: Int) async throws -> T {
        let urlStr = ApiEndPoints.usersList.endPoint + "?results=\(recordsCount)" + "&page=\(pageNumber)"
        let usersResponseModel: UsersResponseModel = try await apiManager.request(WithUrlStr: urlStr,
                                                                                  WithRequestType: .get)
        return usersResponseModel as! T
    }
}
