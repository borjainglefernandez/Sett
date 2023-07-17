//
//  WorkoutViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/14/23.
//

import UIKit

final class WorkoutViewModel: NSObject {
    public let workout: Workout
    private lazy var cellViewModels: [WorkoutGeneralStatsViewCellViewModel] = {
           return WorkoutGeneralStatsViewType.allCases.compactMap { type in
               return WorkoutGeneralStatsViewCellViewModel(type: type, workout: self.workout)
           }
       }()
    
    init(workout: Workout) {
        self.workout = workout
    }
}

extension WorkoutViewModel: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: WorkoutGeneralStatsViewCell.cellIdentifier,
            for: indexPath
        ) as? WorkoutGeneralStatsViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
