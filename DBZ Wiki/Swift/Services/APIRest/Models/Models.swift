//
//  Models.swift
//  DBZ Wiki
//
//  Created by Luis Galvan on 30/03/25.
//

// DragonBallModels.swift
import Foundation

// Estructura para representar una transformación de personaje
struct Transformation: Codable {
    let id: Int
    let name: String
    let image: String
    let ki: String
}

// Estructura para representar el planeta de origen
struct OriginPlanet: Codable {
    let id: Int
    let name: String
    let isDestroyed: Bool
    let description: String
    let image: String
}

// Estructura para representar un personaje de Dragon Ball
struct DBZCharacter: Identifiable,Codable {
    let id:Int
    let name: String
    let ki: String
    let maxKi: String
    let race: String
    let gender: String
    let description: String
    let image: String
    let affiliation: String
    let originPlanet: OriginPlanet?
    let transformations: [Transformation]?
}

struct allCharacter: Codable{
    let items: [DBZCharacter]
}
