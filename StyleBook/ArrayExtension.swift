//
//  ArrayExtension.swift
//  StyleBook
//
//  Created by 스트라입스 on 2016. 12. 15..
//  Copyright © 2016년 jgson. All rights reserved.
//

import Foundation

extension Array {
    mutating func removeLastAndFirst() {
        if self.count > 0 {
            self.removeLast()
            if self.count == 1 {
                self.removeAll()
            }
        }
    }
}
