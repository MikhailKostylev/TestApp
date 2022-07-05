//
//  LeaguesView.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import UIKit

final class LeaguesView: UIView {
    
    var presenter: LeaguesPresenterProtocol?
    
    var leagues: [League] = []
    
    let horizontalInsets: CGFloat = 24
    let verticalInsets: CGFloat = 16

    lazy var collectionView = UICollectionView()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.hidesWhenStopped = true
        spinner.color = .white
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
        setupLayout()
        spinner.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: verticalInsets, left: horizontalInsets, bottom: verticalInsets, right: horizontalInsets)
        layout.minimumLineSpacing = horizontalInsets
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Resources.Colors.appGreen
        collectionView.showsVerticalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            LeaguesCollectionViewCell.self,
            forCellWithReuseIdentifier: LeaguesCollectionViewCell.cellId
        )
    }
    
    private func setupLayout() {
        addSubview(collectionView)
        addSubview(spinner)
        
        collectionView.prepareForAutoLayout()
        spinner.prepareForAutoLayout()
        
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension LeaguesView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return leagues.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LeaguesCollectionViewCell.cellId, for: indexPath) as? LeaguesCollectionViewCell else {
            return LeaguesCollectionViewCell()
        }
        let league = leagues[indexPath.row]
        cell.setup(league: league)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let league = leagues[indexPath.row]
        presenter?.showSeasonScreen(leagueId: league.id)
    }
}

extension LeaguesView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getItemSize()
    }
    
    private func getItemSize() -> CGSize {
        let b = UIScreen.main.bounds
        let lesserValue = b.width < b.height ? b.width : b.height
        let higherValue = b.width > b.height ? b.width : b.height
        var screenWidth = lesserValue
        var columns: CGFloat = Constant.Leagues.columnsPortrait
        
        switch UIDevice.current.orientation {
        case .landscapeLeft, .landscapeRight:
            columns = Constant.Leagues.columnsLandscape
            screenWidth = higherValue - Constant.getInset(view: self)
        default:
            break
        }
        
        let itemWidth = (screenWidth - (columns + 1) * horizontalInsets) / columns
        let itemHeight = itemWidth + Constant.Leagues.titleHeight
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
