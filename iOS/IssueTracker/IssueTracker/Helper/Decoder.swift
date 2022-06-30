//
//  Decoder.swift
//  IssueTracker
//
//  Created by Kai Kim on 2022/06/28.
//

import Foundation

struct Decoder<T: Decodable> {

    typealias Model = T

    func decode(data: Data) -> Model? {
        do {
            let decodedData = try JSONDecoder().decode(Model.self, from: data)
            return decodedData
        } catch {
            print(NetworkError.decodingError(error))
            return nil
        }
    }

}
