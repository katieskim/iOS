//
//  UserDetailView.swift
//  UserDataProject
//
//  Created by Katie Kim on 7/17/25.
//

import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                //Header
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(user.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Spacer()
                        VStack {
                            Circle()
                                .fill(user.isActive ? Color.green : Color.red)
                                .frame(width: 16, height: 16)
                            Text(user.isActive ? "Active" : "Inactive")
                                .font(.caption)
                                .foregroundColor(user.isActive ? .green : .red)
                        }
                    }

                    Text("Age: \(user.age)")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                Divider()
                //Friends
                VStack(alignment: .leading, spacing: 8) {
                    Text("Friends (\(user.friends.count))")
                        .font(.headline)
                    LazyVStack(alignment: .leading, spacing: 4) {
                        ForEach(user.friends) { friend in
                            Text("• \(friend.name)")
                                .padding(.leading, 8)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("User Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserDetailView(user: User(id: "50a48fa3-2c0f-4397-ac50-64da464f9954", isActive: false, name: "Alford Rodriguez", age: 21, company: "Imkan", email: "alfordrodriguez@imkan.com", address: "907 Nelson Street, Cotopaxi, South Dakota, 5913", about:  "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.", friends: [Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel")]))
}
