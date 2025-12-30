import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var model: AppModel
    @State private var time = Date()
    @State private var notificationsEnabled: Bool = true

    var body: some View {
        Form {
            Section("Notificações") {
                Toggle("Ativar lembretes", isOn: $notificationsEnabled)
                    .onChange(of: notificationsEnabled) { value in
                        model.settings.notificationsEnabled = value
                        if !value {
                            NotificationManager.shared.cancelAll()
                        } else if let comp = model.settings.notificationTime {
                            NotificationManager.shared.scheduleDailyNotification(at: comp)
                        }
                    }

                DatePicker("Horário diário", selection: $time, displayedComponents: .hourAndMinute)
                    .onChange(of: time) { newDate in
                        let cal = Calendar.current
                        let comps = cal.dateComponents([.hour, .minute], from: newDate)
                        model.settings.notificationTime = comps
                        if model.settings.notificationsEnabled {
                            NotificationManager.shared.scheduleDailyNotification(at: comps)
                        }
                    }
            }

            Section("Avançado") {
                Button("Redefinir rotinas para padrão") {
                    model.routines = SampleData.defaultRoutines
                }
            }
        }
        .onAppear {
            notificationsEnabled = model.settings.notificationsEnabled
            if let comps = model.settings.notificationTime,
               let d = Calendar.current.date(from: comps) {
                time = d
            } else {
                time = Date()
            }
        }
        .navigationTitle("Configurações")
    }
}