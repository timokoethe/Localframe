//
//  ErrorView.swift
//  Localframe
//
//  Created by Timo Köthe on 27.07.25.
//

import SwiftUI
import ImagePlayground

/// A view that presents an error state when image generation fails.
///
/// The error view consists of:
/// - A system-styled content unavailable view displaying an error message
/// - A fallback message for unexpected or unknown errors
///
/// If an `ImageCreator.Error` is provided, its localized description is shown
/// to give the user more information about what went wrong.
///
/// When no specific error is available, a generic "Unexpected Error" message
/// is displayed instead.
///
/// This view is typically presented in place of main content to clearly
/// communicate failure states and prevent further interaction until resolved.
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
