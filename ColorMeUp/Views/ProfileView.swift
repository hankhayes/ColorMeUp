//
//  ProfileView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import SwiftUI

struct ProfileView: View {
    
    @State var creditsAreShowing: Bool = false
    
    var body: some View {
        NavigationStack {
            Spacer()
            VStack {
                Image("timcook")
                    .resizable()
                    .frame(width: 160, height: 160)
                    .cornerRadius(100)
                    .shadow(radius: 6)
                    .overlay {
                        Circle()
                            .stroke(lineWidth: 6)
                            .foregroundColor(.white)
                    }
                Text("Tim Cook")
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
                }
            }
            Spacer()
            Text("Version 1.0")
                .foregroundStyle(.secondary)
            Button(action: {
                creditsAreShowing = true
            }, label: {
                Text("Credits")
            })
            .padding(.bottom)
            .sheet(isPresented: $creditsAreShowing, onDismiss: {
                creditsAreShowing = false
            }, content: {
                CreditsView()
                    .presentationDetents([.medium])
            })
        }
    }
}

#Preview {
    ProfileView()
}
