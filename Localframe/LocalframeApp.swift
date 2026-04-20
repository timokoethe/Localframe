//
//  LocalframeApp.swift
//  Localframe
//
//  Created by Timo Köthe on 19.07.25.
//

import SwiftUI

/// The main entry point of the app, presenting `HomeView` in the main window.
@main
struct LocalframeApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
