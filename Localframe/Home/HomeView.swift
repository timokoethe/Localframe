//
//  PlaygroundView.swift
//  auronexa
//
//  Created by Timo Köthe on 02.07.25.
//

import SwiftUI
import ImagePlayground

struct HomeView: View {
    @State private var vm = HomeViewModel()
    
    var body: some View {
        // Shows the corresponding views depending on the state.
        switch vm.state {
        case .idle:
            GeneratorView(vm: vm)
        case .isGenerating:
            ProgressionView(vm: vm)
        case .generated:
            FinalView(vm: vm)
        case .error:
            ErrorView(error: vm.creatorError)
        }
    }
}

#Preview {
    HomeView()
}
