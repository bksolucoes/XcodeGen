import Foundation

enum SampleData {
    static let threeMinuteRoutine = Routine(
        name: "3 Min - Rápido",
        exercises: [
            Exercise(title: "Rotação de ombros", duration: 30, description: "Rotacione para frente e para trás, devagar."),
            Exercise(title: "Inclinação do pescoço", duration: 30, description: "Incline cada lado, respire."),
            Exercise(title: "Pulsos e mãos", duration: 30, description: "Estique dedos e empurre o pulso."),
            Exercise(title: "Alongamento de peito", duration: 30, description: "Apoie o braço na porta e abra o peito."),
            Exercise(title: "Flexão lombar sentado", duration: 30, description: "Incline-se à frente mantendo coluna neutra."),
            Exercise(title: "Panturrilha em pé", duration: 30, description: "Apoie-se em algo e estique a panturrilha.")
        ]
    )

    static let defaultRoutines: [Routine] = [
        threeMinuteRoutine,
        Routine(name: "1 Min - Quick", exercises: [
            Exercise(title: "Respiração profunda", duration: 20),
            Exercise(title: "Along. de pescoço", duration: 20),
            Exercise(title: "Along. de ombro", duration: 20)
        ]),
        Routine(name: "5 Min - Full", exercises: [
            Exercise(title: "Pescoço", duration: 60),
            Exercise(title: "Ombros", duration: 60),
            Exercise(title: "Pulsos", duration: 30),
            Exercise(title: "Peito", duration: 45),
            Exercise(title: "Lombar", duration: 45),
            Exercise(title: "Pernas", duration: 60)
        ])
    ]
}