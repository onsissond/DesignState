//
//  ContentView.swift
//  StateApp
//
//  Created by Евгений Суханов on 17.02.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(hex: 0xf3f4f9)
                .ignoresSafeArea()
            TabsView(state: .mock)
            .padding(16)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
