//
//  PlaygroundView.swift
//  auronexa
//
//  Created by Timo Köthe on 02.07.25.
//

import SwiftUI
import ImagePlayground

/// The primary entry point view that orchestrates the user flow for image generation.
///
/// Responsibilities:
/// - Observes the `HomeViewModel` state and presents the appropriate screen.
/// - Routes between:
///   - GeneratorView: when idle and ready for user input.
///   - ProgressionView: while an image is being generated.
///   - FinalView: after a successful generation.
///   - ErrorView: when an error occurs during generation.
///
/// Notes:
/// - Uses `@State` to own the `HomeViewModel` lifecycle within this view.
/// - This view is intended to be placed at the top of the feature's navigation stack.
struct HomeView: View {
    @State private var vm = HomeViewModel()
    
    var body: some View {
        // Shows the corresponding views depending on the state.
        switch vm.state {
        case .idle:
            GeneratorView(vm: vm)
        case .isGenerating:
            ProgressionView(vm: vm)
        case .generated:
            FinalView(vm: vm)
        case .error:
            ErrorView(error: vm.creatorError)
        }
    }
}

#Preview {
    HomeView()
}
