import SwiftUI
import UIKit

final class PlayerViewModel: ObservableObject {
    @Published var currentIndex: Int = 0
    @Published var remainingSeconds: Int
    @Published var isRunning: Bool = false

    private var routine: Routine
    private var timer: Timer?

    init(routine: Routine) {
        self.routine = routine
        self.remainingSeconds = routine.exercises.first?.duration ?? 0
    }

    var currentExercise: Exercise {
        routine.exercises[currentIndex]
    }

    var totalExercises: Int {
        routine.exercises.count
    }

    func start() {
        guard !isRunning else { return }
        isRunning = true
        // schedule on main run loop
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    func pause() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    private func tick() {
        guard remainingSeconds > 0 else {
            advance()
            return
        }
        remainingSeconds -= 1
    }

    func advance() {
        timer?.invalidate()
        timer = nil
        isRunning = false
        if currentIndex + 1 < routine.exercises.count {
            currentIndex += 1
            remainingSeconds = routine.exercises[currentIndex].duration
            start()
        } else {
            // finished routine
            vibrateShort()
        }
    }

    func skip() {
        timer?.invalidate()
        timer = nil
        if currentIndex + 1 < routine.exercises.count {
            currentIndex += 1
            remainingSeconds = routine.exercises[currentIndex].duration
        } else {
            remainingSeconds = 0
            vibrateShort()
        }
    }

    private func vibrateShort() {
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
}

struct PlayerView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm: PlayerViewModel
    var onFinish: (() -> Void)?

    init(routine: Routine, onFinish: (() -> Void)? = nil) {
        _vm = StateObject(wrappedValue: PlayerViewModel(routine: routine))
        self.onFinish = onFinish
    }

    var body: some View {
        VStack(spacing: 20) {
            Text(vm.currentExercise.title)
                .font(.title2)
                .bold()
                .padding(.top)

            if let desc = vm.currentExercise.description, !desc.isEmpty {
                Text(desc)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            ZStack {
                Circle()
                    .stroke(lineWidth: 12)
                    .opacity(0.2)
                    .foregroundColor(.blue)
                    .frame(width: 180, height: 180)

                Text(timeString(vm.remainingSeconds))
                    .font(.system(size: 40, weight: .semibold, design: .rounded))
            }
            .padding()

            HStack(spacing: 20) {
                Button(action: {
                    if vm.isRunning { vm.pause() } else { vm.start() }
                }) {
                    Image(systemName: vm.isRunning ? "pause.fill" : "play.fill")
                        .font(.title2)
                        .frame(width: 60, height: 44)
                }
                .buttonStyle(.borderedProminent)

                Button(action: { vm.skip() }) {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                        .frame(width: 60, height: 44)
                }
                .buttonStyle(.bordered)

                Button("Encerrar") {
                    vm.pause()
                    dismiss()
                }
                .foregroundColor(.red)
            }

            Spacer()
        }
        .padding()
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            vm.pause()
        }
        .onChange(of: vm.remainingSeconds) { newValue in
            if newValue == 0 && vm.currentIndex == vm.totalExercises - 1 {
                // finished full routine
                vm.pause()
                vm.skip() // ensure vibration is triggered
                onFinish?()
                dismiss()
            }
        }
    }

    func timeString(_ s: Int) -> String {
        let m = s / 60
        let sec = s % 60
        return String(format: "%d:%02d", m, sec)
    }
}