//
//  ProfileView.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 11.01.2025.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 16) {
                Spacer()
                
                Image(.user)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(8)
                    .background(.lightGray)
                    .clipShape(Circle())
                    .onTapGesture {
                        viewModel.isAvaAlertPresented.toggle()
                    }
                    .confirmationDialog("Откуда взять фото?", isPresented: $viewModel.isAvaAlertPresented) {
                        Button {
                            print("Library")
                        } label: {
                            Text("Из галереи")
                        }

                        Button {
                            print("Camera")
                        } label: {
                            Text("С камеры")
                        }
                    }
                VStack(alignment: .leading, spacing: 12) {
                    TextField("Имя", text: $viewModel.profile.name)
                        .font(.body.bold())
                    TextField("Телефон", text: $viewModel.profile.phone)
                }
                
                Spacer()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Адрес доставки:")
                    .bold()
                TextField("Ваш адрес", text: $viewModel.profile.address)
            }
            .padding(.horizontal)
            
            List {
                if viewModel.orders.isEmpty {
                    Text("У вас еще не было заказов")
                } else {
                    ForEach(viewModel.orders, id: \.id) { order in
                        OrderCell(order: order)
                    }
                }
            }
            .listStyle(.plain)
            
            HStack {
                Spacer()
                
                Button {
                    viewModel.isQuitAlertPresented.toggle()
                } label: {
                    Text("Выйти")
                        .padding()
                        .padding(.horizontal, 30)
                        .background(.red)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 20))
                }
                .padding()
                .confirmationDialog("Действительно выйти?", isPresented: $viewModel.isQuitAlertPresented) {
                    Button {
                        viewModel.signOut()
                    } label: {
                        Text("Да")
                    }
                }
                
                Spacer()
            }
        }
        .onSubmit {
            viewModel.setProfile()
        }
        .onAppear {
            viewModel.getProfile()
            viewModel.getOrders()
        }
        .fullScreenCover(isPresented: $viewModel.isShowAuthView) {
            AuthView()
        }
        .navigationTitle("Профиль")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    ProfileView()
}
