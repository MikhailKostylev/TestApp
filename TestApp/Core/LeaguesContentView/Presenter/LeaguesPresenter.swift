//
//  LeaguesPresenter.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import Foundation

protocol LeaguesPresenterProtocol: AnyObject {
    func showSeasonScreen(leagueId: String)
}

final class LeaguesPresenter: LeaguesPresenterProtocol {
    
    unowned let viewController: MainViewController
    unowned let contentView: LeaguesView
    let router: Router?
    
    required init(viewController: MainViewController, contentView: LeaguesView, router: Router) {
        self.viewController = viewController
        self.contentView = contentView
        self.router = router
        viewController.setNavigationBarTitle(to: "Leagues")
        loadData()
    }
    
    func loadData() {
        NetworkService.shared.dataRequest(with: "\(Constant.mainUrl)/leagues", objectType: Leagues.self) { [weak self] result in
            switch result {
            case .success(let object):
                self?.contentView.leagues = object.data
                DispatchQueue.main.async {
                    self?.contentView.collectionView.reloadData()
                    self?.contentView.spinner.stopAnimating()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func showSeasonScreen(leagueId: String) {
        router?.showSeasonsScreen(leagueId: leagueId, currentNC: viewController.navigationController)
    }
}
