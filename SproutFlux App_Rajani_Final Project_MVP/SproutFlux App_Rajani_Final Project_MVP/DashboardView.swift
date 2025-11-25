//
//  DashboardView.swift
//  SproutFlux App_Rajani_Final Project_MVP
//
//  Created by user286658 on 11/7/25.
//

//Update DashboardView
//Replace placeholder with a simple summary:


//Shows a summary of waste items by type.
//Uses @EnvironmentObject var wasteManager to access items.
//Displays a simple VStack with:
//Title
//Count for each waste type (wasteManager.countByType(type)).
//Dynamically updates whenever a new item is logged due to @Published in WasteManager.




// UI Screen displays a summary count by waste type.
import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var wasteManager: WasteManager
    let types = ["Organic", "Plastic", "Packaging", "Other"]
    //Accesses wasteManager shared via environmentObject.
    //types: The categories of waste we track.
         
    
    var body: some View {
        VStack(spacing: 20) {
            Text("SproutFlux Dashboard")
                .font(.largeTitle)
                .bold()
                .foregroundColor(.green)

            ForEach(types, id: \.self) { type in
                HStack {
                    Text(type)
                    Spacer()
                    Text("\(wasteManager.countByType(type))")
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .padding(.top, 40)
    }
}
//Loops over each type of waste.
//Displays the count of each waste type from wasteManager.
//HStack → horizontal layout.
//Spacer() → pushes count to the right.


#Preview {
    let wasteManager = WasteManager()
    
    // Add mock items to populate counts
    wasteManager.addItem(type: "Organic", notes: "Apple core", image: nil)
    wasteManager.addItem(type: "Plastic", notes: "Bottle cap", image: nil)
    wasteManager.addItem(type: "Packaging", notes: "Cardboard box", image: nil)
    wasteManager.addItem(type: "Other", notes: "Misc trash", image: nil)
    
    return DashboardView()
        .environmentObject(wasteManager)
        }
//Simple count by type.
//Dynamically updates when new waste is logged.


//Key Concepts:
//EnvironmentObject → access shared manager.
//ForEach → dynamically generates UI from data.
//Data-driven UI → UI automatically updates when waste counts change.
//VStack / HStack → vertical/horizontal layout in SwiftUI.
