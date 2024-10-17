//
//  MockUsersListService.swift
//  Created by GaliSrikanth on 17/10/24.

import XCTest
@testable import IOSTechTest

class MockUsersListService: UsersListUseCase {
    var responseM: UsersResponseModel?
    var errorOccured = false
    
    func getUsersRequest<T: Codable>(WithRecords recordsCount: Int,
                            WithPageNum pageNumber: Int) async throws -> T {
        if errorOccured {
            throw ApiErrors.invalidResponse
        }
        
        if let responseM = responseM as? T {
            return responseM
        } else {
            throw ApiErrors.decodingError
        }
    }
}
