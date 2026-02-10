//
//  ProgressionView.swift
//  Localframe
//
//  Created by Timo Köthe on 27.07.25.
//

import SwiftUI

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
                .disabled(vm.state == .isGenerating)
        }
        .padding()
    }
}

#Preview {
    ProgressionView(vm: HomeViewModel())
}
