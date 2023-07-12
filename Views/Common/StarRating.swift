//
//  StarRating.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/26/23.
//

import UIKit
import Cosmos

final class StarRating: UIView {
    
    public var rating: Double {
        didSet {
            starRating.rating = rating
        }
    }
    
    // Star Rating for an object
    private let starRating: CosmosView = {
        let starRating = CosmosView()
        starRating.translatesAutoresizingMaskIntoConstraints = false
        starRating.settings.filledColor = .systemCyan
        starRating.settings.emptyColor = .systemGray
        starRating.settings.emptyBorderColor = .systemGray2
        starRating.settings.filledBorderColor = .systemGray2
        starRating.settings.fillMode = .half
        return starRating
    }()
    
    // MARK: - Init
    init(frame: CGRect, interactable: Bool, starSize: Double, starMargin: Double, rating: Double = 3.0) {
        self.rating = rating
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
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.starRating.topAnchor.constraint(equalTo: topAnchor),
            self.starRating.leftAnchor.constraint(equalTo: leftAnchor),
            self.starRating.rightAnchor.constraint(equalTo: rightAnchor),
            self.starRating.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
}
