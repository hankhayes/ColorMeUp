//
//  IshiharaInformationView.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 1/5/24.
//

import SwiftUI

struct IshiharaInformationView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                // Origin
                VStack {
                    HStack {
                        Text("Origin")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding([.horizontal, .top])
                    HStack {
                        Text("""
    The Ishihara color vision test, named after its creator Dr. Shinobu Ishihara, is a diagnostic tool designed to assess color blindness or deficiencies in individuals. Dr. Ishihara, a Japanese ophthalmologist, developed the test in the early 20th century, with the first edition published in 1917. The primary motivation behind creating the Ishihara test was to address the increasing demand for a reliable and standardized method to detect color vision deficiencies, which can significantly impact an individual's daily life, career choices, and safety in various environments. Dr. Ishihara's innovative approach involved the use of specially designed plates containing colored dots arranged to form numbers or patterns that are visible only to individuals with normal color vision. The test has since become a widely accepted and globally used tool for identifying color vision impairments, aiding professionals in diagnosing and accommodating individuals with such conditions.
    """)
                    Spacer()
                    }
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                }
                // Purpose
                VStack {
                    HStack {
                        Text("Purpose")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding([.horizontal, .top])
                    HStack {
                        Text("""
The Ishihara test serves a crucial purpose in identifying and categorizing various types of color vision deficiencies, including red-green and blue-yellow color blindness. By presenting individuals with a series of plates, each designed to be discernible by those with normal color vision but challenging for those with specific color deficiencies, the test allows healthcare professionals, such as optometrists and ophthalmologists, to diagnose and quantify the extent of color vision impairment accurately. Beyond its diagnostic role, the Ishihara test is instrumental in industries where color discrimination is critical, such as aviation, transportation, and occupations involving the use of color-coded signals or displays. Additionally, the test is employed in educational settings to help individuals understand and manage their color vision deficiencies, fostering awareness and accommodation for those with impaired color perception.
""")
                    Spacer()
                    }
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                }
                // Resources
                VStack {
                    HStack {
                        Text("Resources")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Spacer()
                    }
                    .padding([.horizontal, .top])
                    HStack {
                        Text("""
For more information, check out the following resources:
""")
                        .multilineTextAlignment(.leading)
                    Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 1)
                    .multilineTextAlignment(.leading)
                    HStack {
                        Link("Wikipedia", destination: URL(string: "https://en.wikipedia.org/wiki/Ishihara_test")!)
                    Spacer()
                    }
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                    HStack {
                        Link("Pilestone", destination: URL(string: "https://pilestone.com/blogs/news/understanding-ishiharas-test-for-color-deficiency")!)
                    Spacer()
                    }
                    .padding(.horizontal)
                    .multilineTextAlignment(.leading)
                    HStack {
                        Link("Online test", destination: URL(string: "https://www.colorlitelens.com/ishihara-test")!)
                    Spacer()
                    }
                    .padding([.horizontal, .bottom])
                    .multilineTextAlignment(.leading)
                }
            }
            .navigationTitle("The Ishihara Test")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    IshiharaInformationView()
}
