//
//  DatabaseHelper+Constants.swift
//  Progressia
//
//  Created by William Chrisandy on 23/07/22.
//

import Foundation

protocol HasKeyLastId
{
    static var keyLastId: String { get }
}

protocol HasId
{
    var id: Int64 { get set }
}

extension DatabaseHelper
{
    static let keyNewTask = "newTask"
}
