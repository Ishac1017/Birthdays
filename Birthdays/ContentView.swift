//
//  ContentView.swift
//  Birthdays
//
//  Created by Scholar on 6/6/25.
//

import SwiftUI

struct ContentView: View {
    @State private var friends: [Friend] = [
        Friend(name: "Elton Lin", birthday: .now),
        Friend(name: "Jenny Court", birthday: Date(timeIntervalSince1970: 0))
    ]
    @State private var newName = ""
    @State private var newBirthday = Date.now

    
    //end array
    var body: some View {
        NavigationStack {
            List(friends, id: \.name) { friend in
                HStack {
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                }
                //end hstack
            }
            //end list

            .navigationTitle("Birthdays")
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
                        friends.append(newFriend)
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
        }
        //end nav stack
    }
    //end body view
}
//end content
    
#Preview {
    ContentView()
}
