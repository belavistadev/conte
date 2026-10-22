//
//  Counter.swift
//  Liceu
//
//  Created by Thiago Campos on 22/10/26.
//

import Foundation
import SwiftData

@Model
final class Counter {
    var title: String = ""
    var count: Int = 0
    // Metadata
    var creationDate: Date = Date.now
    var modificationDate: Date = Date.now

    init(title: String, count: Int = 0, creationDate: Date = .now) {
        self.title = title
        self.count = count
        self.creationDate = creationDate
        modificationDate = creationDate
    }
}
