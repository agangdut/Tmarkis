//
//  ProductTab.swift
//  Tmarkis
//
//  Created by Agang Dut on 8/23/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ProductTab: View {
    @EnvironmentObject var session: SessionStore
    @AppStorage("animationModeKey") private var animationsMode: productSize = .small
        @Environment(\.colorScheme) var colorScheme
        let color = Color.yellow
    @AppStorage("animationModeKey2") private var animationsMode2: productColor = .black
        @Environment(\.colorScheme) var colorScheme2
        let color2 = Color.yellow
    
    enum productSize: Int, CaseIterable {
        case small, medium, large
        var imageName: String {
                switch self {
                case .small:
                    return "s.square.fill"
                case .medium:
                    return "m.square.fill"
                case .large:
                    return "l.square.fill"
                }
            }
    }
    
    enum productColor: Int, CaseIterable {
        case black, white, yellow
        var imageName: Color {
                switch self {
                case .black:
                    return Color.blue
                case .white:
                    return Color.green
                case .yellow:
                    return Color.red
                }
            }
    }

    let images = ["userimg","userimg","userimg"]
    
    @State private var selectedColor: productColor = .black
    @State private var selectedSize: productSize = .small
    @State private var selection = 0
    
    func addToCart() -> some View {
       if session.session == nil {
           return AnyView(AccountTab())
       } else {
           return AnyView(CartTab())
       }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text("Tmarkis Premier Jeans")
                        .font(.system(size: 20, weight: .semibold))
                    Text("$39.99")
                        .font(.system(size: 18, weight: .semibold))
                    ZStack{
                        Color.black
                        TabView(selection : $selection){
                            
                            ForEach(0..<3){ i in
                                Image("\(images[i])")
                                    .resizable()
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 500, alignment: Alignment.topLeading)
                                    .ignoresSafeArea()
                            }
                        }.frame(minHeight: 500)
                    }
                    .ignoresSafeArea()
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    Text("Select Size")
                        .padding(.leading, 25)
                        .padding(.bottom, 5)
                        .font(.system(size: 15, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack() {
                        ForEach(productSize.allCases.indices, id: \.self) { index in
                            let mode = productSize.allCases[index]
                            Button {
                                animationsMode = mode
                            } label: {
                                VStack() {
                                    Image(systemName: mode.imageName)
                                        .font(.system(size: 38))
                                        .padding(.bottom, 10)
                                }
                            }
                            .foregroundStyle(mode == animationsMode ? color : .primary)
                        }
                    } .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                    Text("Select Color")
                        .padding(.leading, 25)
                        .padding(.bottom, 5)
                        .font(.system(size: 15, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack() {
                        ForEach(productColor.allCases.indices, id: \.self) { index in
                            let mode = productColor.allCases[index]
                            Button {
                                animationsMode2 = mode
                            } label: {
                                mode.imageName
                                    .frame(maxWidth: 40, minHeight: 40)
                                    .cornerRadius(10)
                            }
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke((mode == animationsMode2 ? (Color.yellow) : (Color(UIColor.systemBackground))), lineWidth: 2)
                            )
                        }
                    } .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.bottom, 5)
                    Text("Description")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.leading, 20)
                        .padding(.bottom, 5)
                    Text("""
                Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                """)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 20)
                }
            }
            VStack {
                GeometryReader { geometry in
                    HStack {
                        Spacer()
                        Button() {

                        } label: {
                            Text("Add to Cart")
                            Image(systemName: "cart")
                        }
                        .padding()
                        .frame(width: CGFloat(geometry.size.width / 2))
                        .disabled(session.session == nil)
                        .background(session.session == nil ? .gray :  Color(UIColor.systemBackground))
                        .colorInvert()
                        .foregroundColor(session.session == nil ? .white : .blue)
                        .cornerRadius(15)
                        .tint(.gray)
                        Button() {
                        } label: {
                            Text("Buy Now")
                        }
                        .frame(width: CGFloat(geometry.size.width / 3))
                        .padding()
                        .background(Color(UIColor.systemBackground))
                        .colorInvert()
                        .foregroundColor(.blue)
                        .cornerRadius(15)
                        Spacer()
                    }
                }.frame(maxWidth: .infinity, maxHeight: 10, alignment: .bottom)
                    .padding(.bottom, 50)
            }
        }
    }
}

struct ProductTab_Previews: PreviewProvider {
    static var previews: some View {
        ProductTab()
            .environmentObject(SessionStore())
    }
}
