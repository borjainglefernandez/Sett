//
//  AddExerciseBottomBar.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/13/23.
//

import UIKit

class AddExerciseBottomBar: UIView {
    // View Model for the bottom bar
    private var viewModel: AddExerciseBottomBarViewModel?
    
    // Bottom bar to house the items
    public let bottomBar: MenuBar = {
        let bottomBar = MenuBar()
        bottomBar.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return bottomBar
    }()
    
    // Gesture Recogniser for whole view
    lazy var gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.addExercise))
    
    // Title to add exercise
    private let title: Label = Label(frame: .zero, title: "Add Exercise", fontSize: 14.0)
    
    // Add Exercise Icon Button
    private let plusIconButton: IconButton = IconButton(imageName: "plus.app")
    
    // MARK: - Init
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        self.addGestureRecognizer(self.gestureRecognizer)
        
        self.addSubviews(self.bottomBar, self.title, self.plusIconButton)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported initialiser")
    }
    
    // MARK: - Constraints
    public func addConstraints() {
        NSLayoutConstraint.activate([
            self.bottomBar.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.bottomBar.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.bottomBar.topAnchor.constraint(equalTo: self.topAnchor),
            self.bottomBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.title.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.title.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            self.plusIconButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.plusIconButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -18),
            self.plusIconButton.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: AddExerciseBottomBarViewModel) {
        self.viewModel = viewModel
    }
    
    @objc func addExercise() {
        if let parentVC = self.getParentViewController(self) as? LiftsViewController {
            if let category = self.viewModel?.category {
                parentVC.addExercise(category: category)
            }
            
        }
    }

}
