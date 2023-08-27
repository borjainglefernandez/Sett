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
    private let selectedCellCallback: ((String, ModalTableViewType) -> Void)
    private var selectedIndexPath: IndexPath?
    private let category: Category?
    private let exercise: Exercise?
    private let exerciseType: ExerciseType?
    private var cellViewModels: [ModalTableViewCellViewModel]
    
    init(modalTableViewType: ModalTableViewType, modalTableViewSelectionType: ModalTableViewSelectionType, selectedCellCallBack: @escaping ((String, ModalTableViewType) -> Void), category: Category? = nil, exercise: Exercise? = nil, exerciseType: ExerciseType? = nil) {
        self.modalTableViewType = modalTableViewType
        self.modalTableViewSelectionType = modalTableViewSelectionType
        self.selectedCellCallback = selectedCellCallBack
        self.category = category
        self.exercise = exercise
        self.exerciseType = exerciseType
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
            if category == self.category { // Add preselected category to top
                self.cellViewModels.insert(cellViewModel, at: 0)
            } else {
                self.cellViewModels.append(cellViewModel)
            }
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
            if type == self.exerciseType {
                self.cellViewModels.insert(cellViewModel, at: 0)
            } else {
                self.cellViewModels.append(cellViewModel)
            }
        }
    }
    
    /// Selects a cell if it should be selected
    ///
    /// - Parameters:
    ///   - cell: cell to select
    ///   - indexPath: indexPath to check whether or not we should select
    ///
    ///   Select cell if:
    ///   1.) We are coming from an existing category, exercise, or exercise type and that cell shares that name
    ///   or
    ///   2.) We have selected that cell (as indicated by selectedIndexPath)
    private func selectCellIfNeeded(at cell: ModalTableViewCell, for indexPath: IndexPath) {
        let existingCategory:Bool = self.category?.name == self.cellViewModels[indexPath.row].title
        let existingExercise:Bool = self.exercise?.name == self.cellViewModels[indexPath.row].title
        let existingExerciseType:Bool = self.exerciseType?.rawValue == self.cellViewModels[indexPath.row].title
        let existingField: Bool = (existingCategory || existingExercise || existingExerciseType) && selectedIndexPath == nil
        let selectedThisIndex: Bool = self.selectedIndexPath == indexPath
        
        if existingField || selectedThisIndex {
            self.selectedIndexPath = indexPath
            cell.selectDeselectCell(select: true)
            self.selectedCellCallback(self.cellViewModels[indexPath.row].title, self.modalTableViewType)
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
        self.selectCellIfNeeded(at: cell, for: indexPath)
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
                
        if let selectedIndexPath = self.selectedIndexPath {
            self.cellViewModels[selectedIndexPath.row].selectDeselectCell(select: false)
        }
        self.selectedIndexPath = indexPath
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
}
