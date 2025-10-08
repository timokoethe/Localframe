//
//  ErrorView.swift
//  Localframe
//
//  Created by Timo Köthe on 27.07.25.
//

import SwiftUI
import ImagePlayground

/// A view that displays that no content is available..
///
/// Error messages are presented inside a paddedcontainer for readability.
struct ErrorView: View {
    let error: ImageCreator.Error?
    
    var body: some View {
        if let error = error {
            ContentUnavailableView(error.localizedDescription, systemImage: "nosign")
        } else {
            ContentUnavailableView("Unexpected Error", systemImage: "nosign")
        }
    }
}

#Preview {
    ErrorView(error: .notSupported)
}
