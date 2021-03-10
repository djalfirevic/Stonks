//
//  TextViewController.swift
//  Stonks
//
//  Created by Djuro on 3/10/21.
//

import UIKit

final class TextViewController: UIViewController {
    
    // MARK: - Properties
    private let textLabel = UILabel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let heading: String
    private let text: String
    private let topInset: CGFloat

    // MARK: - Initializers
    
    /// Main initializer.
    /// - Parameters:
    ///   - heading: Heading of the text.
    ///   - text: Body text.
    ///   - topInset: Inset used for `PlayerView`.
    init(heading: String, text: String, topInset: CGFloat = 0) {
        self.heading = heading
        self.text = text
        self.topInset = topInset
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
    }
    
    // MARK: - Private API
    
    /// Layout the UI elements.
    private func layout() {
        view.backgroundColor = .white
        
        setupScrollView()
        setupTextLabel()
    }
    
    /// Setup scroll view as a container which holds the `textLabel`.
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: topInset + Constants.textPadding),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    /// Setup `textLabel` with attributed string.
    private func setupTextLabel() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        contentView.addSubview(textLabel)
        
        let headingAttributedString = NSAttributedString(string: "\(heading)\n\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)])
        let textAttributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
        let attributedString = NSMutableAttributedString(attributedString: headingAttributedString)
        attributedString.append(textAttributedString)
        textLabel.attributedText = attributedString
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.textPadding),
            textLabel.widthAnchor.constraint(equalToConstant: view.bounds.width - 2*Constants.textPadding),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.textPadding)
        ])
    }

}

extension TextViewController {
    struct Constants {
        static let textPadding: CGFloat = 10
    }
}
