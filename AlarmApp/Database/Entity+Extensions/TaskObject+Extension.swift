//
//  TaskObject+Extension.swift
//  AlarmApp
//
//  Created by Noura Mohammad Althrowi on 17/06/1444 AH.
//

import Foundation

extension TaskObject {
    
    var wrappedTitle: String {
        self.title ?? ""
    }
    
    var wrappedUniqueId: String {
        self.uniqueId ?? ""
    }
}
