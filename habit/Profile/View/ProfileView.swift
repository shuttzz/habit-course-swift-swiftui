//
//  ProfileView.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 15/03/23.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var viewModel: ProfileViewModel
    
    var disableDone: Bool {
        
        viewModel.fullNameValidation.failure ||
        viewModel.birthdayValidation.failure ||
        viewModel.phoneValidation.failure
        
    }
    
    @State var email = "netomenezesucg@gmail.com"
    @State var cpf = "024.868.001-31"
    @State var selectedGender: Gender? = .male
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Form {
                    
                    Section(header: Text("Dados cadastrais")) {
                        
                        HStack {
                            
                            Text("Nome")
                            Spacer()
                            TextField("Nome", text: $viewModel.fullNameValidation.value)
                                .keyboardType(.alphabet)
                                .multilineTextAlignment(.trailing)
                            
                        }
                        
                        if viewModel.fullNameValidation.failure {
                            
                            Text("Nome deve ter mais de 3 caracteres")
                                .foregroundColor(.red)
                            
                        }
                        
                        HStack {
                            
                            Text("E-mail")
                            Spacer()
                            TextField("", text: $email)
                                .multilineTextAlignment(.trailing)
                                .disabled(true)
                                .foregroundColor(Color.gray)
                            
                        }
                        
                        HStack {
                            
                            Text("CPF")
                            Spacer()
                            TextField("", text: $cpf)
                                .multilineTextAlignment(.trailing)
                                .disabled(true)
                                .foregroundColor(Color.gray)
                            
                        }
                        
                        HStack {
                            
                            Text("Telefone")
                            Spacer()
                            TextField("Celular", text: $viewModel.phoneValidation.value)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                            
                        }
                        
                        if viewModel.phoneValidation.failure {
                            
                            Text("Entre com o DDD + 9 dígitos")
                                .foregroundColor(.red)
                            
                        }
                        
                        HStack {
                            
                            Text("Data Nascimento")
                            Spacer()
                            TextField("Data Nascimento", text: $viewModel.birthdayValidation.value)
                                .multilineTextAlignment(.trailing)
                            
                        }
                        
                        if viewModel.birthdayValidation.failure {
                            
                            Text("Data deve ser dd/MM/yyyy")
                                .foregroundColor(.red)
                            
                        }
                        
                        NavigationLink(
                            destination: GenderSelectorView(
                                selectedGender: $selectedGender,
                                genders: Gender.allCases,
                                title: "Escolha o gênero"),
                            label: {
                                
                                Text("Gênero")
                                Spacer()
                                Text(selectedGender?.rawValue ?? "")
                                
                            })
                        
                    }
                    
                }
                
            }
            .navigationBarTitle(Text("Editar Pefil"), displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                Image(systemName: "checkmark")
                    .foregroundColor(.orange)
            })
                .opacity(disableDone ? 0 : 1)
                                
            )
            
        }
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel())
    }
}
