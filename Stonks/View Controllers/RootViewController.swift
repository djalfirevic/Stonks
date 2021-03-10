//
//  RootViewController.swift
//  Stonks
//
//  Created by Djuro on 3/10/21.
//

import UIKit

final class RootViewController: UIViewController {
    
    // MARK: - Properties
    private let playerView = PlayerView(frame: .zero)
    private var playerViewLeadingAnchor: NSLayoutConstraint!
    private var playerViewTrailingAnchor: NSLayoutConstraint!
    private var playerViewWidthAnchor: NSLayoutConstraint!
    private var playerViewHeightAnchor: NSLayoutConstraint!
    private var playerViewTopAnchor: NSLayoutConstraint!
    private var playerViewBottomAnchor: NSLayoutConstraint!
    private let tabController = TabController()
    private var isPlayerViewInMiniMode = false

    // MARK: - Initializers
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabController.delegate = self
        layout()
    }
    
    // MARK: - Private API
    
    /// Layout the UI elements.
    private func layout() {
        view.backgroundColor = .white
        
        setupTabController()
        setupPlayerView()
    }
    
    /// Perform initial setup of `TabController`.
    private func setupTabController() {
        addChild(tabController)
        view.addSubview(tabController.view)
        tabController.didMove(toParent: self)
    }
    
    /// Setup the main `PlayerView`.
    private func setupPlayerView() {
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)
        
        playerViewTopAnchor = playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        playerViewBottomAnchor = playerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.playerViewBottomMargin)
        playerViewLeadingAnchor = playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        playerViewTrailingAnchor = playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.playerViewMinWidth)
        playerViewWidthAnchor = playerView.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        playerViewHeightAnchor = playerView.heightAnchor.constraint(equalToConstant: Constants.playerViewMaxHeight)
        
        NSLayoutConstraint.activate([playerViewTopAnchor, playerViewLeadingAnchor, playerViewWidthAnchor, playerViewHeightAnchor])
    }
    
    /// Switch player to maximized mode.
    private func switchToMaxPlayerMode() {
        UIView.animate(withDuration: 0.3) {
            self.playerViewTrailingAnchor.constant = Constants.playerViewMinWidth
            self.view.layoutIfNeeded()
        } completion: { _ in
            NSLayoutConstraint.deactivate([self.playerViewBottomAnchor, self.playerViewTrailingAnchor])
            
            self.playerViewLeadingAnchor.constant = -self.view.frame.size.width
            self.playerViewWidthAnchor.constant = self.view.frame.size.width
            self.playerViewHeightAnchor.constant = Constants.playerViewMaxHeight
            NSLayoutConstraint.activate([self.playerViewTopAnchor, self.playerViewLeadingAnchor])
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3) {
                self.playerViewLeadingAnchor.constant = 0
                self.view.layoutIfNeeded()
                
                self.isPlayerViewInMiniMode = false
            }
        }
    }
    
    /// Switch player to minimized mode.
    private func switchToMiniPlayerMode() {
        UIView.animate(withDuration: 0.3) {
            self.playerViewLeadingAnchor.constant = -self.playerViewWidthAnchor.constant
            self.view.layoutIfNeeded()
        } completion: { _ in
            NSLayoutConstraint.deactivate([self.playerViewTopAnchor, self.playerViewLeadingAnchor])
            
            self.playerViewWidthAnchor.constant = Constants.playerViewMinWidth
            self.playerViewHeightAnchor.constant = Constants.playerViewMinHeight
            NSLayoutConstraint.activate([self.playerViewBottomAnchor, self.playerViewTrailingAnchor])
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3) {
                self.playerViewTrailingAnchor.constant = -Constants.playerViewTrailingMargin
                self.view.layoutIfNeeded()
                
                self.isPlayerViewInMiniMode = true
            }
        }
    }

}

extension RootViewController: TabControllerDelegate {
    
    // MARK: - TabControllerDelegate
    func tabControllerDidSelectTab(_ tab: Tab) {
        switch tab {
        case .home:
            if isPlayerViewInMiniMode {
                switchToMaxPlayerMode()
            }
        case .screen:
            if !isPlayerViewInMiniMode {
                switchToMiniPlayerMode()
            }
        }
    }
    
}

extension RootViewController {
    struct Constants {
        static let playerViewMaxHeight: CGFloat = 250
        static let playerViewMinHeight: CGFloat = 100
        static let playerViewMinWidth: CGFloat = 150
        static let playerViewBottomMargin: CGFloat = 70
        static let playerViewTrailingMargin: CGFloat = 20
    }
}
