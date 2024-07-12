//
//  Sprint4App.swift
//  Sprint4
//
//  Created by Óscar M on 8/7/24.
//

import SwiftUI

@main
struct Sprint4App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
