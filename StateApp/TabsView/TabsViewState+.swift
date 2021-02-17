//
//  TabsViewState.swift
//  StateApp
//
//  Created by Евгений Суханов on 17.02.2021.
//

extension TabsViewState {
    enum Tab {
        case all, avia, train, bus
    }
    enum Style {
        case `static`
        case dynamic(ContentStatus)
    }
    enum ContentStatus {
        case content(Content)
        case noTicket
    }
    struct Content {
        let price: Money
        let duration: Duration
    }
    enum State {
        case all
        case avia(ContentStatus?)
        case train(ContentStatus?)
        case bus(ContentStatus?)
    }
}

extension TabsViewState.Content {
    struct Money {
        let value: UInt
        let currency: Currency

        var string: String {
            "\(value) \(currency.rawValue)"
        }
    }
    enum Currency: String {
        case rub = "₽", dollar = "$"
    }
    struct Duration {
        let hours: UInt
        let minutes: UInt

        var string: String {
            "\(hours) h \(minutes) m"
        }
    }
}
