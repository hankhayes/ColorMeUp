//
//  AppColor.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 1/3/24.
//

import SwiftUI

class AppColor: ObservableObject {
    
    @AppStorage("visionType") private var visionType: Int = 0 {
        didSet {
            updateTint()
        }
    }
    
    @Published var tint: Color = .blue
    
    init() {
        updateTint()
    }
    
    private func updateTint() {
        switch visionType {
        case 0:
            tint = .red
        case 1:
            tint = .orange
        case 2:
            tint = .yellow
        case 3:
            tint = .green
        case 4:
            tint = .blue
        case 5:
            tint = .purple
        case 6:
            tint = .indigo
        default:
            print()
        }
    }
}
