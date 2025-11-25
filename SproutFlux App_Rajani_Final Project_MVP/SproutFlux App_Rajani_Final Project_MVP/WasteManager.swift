//
//  WasteManager.swift
//  SproutFlux App_Rajani_Final Project_MVP
//
//  Created by user286658 on 11/7/25.
//

//WasteManager class acts as a central data controller for all waste items in the app.
//Acts as a single source of truth for app's waste data
//It stores, updates, and provides utility functions for the waste data.
//It as the “brain” managing all waste entries and notifying the UI whenever the data changes.


//Class: WasteManager: ObservableObject
//Holds all WasteItems in @Published var items.
//Functions:
//addItem(type:notes:image:) → creates a new WasteItem and appends it.
//countByType(_:) → returns count for a specific type (used in DashboardView).
//UI automatically updates when items changes due to @Published.


import Foundation
import SwiftUI

final class WasteManager: ObservableObject {
    @Published var items: [WasteItem] = []

    //final class WasteManager: Declares a class that cannot be subclassed.
    //ObservableObject: Makes the class observable by SwiftUI views.
    //Views that use @EnvironmentObject var wasteManager automatically update when the @Published properties change.
    //@Published var items:
    //Holds the array of all WasteItem objects.
    //Any modification (adding/removing items) automatically triggers UI updates in SwiftUI.

    
    // Add a new waste item
    func addItem(type: String, notes: String?, image: UIImage?) {
        let newItem = WasteItem(type: type, notes: notes, image: image)
        items.append(newItem)
    }
    //Purpose: Adds a new waste entry to the manager.
    //Steps:
    //Creates a new WasteItem using the initializer from ModelsWaste.swift.
    //Appends it to items.
    //Effect: Because items is @Published, any SwiftUI view observing this manager (like LogWasteView) automatically refreshes to show the new item.

    // Count of each type
    func countByType(_ type: String) -> Int {
        return items.filter { $0.type == type }.count
    }
    //Purpose: Returns how many items exist of a specific waste type.
    //Usage: Can be used in a dashboard or summary view to display stats like “3 Organic items, 5 Plastic items”.
    //Implementation: Filters items by type and counts the matching elements.
}

//Holds all waste items.
//Adding items updates all UI automatically (@Published).
//Simple helper to count items by type.

//Key Responsibilities
//Store All Waste Items
//Maintains a single source of truth for the app’s waste data.
//Add New Items
//Provides a function (addItem) to create and save new entries.
//Notify UI About Changes
//The @Published property ensures that any view observing WasteManager automatically updates when items are added.
//Provide Utility Functions
//For example, countByType allows easy aggregation or statistics for dashboards.
