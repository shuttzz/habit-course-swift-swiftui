//
//  HomeViewRouter.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 13/03/23.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    
    static func makeHabitView(viewModel: HabitViewModel) -> some View {
        
        return HabitView(viewModel: viewModel)
        
    }
    
    static func makeProfileView(viewModel: ProfileViewModel) -> some View {
        
        return ProfileView(viewModel: viewModel)
        
    }
    
}
