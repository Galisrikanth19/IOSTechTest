//
//  AlertView.swift
//  Created by GaliSrikanth on 17/10/24.

import SwiftUI

struct AlertView: View {
    @Binding var alertMessage: String
    
    var body: some View {
        VStack{
            ZStack {
                Text(alertMessage)
                    .foregroundStyle(Color.black)
                    .padding(15)
            }
            .background(Color.green.opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .padding(20)
            .padding(.top, 20)
            Spacer()
        }
    }
}
