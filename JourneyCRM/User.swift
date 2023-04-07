//
//  User.swift
//  JourneyCRM
//
//  Created by Марк Горкій on 06.04.2023.
//

import Foundation
import SwiftUI
let uuid = UUID().uuidString
struct User: Identifiable{
    var id: String
    var email: String
    var role: String
    var age: String
    var name: String
}
