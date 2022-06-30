//
//  Encoder.swift
//  Pods
//
//  Created by Kai Kim on 2022/06/28.
//

import Foundation

struct Encoder <T: Encodable> {

    typealias Model = T

    func encode(model: Model) -> Data? {
        do {
            let encodedData = try JSONEncoder().encode(model)
            return encodedData
        } catch {
            print(NetworkError.encodingError(error))
            return nil
        }
    }

}
