//
//  Color.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import Foundation

struct UserColor: Identifiable {
    
    var id = UUID()
    var hex: String
    var date: Date
    var note: String
}
