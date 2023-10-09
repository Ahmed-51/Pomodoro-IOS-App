//
//  JSONManager.swift
//  Pomodoro
//
//  Created by Ashfaq on 12/24/22.
//

import Foundation

struct About: Codable, Identifiable {
    
    var id: Int
    var developer1: String
    var developer2: String
    var developer3: String
    var support1: String
    var support2: String
    var device1: String
}

