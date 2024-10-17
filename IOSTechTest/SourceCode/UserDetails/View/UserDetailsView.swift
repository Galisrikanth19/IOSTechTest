//
//  UserDetailsView.swift
//  Created by GaliSrikanth on 17/10/24.

import SwiftUI

struct UserDetailsView: View {
    @StateObject var viewModel: UserDetailsViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 20) {
                AsyncImage(url: URL(string: (viewModel.userModel.picture?.large ?? ""))) { image in
                    image
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 5.0))
                } placeholder: {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(Color.gray.opacity(0.6))
                }
                .frame(height: UIScreen.main.bounds.width)
                .padding(.vertical, 10)
                
                VStack(alignment: .leading, spacing: 3) {
                    if let title = viewModel.userModel.name?.title,
                       let first = viewModel.userModel.name?.first,
                       let last = viewModel.userModel.name?.last {
                        Text("\(title) \(first) \(last)")
                            .fontWeight(.bold)
                    }
                    
                    Text(viewModel.userModel.email ?? "")
                        .fontWeight(.regular)
                    Text(viewModel.userModel.phone ?? "")
                        .fontWeight(.regular)
                        .padding(.bottom, 10)
                    
                    Text("Age: \(viewModel.userModel.dob?.age ?? 0)")
                        .fontWeight(.regular)
                    Text("Gender: \(viewModel.userModel.gender ?? "")")
                        .fontWeight(.regular)
                        .padding(.bottom, 10)
                    
                    Text("Address:")
                        .fontWeight(.semibold)
                    if let number = viewModel.userModel.location?.street?.number,
                       let name = viewModel.userModel.location?.street?.name,
                       let city = viewModel.userModel.location?.city,
                       let state = viewModel.userModel.location?.state,
                       let country = viewModel.userModel.location?.country {
                        Text("\(number), \(name)")
                            .fontWeight(.regular)
                        Text("\(city), \(state), \(country)")
                            .fontWeight(.regular)
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 15)
        }
        .navigationTitle(AppConstants.usersDetailTitle)
    }
}
