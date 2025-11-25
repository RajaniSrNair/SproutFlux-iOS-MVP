//
//  AuthManager.swift
//  SproutFlux App_Rajani_Final Project_MVP
//
//  Created by user286658 on 11/7/25.
//

//Class: AuthManager: ObservableObject
//Responsibilities:
//Tracks login state (isSignedIn) and the current user (currentUser).
//Publishes changes so UI automatically updates when auth state changes.
//Saves and loads user info using UserDefaults for persistence.
//Provides mock sign-in (signInMock) and guest login (signInGuest).
//Provides a signOut() function.
//Key points:
//Uses @Published private(set) to allow views to read but prevent external writes.
//Conforms to ObservableObject so ContentView and other screens can react to auth state.


//Handles sign-in, guest login and session persistence
import Foundation

//Setting up a class and making it observable by SwiftUI. views will refresh automatically when certain properties change

final class AuthManager: ObservableObject {

//final class AuthManager: Declares a class that cannot be subclassed.
//ObservableObject: Makes the class observable by SwiftUI views; when @Published properties change, the UI updates automatically.
//representing authentication state of the app
// isSignedIn- whether someone is logged in. initialized as false
// currentUser- details of the logged-in user. nil if nobody is
// @Published- SwiftUI views observing this class will automatically update when these values changes
//private(set) only this class can modify these values and other parts can read them
//storageKey is a constant used to save and retrieve data in userDefaults
    

    @Published private(set) var isSignedIn: Bool = false
    @Published private(set) var currentUser: User?
    private let storageKey = "sproutflux_user"
    
    //ensuring that the app "remembers" the user last signed in
   
    init() {             //checks when app starts if there's a saved user session
        loadUser()      //restore previously signed in user from storage (if any)
    }
    //init(): Called when AuthManager is created.
    //loadUser(): Loads a persisted user from UserDefaults if available, so the app can remember a previous session.
    
 //Defines an asynchronous function signInMock : async allows the function to do work that take time w/o blocking rest of the app
 //simulating signing in a user in the mock login
//checking email and password are not empty
    //simulating a delay like waiting for a real server
    
    func signInMock(email: String, password: String) async throws{  //throws allow the func to throw error if something goes wrong
        guard !email.isEmpty, !password.isEmpty else{               //guard- ensures both conditions are met before execution of func
            throw AuthError.invalidCredentials
        }
        
        //simulate network latency by waiting for 0.5 seconds
        try await Task.sleep(nanoseconds: 500*1_000_000)
        
        //creates a mock user
        let user = User(id: UUID().uuidString, name: email.components(separatedBy:"@").first ?? "User", email: email)  //extracting first part of email for name. if email is not there, use "User" instead
        
        saveUser(user)     //saves User object to persistent storage-userDefaults
        await MainActor.run {
            self.currentUser = user   //updates published properties, currentUser-> trigger UI updates
            self.isSignedIn = true    //updates isSignedIn. Notifies UI that user is now signed in
        }
    }
    
    //clears user data and updates the state at the time of sign out
    //demonstrates state management and persistence
    func signOut() {                   //logging out function
        currentUser = nil              //clears user data from memory & storage
        isSignedIn = false             //set false. UI --> logged out state
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
    
    //saves User object (now converted into JSONEncoder data) into persistent storage- userDEfaults.
    //Ensures that user info remains available next time
    private func saveUser(_ user: User) {  //converts user data into JSONEncoder
        if let d = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(d, forKey: storageKey)
            
        }
        
    }
    
    //reads the saved user from UserDEfaults when the app launches
    //once valid data is found, it's decoded back to User obj. mark as signedin
    //reset to signed-out state if valid data not found
    private func loadUser(){
    guard let d = UserDefaults.standard.data(forKey: storageKey),
            let u = try? JSONDecoder().decode(User.self, from: d)
        else {
            self.isSignedIn = false
            self.currentUser = nil
            return
        }
        self.currentUser = u
        self.isSignedIn = true
                
    }
    
    //Provides a guest login flow
    //uses same approach as normal login but without credentials
    func signInGuest(_ user: User) {
        saveUser(user)
        currentUser = user
        isSignedIn = true
    }
    
    enum AuthError: LocalizedError {  //allows readable message for UI to display
        case invalidCredentials   //defines custom errors AuthManager can throw
        var errorDescription: String? {
            switch self{
            case .invalidCredentials: return "Please enter email and password."
            }
            
        }
    }
    
}



//Key Concepts in AuthManager.swift:
//ObservableObject & @Published → reactive state updates in SwiftUI.
//Async/Await → simulating network calls.
//Persistence → storing/retrieving data using UserDefaults.
//Error handling → using Swift’s throw and custom Error enum.
//Guest vs Regular login → same flow, different data.
//final class modifier prevents another class from extending the class.cannot be subclassed from or inherited from
//ObservableObject protocol. SwiftUI views can observe the conforming class for changes
//@Published property wrapper automatically creates a publisher for <>. when <> value changes, any objects observing this property are notified
//private(set). access control modifier. property can be read(get) from wnywhere within the module, but can be written to(set) from within the class or struct. read-only public property

