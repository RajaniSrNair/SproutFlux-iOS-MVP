//
//  LogWasteView.swift
//  SproutFlux App_Rajani_Final Project_MVP
//
//  Created by user286658 on 11/7/25.
//

//
//Making LogWasteView functional
//Replace LogWasteView in v1

//collects user input, saves waste item, display logged waste items, manage UI state, navigation and presentation


//Screen for logging new waste items.
//Uses:
//Picker to select type
//TextField for notes
//Optional ImagePicker for photo
//Save Waste button calls wasteManager.addItem(...).
//Displays a List of all logged items in reverse order (newest first).
//Automatically updates the UI when items are added due to @Published in WasteManager.



// UI Screen which allows logging new waste items
import SwiftUI

struct LogWasteView: View {
    @EnvironmentObject var wasteManager: WasteManager
    @State private var wasteType = "Organic"  //Tracks the selected type of waste (default "Organic")
    @State private var notes = ""    //Holds any optional notes for the waste item.
    @State private var showImagePicker = false //Controls whether the image picker sheet is visible.
    @State private var selectedImage: UIImage?  //Stores the optional image the user selects.
    
    //@EnvironmentObject var wasteManager: WasteManager: Pulls in a shared object (the WasteManager) from the environment. Allows to access and update the waste list.

    let wasteTypes = ["Organic", "Plastic", "Packaging", "Other"]
//A fixed array of waste categories for the Picker.
    
    
    var body: some View {
        NavigationView {   //enables navigation bars, back buttons
            VStack(spacing: 20) {
                Text("Log New Waste")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.green)

                Picker("Waste Type", selection: $wasteType) {
                    ForEach(wasteTypes, id: \.self) { type in
                        Text(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                //Picker: Lets users choose from multiple waste types.
                //$wasteType: Binds the selected value to the wasteType state variable.
                //.pickerStyle(.segmented): Makes the picker look like a horizontal segmented control.
                //.padding(.horizontal): Adds horizontal padding.
                

                TextField("Notes (optional)", text: $notes)
                    .padding()
                    .background(.regularMaterial)
                    .cornerRadius(8)
                    .padding(.horizontal)
                //Input field for optional notes

                Button(action: { showImagePicker = true }) {
                    Text(selectedImage == nil ? "Add Photo (optional)" : "Change Photo")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                //Button: Opens the image picker by setting showImagePicker to true.
                //Dynamic Text: Shows “Add Photo” if no image is selected, otherwise “Change Photo”.
                //Styling: Full width, green background, white text, rounded corners.

                Button(action: addWaste) {
                    Text("Save Waste")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                //Button: Calls the addWaste() function (defined below).
                //Styling: Similar to photo button, but blue for differentiation.

                List(wasteManager.items.reversed()) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.type).bold()
                            if let notes = item.notes { Text(notes) }
                            Text(item.date, style: .date).font(.caption).foregroundColor(.gray)
                        }
                        Spacer()
                        if let data = item.imageData, let uiImg = UIImage(data: data) {
                            Image(uiImage: uiImg)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(6)
                        }
                    }
                }
                //List: Displays all logged waste items in reverse order (newest first).
                //HStack: Horizontally arranges each item’s content.
                //VStack: Shows type, notes (if any), and formatted date.
                //Optional Image: Displays a thumbnail if an image was attached.
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $selectedImage)
            }
            //.sheet: Presents a modal sheet when showImagePicker is true.
            //ImagePicker: Custom view that allows the user to select an image.
        }
    }

    func addWaste() {
        wasteManager.addItem(type: wasteType, notes: notes, image: selectedImage)
        notes = ""
        selectedImage = nil
    }
    //Calls wasteManager.addItem() to add a new waste entry.
    //Resets notes and selectedImage for the next entry.
}
#Preview {
    let wasteManager = WasteManager()
    
    // Add mock waste items to show in list
    wasteManager.addItem(type: "Organic", notes: "Apple core", image: nil)
    wasteManager.addItem(type: "Plastic", notes: "Bottle cap", image: nil)
    wasteManager.addItem(type: "Other", notes: "Misc trash", image: nil)
    
    return LogWasteView()
        .environmentObject(wasteManager)
}

//Picker for waste type, text field for notes.
//Optional image using ImagePicker (we’ll implement next).
//Button saves to WasteManager.
//List below shows all added waste entries.


//The key responsibilities of this swift code are:
//Gathering user input for new waste items (type, notes, optional image).
//Saving the input into a shared data manager (WasteManager).
//Dynamically displaying all logged waste entries in a list.
//Managing UI state (form inputs, image picker visibility).
//Providing a clean, interactive SwiftUI interface.
