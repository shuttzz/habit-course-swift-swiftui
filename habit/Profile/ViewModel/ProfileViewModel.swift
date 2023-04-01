//
//  ProfileViewModel.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 20/03/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var birthdayValidation = BirthdayValidation()
    @Published var phoneValidation = PhoneValidation()
    
}

class FullNameValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "José Assis de Menezes Neto" {
        didSet {
            
            failure = value.count < 3
            
        }
    }
    
}

class PhoneValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "(62) 98496-0427" {
        didSet {
            
            failure = value.count < 10 || value.count >= 12
            
        }
    }
    
}

class BirthdayValidation: ObservableObject {
    
    @Published var failure = false
    
    var value: String = "27/10/1987" {
        didSet {
            
            failure = value.count != 10
            
        }
    }
    
}
