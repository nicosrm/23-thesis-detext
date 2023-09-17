//
//  DeTeXtApp.swift
//  Shared
//
//  Created by Venkat on 29/8/20.
//

import SwiftUI
import PencilKit

class LabelScores: ObservableObject {

    typealias Score = (key: String, value: Double)

    @Published var scores = [Score]()

    func clearScores() {
        self.scores = [Score]()
    }
}

@main
struct DeTeXtApp: App {

    @StateObject var symbols = Symbols()
    @StateObject var labelScores: LabelScores = LabelScores()

    var body: some Scene {
        #if targetEnvironment(macCatalyst)
        WindowGroup {
            TwoColumnMainView(labelScores: labelScores, symbols: symbols)
        }
        .commands {
            CommandGroup(replacing: .help, addition: {
                Link("Contact Support...",
                     destination: URL(string: "mailto:venkat@venkatasg.net")!)

                Divider()

                Link("Release Notes",
                     destination: URL(string: "https://venkatasg.net/apps/detext#release-notes")!)
                Link("GitHub Repository",
                     destination: URL(string: "https://github.com/venkatasg/DeTeXt")!)
            })

            CommandGroup(after: CommandGroupPlacement.undoRedo) {
                Button("Clear Canvas") {
                    self.labelScores.clearScores()
                }
                .keyboardShortcut("r", modifiers: [.command])
            }
        }
        #else
        WindowGroup {
            MainView(labelScores: labelScores, symbols: symbols)
        }
        .commands {
            CommandGroup(after: CommandGroupPlacement.undoRedo) {
                Button("Clear Canvas") {
                    self.labelScores.clearScores()
                }
                .keyboardShortcut("r", modifiers: [.command])
            }
        }
        #endif
    }
}
