//
//  DetailRouter.swift
//  ToDo List
//
//  Created by MyBook on 20.11.2024.
//

import Foundation
import SwiftUI

protocol DetailRouterInput {}

class DetailRouter: DetailRouterInput {
    var viewController: DetailView?
}
