//
//  ModelsUser.swift
//  SproutFlux App_Rajani_Final Project_MVP
//
//  Created by user286658 on 11/7/25.
//


//Defines User struct.
//Conforms to:
//Codable → allows saving/loading in UserDefaults.
//Identifiable → unique id for SwiftUI lists if needed.



import Foundation
struct User: Codable, Identifiable {
    let id: String
    var name: String
    var email: String
}
//Codable for persistence
//Identifiable for use in lists. confirming to Identifiable protocol. uniquely identified
