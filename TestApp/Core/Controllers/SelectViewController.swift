//
//  SelectViewController.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import UIKit

protocol SelectViewProtocol {
    var delegate: SelectViewDelegateProtocol? { get set }
}

final class SelectViewController: UIViewController, SelectViewProtocol {
    
    let cellId = String(describing: SelectViewController.self)
    var seasons: [Season]!
    var delegate: SelectViewDelegateProtocol?
    
    private let cellHeight: CGFloat = 36
    private let headerHeight: CGFloat = 40
    
    lazy var tableView = UITableView()
    
    init(seasons: [Season], delegate: SelectViewDelegateProtocol) {
        self.seasons = seasons
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupTableView()
        setupLayout()
    }
    
    private func setupVC() {
        view.backgroundColor = Resources.Colors.appGreen
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.sectionHeaderTopPadding = 0
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.prepareForAutoLayout()
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension SelectViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let season = seasons[indexPath.row]
        cell.textLabel?.text = season.displayName
        cell.textLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedYear = seasons[indexPath.row].year
        delegate?.changeSeason(to: selectedYear.description)
        dismiss(animated: true)
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
        nameLabel.text = "Choose a season"
        nameLabel.font = .systemFont(ofSize: 18, weight: .medium)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        
        header.addSubview(nameLabel)
        nameLabel.prepareForAutoLayout()
        
        let constraints = [
            nameLabel.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        return header
    }
}
