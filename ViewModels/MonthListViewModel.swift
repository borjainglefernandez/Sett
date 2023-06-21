//
//  WorkoutListViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/16/23.
//

import UIKit

final class MonthListViewModel: NSObject {
    
}

extension MonthListViewModel: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthWorkoutListCell.cellIdentifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: 320)
    }
}
