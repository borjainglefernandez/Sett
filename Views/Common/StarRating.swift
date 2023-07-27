//
//  StarRating.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/26/23.
//

import UIKit
import Cosmos

class StarRating: UIView {
    
    // Star Rating for an object
    public let starRating: CosmosView = {
        let starRating = CosmosView()
        starRating.translatesAutoresizingMaskIntoConstraints = false
        starRating.settings.filledColor = .systemCyan
        starRating.settings.emptyColor = .systemGray
        starRating.settings.emptyBorderColor = .systemGray2
        starRating.settings.filledBorderColor = .systemGray2
        starRating.settings.fillMode = .half
        starRating.settings.minTouchRating = 0
        return starRating
    }()
    
    // MARK: - Init
    init(frame: CGRect, interactable: Bool, starSize: Double, starMargin: Double, rating: Double = 3.0) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        self.starRating.isUserInteractionEnabled = interactable
        self.starRating.settings.starSize = starSize
        self.starRating.settings.starMargin = starMargin
        self.starRating.settings.emptyBorderWidth = starSize / 40
        self.starRating.settings.filledBorderWidth = starSize / 40
        self.starRating.rating = rating
        addSubview(self.starRating)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.starRating.topAnchor.constraint(equalTo: self.topAnchor),
            self.starRating.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.starRating.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.starRating.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    
}
