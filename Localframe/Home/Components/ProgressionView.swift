//
//  ProgressionView.swift
//  Localframe
//
//  Created by Timo Köthe on 27.07.25.
//

import SwiftUI

/// A view that displays the generation progress and allows restarting the process.
///
/// The progression view consists of:
/// - Two square progress indicators displayed in rounded containers
/// - A restart button that resets the generation state after both images are generated
///
/// Each progress indicator is embedded in a `ZStack` with a rounded rectangular
/// background to visually separate it from surrounding content.
///
/// The restart button triggers the `reset` function on the associated
/// `HomeViewModel` and is disabled while content is currently being generated.
///
/// This view is typically placed within the main content area of the home screen
/// to provide feedback about ongoing operations and offer a reset option.
struct ProgressionView: View {
    @Bindable var vm: HomeViewModel
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemBackground))
                ProgressView()
            }
            .aspectRatio(1, contentMode: .fit)

            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.secondarySystemBackground))
                ProgressView()
            }
            .aspectRatio(1, contentMode: .fit)
            
            Button("Restart", action: vm.reset)
                .buttonStyle(.glass)
                .padding()
                .disabled(vm.viewState == .isGenerating)
        }
        .padding()
    }
}

#Preview {
    ProgressionView(vm: HomeViewModel())
}
