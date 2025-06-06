//
//  EditFriendView.swift
//  Birthdays
//
//  Created by Scholar on 6/6/25.
//

import SwiftUI

struct EditFriendView: View {
    var friend: Friend
    @State private var newName: String
    @State private var newBirthday: Date
    @Environment(\.dismiss) private var dismiss // new

    
    init(friend: Friend) {
        self.friend = friend
        _newName = State(initialValue: friend.name)
        _newBirthday = State(initialValue: friend.birthday)
    }
    var body: some View {
        Text("Hello World")
        Form { // new
            TextField("Name", text: $newName) // new
            DatePicker("Birthday", selection: $newBirthday, displayedComponents: .date) // new
        }
        // end form
        .navigationTitle("Edit Friend")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") { // new
                        friend.name = newName
                            friend.birthday = newBirthday
                    dismiss()
                }
                //end save button
            }//end action
        }//end toolbar
    }
    // end body
}

#Preview {
    NavigationStack { // new
            EditFriendView(friend: Friend(name: "Test", birthday: Date.now))
    }
    //end nav stack
}
