//
//  TabController.swift
//  Stonks
//
//  Created by Djuro on 3/10/21.
//

import UIKit

protocol TabControllerDelegate: class {
    func tabControllerDidSelectTab(_ tab: Tab)
}

final class TabController: UIViewController {
    
    // MARK: - Properties
    private let homeController = TextViewController(heading: "Sample Title", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam a tellus eleifend, porttitor odio vitae, accumsan turpis. Fusce auctor ornare mauris, et vestibulum dui rutrum eu. Sed id felis vitae dui ultricies ultrices non sed risus. Donec placerat ipsum sit amet mauris dictum euismod. Nam placerat non diam ac dictum. Aliquam congue non urna a molestie. Aenean diam sapien, molestie nec ornare vitae, tempor et libero. In in neque condimentum, finibus quam nec, auctor diam. Aliquam erat volutpat. Sed lorem est, sagittis a lobortis in, mattis id risus. Cras tristique non eros eu ultrices. Curabitur non dui in arcu tincidunt bibendum id ut nisl. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam varius suscipit lectus sed elementum.", topInset: RootViewController.Constants.playerViewMaxHeight)
    private let screenController = TextViewController(heading: "Screen 2", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam a tellus eleifend, porttitor odio vitae, accumsan turpis. Fusce auctor ornare mauris, et vestibulum dui rutrum eu. Sed id felis vitae dui ultricies ultrices non sed risus. Donec placerat ipsum sit amet mauris dictum euismod. Nam placerat non diam ac dictum. Aliquam congue non urna a molestie. Aenean diam sapien, molestie nec ornare vitae, tempor et libero. In in neque condimentum, finibus quam nec, auctor diam. Aliquam erat volutpat. Sed lorem est, sagittis a lobortis in, mattis id risus. Cras tristique non eros eu ultrices. Curabitur non dui in arcu tincidunt bibendum id ut nisl. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam varius suscipit lectus sed elementum.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nam a tellus eleifend, porttitor odio vitae, accumsan turpis. Fusce auctor ornare mauris, et vestibulum dui rutrum eu. Sed id felis vitae dui ultricies ultrices non sed risus. Donec placerat ipsum sit amet mauris dictum euismod. Nam placerat non diam ac dictum. Aliquam congue non urna a molestie. Aenean diam sapien, molestie nec ornare vitae, tempor et libero. In in neque condimentum, finibus quam nec, auctor diam. Aliquam erat volutpat. Sed lorem est, sagittis a lobortis in, mattis id risus. Cras tristique non eros eu ultrices. Curabitur non dui in arcu tincidunt bibendum id ut nisl. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam varius suscipit lectus sed elementum.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nam a tellus eleifend, porttitor odio vitae, accumsan turpis. Fusce auctor ornare mauris, et vestibulum dui rutrum eu. Sed id felis vitae dui ultricies ultrices non sed risus. Donec placerat ipsum sit amet mauris dictum euismod. Nam placerat non diam ac dictum. Aliquam congue non urna a molestie. Aenean diam sapien, molestie nec ornare vitae, tempor et libero. In in neque condimentum, finibus quam nec, auctor diam. Aliquam erat volutpat. Sed lorem est, sagittis a lobortis in, mattis id risus. Cras tristique non eros eu ultrices. Curabitur non dui in arcu tincidunt bibendum id ut nisl. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam varius suscipit lectus sed elementum.")
    private let tabBarView = TabBarView()
    private var appearingController: UIViewController?
    private var currentController: UIViewController?
    private var containerView = UIView()
    weak var delegate: TabControllerDelegate?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarView.callback = { [weak self] tab in
            self?.showController(for: tab)
        }
        
        layout()
        showController(for: tabBarView.selectedTab)
    }
    
    // MARK: - Private API
    
    /// Layout the UI elements.
    private func layout() {
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBarView)
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: view.safeAreaInsets.bottom + Constants.tabBarHeight),
            
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: tabBarView.topAnchor),
            containerView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    private func showController(for tab: Tab) {
        switch tab {
            case .home: showController(homeController)
            case .screen: showController(screenController)
        }
        
        delegate?.tabControllerDidSelectTab(tab)
    }
    
    private func showController(_ controller: UIViewController) {
        guard appearingController == nil else { return }
        
        appearingController = controller
        var removeCompletion: (() -> Void)?
        if let currentController = currentController {
            removeCompletion = removeController(controller: currentController)
        }
        
        updateAdditionalSafeAreaInsets()
        let addCompletion = addController(controller: controller, contentView: containerView)
        controller.view.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            controller.view.alpha = 1.0
        } completion: { _ in
            removeCompletion?()
            addCompletion()
            self.currentController = controller
            self.appearingController = nil
        }
    }
    
    private func updateAdditionalSafeAreaInsets() {
        let visibleTabHeight = containerView.bounds.height - tabBarView.bounds.origin.y
        if let controller = currentController {
            controller.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: visibleTabHeight, right: 0)
        }
        
        if let controller = appearingController {
            controller.additionalSafeAreaInsets = UIEdgeInsets(top: 0, left: 0, bottom: visibleTabHeight, right: 0)
        }
    }
    
}

extension TabController {
    struct Constants {
        static let tabBarHeight: CGFloat = 80
    }
}

extension UIViewController {
    func removeController(controller: UIViewController, animated: Bool = true) -> (() -> Void) {
        controller.willMove(toParent: nil)
        controller.beginAppearanceTransition(false, animated: animated)
        return {
            controller.view.removeFromSuperview()
            controller.removeFromParent()
            controller.endAppearanceTransition()
            controller.didMove(toParent: nil)
        }
    }
    
    func addController(controller: UIViewController, contentView: UIView? = nil, animated: Bool = true) -> (() -> Void) {
        guard let view = contentView ?? self.view else { return {} }
        
        controller.willMove(toParent: self)
        controller.beginAppearanceTransition(true, animated: animated)
        controller.view.frame = view.bounds
        view.addSubview(controller.view)
        addChild(controller)
        return {
            controller.endAppearanceTransition()
            controller.didMove(toParent: self)
        }
    }
}
