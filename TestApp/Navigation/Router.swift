//
//  Router.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import UIKit

protocol MainRouterProtocol {
    var assembly: AssemblyProtocol? { get set }
}

protocol RouterProtocol: MainRouterProtocol {
    func showSeasonsScreen(leagueId: String, currentNC: UINavigationController?)
    func showStandingsScreen(leagueId: String, seasonYear: String, seasons: [Season], currentNC: UINavigationController?)
}

final class Router: RouterProtocol {
    var assembly: AssemblyProtocol?
    
    init(assembly: AssemblyProtocol) {
        self.assembly = assembly
    }
    
    func showSeasonsScreen(leagueId: String, currentNC: UINavigationController?) {
        guard let vc = assembly?.createSeasonsScreen(leagueId: leagueId, router: self) else { return }
        currentNC?.pushViewController(vc, animated: true)
    }
    
    func showStandingsScreen(leagueId: String, seasonYear: String, seasons: [Season], currentNC: UINavigationController?) {
        guard let vc = assembly?.createStandingsScreen(leagueId: leagueId, seasonYear: seasonYear, seasons: seasons, router: self) else { return }
        currentNC?.pushViewController(vc, animated: true)
    }
}
