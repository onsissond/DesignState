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
            TabsView(state: .init(
                all: .all,
                avia: .avia(.content(.init(
                    price: .init(value: 10, currency: .rub),
                    duration: .init(hours: 10, minutes: 10)
                ))),
                train: .train(.noTicket),
                bus: .bus(nil),
                selectedTab: .avia
            ))
            .padding(16)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension TabViewState {
    static var mock = TabViewState(
        kind: .static(icon: "FeedTabs/all"),
        isSelected: true
    )
}
