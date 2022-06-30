//
//  Observable.swift
//  IssueTracker
//
//  Created by juntaek.oh on 2022/06/24.
//

import Foundation

final class Observable<T> {
    typealias Listener = ((T) -> Void)

    private var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: @escaping Listener) {
        listener(value)
        self.listener = listener
    }

    func updateValue(value: T) {
        self.value = value
    }
}
