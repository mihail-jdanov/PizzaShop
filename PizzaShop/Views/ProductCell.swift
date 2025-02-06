//
//  ProductCell.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 11.01.2025.
//

import SwiftUI

struct ProductCell: View {
    
    var product: Product
    
    @State var uiImage = UIImage(resource: .productImagePH)
    
    var body: some View {
        VStack(spacing: 6) {
            Image(uiImage: uiImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: screen.width * 0.45)
                .clipped()
            HStack {
                Text(product.title)
                    .font(.custom("AvenirNext-regular", size: 12))
                Spacer()
                Text("\(product.getPrice(for: .small)) ₽")
                    .font(.custom("AvenirNext-bold", size: 12))
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 6)
        }
        .frame(width: screen.width * 0.45, height: screen.width * 0.55)
        .background(.white)
        .clipShape(.rect(cornerRadius: 16))
        .shadow(radius: 4)
        .onAppear {
            loadImage()
        }
    }
    
    func loadImage() {
        Task {
            let result = await StorageService.shared.downloadImage(productID: product.id)
            switch result {
            case .success(let data):
                await MainActor.run {
                    uiImage = UIImage(data: data) ?? UIImage(resource: .productImagePH)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

#Preview {
    ProductCell(product: .mock)
}
