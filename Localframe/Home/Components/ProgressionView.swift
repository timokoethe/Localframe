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
            ProgressView()
        }
    }
}

#Preview {
    ProgressionView(vm: HomeViewModel())
}
