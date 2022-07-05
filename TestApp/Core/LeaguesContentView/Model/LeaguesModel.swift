//
//  Model.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import Foundation

struct Leagues: Decodable {
    let status: Bool
    let data: [League]
}

struct League: Decodable {
    let id: String
    let name: String
    let slug: String
    let abbr: String
    let logos: Logos
}

struct Logos: Decodable {
    let light: String
    let dark: String
}


