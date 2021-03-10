//
//  HomeTabBarView.swift
//  Stonks
//
//  Created by Djuro on 3/10/21.
//

import UIKit

final class TabBarView: UIView {
    
    // MARK: - Properties
    private let tabViews = [TabView(tab: .home), TabView(tab: .screen)]
    private let stackView = UIStackView()
    private let tabsViewsForTabs: [Tab: TabView]
    private(set) var selectedTab: Tab = .home
    var callback: ((Tab) -> Bool)?
    
    // MARK: - Initializers
    init() {
        var tvs = [Tab: TabView]()
        for view in tabViews {
            tvs[view.tab] = view
        }
        tabsViewsForTabs = tvs
        super.init(frame: .zero)
        
        layout()
        
        updateSelectedTabs()
        
        for view in tabViews {
            view.callback = { [weak self] tab in
                self?.select(tab: tab)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public API
    func select(tab: Tab) {
        guard tab != selectedTab else { return }
        
        if callback?(tab) ?? true {
            selectedTab = tab
            updateSelectedTabs()
        }
    }
    
    // MARK: - Private API
    private func layout() {
        backgroundColor = .lightGray
        
        setupStackView()
    }
    
    private func setupStackView() {
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func updateSelectedTabs() {
        for view in tabViews {
            view.update(selected: view.tab == selectedTab)
        }
    }
    
}
