//
//  HomeViewModel.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 04/03/23.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    let viewModel = HabitViewModel(interector: HabitInterector())
    let profileViewModel = ProfileViewModel()
    
}

extension HomeViewModel {
    
    func habitView() -> some View {
        
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
        
    }
    
    func profileView() -> some View {
        
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
        
    }
    
}
