//
//  WorkoutListViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/16/23.
//

import UIKit

final class WorkoutListViewModel: NSObject {
    
}

extension WorkoutListViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .systemBrown
        return cell
    }
    
    
}
