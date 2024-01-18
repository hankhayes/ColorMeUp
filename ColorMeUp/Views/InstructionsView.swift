//
//  InstructionsView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 1/2/24.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                // Introduction
                VStack {
                    HStack {
                        Text("Introduction")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding([.horizontal, .top])
                    HStack {
                        Text("""
    ColorMeUp is a tool for colorblind designers and individuals to capture colors in the world around them.
    """)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                }
                InformationCard(title: "Proof of Concept", info: "This app is a proof of concept. Some features (user login and pro version) are not fully implemented, as they are not the main focus of this product.", readMore: false)
                    .padding()
                // Test
                VStack {
                    HStack {
                        Text("Test")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding([.horizontal, .top])
                    HStack {
                        Text("""
The Test tab allows you to take the Ishihara Test, which is a common colorblindness tset. You likely already know whether or not you are colorblind, but the test is there for fun or to share with friends. This tab also provides information about the origin and purpose of the test.
""")
                        Spacer()
                    }
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                }
                // Collections
                VStack {
                    HStack {
                        Text("Collections")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding([.horizontal, .top])
                    HStack {
                        Text("""
    The Collections tab provides an easy way to view your saved colors. You can filter results by category, view your saved notes, and see a full screen view of each color.
    """)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                }
                // Home
                VStack {
                    HStack {
                        Text("Home")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding([.horizontal, .top])
                    HStack {
                        Text("""
    The Home tab allows you to capture and save new colors. You can take a photo or choose a photo from your library, which allows you to select a color from that photo. Additionally, you have the ability to manually add colors using hex codes or a color wheel.
    """)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                }
                // Profile
                VStack {
                    HStack {
                        Text("Profile")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding([.horizontal, .top])
                    HStack {
                        Text("""
    The Profile tab is where you can find account information, as well as the option to upgrade to a pro account.
    """)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                }
                // Settings
                VStack {
                    HStack {
                        Text("Settings")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding([.horizontal, .top])
                    HStack {
                        Text("""
    The Settings tab allows you to change the apperaance of the app and specifiy your personal type of colorblindness. The accent color throughout the app will change based on what type of colorblindness.
    """)
                        Spacer()
                    }
                    .padding([.horizontal, .bottom])
                    .multilineTextAlignment(.leading)
                }
            }
            .navigationTitle("How to Use")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    InstructionsView()
}
