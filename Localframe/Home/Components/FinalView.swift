//
//  FinalView.swift
//  Localframe
//
//  Created by Timo Köthe on 27.07.25.
//

import SwiftUI

/// A view that displays the final generated images and provides a restart option.
///
/// The final view consists of:
/// - A vertical list of generated images displayed with rounded corners
/// - A restart button to reset the generation workflow
///
/// Generated images are retrieved from `generatedImages` on the associated
/// `HomeViewModel` and rendered using SwiftUI `Image` views.
///
/// Each image is scaled to fit its container and clipped to a rounded
/// rectangular shape for a polished appearance.
///
/// The restart button invokes the `reset` function on the view model and allows
/// the user to return to the initial generation state.
///
/// This view is typically presented after the generation process completes
/// to showcase results and allow starting a new generation cycle.
struct FinalView: View {
    @Bindable var vm: HomeViewModel
    var body: some View {
        VStack {
            if !vm.generatedCGImages.isEmpty {
                VStack {
                    ForEach(vm.generatedCGImages, id: \.self){ selectedImage in
                        Image(uiImage: UIImage(cgImage: selectedImage))
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 16))
                    }
                }
            }

            Spacer()

            Button("Restart", action: vm.reset)
                .foregroundStyle(.purple)
                .buttonStyle(.glass)
                .padding()
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var vm = HomeViewModel()

    if let cgImage = UIImage(named: "Image01.Test")?.cgImage {
        vm.generatedCGImages = [cgImage]
    }
    if let cgImage = UIImage(named: "Image02.Test")?.cgImage {
        vm.generatedCGImages.append(cgImage)
    }

    return FinalView(vm: vm)
}
