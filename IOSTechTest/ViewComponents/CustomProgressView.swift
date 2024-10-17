//
//  CustomProgressView.swift
//  Created by GaliSrikanth on 17/10/24.

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                .scaleEffect(3.0)
        }
        .ignoresSafeArea()
    }
}
