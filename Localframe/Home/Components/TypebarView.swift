//
//  TypebarView.swift
//  Localframe
//
//  Created by Timo Köthe on 12.01.26.
//

import SwiftUI

/// A view that provides the input area for composing and sending a prompt.
///
/// The type bar consists of:
/// - A `TextField` for entering user input
/// - A send button with a paper plane icon that starts image generation
///
/// The send button is disabled when the input field is empty.
/// The entire type bar is styled with padding and a rounded rectangular border
/// to distinguish it from the generation area.
///
/// This view is typically placed at the bottom of the generation screen as the main input control.
struct TypebarView: View {
    @Bindable var vm: HomeViewModel
    
    var body: some View {
        HStack {
            TextField("Type here ...", text: $vm.inputPrompt)
                .padding(.horizontal, 6)

            Button(role: .confirm) {
                Task {
                    await vm.generateImages()
                }
            } label: {
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30)
                    .padding(.trailing, 6)
                    .padding(.vertical, 2)
            }
            .foregroundStyle(canGenerate ? Color("Tint") : .gray)
            .disabled(!canGenerate)
        }
        .padding(6)
        .glassEffect()
        .padding()
    }

    private var canGenerate: Bool {
        vm.isCreatorReady && !vm.inputPrompt.isEmpty
    }
}

#Preview {
    TypebarView(vm: HomeViewModel())
}
