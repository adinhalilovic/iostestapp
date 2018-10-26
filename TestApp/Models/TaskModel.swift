//
//  TaskModel.swift
//  TestApp
//
//  Created by Mahmutović Edin on 26/10/2018.
//  Copyright © 2018 Adin Halilovic. All rights reserved.
//

import Foundation

class TaskModel {
    
    var title: String
    var description: String
    var isDone: Bool
    
    init(title: String?, description: String?, isDone: Bool?) {
        self.title = title ?? ""
        self.description = description ?? ""
        self.isDone = isDone ?? false
    }
}
