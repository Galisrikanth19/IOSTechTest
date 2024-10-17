//
//  IOSTechTestApp.swift
//  Created by GaliSrikanth on 16/10/24.

import SwiftUI

@main
struct IOSTechTestApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                UsersListView(viewModel: UsersListViewModel(WithApiService: UsersListService()))
            }
        }
    }
}
