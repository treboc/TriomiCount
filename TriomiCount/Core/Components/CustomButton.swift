//
//  CustomButton.swift
//  TriomiCount
//
//  Created by Marvin Lee Kobert on 17.02.22.
//

import SwiftUI

struct CustomButton: View {
    let title: LocalizedStringKey
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}

struct CustomNavLink<Destination: View>: View {
    let title: LocalizedStringKey
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal)
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
    }
}
