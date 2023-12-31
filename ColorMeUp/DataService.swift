//
//  DataService.swift
//  ColorMeUp
//
//  Created by Hank Hayes on 12/23/23.
//

import Foundation

struct DataService {
    
    func getColors() -> [UserColor] {
        print("got colors from DS")
        return [UserColor(hex: "007AFF", date: Date(), note: "Bedroom wall"), UserColor(hex: "ff28a1", date: Date(), note: "Kitchen backsplash"), UserColor(hex: "e3ffb3", date: Date(), note: "Office wall")]
    }
}
