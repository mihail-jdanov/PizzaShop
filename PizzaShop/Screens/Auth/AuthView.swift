//
//  AuthView.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 11.01.2025.
//

import SwiftUI

struct AuthView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.isAuth ? "Авторизация" : "Регистрация")
                .padding()
                .padding(.horizontal, 30)
                .font(.title.bold())
                .background(.whiteAlpha)
                .clipShape(.rect(cornerRadius: 30))
            
            VStack {
                TextField("Введите Email", text: $viewModel.email)
                    .padding()
                    .background(.whiteAlpha)
                    .clipShape(.rect(cornerRadius: 12))
                    .padding(8)
                    .padding(.horizontal, 12)
                
                SecureField("Введите пароль", text: $viewModel.password)
                    .padding()
                    .background(.whiteAlpha)
                    .clipShape(.rect(cornerRadius: 12))
                    .padding(8)
                    .padding(.horizontal, 12)
                    .onSubmit {
                        if viewModel.isAuth {
                            viewModel.signIn()
                        }
                    }
                
                if !viewModel.isAuth {
                    SecureField("Повторите пароль", text: $viewModel.confirmPassword)
                        .padding()
                        .background(.whiteAlpha)
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(8)
                        .padding(.horizontal, 12)
                        .onSubmit {
                            if !viewModel.isAuth {
                                viewModel.signUp()
                            }
                        }
                }
                
                Button {
                    if viewModel.isAuth {
                        viewModel.signIn()
                    } else {
                        viewModel.signUp()
                    }
                } label: {
                    Text(viewModel.isAuth ? "Войти" : "Создать аккаунт")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(
                            colors: [.yellow, .orange],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundStyle(.darkBrown)
                }
                .buttonStyle(.plain)
                .disabled(viewModel.isLoading)
                
                Button {
                    viewModel.isAuth.toggle()
                } label: {
                    Text(viewModel.isAuth ? "Ещё не с нами?" : "Уже есть аккаунт?")
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity)
                        .clipShape(.rect(cornerRadius: 12))
                        .padding(8)
                        .padding(.horizontal, 12)
                        .font(.title3.bold())
                        .foregroundStyle(.darkBrown)
                }
            }
            .padding()
            .padding(.top, 16)
            .background(.whiteAlpha)
            .clipShape(.rect(cornerRadius: 24))
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.bg)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .blur(radius: viewModel.isAuth ? 0 : 6)
        )
        .ignoresSafeArea()
        .animation(.easeInOut, value: viewModel.isAuth)
        .fullScreenCover(isPresented: $viewModel.isTabViewShow) {
            if viewModel.isLoggedInAsAdmin {
                AdminOrdersView()
            } else {
                MainTabBarView()
            }
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.isShowAlert) {
            Button { } label: {
                Text("OK")
            }
        }
    }
    
}

#Preview {
    AuthView()
}
