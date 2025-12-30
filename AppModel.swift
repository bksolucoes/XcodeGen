import Foundation
import Combine

final class AppModel: ObservableObject {
    @Published var routines: [Routine] = SampleData.defaultRoutines
    @Published var settings = UserSettings(defaultDuration: 180, notificationTime: nil, notificationsEnabled: true)
}