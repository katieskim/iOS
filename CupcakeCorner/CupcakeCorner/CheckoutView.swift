//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Katie Kim on 7/11/25.
//

import Foundation
import SwiftUI

struct CheckoutView: View {
    var order: Order
    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 233)

            Text("Your total cost is \(order.cost, format: .currency(code: "USD"))")

            Button("Place Order") {
                Task {
                    await placeOrder()
                }
            }
            .padding()
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}
