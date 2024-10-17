//
//  UsersListView.swift
//  Created by GaliSrikanth on 16/10/24.

import SwiftUI

struct UsersListView: View {
    @StateObject var viewModel: UsersListViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            mainContent
            .task {
                await viewModel.getUsers()
            }
            
            if viewModel.isLoading {
                CustomProgressView()
            }
            
            if (viewModel.errorMsg.isEmpty == false) && (viewModel.usersListArray.isEmpty == true) {
                NoDataView()
            } else if (viewModel.errorMsg.isEmpty == false) && (viewModel.usersListArray.isEmpty == false) {
                AlertView(alertMessage: $viewModel.errorMsg)
            }
        }
        .navigationTitle(AppConstants.usersListTitle)
    }
    
    //Main content is separated from the body for code simplicity
    var mainContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            List {
                ForEach(viewModel.usersListArray) { userM in
                    NavigationLink(destination: UserDetailsView(viewModel: UserDetailsViewModel(userModel: userM))) {
                        HStack(alignment: .top, spacing: 0) {
                            AsyncImage(url: URL(string: (userM.picture?.medium ?? ""))) { image in
                                image
                                    .resizable()
                                    .frame(width: 150, height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 5.0))
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 5.0)
                                    .fill(Color.gray.opacity(0.6))
                                    .frame(width: 150, height: 150)
                            }
                            .padding(.trailing, 10)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                if let title = userM.name?.title,
                                   let first = userM.name?.first,
                                   let last = userM.name?.last {
                                    Text("\(title) \(first) \(last)")
                                        .fontWeight(.bold)
                                }
                                Text(userM.email ?? "")
                                    .fontWeight(.regular)
                                Text(userM.phone ?? "")
                                    .fontWeight(.regular)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .onAppear() {
                            if userM == viewModel.usersListArray.last {
                                Task {
                                    await viewModel.getUsers()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
