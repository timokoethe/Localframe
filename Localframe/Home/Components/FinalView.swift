//
//  FinalView.swift
//  Localframe
//
//  Created by Timo Köthe on 27.07.25.
//

import SwiftUI

struct FinalView: View {
    @Bindable var vm: HomeViewModel
    var body: some View {
        VStack {
            if !vm.generatedImages.isEmpty {
                VStack(){
                    ForEach(vm.generatedImages, id: \.self){ selectedImage in
                        Image(uiImage: UIImage(cgImage: selectedImage))
                            .resizable()
                            .scaledToFit()
                            .clipShape(.rect(cornerRadius: 16))
                    }
                }
            }

            Spacer()

            Button("Restart", action: vm.reset)
                .buttonStyle(.borderedProminent)
                .padding()
        }
        .padding()
    }
}

#Preview {
    @Previewable @State var vm = HomeViewModel()

    if let cgImage = UIImage(named: "Image01.Test")?.cgImage {
        vm.generatedImages = [cgImage]
    }
    if let cgImage = UIImage(named: "Image02.Test")?.cgImage {
        vm.generatedImages.append(cgImage)
    }

    return FinalView(vm: vm)
}
