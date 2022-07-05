//
//  SeasonsPresenter.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import Foundation

protocol SeasonsPresenterProtocol: AnyObject {
    func showStandingsScreen(seasonYear: String)
}

final class SeasonsPresenter: SeasonsPresenterProtocol {
    unowned let viewController: MainViewController
    unowned let contentView: SeasonsView
    let router: Router?
    
    let leagueId: String!
    
    required init(leagueId: String, viewController: MainViewController, contentView: SeasonsView, router: Router) {
        self.viewController = viewController
        self.contentView = contentView
        self.router = router
        self.leagueId = leagueId
        viewController.setNavigationBarTitle(to: "Seasons")
        loadData(leagueId: leagueId)
    }
    
    func loadData(leagueId: String) {
        NetworkService.shared.dataRequest(with: "\(Constant.mainUrl)/leagues/\(leagueId)/seasons", objectType: LeagueSeasons.self) { [weak self] result in
            switch result {
            case .success(let object):
                self?.contentView.seasons = object.data.seasons
                DispatchQueue.main.async {
                    self?.contentView.tableView.reloadData()
                    self?.contentView.spinner.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func showStandingsScreen(seasonYear: String) {
        router?.showStandingsScreen(leagueId: leagueId, seasonYear: seasonYear, seasons: contentView.seasons, currentNC: viewController.navigationController)
    }
}
