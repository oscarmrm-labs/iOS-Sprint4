import SwiftUI

@main
struct Sprint4App: App {
    @StateObject private var dataController = Sprint4CoreData()

    var body: some Scene {
        WindowGroup {
            ContactScreen(coreData: dataController)
                .environment(\.managedObjectContext,dataController.container.viewContext)
        }
    }
}
