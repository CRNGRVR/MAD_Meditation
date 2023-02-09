//
//  LogIn.swift
//  MAD_Meditation
//
//  Created by Иван on 05.02.2023.
//

import SwiftUI

struct LogIn: View {

    @ObservedObject var logController: LogInController
    @ObservedObject var mController: MainController
    
    var body: some View {
        ZStack{
            Color("LogIn_background")
                .ignoresSafeArea(.all)
            
            VStack{
                VStack(spacing: 1){
                    Image("Logo")
                        .resizable()
                        .frame(width: 130, height: 160)
                        .padding(.trailing, 250)
                    
                    Text("Sign in")
                        .foregroundColor(Color.white)
                        .font(Font.custom("Alegreya-Medium", size: 30))
                        .padding(.trailing, 220)
                }
                    .padding(.bottom, 80)
                    
                
                VStack{
                    TextField("Email", text: $logController.mail)
                        .frame(width: 305, height: 40)
                        .font(.system(size: 18))
                        .foregroundColor(Color.gray)
                        .accentColor(Color.gray)
                    
                    Color.gray
                        .frame(width: 305, height: 2)
                }
                .padding(.bottom, 20)
                
                
                VStack{
                    SecureField("Пароль", text: $logController.password)
                        .frame(width: 305, height: 40)
                        .font(.system(size: 18))
                        .foregroundColor(Color.gray)
                        .accentColor(Color.gray)
                    
                    Color.gray
                        .frame(width: 305, height: 2)
                }
                .padding(.bottom, 40)
                
                
                Button(action: {
                    
                    if logController.log_in(){
                        mController.currentScreen = "/main"
                    }
                    
                }, label: {
                    ZStack{
                        Color("button")
                            .cornerRadius(10)
                        
                        Text("Sign in")
                            .foregroundColor(Color.white)
                            .font(.custom("Alegreya-Medium", size: 25))
                    }
                })
                .frame(width: 321, height: 61)
                .padding(.bottom, 20)
                .alert(logController.msg, isPresented: $logController.isShowingAlert, actions: {})
                
                
                Button(action: {
                    mController.currentScreen = "/onboarding/register"
                }, label: {
                    Text("Register")
                        .foregroundColor(Color.white)
                })
                .padding(.trailing, 250)
                .padding(.bottom, 20)
                
                
                Button(action: {
                    
                }, label: {
                    ZStack{
                        Color("button")
                            .cornerRadius(10)
                        
                        Text("Профиль")
                            .foregroundColor(Color.white)
                            .font(.custom("Alegreya-Medium", size: 25))
                    }
                })
                .frame(width: 321, height: 61)
                
            }
            
            Image("LogIn_effect")
                .padding(.top, 600)
        }
    }
}
