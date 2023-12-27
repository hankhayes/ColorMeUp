//
//  DataService.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import Foundation

struct DataService {
    
    func getColors() -> [UserColor] {
        return [UserColor(hex: "007AFF", date: Date(), note: "Bedroom wall", category: "red"), UserColor(hex: "FFFFFF", date: Date(), note: "Kitchen backsplash", category: "orange"), UserColor(hex: "000000", date: Date(), note: "Office wall", category: "yellow")]
    }
    
}
