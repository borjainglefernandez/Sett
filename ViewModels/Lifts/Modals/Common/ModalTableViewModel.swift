//
//  ModalTableVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/14/23.
//

import Foundation
import UIKit
import CoreData

class ModalTableVM: NSObject {
    
    // Type of modal and selection
    public let modalTableViewType: ModalTableViewType
    public let modalTableViewSelectionType: ModalTableViewSelectionType
    
    // Callback
    private let selectedCellCallback: ((String, String, ModalTableViewType, UIView?) -> Void)
    private let shouldShowExerciseCallback: ((Exercise) -> Bool)?
    
    // Entities to select
    private let category: Category?
    private let exercise: Exercise?
    private let exerciseType: ExerciseType?
    
    // VM's
    public var cellVMs: [ModalTableViewCellVM]
    public var filteredCellVMs: [ModalTableViewCellVM]
    
    // UI Information
    public var tableView: UITableView?
    private var selectedIndexPath: IndexPath?
    
    // Search Controllers
    private var categoryFetchedResultsController: NSFetchedResultsController<Category>?
    private var exerciseFetchedResultsController: NSFetchedResultsController<Exercise>?
    
    // MARK: - Init
    init(modalTableViewType: ModalTableViewType,
         modalTableViewSelectionType: ModalTableViewSelectionType,
         selectedCellCallBack: @escaping ((String, String, ModalTableViewType, UIView?) -> Void),
         shouldShowExerciseCallback: ((Exercise) -> Bool)? = nil,
         category: Category? = nil,
         exercise: Exercise? = nil,
         exerciseType: ExerciseType? = nil) {
        self.modalTableViewType = modalTableViewType
        self.modalTableViewSelectionType = modalTableViewSelectionType
        self.selectedCellCallback = selectedCellCallBack
        self.shouldShowExerciseCallback = shouldShowExerciseCallback
        self.category = category
        self.exercise = exercise
        self.exerciseType = exerciseType
        self.cellVMs = []
        self.filteredCellVMs = []
        super.init()
        
        self.initCellVMs()
    }
    
    public func initCellVMs() {
        self.cellVMs = []
        self.filteredCellVMs = []
        
        switch modalTableViewType {
        case .category:
            self.createCategoryCellVMs()
        case .exercise:
            self.createExerciseCellVMs()
        case .exerciseType:
            self.createExerciseTypeCellVMs()
        }
        self.filteredCellVMs = self.cellVMs
    }
    
    // MARK: - Init VM's
    private func createCategoryCellVMs() {
        self.categoryFetchedResultsController = CoreDataBase.createFetchedResultsController(
                                                    withEntityName: "Category",
                                                    expecting: Category.self,
                                                    sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
        if let categoryFetchedResultsController = self.categoryFetchedResultsController {
            CoreDataBase.configureFetchedResults(controller: categoryFetchedResultsController, expecting: Category.self, with: self)
        }
        let categories: [Category] = self.categoryFetchedResultsController?.fetchedObjects ?? []
        
        for category in categories {
            let cellVM =
                ModalTableViewCellVM(title: category.name!,
                                            subTitle: String(describing: "\(category.exercises?.count ?? 0) Exercises"),
                                            modalTableViewSelectionType: self.modalTableViewSelectionType)
            if category == self.category { // Add preselected category to top
                self.cellVMs.insert(cellVM, at: 0)
            } else {
                self.cellVMs.append(cellVM)
            }
        }
    }
    
    private func createExerciseCellVMs() {
        if let categoryName = self.category?.name {
            self.exerciseFetchedResultsController = CoreDataBase.createFetchedResultsController(
                    withEntityName: "Exercise",
                    expecting: Exercise.self,
                    predicates: [NSPredicate(format: "category.name = %@", categoryName)],
                    sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
        }
        if let exerciseFetchedResultsController = self.exerciseFetchedResultsController {
            CoreDataBase.configureFetchedResults(controller: exerciseFetchedResultsController, expecting: Exercise.self, with: self)
        }
        let exercises: [Exercise] = self.exerciseFetchedResultsController?.fetchedObjects ?? []

        for exercise in exercises {
            // Check if we should add it
            if let shouldShowExerciseCallback = self.shouldShowExerciseCallback, !shouldShowExerciseCallback(exercise){
                continue
            }
            
            let cellVM = ModalTableViewCellVM(
                                title: exercise.name!,
                                subTitle: exercise.type?.exerciseType.rawValue ?? "",
                                modalTableViewSelectionType: self.modalTableViewSelectionType)
            self.cellVMs.append(cellVM)
        }
    }
    
    private func createExerciseTypeCellVMs() {
        for type in ExerciseType.allCases {
            let cellVM = ModalTableViewCellVM(
                                    title: type.rawValue,
                                    subTitle: "",
                                    modalTableViewSelectionType: self.modalTableViewSelectionType)
            if type == self.exerciseType {
                self.cellVMs.insert(cellVM, at: 0)
            } else {
                self.cellVMs.append(cellVM)
            }
        }
    }
    
    // MARK: - Actions
    
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
        let existingCategory: Bool = self.category?.name == self.filteredCellVMs[indexPath.row].title
        let existingExercise: Bool = self.exercise?.name == self.filteredCellVMs[indexPath.row].title
        let existingExerciseType: Bool = self.exerciseType?.rawValue == self.filteredCellVMs[indexPath.row].title
        let existingField: Bool = (existingCategory || existingExercise || existingExerciseType) && selectedIndexPath == nil
        let selectedThisIndex: Bool = self.selectedIndexPath == indexPath
        
        if existingField || selectedThisIndex {
            self.selectedIndexPath = indexPath
            cell.selectDeselectCell(select: true)
            self.selectedCellCallback(
                self.filteredCellVMs[indexPath.row].title,
                self.filteredCellVMs[indexPath.row].subTitle,
                self.modalTableViewType,
                self.tableView)
        }

    }
}

// MARK: Table View Delegate
extension ModalTableVM: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ModalTableViewCell.cellIdentifier,
            for: indexPath
        ) as? ModalTableViewCell else {
            fatalError("Unsupported cell")
        }
        
        // Only show divider if not the last exercise in the category
        let showDivider = indexPath.row != self.filteredCellVMs.count - 1
        
        cell.configure(with: self.filteredCellVMs[indexPath.row], showDivider: showDivider)
        filteredCellVMs[indexPath.row].delegate = cell
        self.selectCellIfNeeded(at: cell, for: indexPath)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tableView = self.tableView {
            if filteredCellVMs.count == 0 {
                tableView.setEmptyMessage("No results.")
            } else {
                tableView.restore()
            }
        }

        return filteredCellVMs.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        if let selectedIndexPath = self.selectedIndexPath {
            self.filteredCellVMs[selectedIndexPath.row].selectDeselectCell(select: false)
        }
        self.selectedIndexPath = indexPath
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

// MARK: - Search Bar Delegate
extension ModalTableVM: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filteredCellVMs = self.cellVMs
        } else {
            self.filteredCellVMs = self.cellVMs.filter {
                return $0.title.lowercased().contains(searchText.lowercased())
            }
        }
        self.selectedIndexPath = nil
        self.tableView?.reloadData()
    }
}

// MARK: - Fetched Results Controller Delegate
extension ModalTableVM: NSFetchedResultsControllerDelegate {
    // Update screen if CRUD conducted on Categories or Exercises
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.initCellVMs()
        self.tableView?.reloadData()
    }
}
