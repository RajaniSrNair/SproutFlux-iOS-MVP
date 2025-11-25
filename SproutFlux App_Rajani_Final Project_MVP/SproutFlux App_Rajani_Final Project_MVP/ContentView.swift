//
//  ContentView.swift
//  SproutFlux App_Rajani_Final Project_MVP
//
//  Created by user286658 on 11/7/25.
//


//Main screen controller for the app
//Decides what to show to the user depending on whether they are signed in or not
//Looks at the authentication state from AuthManager to decide which screen to display


//Root view that decides what to display based on auth.isSignedIn.
//Uses @StateObject to instantiate:
//AuthManager (for authentication)
//WasteManager (for waste data)
//UI Logic:
//If user is signed in → show TabView with two tabs:
//LogWasteView (logging waste)
//DashboardView (summary)
//If not signed in → show LoginView.
//Injects both managers as environmentObject so all child views can access them.



//UI Screen which Decides which screen to show (login vs. main app interface).

import SwiftUI

struct ContentView: View {
    
    //runs authManager to check if user is signed in
    
    @StateObject private var auth = AuthManager()  //an instance of AuthManager, auth, is created
    @StateObject private var wasteManager = WasteManager() //added for MVP
    //@StateObject: Creates a single source of truth for these managers within this view.
    //auth: Manages authentication state.
    //wasteManager: Holds and manages all logged waste items.
    
    
    var body: some View {
        Group {
    //Container that allows if/else inside a single view
              if auth.isSignedIn {
        
        //builds the main interface that appears after login
                
                  TabView {  //creates a tab bar interface. multiple tabs at the bottom
                    
                    LogWasteView()
                          .environmentObject(wasteManager)  // pass manager

                        .tabItem { Label ("Log Waste", systemImage: "leaf")}
                      //.tabItem defines label and system icon for each tab
                   
                    DashboardView()
                          .environmentObject(wasteManager)  // pass manager

                        .tabItem { Label ("Dashboard", systemImage: "chart.bar.fill")}
                    
                }
                .environmentObject(auth)
                .accentColor(.green)
 //environmentObject injects the same
//if user is logged in (from AuthManager), the main app interface is shown- 2 tabs at the bottom containing separate views- LogWaste and Dashboard

            } else {
        
        //builds the signed out interface
                
                LoginView() .environmentObject(auth)
                
        //displays the login screen if isSignedIn is false
                
            }
        }
    }
}
//Group { ... }: Container to allow multiple conditional views in SwiftUI.
//if auth.isSignedIn { ... } else { ... }: Decides which view to show based on login state.
//TabView: Creates a tabbed interface for the main app (after login).
//.environmentObject(...): Shares the same instance of the object across child views so that they can read/write to it.
//accentColor(.green): Sets the tab bar’s accent color.


#Preview {
    let auth = AuthManager()
    let wasteManager = WasteManager()
    
    // Add mock data
    wasteManager.addItem(type: "Organic", notes: "Banana peel", image: nil)
    wasteManager.addItem(type: "Plastic", notes: "Bottle", image: nil)
    wasteManager.addItem(type: "Packaging", notes: "Cardboard box", image: nil)
    
    // Simulate signed-in user
    let user = User(id: UUID().uuidString, name: "TestUser", email: "test@example.com")
    auth.signInGuest(user)
    
    return ContentView()
        .environmentObject(auth)
        .environmentObject(wasteManager)
}


//Key Concepts in ContentView.swift:
//State management with @StateObject.
//Conditional rendering based on authentication.
//EnvironmentObject injection → allows child views to access shared data.
//SwiftUI TabView → multiple tabs, each with its own view.
