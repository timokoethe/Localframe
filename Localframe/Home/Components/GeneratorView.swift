//
//  GeneratorView.swift
//  Localframe
//
//  Created by Timo Köthe on 24.07.25.
//

import SwiftUI
import ImagePlayground

struct GeneratorView: View {
    @Bindable var vm: HomeViewModel
    var body: some View {
        VStack {
            Picker("Style", selection: $vm.generationStyle) {
                ForEach(vm.styles, id: \.self) { style in
                    Text(style.id.description)
                    
                }
            }
            TextField("Prompt ...", text: $vm.prompt)
            
            
            Button("Generate") {
                Task {
                    do {
                        try await vm.generateImage()
                    } catch {
                        print("Error")
                    }

                }
            }
            
            
        }
    }
}

#Preview {
    GeneratorView(vm: HomeViewModel())
}
