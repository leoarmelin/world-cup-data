//
//  LoginView.swift
//  WorldCupData
//
//  Created by Leonardo Armelin on 26/11/22.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    @EnvironmentObject var storeWrapper: WrappedStruct<Store<WorldCupFeature.State, WorldCupFeature.Action>>
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var rotatingBallAngle: CGFloat = 0.0
    
    var body: some View {
        WithViewStore(storeWrapper.item, observe: {$0}) { viewStore in
            ZStack {
                Color(cgColor: CGColor(red: 255, green: 223, blue: 0, alpha: 1))
                
                VStack {
                    if viewStore.isLoginRequestLoading == true {
                        Image(uiImage: UIImage(named: "soccer_ball")!)
                            .frame(width: 100, height: 100)
                            .rotationEffect(.degrees(rotatingBallAngle))
                            .onAppear {
                                withAnimation(.linear(duration: 0.5)
                                    .speed(0.2)
                                    .repeatForever(autoreverses: false)
                                ) {
                                    rotatingBallAngle = 360.0
                                }
                            }
                    } else {
                        TextField("Email", text: $email)
                            .textInputAutocapitalization(.never)
                            .textContentType(.emailAddress)
                            .padding([.leading, .trailing], 16)
                            .padding([.top, .bottom], 8)
                            .background(Color.white)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 2)
                            )
                            .padding([.leading, .trailing], 16)
                        
                        SecureField("Password", text: $password)
                            .textInputAutocapitalization(.never)
                            .textContentType(.password)
                            .padding([.leading, .trailing], 16)
                            .padding([.top, .bottom], 8)
                            .background(Color.white)
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(.gray, lineWidth: 2)
                            )
                            .padding([.leading, .trailing], 16)
                            .padding([.top], 8)
                        
                        Button("Go To Field") {
                            viewStore.send(.loginUser(email: email, password: password))
                        }
                        .padding([.top, .bottom], 8)
                        .padding([.leading, .trailing], 16)
                        .foregroundColor(Color.white)
                        .background(Color(cgColor: CGColor(red: 0, green: 0.3, blue: 0.8, alpha: 1)))
                        .cornerRadius(16)
                        .padding([.top], 16)
                    }
                }
            }.ignoresSafeArea()
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
