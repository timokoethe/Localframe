//
//  GenerationView.swift
//  Localframe
//
//  Created by Timo Köthe on 27.07.25.
//

import SwiftUI

struct GenerationView: View {
    @Bindable var vm: HomeViewModel
    var body: some View {
        Text("Is Generating")
    }
}

#Preview {
    GenerationView(vm: HomeViewModel())
}
