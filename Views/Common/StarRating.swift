//
//  StarRating.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/26/23.
//

import UIKit
import Cosmos

class StarRating: UIView {

    private let starRating: CosmosView = {
        let starRating = CosmosView()
        starRating.translatesAutoresizingMaskIntoConstraints = false
        starRating.settings.filledColor = .systemCyan
        starRating.settings.emptyColor = .systemGray
        starRating.settings.emptyBorderColor = .systemGray2
        starRating.settings.filledBorderColor = .systemGray2
        starRating.rating = 4.5
        starRating.settings.fillMode = .half
        return starRating
    }()
    
    init(frame: CGRect, interactable: Bool, starSize: Double, starMargin: Double) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.starRating.isUserInteractionEnabled = interactable
        self.starRating.settings.starSize = starSize
        self.starRating.settings.starMargin = starMargin
        self.starRating.settings.emptyBorderWidth = starSize / 40
        self.starRating.settings.filledBorderWidth = starSize / 40
        addSubview(self.starRating)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.starRating.topAnchor.constraint(equalTo: topAnchor),
            self.starRating.leftAnchor.constraint(equalTo: leftAnchor),
            self.starRating.rightAnchor.constraint(equalTo: rightAnchor),
            self.starRating.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
}
