//
//  GeneratorView.swift
//  Localframe
//
//  Created by Timo Köthe on 24.07.25.
//

import SwiftUI
import ImagePlayground

/// A view that provides controls for configuring and starting content generation.
///
/// The generator view consists of:
/// - A segmented picker for selecting the generation style
/// - A type bar anchored at the bottom for entering and submitting prompts
///
/// The picker displays all available styles from the associated `HomeViewModel`
/// and binds the current selection to `generationStyle`.
///
/// The `TypebarView` is inserted using a safe area inset at the bottom edge,
/// ensuring it stays anchored above system UI elements while remaining visually
/// separated from the main content area.
///
/// This view is typically used as the primary interaction screen where users
/// choose a style and initiate the generation process.
struct GeneratorView: View {
    @Bindable var vm: HomeViewModel
    var body: some View {
        VStack {
            Picker("Style", selection: $vm.generationStyle) {
                ForEach(vm.styles, id: \.self) { style in
                    Text(style.id.description)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            Spacer()
                .safeAreaInset(edge: .bottom, spacing: 0) {
                    TypebarView(vm: vm)
                }
        }
    }
}

#Preview {
    GeneratorView(vm: HomeViewModel())
}
