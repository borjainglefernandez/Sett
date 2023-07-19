//
//  WorkoutGeneralStatsRating.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/17/23.
//

import UIKit

final class WorkoutGeneralStatsRating: StarRating {
    
    private let viewModel: WorkoutGeneralStatsViewCellViewModel
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutGeneralStatsViewCellViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame, interactable: true, starSize: 25, starMargin: 0.5, rating: self.viewModel.workout.rating)
        
        self.starRating.didFinishTouchingCosmos = { rating in
            self.viewModel.changeRating(newRating: rating)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
}
