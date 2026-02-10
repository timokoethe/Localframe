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
