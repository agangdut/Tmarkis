//
//  HomeTab.swift
//  Tmarkis
//
//  Created by Agang Dut on 8/21/23.
//

import SwiftUI

struct CartTab: View {
    var body: some View {
        Text("You have no Items!")
    }
}

struct homecards: View {
    var body: some View {
                Image("men")
                    .resizable()
                    .padding(.trailing, 2)
                    .cornerRadius(15)
                    .frame(minWidth: 0, maxWidth: 220, minHeight: 0, maxHeight: 200, alignment: Alignment.topLeading)
                // calltoproductview()
        }
    }


struct HomeTab: View {
    @EnvironmentObject var session: SessionStore
    
     func CartItems() -> some View {
        if session.session == nil {
            return AnyView(AccountTab())
        } else {
            return AnyView(CartTab())
        }
    }
    
    let dummycards: [String] = ["First", "Second", "Third"]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
            Text("**Featured**")
                    .padding(.leading, 12.0)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, alignment: .leading)
                    .font(.title2)
            VStack {
                NavigationLink(destination: ProductTab()) {
                let Header: NSAttributedString = "Tmarkis Designers".attributedStringWithColor(["Tmarkis"], color: Color.yellow)
                     Image("shirt")
                        .resizable()
                        .renderingMode(.original)
                        .navigationBarTitle("\(Header)", displayMode: .inline)
                        .navigationBarItems(trailing: NavigationLink(destination: CartItems()){
                            Image("Cart")
                        })
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300, alignment: Alignment.topLeading) .background(Color.yellow)
                    .cornerRadius(15)

                Text("**Categories**")
                    .padding(.leading, 12.0)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, alignment: .leading)
                    .font(.title2)
                
            ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                ForEach(dummycards, id: \.self) { i in
                homecards()
                    }
                }
            }
                Text("**Collections**")
                    .padding(.leading, 12.0)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, alignment: .leading)
                    .font(.title2)
                
                
            ForEach(dummycards, id: \.self) { i in
                Image("shirt")
                    .resizable()
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300, alignment: Alignment.topLeading) .background(Color.yellow)
                            .cornerRadius(15)
            
                Text("**Summer 2021**")
                    .padding(.leading, 12.0)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 50)
                    .font(.headline)
                    }
                }
            }
        }
    }
}

struct HomeTab_Previews: PreviewProvider {
    static var previews: some View {
        HomeTab()
            .environmentObject(SessionStore())
    }
}
