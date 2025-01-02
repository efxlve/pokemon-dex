//
//  Dex3App.swift
//  Dex3
//
//  Created by Muharrem Efe Çayırbahçe on 28.12.2024.
//

import SwiftUI

@main
struct Dex3App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
