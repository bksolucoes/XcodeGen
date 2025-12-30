import SwiftUI

struct HomeView: View {
    @EnvironmentObject var model: AppModel
    @State private var activeRoutine: Routine?
    @State private var showPlayer = false

    var body: some View {
        List {
            Section("Rotinas rápidas") {
                ForEach(model.routines) { routine in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(routine.name).font(.headline)
                            Text("\(formatSeconds(routine.totalDuration)) • \(routine.exercises.count) exercícios")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Button("Iniciar") {
                            activeRoutine = routine
                            showPlayer = true
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.vertical, 6)
                }
            }
            Section {
                NavigationLink("Configurações") {
                    SettingsView()
                        .environmentObject(model)
                }
            }
        }
        .navigationTitle("AlongueJá")
        .sheet(isPresented: $showPlayer) {
            if let r = activeRoutine {
                PlayerView(routine: r) { /* onFinish: opcional */ }
            }
        }
    }

    func formatSeconds(_ s: Int) -> String {
        let m = s / 60
        let sec = s % 60
        if m > 0 {
            return String(format: "%dm %02ds", m, sec)
        } else {
            return String(format: "%ds", sec)
        }
    }
}