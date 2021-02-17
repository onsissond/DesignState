//
//  TabView.swift
//  StateApp
//
//  Created by Евгений Суханов on 17.02.2021.
//

import SwiftUI

struct LoadingTabViewState {
    let icon: String
}
private struct LoadingTabView: View {
    @State var state: LoadingTabViewState

    var body: some View {
        HStack(alignment: .top) {
            Image(state.icon)
                .renderingMode(.template)
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}

struct NoTicketViewState {
    let icon: String
}
private struct NoTicketTabView: View {
    @State var state: NoTicketViewState

    var body: some View {
        VStack(alignment: .leading) {
            Image(state.icon)
                .renderingMode(.template)
            Text("Нет билетов")
                .font(.caption2)
        }
    }
}

struct ContentTabViewState {
    let icon: String
    let price: String
    let duration: String
}
private struct ContentTabView: View {
    @State var state: ContentTabViewState

    var body: some View {
        HStack(alignment: .top) {
            Image(state.icon)
                .renderingMode(.template)
            VStack(alignment: .leading, spacing: 4) {
                Text(state.price)
                    .bold()
                    .font(.subheadline)
                Text(state.duration)
                    .font(.caption2)
            }
        }
    }
}

struct TabViewState {
    enum Kind {
        enum ContentState {
            case noTicket(NoTicketViewState)
            case loading(LoadingTabViewState)
            case loaded(ContentTabViewState)
        }
        case `static`(icon: String)
        case dynamic(ContentState)
    }
    var kind: Kind
    var isSelected: Bool
}

struct TabView: View {
    @State var state: TabViewState

    var body: some View {
        ZStack {
            switch state.kind {
            case .static(let icon):
                Image(icon)
                    .renderingMode(.template)
                    .frame(minWidth: 44)
            case .dynamic(let contentState):
                VStack(alignment: .leading) {
                    switch contentState {
                    case .noTicket(let noTicketState):
                        NoTicketTabView(state: noTicketState)
                    case .loading(let loadingState):
                        LoadingTabView(state: loadingState)
                            .frame(width: 84)
                    case .loaded(let content):
                        ContentTabView(state: content)
                    }
                    Spacer()
                }
                .frame(minWidth: 84)
            }
        }
        .frame(height: 44)
        .padding(6)
        .background(state.backgroundColor)
        .foregroundColor(state.foregroundColor)
        .progressViewStyle(CircularProgressViewStyle(
            tint: state.foregroundColor
        ))
        .cornerRadius(8)
    }
}

extension TabViewState {
    var foregroundColor: Color {
        isSelected
            ? Color.black
            : Color.white
    }

    var backgroundColor: Color {
        isSelected
            ? Color.white
            : Color(hex: 0x1e3047)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            TabView(state: .init(
                kind: .static(icon: "FeedTabs/all"),
                isSelected: true
            ))
            TabView(state: .init(
                kind: .dynamic(.noTicket(.init(
                    icon: "FeedTabs/avia"
                ))),
                isSelected: false
            ))
            TabView(state: .init(
                kind: .dynamic(.loading(.init(
                    icon: "FeedTabs/avia"
                ))),
                isSelected:  true
            ))
            TabView(state: .init(
                kind: .dynamic(.loaded(.init(
                    icon: "FeedTabs/avia",
                    price: "1 764 ₽",
                    duration: "1 ч 25 м"
                ))),
                isSelected: true
            ))
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .center
        )
        .background(Color(hex: 0xf3f4f9))
    }
}
