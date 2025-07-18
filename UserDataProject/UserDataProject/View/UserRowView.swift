//
//  UserRowView.swift
//  UserDataProject
//
//  Created by Katie Kim on 7/17/25.
//

import SwiftUI

struct UserRowView: View {
    let user: User

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                Text(user.company)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Circle()
                    .fill(user.isActive ? Color.green: Color.red)
                    .frame(width: 12, height: 12)
                Text(user.isActive ? "Active" : "Inactive")
                    .font(.caption)
                    .foregroundColor(user.isActive ? .green : .red)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    UserRowView(user: User(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about:  "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.", friends: [Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel")]))
}
