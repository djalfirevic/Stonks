//
//  TabView.swift
//  Stonks
//
//  Created by Djuro on 3/10/21.
//

import UIKit

enum Tab: String {
    case home = "Home"
    case screen = "Screen"
}

final class TabView: UIView {
    
    // MARK: - Properties
    private let titleLabel = UILabel()
    private(set) var selected = false
    let tab: Tab
    var callback: ((Tab) -> Void)?
    
    // MARK: - Initializers
    
    /// Initializer for `TabView` for a particular `Tab`.
    /// - Parameter tab: Provided `Tab`.
    init(tab: Tab) {
        self.tab = tab
        super.init(frame: .zero)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIResponder
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        showTouch()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        if let touch = touches.first {
            if touchInRange(touch: touch) {
                showTouch()
            } else {
                hideTouch()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        handleEnd(touch: touches.first)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        handleEnd(touch: touches.first)
    }
    
    // MARK: - Public API
    func update(selected: Bool) {
        self.selected = selected
        
        titleLabel.textColor = selected ? .white : .darkGray
    }
    
    // MARK: - Private API
    
    /// Layout the UI elements.
    private func layout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = tab.rawValue
        titleLabel.textColor = .darkGray
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    /// Helper function for determining bounds of user's touch.
    /// - Parameter touch: User's touch.
    /// - Returns: Whether the user's touch is in range or not.
    private func touchInRange(touch: UITouch) -> Bool {
        let rect = bounds.insetBy(dx: -1 * Constants.touchPadding, dy: -1 * Constants.touchPadding)
        return rect.contains(touch.location(in: self))
    }
    
    /// Handler for touches ended event.
    /// - Parameter touch: User's touch.
    private func handleEnd(touch: UITouch?) {
        if let touch = touch {
            if touchInRange(touch: touch) {
                callback?(self.tab)
            }
        }
        
        hideTouch()
    }
    
    /// Animates the alpha property in order to hide user's touch.
    private func showTouch() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.5
        }
    }
    
    /// Animates the alpha property in order to hide user's touch.
    private func hideTouch() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1.0
        }
    }
    
}

extension TabView {
    struct Constants {
        static let touchPadding: CGFloat = 40
    }
}
