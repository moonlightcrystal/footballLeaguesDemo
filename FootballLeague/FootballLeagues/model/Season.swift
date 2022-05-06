//
//  Season.swift
//  FootballLeagues
//
//  Created by Kristina Rudakova on 06.05.22.
//

import Foundation

// MARK: - ResponseLeagues
struct ResponseLeaguesSeason: Codable {
    let status: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let desc: String
    let seasons: [Season]
}

// MARK: - Season
struct Season: Codable {
    let year: Int
    let startDate, endDate, displayName: String
    let types: [SeasonInfo]
}

// MARK: - TypeElement
struct SeasonInfo: Codable {
    let id, name, abbreviation, startDate: String
    let endDate: String
    let hasStandings: Bool
}
