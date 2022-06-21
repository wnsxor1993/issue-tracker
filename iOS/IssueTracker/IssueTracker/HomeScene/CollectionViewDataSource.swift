//
//  CollectionViewDataSource.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/21.
//

import UIKit

class CollectionViewDataSource<Model, Cell: UICollectionViewCell>: NSObject, UICollectionViewDataSource {

    typealias CellConfigurator =  (Model, Cell) -> Void
    private let models: [Model]
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(_ models: [Model], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? Cell else {return UICollectionViewCell()}

        cellConfigurator(models[indexPath.item], cell)
        return cell
    }

}
