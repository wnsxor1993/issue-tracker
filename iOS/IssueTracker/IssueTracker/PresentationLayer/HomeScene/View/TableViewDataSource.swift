//
//  CollectionViewDataSource.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/21.
//

import UIKit

final class TableViewDataSource<Model, Cell: UITableViewCell>: NSObject, UITableViewDataSource {

    typealias CellConfigurator =  (Model, Cell) -> Void
    private(set) var models: [Model]
    private let reuseIdentifier: String
    private let cellConfigurator: CellConfigurator

    init(_ models: [Model], reuseIdentifier: String, cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.reuseIdentifier = reuseIdentifier
        self.cellConfigurator = cellConfigurator
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? Cell else {return UITableViewCell()}
        cellConfigurator(models[indexPath.row], cell)
        return cell
    }
}

extension TableViewDataSource {

    func updateData(_ models: [Model]) {
        self.models = models
    }

}
