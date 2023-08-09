//
//  CategoryListCellCollectionViewCell.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/8/23.
//

import UIKit

class CategoryListCell: UICollectionViewCell {
    
    static let cellIdentifier = "CategoryListCell"
    
    weak var delegate:ExpandedCellDelegate?
    
    public var indexPath:IndexPath!
    
    // Top bar of the category list container
    private let topBar: UIView = TopBar(frame: .zero)
    
    // Title label for the container
    private let titleLabel: UILabel = TitleLabel(frame: .zero, title: "", fontSize: 14.0)
    
    // Button to expand or collapse cell
    private let expandCollapseButton: UIButton = ExpandCollapseButton(frame: .zero)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.layer.cornerRadius = 15
    
//        self.expandCollapseButton.addTarget(self, action: #selector(collapseExpand), for: .touchUpInside)

        self.addSubviews(topBar, titleLabel, expandCollapseButton)
        self.addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported constructor")
    }
    
    // MARK: - Constraints
    private func addConstraints() {
        
    }
    
    // MARK: - Configurations
    public func configure(with viewModel: CategoryListCellViewModel) {
       
    }

    
    
    
    
    
    
    // Show or hide month list view depending on whether or not it was expanded
    public func showHideMonthListView(isExpanded: Bool) {
//        topBar.layer.cornerRadius = 15
//        monthWorkoutListView.isHidden = !isExpanded // Hide or show view
//
//        // Change corner radii and icon depending on whether or not showing or hiding
//        var iconImage: UIImage?
//        if isExpanded {
//            topBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//            iconImage = UIImage(systemName: "chevron.up")
//        } else {
//            topBar.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
//            iconImage = UIImage(systemName: "chevron.down")
//        }
//        self.expandCollapseButton.setImage(iconImage, for: .normal)
    }
}
