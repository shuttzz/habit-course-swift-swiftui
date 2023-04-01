//
//  HabitViewModel.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 13/03/23.
//

import Foundation
import Combine
import SwiftUI

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .loading
    
    @Published var title = ""
    @Published var headline = ""
    @Published var desc = ""
    
    @Published var opened = false
    
    private var cancellableRequest: AnyCancellable?
    private var cancellableNotify: AnyCancellable?
    private let interactor: HabitInterector
    
    private let habitPublisher = PassthroughSubject<Bool, Never>()
    
    init(interector: HabitInterector) {
        
        self.interactor = interector
        
        cancellableNotify = habitPublisher.sink(receiveValue: { saved in
            print("saved: \(saved)")
            self.onAppear()
        })
        
    }
    
    deinit {
        
        cancellableRequest?.cancel()
        cancellableNotify?.cancel()
        
    }
    
    func onAppear() {
        
        self.opened = true
        self.uiState = .loading
        
        cancellableRequest = interactor.fetchHabits()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                
                switch completion {
                        
                    case .failure(let appError):
                        self.uiState = .error(appError.message)
                        break
                    case .finished:
                        break
                        
                }
                
            }, receiveValue: { response in
                
                if response.isEmpty {
                    
                    self.uiState = .emptyList
                    self.title = ""
                    self.headline = "Fique ligado!"
                    self.desc = "Você ainda não possui hábitos!"
                    
                } else {
                    
                    self.uiState = .fullList(
                        response.map { item in
                            
                            let lastDate = item.lastDate?.toDate(
                                sourcePattern: "yyyy-MM-dd'T'HH:mm:ss",
                                destPattern: "dd/MM/yyyy HH:mm") ?? ""
                            
                            var state = Color.green
                            self.title = "Muito bom!"
                            self.headline = "Seus hábitos estão em dia"
                            self.desc = ""
                            
                            let dateToCompare = item.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss") ?? Date()
                            
                            if dateToCompare < Date() {
                                
                                state = .red
                                self.title = "Atenção"
                                self.headline = "Fique Ligado!"
                                self.desc = "Você está atrasado nos seus hábitos"
                                
                            }
                            
                            return HabitCardViewModel(id: item.id,
                                                      icon: item.iconUrl ?? "",
                                                      date: lastDate,
                                                      name: item.name,
                                                      label: item.label,
                                                      value: "\(item.value ?? 0)",
                                                      state: state,
                                                      habitPublisher: self.habitPublisher)
                            
                        }
                    )
                    
                }
                
            })
        
    }
    
}
