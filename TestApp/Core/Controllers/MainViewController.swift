//
//  ViewController.swift
//  TestApp
//
//  Created by Mikhail Kostylev on 04.07.2022.
//

import UIKit

protocol MainViewControllerDelegate: AnyObject {
    var mainViewControllerDelegate: MainViewController? { get set }
}

final class MainViewController: UIViewController {
    
    var contentView: UIView!
    
    init(contentView: UIView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupLayout()
    }
    
    func setNavigationBarTitle(to title: String) {
        navigationItem.setTitle(with: title)
    }
    
    private func setupVC() {
        view.backgroundColor = Resources.Colors.appGreen
    }
    
    private func setupLayout() {
        view.addSubview(contentView)
        contentView.prepareForAutoLayout()
        
        let constraints = [
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
