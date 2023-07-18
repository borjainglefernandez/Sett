//
//  NotesButton.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/18/23.
//

import UIKit

class NotesButton: UIButton {
    private let viewModel: WorkoutGeneralStatsViewCellViewModel
    
    // MARK: - Init
    init(frame: CGRect, viewModel: WorkoutGeneralStatsViewCellViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 17, weight: .bold))
        tintColor = .label
        setPreferredSymbolConfiguration(config, forImageIn: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        let iconImage = UIImage(systemName: "chevron.right")
        setImage(iconImage, for: .normal)
        addTarget(self, action: #selector(showNotes), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initializer")
    }
    
    // MARK: - Actions
    @objc func showNotes() {
        viewModel.viewNotes(view: self)
    }
}
