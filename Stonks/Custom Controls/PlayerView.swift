//
//  PlayerView.swift
//  Stonks
//
//  Created by Djuro on 3/10/21.
//

import UIKit
import AVKit

final class PlayerView: UIView {
    
    // MARK: - Properties
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playerLayer?.frame = bounds
    }
    
    // MARK: - Private API
    
    /// Setup the player to play the stream.
    private func setup() {
        backgroundColor = .black
        guard let url = URL(string: "https://stream.mux.com/\(Secrets.playlistId)") else { return }
        
        let player = AVPlayer(url: url)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        self.playerLayer = playerLayer
        layer.addSublayer(playerLayer)
  
        self.player = player
        player.play()
    }
    
}
