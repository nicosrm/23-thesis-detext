//
//  MainView.swift
//  iOS
//
//  Created by Venkat on 3/10/20.
//

import SwiftUI
import UIKit

// Enumeration of two major view in app
enum Tab {
    case draw
    case search
}

// Tabcontroller controls active TabView
class TabController: ObservableObject {

    @Published var activeTab = Tab.draw

    func open(_ tab: Tab) {
        activeTab = tab
    }
}

struct MainView: View {

    @StateObject private var tabController = TabController()

    @ObservedObject var labelScores: LabelScores
    @ObservedObject var symbols: Symbols

    var body: some View {
        TabView(selection: $tabController.activeTab) {
            CanvasView(labelScores: labelScores, symbols: symbols)
                .tag(Tab.draw)
                .tabItem {
                    Image(systemName: "scribble")
                        .accessibility(
                            label: Text(Localizables.Accessibility.drawSymbols)
                        )
                        .accessibility(
                            hint: Text(Localizables.Accessibility.searchEntireListDrawing)
                        )
                    Text("Draw")
                }

            SearchView(symbols: symbols)
                .tag(Tab.search)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .accessibility(label: Text(Localizables.Accessibility.searchSymbols))
                        .accessibility(hint: Text(Localizables.Accessibility.searchEntireListName))
                    Text(Localizables.search)
                }
        }
        .environmentObject(tabController)
        .onAppear {
            let appearance = UITabBarAppearance()
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

// MARK: - Localizables

private extension MainView {

    enum Localizables {

        static var search: String {
            "Search"
        }
    }
}

private extension MainView.Localizables {

    enum Accessibility {

        static var drawSymbols: String {
            "Draw symbols"
        }

        static var searchEntireListDrawing: String {
            "Search the entire list of 1098 LaTeX symbols by drawing on a canvas."
        }

        static var searchEntireListName: String {
            "Search the entire list of 1098 LaTeX symbols by name."
        }

        static var searchSymbols: String {
            "Search symbols"
        }
    }
}

// MARK: - Previews

struct MainView_Previews: PreviewProvider {

    static let symbols = Symbols()
    static let labelScores = LabelScores()

    static var previews: some View {
        Group {
            MainView(labelScores: labelScores, symbols: symbols)
        }
    }
}
