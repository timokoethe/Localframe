//
//  PlaygroundView.swift
//  auronexa
//
//  Created by Timo Köthe on 02.07.25.
//

import SwiftUI
import UIKit
import ImagePlayground


struct HomeView: View {
    @State private var vm = HomeViewModel()
    
    var body: some View {
        
        switch vm.state {
        case .idle:
            GeneratorView(vm: vm)
        case .isGenerating:
            Text("Generating")
        case .generated:
            if let images = vm.generatedImages {
                VStack(){
                    ForEach(images, id: \.self){ selectedImage in
                        Image(uiImage: UIImage(cgImage: selectedImage))
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
                }
            }
        case .error:
            ErrorView(error: vm.creatorError)
        }
    }
}

#Preview {
    HomeView()
}
