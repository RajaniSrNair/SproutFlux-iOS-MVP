//
//  ImagePicker.swift
//  SproutFlux App_Rajani_Final Project_MVP
//
//  Created by user286658 on 11/7/25.
//


//SwiftUI wrapper around UIImagePickerController (UIKit).
//Provides UIViewControllerRepresentable to pick images.
//Binds the selected image back to LogWasteView.
//Handles cancel and completion events via Coordinator.



// UI Screen ImagePicker allows picking images from the device.
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
@Binding var image: UIImage?
//Bridges UIKit UIImagePickerController to SwiftUI.
//@Binding var image: Selected image is bound to a state variable in the parent view.

func makeUIViewController(context: Context) -> some UIViewController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
}
//Creates the UIKit image picker and sets a delegate to handle selection.
//This is called once when SwiftUI needs the UIKit view controller.
//Creates an instance of UIImagePickerController.
//Sets its delegate to context.coordinator.
//The delegate handles user interactions like selecting an image or canceling.
    
    
func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
//Called whenever SwiftUI updates the view.
//Here it’s empty because we don’t need to update the picker dynamically.

func makeCoordinator() -> Coordinator { Coordinator(self) }
//SwiftUI needs a coordinator object to communicate back from UIKit delegates.
//Creates an instance of Coordinator, passing a reference to self.

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: ImagePicker
    init(_ parent: ImagePicker) { self.parent = parent }
//Acts as the delegate for the UIImagePickerController.
//Holds a reference to the ImagePicker struct so it can modify the @Binding property.

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            parent.image = uiImage
        }
        picker.dismiss(animated: true)
    }
    //Called when the user selects an image.
    //Extracts the selected image from info dictionary.
    //Updates parent.image (the SwiftUI binding).
    //Dismisses the picker.


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    //Called when the user cancels.
    //Just dismisses the picker without updating the binding.
}
}
//Coordinator handles the delegate callbacks for UIKit → SwiftUI bridge.
//Selected image is passed back to SwiftUI via the binding.
//Standard UIKit image picker for SwiftUI.
//Binds selected image00 to LogWasteView.


//Key Concepts:
//UIViewControllerRepresentable → integrates UIKit components in SwiftUI.
//Coordinator pattern → handles UIKit delegates.
//Bindings → allows parent view to react to image selection.
//ImagePicker lets you use a UIKit image picker in SwiftUI.
//It uses:
//UIViewControllerRepresentable to wrap the UIKit view.
//@Binding to send the selected image back to the SwiftUI view.
//A Coordinator to act as the delegate and handle callbacks.
//The SwiftUI parent view can now show this picker and receive the selected image.
