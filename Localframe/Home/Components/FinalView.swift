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
            if let images = vm.generatedImages {
                VStack(){
                    ForEach(images, id: \.self){ selectedImage in
                        Image(uiImage: UIImage(cgImage: selectedImage))
                            .resizable()
                            .scaledToFit()
                    }
                }
            }

            Button("Restart", action: vm.reset)
        }
        .padding()
    }
}

#Preview {
    FinalView(vm: HomeViewModel())
}
