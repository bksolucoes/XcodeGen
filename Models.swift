import Foundation

struct Exercise: Identifiable, Codable {
    let id: UUID
    var title: String
    var duration: Int // seconds
    var description: String?

    init(id: UUID = UUID(), title: String, duration: Int, description: String? = nil) {
        self.id = id
        self.title = title
        self.duration = duration
        self.description = description
    }
}

struct Routine: Identifiable, Codable {
    let id: UUID
    var name: String
    var exercises: [Exercise]

    var totalDuration: Int {
        exercises.reduce(0) { $0 + $1.duration }
    }

    init(id: UUID = UUID(), name: String, exercises: [Exercise]) {
        self.id = id
        self.name = name
        self.exercises = exercises
    }
}

final class UserSettings: ObservableObject {
    @Published var defaultDuration: Int
    @Published var notificationTime: DateComponents?
    @Published var notificationsEnabled: Bool

    init(defaultDuration: Int = 180, notificationTime: DateComponents? = nil, notificationsEnabled: Bool = true) {
        self.defaultDuration = defaultDuration
        self.notificationTime = notificationTime
        self.notificationsEnabled = notificationsEnabled
    }
}