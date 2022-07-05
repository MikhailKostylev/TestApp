//
//  SeasonsModel.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import Foundation

struct LeagueSeasons: Decodable {
    let status: Bool
    let data: Seasons
}

struct Seasons: Decodable {
    let desc: String
    let seasons: [Season]
}

struct Season: Decodable {
    let year: Int
    let startDate: String
    let endDate: String
    let displayName: String
    let types: [SeasonType]
}

struct SeasonType: Decodable {
    let id: String
    let name: String
    let abbreviation: String
    let startDate: String
    let endDate: String
    let hasStandings: Bool
}
