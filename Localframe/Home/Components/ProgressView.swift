//
//  ProgressView.swift
//  Localframe
//
//  Created by Timo Köthe on 27.07.25.
//

import SwiftUI

struct ProgressView: View {
    @Bindable var vm: HomeViewModel
    var body: some View {
        VStack {
            Text("Is Generating")
        }
    }
}

#Preview {
    ProgressView(vm: HomeViewModel())
}
