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
            .pickerStyle(.segmented)
            .padding()
            
            TextField("Prompt ...", text: $vm.prompt)
                .textFieldStyle(.roundedBorder)
                .padding()
                
            Spacer()

            Button("Generate") {
                Task {
                    do {
                        try await vm.generateImage()
                    } catch {
                        print("Error")
                    }

                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(vm.prompt.isEmpty)
        }
    }
}

#Preview {
    GeneratorView(vm: HomeViewModel())
}
