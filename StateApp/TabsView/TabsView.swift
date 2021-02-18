//
//  TabsView.swift
//  StateApp
//
//  Created by Евгений Суханов on 17.02.2021.
//

import SwiftUI

struct TabsViewState {
    var avia: ContentStatus?
    var train: ContentStatus?
    var bus: ContentStatus?
    var selectedTab: TabID = .all
}

extension TabsViewState {
    static var mock = TabsViewState(
        avia: .content(.init(
            price: .init(value: 10, currency: .rub),
            duration: .init(hours: 10, minutes: 10)
        )),
        train: .noTicket,
        bus: nil,
        selectedTab: .avia
    )
}

struct TabsView: View {
    @State var state: TabsViewState

    var body: some View {
        HStack {
            ForEach(
                [TabsViewState.Tab.all, .avia(state.avia), .train(state.train), .bus(state.bus)],
                id: \.tab
            ) { tabViewState in
                TabView(state: .init(
                    kind: .init(state: tabViewState),
                    isSelected: state.selectedTab == tabViewState.tab
                ))
            }
            Spacer()
        }
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(hex: 0xf3f4f9)
                .ignoresSafeArea()
            TabsView(state: .mock)
                .padding(16)
        }
    }
}

// Mapping
private extension TabViewState.Kind {
    init(state: TabsViewState.Tab) {
        switch state {
        case .all:
            self = .static(icon: state.tab.icon)
        case .avia(let contentStatus),
             .train(let contentStatus),
             .bus(let contentStatus):
            self = .dynamic(.init(
                contentStatus: contentStatus,
                tab: state.tab
            ))
        }
    }
}

private extension TabViewState.Kind.ContentState {
    init(
        contentStatus: TabsViewState.ContentStatus?,
        tab: TabsViewState.TabID
    ) {
        switch contentStatus {
        case .content(let content):
            self = .loaded(.init(
                icon: tab.icon,
                price: content.price.string,
                duration: content.duration.string
            ))
        case .noTicket:
            self = .noTicket(.init(icon: tab.icon))
        case .none:
            self = .loading(.init(icon: tab.icon))
        }
    }
}

private extension TabsViewState.TabID {
    var icon: String {
        switch self {
        case .all:
            return "FeedTabs/all"
        case .avia:
            return "FeedTabs/avia"
        case .train:
            return "FeedTabs/train"
        case .bus:
            return "FeedTabs/bus"
        }
    }
}

private extension TabsViewState.Tab {
    var tab: TabsViewState.TabID {
        switch self {
        case .all:
            return .all
        case .avia:
            return .avia
        case .train:
            return .train
        case .bus:
            return .bus
        }
    }
}
