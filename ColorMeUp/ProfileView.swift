//
//  ProfileView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.fill")
            Text("Hank Hayes")
                .font(.title)
            VStack(spacing: 20) {
                Button(action: {
                    print("2")
                }, label: {
                    Text("Upgrade to Pro")
                })
                .buttonStyle(.bordered)
                Button(action: {
                    print("3")
                }, label: {
                    Text("Log Out")
                })
                .buttonStyle(.bordered)
                .foregroundColor(.red)
            }
        }
    }
}

#Preview {
    ProfileView()
}
