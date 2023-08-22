//
//  ContentView.swift
//  Tmarkis
//
//  Created by Agang Dut on 8/20/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selection = 0
    @EnvironmentObject var session: SessionStore
    
    func getUser () {
        session.listen()
    }
    
    var body: some View {
        TabView(selection: $selection) {
            if session.session == nil {
                HomeTab().tabItem {
                    VStack {
                        Image("Home")
                        Text("Home")
                    }
                }.tag(0)
                AccountTab().tabItem {
                VStack {
                    Image("Account")
                    Text("Account")
                }
                }.tag(1)
            } else {
                HomeTab().tabItem {
                        VStack {
                            Image("Home")
                            Text("Home")
                        }
                    }.tag(0)
                SignedInTab().tabItem {
                    VStack {
                        Image("Account")
                        Text("Account")
                    }
                }.tag(1)
            }
        }.accentColor(Color.yellow)
         .onAppear() {
         self.getUser()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionStore())
    }
}

