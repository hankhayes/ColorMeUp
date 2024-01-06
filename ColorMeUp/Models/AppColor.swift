//
//  AppColor.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 1/3/24.
//

import SwiftUI

class AppColor: ObservableObject {
    
    // Runs updateTint() when the "visionType" user default is changed
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
            tint = .blue
        case 1:
            tint = .blue
        case 2:
            tint = .red
        default:
            tint = .blue
        }
    }
}
