//
//  SearchView.swift
//  DeTeXt
//
//  Created by Venkat on 10/9/20.
//

import SwiftUI

struct SearchView: View {

    @State var searchText = ""
    @ObservedObject var symbols: Symbols
    @State private var showAboutView = false

    @EnvironmentObject private var tabController: TabController

    var body: some View {
        NavigationStack {
            List(
                symbols.allSymbols.filter {
                    if searchText.isEmpty {
                        return true
                    }

                    if $0.command.lowercased().contains(searchText.lowercased()) {
                        return true
                    }

                    return $0.package?.lowercased().contains(searchText.lowercased()) ?? false
                }
            ) { symbol in
                RowView(symbol: symbol)
                    .onDrag {
                        NSItemProvider(object: symbol.command as NSString)
                    }
                    .frame(minHeight: 70)
            }
            .listStyle(InsetListStyle())
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search by command or package"
            )
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)

#if targetEnvironment(macCatalyst)
            .navigationTitle("Search")
#else
            .toolbar {
                Button(
                    action: {
                        self.showAboutView.toggle()
                    },
                    label: {
                        Image(systemName: "questionmark.circle")
                            .font(.title3)
                            .accessibility(label: Text("About"))
                    }
                )
            }
            .navigationTitle("Search")
            .sheet(
                isPresented: $showAboutView,
                onDismiss: {
                    tabController.open(.search)
                },
                content: {
                    AboutView()
                }
            )
#endif
        }
    }
}

struct SearchView_Previews: PreviewProvider {

    static let symbols = Symbols()

    static var previews: some View {
        Group {
            SearchView(symbols: symbols)
        }
    }
}
