//
//  SeasonsView.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import UIKit

protocol SeasonsViewControllerDelegate {
    func routeToStandingsModule(seasons: [Season], leagueId: String, seasonYear: String)
}

final class SeasonsView: UIView {

    var presenter: SeasonsPresenterProtocol?
    
    var seasons: [Season] = []
    
    private let cellHeight: CGFloat = 100
    
    lazy var tableView = UITableView()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.hidesWhenStopped = true
        spinner.color = .white
        return spinner
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTableView()
        setupLayout()
        spinner.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SeasonsTableViewCell.self, forCellReuseIdentifier: SeasonsTableViewCell.cellId)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = Resources.Colors.appGreen
        tableView.rowHeight = cellHeight
    }
    
    private func setupLayout() {
        addSubview(tableView)
        addSubview(spinner)
        
        tableView.prepareForAutoLayout()
        spinner.prepareForAutoLayout()
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension SeasonsView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeasonsTableViewCell.cellId, for: indexPath) as? SeasonsTableViewCell else {
            return SeasonsTableViewCell()
        }
        let season = seasons[indexPath.row]
        cell.setup(season: season)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let season = seasons[indexPath.row]
        presenter?.showStandingsScreen(seasonYear: season.year.description)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
