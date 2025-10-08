//
//  LocalframeApp.swift
//  Localframe
//
//  Created by Timo Köthe on 19.07.25.
//

import SwiftUI

/// The main application entry point.
///
/// `LocalframeApp` defines the app’s lifecycle using the SwiftUI `App` protocol.
/// It creates a single `WindowGroup` scene that displays the `ContentView`
/// as the root view of the application.
///
/// This is where the app launches and sets up its initial UI.
@main
struct LocalframeApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
