//
//  Assembly.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import UIKit

protocol AssemblyProtocol {
    func createLeaguesScreen(router: Router) -> UIViewController
    func createSeasonsScreen(leagueId: String, router: Router) -> UIViewController
    func createStandingsScreen(leagueId: String, seasonYear: String, seasons: [Season], router: Router) -> UIViewController
}

final class Assembly: AssemblyProtocol {
    
    func createLeaguesScreen(router: Router) -> UIViewController {
        let contentView = LeaguesView(frame: UIScreen.main.bounds)
        let viewController = MainViewController(contentView: contentView)
        let presenter = LeaguesPresenter(
            viewController: viewController, contentView: contentView, router: router)
        contentView.presenter = presenter
        return viewController
    }
    
    func createSeasonsScreen(leagueId: String, router: Router) -> UIViewController {
        let contentView = SeasonsView(frame: UIScreen.main.bounds)
        let viewController = MainViewController(contentView: contentView)
        let presenter = SeasonsPresenter(
            leagueId: leagueId,
            viewController: viewController, contentView: contentView, router: router)
        contentView.presenter = presenter
        return viewController
    }
    
    func createStandingsScreen(leagueId: String, seasonYear: String, seasons: [Season], router: Router) -> UIViewController {
        let contentView = StandingsView(frame: UIScreen.main.bounds)
        let viewController = MainViewController(contentView: contentView)
        let presenter = StandingsPresenter(
            leagueId: leagueId, seasonYear: seasonYear, seasons: seasons,
            viewController: viewController, contentView: contentView, router: router)
        contentView.presenter = presenter
        return viewController
    }
    
}
