//
//  League.swift
//  FootballLeagues
//
//  Created by Kristina Rudakova on 06.05.22.
//

import Foundation
// MARK: - ResponseLeagues
struct ResponseLeagues: Codable {
    let status: Bool
    let data: [League]
}

// MARK: - League
struct League: Codable {
    let id, name, slug, abbr: String
    let logos: Logos
}

// MARK: - Logos
struct Logos: Codable {
    let light, dark: String
}


