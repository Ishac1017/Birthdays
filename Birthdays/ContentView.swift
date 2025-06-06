//
//  ContentView.swift
//  Birthdays
//
//  Created by Scholar on 6/6/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    func deleteFriend(at offsets: IndexSet)
    {
        for index in offsets {
            let friendToDelete = friends[index]
            context.delete(friendToDelete)
        }
    }
    //end function
    @Query private var friends: [Friend] = [
        Friend(name: "Elton Lin", birthday: .now),
        Friend(name: "Jenny Court", birthday: Date(timeIntervalSince1970: 0))
    ]
    @Environment(\.modelContext) private var context
    @State private var newName = ""
    @State private var newBirthday = Date.now
    @State private var selectedFriend: Friend?

    
    //end array
    var body: some View {
        NavigationStack {
            List {
                ForEach(friends) { friend in
                    HStack {
                            Text(friend.name)
                            Spacer()
                            Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                        }
                        //end hstack
                    .onTapGesture {
                        selectedFriend = friend
                    }
                }
                .onDelete(perform: deleteFriend)
            }
            //end list
            .navigationTitle("Birthdays")
            .sheet(item: $selectedFriend) { friend in
                NavigationStack {
                    EditFriendView(friend: friend)
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center, spacing: 20) {
                        Text("New Birthday")
                            .font(.headline)
                        
                    DatePicker(selection: $newBirthday, in: Date.distantPast...Date.now, displayedComponents: .date) {
                                TextField("Name", text: $newName)
                                    .textFieldStyle(.roundedBorder)
                            }
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        context.insert(newFriend)
                        newName = ""
                        newBirthday = .now
                    }
                    //end button
                    .bold()
                }
                //end VStack
                .padding()
                .background(.bar)
            }
            //end safenet
        }
        //end nav stack
    }
    //end body view
}
//end content
    
#Preview {
    ContentView()
        .modelContainer(for:Friend.self, inMemory: true)
}
