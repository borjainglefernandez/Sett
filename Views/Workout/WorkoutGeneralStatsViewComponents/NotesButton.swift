//
//  NotesButton.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/18/23.
//

import UIKit

final class NotesButton: UIButton {
    
    private let viewModel: WorkoutGeneralStatsViewCellVM
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutGeneralStatsViewCellVM) {
        self.viewModel = viewModel
        super.init(frame: frame)

        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Actions
    @objc func showNotes() {
        self.viewModel.viewNotes(view: self)
    }
    
    // MARK: - Configurations
    private func configure() {
        let iconImage = UIImage(systemName: "chevron.right")
        self.setImage(iconImage, for: .normal)
        
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17, weight: .bold))
        self.setPreferredSymbolConfiguration(config, forImageIn: .normal)
        
        self.tintColor = .label
        
        self.addTarget(self, action: #selector(showNotes), for: .touchUpInside)
    }
}
