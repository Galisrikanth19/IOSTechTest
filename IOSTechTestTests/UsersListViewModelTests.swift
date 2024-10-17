//
//  UsersListViewModelTests.swift
//  Created by GaliSrikanth on 17/10/24.

import XCTest
@testable import IOSTechTest

final class UsersListViewModelTests: XCTestCase {
    var apiService: MockUsersListService!
    var sut: UsersListViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        apiService = MockUsersListService()
        sut = UsersListViewModel(WithApiService: apiService)
    }

    override func tearDownWithError() throws {
        sut = nil
        apiService = nil
        try super.tearDownWithError()
    }

    func testGetUsersSuccessSenario() async {
        let userM = UserModel(name: NameModel(title: "Mr.", first: "Srikanth", last: "Gali"),
                              location: LocationModel(street: StreetModel(number: 100,
                                                                          name: "Tagore street"),
                                                      city: "Hyderabad", state: "Telangana", country: "India"),
                              email: "testgaliSrikanth@gmail.com",
                              phone: "9090909090",
                              gender: "male",
                              dob: DobModel(age: 98),
                              picture: PictureModel(large: "large.jpg", medium: "medium.jpg", thumbnail: "thumb.jpg"))
        
        apiService.responseM = UsersResponseModel(results: [userM])
        await sut.getUsers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.usersListArray.count, 1)
            XCTAssertEqual(self.sut.usersListArray.first?.email, "testgaliSrikanth@gmail.com")
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertEqual(self.sut.errorMsg, "")
            XCTAssertEqual(self.sut.pageNumber, 2)
        }
    }
    
    func testGetUsersNoDataSenario() async {
        apiService.responseM = UsersResponseModel(results: [])
        await sut.getUsers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.usersListArray.count, 0)
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertEqual(self.sut.errorMsg, AppConstants.noData)
        }
    }
    
    func testGetUsersWithApiErrorSenario() async {
        apiService.errorOccured = true
        await sut.getUsers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.sut.usersListArray.count, 0)
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertEqual(self.sut.errorMsg, AppConstants.invalidResponse)
        }
    }
}
