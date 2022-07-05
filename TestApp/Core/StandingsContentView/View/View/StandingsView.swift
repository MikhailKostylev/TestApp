//
//  StandingsView.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import UIKit

final class StandingsView: UIView {
    
    var presenter: StandingsPresenterProtocol?
    var standings: [Standing] = []
    
    private let cellHeight: CGFloat = 36
    private let headerHeight: CGFloat = 40
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StandingsTableViewCell.self, forCellReuseIdentifier: StandingsTableViewCell.cellId)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.sectionHeaderTopPadding = 0
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

extension StandingsView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return standings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StandingsTableViewCell.cellId, for: indexPath) as? StandingsTableViewCell else {
            return SeasonsTableViewCell()
        }
        let standing = standings[indexPath.row]
        cell.setup(standing: standing)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = Resources.Colors.appGreen
        
        let nameLabel = UILabel()
        nameLabel.text = "Team name"
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        
        var teamFieldWidth = Constant.Standings.teamFieldWidth
        if Constant.isPortraitOrientation() == false {
            teamFieldWidth += Constant.Standings.nameWidth
        }
        
        header.addSubview(nameLabel)
        nameLabel.prepareForAutoLayout()
        
        let constraints = [
            nameLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: header.leadingAnchor, constant: teamFieldWidth)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        var leading = Constant.Standings.inset
        for i in 0..<Constant.Standings.totalStats {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14, weight: .medium)
            label.textColor = .white
            label.textAlignment = .center
            
            var itemWidth = Constant.Standings.itemWidth
            if i >= Constant.Standings.totalStats - 4 { itemWidth *= 1.5 }
            if i >= Constant.Standings.totalStats - 1 { itemWidth += itemWidth }
            if standings.count > 0 {
                let abbr = standings[0].stats[i].abbreviation
                label.text = abbr
            }
            
            header.addSubview(label)
            label.prepareForAutoLayout()
            
            let constraints = [
                label.centerYAnchor.constraint(equalTo: header.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: leading),
                label.widthAnchor.constraint(equalToConstant: itemWidth),
            ]
            
            NSLayoutConstraint.activate(constraints)
            
            if i >= Constant.Standings.itemsCount {
                label.isHidden = Constant.isPortraitOrientation()
            }
            
            leading += itemWidth
        }
        
        return header
    }
}
