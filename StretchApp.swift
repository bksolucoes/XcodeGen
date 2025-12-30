import SwiftUI

@main
struct StretchApp: App {
    @StateObject private var model = AppModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .environmentObject(model)
            }
            .onAppear {
                NotificationManager.shared.requestAuthorization()
            }
        }
    }
}