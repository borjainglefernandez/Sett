//
//  DurationView.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/9/24.
//
import UIKit

final class DurationView: UIView {
    
    // View Model
    private let viewModel: WorkoutGeneralStatsViewCellVM
    
    // Duration Label
    lazy var durationLabel: Label = Label(title: self.getDurationLabelText(), fontSize: 14, weight: .regular)
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutGeneralStatsViewCellVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubviews(self.durationLabel)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            self.durationLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            self.durationLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    // MARK: - Configurations
    private func getDurationLabelText() -> String {
        if let durationSeconds = self.viewModel.workout.durationSeconds as? Int {
            let minutes = durationSeconds / 60
            
            if minutes == 1 {
                return "1 minute"
            }
            
            return "\(minutes) minutes"

        }
        return "0 minutes"
    }
}
