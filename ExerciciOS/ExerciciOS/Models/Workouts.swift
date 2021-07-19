//
//  WorkoutList.swift
//  ExerciciOS
//
//  Created by Fabricio Cordella on 07/07/21.
//

import Foundation

// MARK: - WorkoutGroup
struct WorkoutGroup: Codable {
    let category: WorkoutCategory
    let description: String
    let workout: [Workout]

    enum CodingKeys: String, CodingKey {
        case category = "categoria"
        case description = "descricao"
        case workout = "exercicios"
    }
}

enum WorkoutCategory: String, Codable {
    case bodybuilding = "Musculação"
    case aerobic = "Aeróbicos"
}

// MARK: - Workout
struct Workout: Codable, Hashable, Equatable {
    let id: Int
    let name: String
    let image: String
    let options: [String]?
    var selectedOption: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "nome"
        case image = "imagem"
        case options = "opcoes"
        case selectedOption
    }
}

extension Workout {
    static func mock() -> Workout {        
        .init(id: 0, name: "Halteres", image: "https://raw.githubusercontent.com/hedojunior/exercicios-imagens/main/015-pull%20up%20bar.png", options: [
            "Iniciante (9 repetições)",
            "Intermediário (12 repetições)",
            "Avançado (15 repetições)"
        ])
    }
}
