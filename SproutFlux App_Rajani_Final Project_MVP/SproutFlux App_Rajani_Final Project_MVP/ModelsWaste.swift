//
//  ModelsWaste.swift
//  SproutFlux App_Rajani_Final Project_MVP
//
//  Created by user286658 on 11/7/25.
//

//Defines the data model for individual waste items in the app. Assigns UUID and timestamp to the WasteItem
//Defines WasteItem struct.
//Properties:
//id: UUID for uniqueness
//type, notes, date
//imageData: optional image saved as Data for persistence
//Conforms to Codable (can be saved later) and Identifiable (used in lists).


import Foundation
import SwiftUI

struct WasteItem: Identifiable, Codable {
    let id: UUID
    let type: String
    let notes: String?
    let date: Date
    let imageData: Data? // optional image
    
    //Identifiable:
    //Each item has a unique id (UUID).
    //This is required to show items in SwiftUI List or other collection views.
    //Codable:
    //Allows the struct to be encoded/decoded to/from JSON or other formats.
    //Useful for saving or loading waste items from local storage later.
    //Properties:
    //id: Unique identifier.
    //type: The category of waste (e.g., Organic, Plastic).
    //notes: Optional text notes.
    //date: Timestamp when the item was created.
    //imageData: Optional binary data representing an image (JPEG format).

    init(type: String, notes: String? = nil, image: UIImage? = nil) {
        self.id = UUID()
        self.type = type
        self.notes = notes
        self.date = Date()
        if let img = image {
            self.imageData = img.jpegData(compressionQuality: 0.5)
        } else {
            self.imageData = nil
        }
    }
    //Creates a new WasteItem with:
    //Unique ID: UUID().
    //Current date: Date().
    //Optional image: Converts a UIImage to compressed JPEG Data for storage.
    //Optional notes: Defaults to nil if no notes are provided.
    //Essentially, this initializer prepares a waste item so it’s ready to be stored, displayed, or encoded.
}

//Each waste entry has a type, optional notes, optional image, and a timestamp.
//Identifiable → needed for List in SwiftUI.
//Codable → can persist locally later if needed.

//Role in the app: Serves as the core data model for waste items.
//Why it exists: The LogWasteView and WasteManager rely on WasteItem to store, identify, and display waste entries.
//Notable features:
//Automatically assigns UUID and timestamp.
//Optional notes and images.
//Encodable/decodable for persistence.

