import Foundation
import UserNotifications
import UIKit

final class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, err in
            if let e = err {
                print("Notif auth error:", e.localizedDescription)
            }
            print("Notifications granted:", granted)
        }
    }

    func scheduleDailyNotification(at components: DateComponents, title: String = "Hora do alongamento", body: String = "Faça um quick stretch de 1–5 minutos.") {
        cancelAll()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let req = UNNotificationRequest(identifier: "daily-stretch", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(req) { err in
            if let e = err { print("Schedule error:", e.localizedDescription) }
        }
    }

    func cancelAll() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func vibrateShort() {
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
}