//
//  ModalTableViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/14/23.
//

import Foundation
import UIKit

class ModalTableViewModel: NSObject {
    public let modalTableViewType: ModalTableViewType
    public let modalTableViewSelectionType: ModalTableViewSelectionType
    private let category: Category?
    private var cellViewModels: [ModalTableViewCellViewModel]
    
    init(modalTableViewType: ModalTableViewType, modalTableViewSelectionType: ModalTableViewSelectionType, category: Category? = nil) {
        self.modalTableViewType = modalTableViewType
        self.modalTableViewSelectionType = modalTableViewSelectionType
        self.category = category
        self.cellViewModels = []
        super.init()
        
        self.initCellViewModels()
    }
    
    private func initCellViewModels() {
        switch modalTableViewType {
        case .category:
            self.createCategoryCellViewModels()
        case .exercise:
            self.createExerciseCellViewModels()
        case .exerciseType:
            self.createExerciseTypeCellViewModels()
        }
    }
    
    private func createCategoryCellViewModels() {
        let categories: [Category] = CoreDataBase.fetchEntities(withEntity: "Category", expecting: Category.self) ?? []
        
        for category in categories {
            let cellViewModel = ModalTableViewCellViewModel(title: category.name!, subTitle: String(describing: "\(category.exercises?.count ?? 0) Exercises"), modalTableViewSelectionType: self.modalTableViewSelectionType)
            self.cellViewModels.append(cellViewModel)
        }
    }
    
    private func createExerciseCellViewModels() {
        guard let exercises = self.category?.exercises else {
            return
        }
        for exercise in exercises {
            let exercise = exercise as! Exercise
            let cellViewModel = ModalTableViewCellViewModel(title: exercise.name!, subTitle: exercise.type?.exerciseType.rawValue ?? "", modalTableViewSelectionType: self.modalTableViewSelectionType)
            self.cellViewModels.append(cellViewModel)
        }
    }
    
    private func createExerciseTypeCellViewModels() {
        for type in ExerciseType.allCases {
            let cellViewModel = ModalTableViewCellViewModel(title: type.rawValue, subTitle: "", modalTableViewSelectionType: self.modalTableViewSelectionType)
            self.cellViewModels.append(cellViewModel)
        }
    }
}

extension ModalTableViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ModalTableViewCell.cellIdentifier,
            for: indexPath
        ) as? ModalTableViewCell else {
            fatalError("Unsupported cell")
        }
        
        // Only show divider if not the last exercise in the category
        let showDivider = indexPath.row != self.cellViewModels.count - 1
        
        cell.configure(with: self.cellViewModels[indexPath.row], showDivider: showDivider)
        cellViewModels[indexPath.row].delegate = cell
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellViewModels.count

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for (i, cellViewModel) in self.cellViewModels.enumerated() {
            if i == indexPath.row {
                cellViewModel.selectDeselectCell(select: true)
            } else {
                cellViewModel.selectDeselectCell(select: false)
            }
            tableView.reloadData()
        }
    }
    
}
