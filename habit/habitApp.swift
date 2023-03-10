//
//  habitApp.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 06/02/23.
//

import SwiftUI

@main
struct habitApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel())
        }
    }
}
