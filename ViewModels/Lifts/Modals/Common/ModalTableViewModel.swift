//
//  ModalTableViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/14/23.
//

import Foundation
import UIKit
import CoreData

class ModalTableViewModel: NSObject {
    public let modalTableViewType: ModalTableViewType
    public let modalTableViewSelectionType: ModalTableViewSelectionType
    private let selectedCellCallback: ((String, String, ModalTableViewType, UIView?) -> Void)
    private var selectedIndexPath: IndexPath?
    private let category: Category?
    private let exercise: Exercise?
    private let exerciseType: ExerciseType?
    public var cellViewModels: [ModalTableViewCellViewModel]
    public var filteredCellViewModels: [ModalTableViewCellViewModel]
    public var tableView: UITableView?
    private var categoryFetchedResultsController: NSFetchedResultsController<Category>?
    private var exerciseFetchedResultsController: NSFetchedResultsController<Exercise>?
    
    init(modalTableViewType: ModalTableViewType, modalTableViewSelectionType: ModalTableViewSelectionType, selectedCellCallBack: @escaping ((String, String, ModalTableViewType, UIView?) -> Void), category: Category? = nil, exercise: Exercise? = nil, exerciseType: ExerciseType? = nil) {
        self.modalTableViewType = modalTableViewType
        self.modalTableViewSelectionType = modalTableViewSelectionType
        self.selectedCellCallback = selectedCellCallBack
        self.category = category
        self.exercise = exercise
        self.exerciseType = exerciseType
        self.cellViewModels = []
        self.filteredCellViewModels = []
        super.init()
        
        self.initCellViewModels()
    }
    
    public func initCellViewModels() {
        self.cellViewModels = []
        self.filteredCellViewModels = []
        
        switch modalTableViewType {
        case .category:
            self.createCategoryCellViewModels()
        case .exercise:
            self.createExerciseCellViewModels()
        case .exerciseType:
            self.createExerciseTypeCellViewModels()
        }
        self.filteredCellViewModels = self.cellViewModels
    }
    
    private func createCategoryCellViewModels() {
        self.categoryFetchedResultsController = CoreDataBase.createFetchedResultsController(withEntityName: "Category", expecting: Category.self, sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
        if let categoryFetchedResultsController = self.categoryFetchedResultsController {
            CoreDataBase.configureFetchedResults(controller: categoryFetchedResultsController, expecting: Category.self, with: self)
        }
        let categories: [Category] = self.categoryFetchedResultsController?.fetchedObjects ?? []
        
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
        if let categoryName = self.category?.name {
            self.exerciseFetchedResultsController = CoreDataBase.createFetchedResultsController(withEntityName: "Exercise", expecting: Exercise.self, predicates: [NSPredicate(format: "category.name = %@", categoryName)], sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
        }
        if let exerciseFetchedResultsController = self.exerciseFetchedResultsController {
            CoreDataBase.configureFetchedResults(controller: exerciseFetchedResultsController, expecting: Exercise.self, with: self)
        }
        let exercises: [Exercise] = self.exerciseFetchedResultsController?.fetchedObjects ?? []

        for exercise in exercises {
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
        let existingCategory:Bool = self.category?.name == self.filteredCellViewModels[indexPath.row].title
        let existingExercise:Bool = self.exercise?.name == self.filteredCellViewModels[indexPath.row].title
        let existingExerciseType:Bool = self.exerciseType?.rawValue == self.filteredCellViewModels[indexPath.row].title
        let existingField: Bool = (existingCategory || existingExercise || existingExerciseType) && selectedIndexPath == nil
        let selectedThisIndex: Bool = self.selectedIndexPath == indexPath
        
        if existingField || selectedThisIndex {
            self.selectedIndexPath = indexPath
            cell.selectDeselectCell(select: true)
            self.selectedCellCallback(self.filteredCellViewModels[indexPath.row].title, self.filteredCellViewModels[indexPath.row].subTitle, self.modalTableViewType, self.tableView)
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
        let showDivider = indexPath.row != self.filteredCellViewModels.count - 1
        
        cell.configure(with: self.filteredCellViewModels[indexPath.row], showDivider: showDivider)
        filteredCellViewModels[indexPath.row].delegate = cell
        self.selectCellIfNeeded(at: cell, for: indexPath)
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableView = self.tableView {
            if filteredCellViewModels.count == 0 {
                tableView.setEmptyMessage("No results.")
            } else {
                tableView.restore()
            }
        }

        return filteredCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        if let selectedIndexPath = self.selectedIndexPath {
            self.filteredCellViewModels[selectedIndexPath.row].selectDeselectCell(select: false)
        }
        self.selectedIndexPath = indexPath
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    
    
}

extension ModalTableViewModel: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredCellViewModels = self.cellViewModels
        } else {
            self.filteredCellViewModels = self.cellViewModels.filter {
                return $0.title.lowercased().contains(searchText.lowercased())
            }
        }
        self.selectedIndexPath = nil
        self.tableView?.reloadData()
    }
}

extension ModalTableViewModel: NSFetchedResultsControllerDelegate {
    // Update screen if CRUD conducted on Categories or Exercises
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.initCellViewModels()
        self.tableView?.reloadData()
    }
}
