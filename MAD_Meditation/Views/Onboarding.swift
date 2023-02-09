//
//  Onboarding.swift
//  MAD_Meditation
//
//  Created by Иван on 05.02.2023.
//

import SwiftUI

struct Onboarding: View {
    
    @ObservedObject var mController: MainController
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
            
            
            VStack{
                Image("Logo")
                    .frame(width: 191, height: 199)
                    .padding(.bottom, 20)
                    .padding(.top, 150)
                    
                
                Text("Привет")
                    .foregroundColor(Color.white)
                    .font(Font.custom("Alegreya-Bold", size: 34))
                
                Text("Наслаждайся отборочными.\nБудь внимателен.\nДелай хорошо")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .font(Font.custom("Alegreya-Medium", size: 20))
                    .padding(.bottom, 90)
                
                Button(action: {
                    mController.currentScreen = "/onboarding/logIn"
                }, label: {
                    ZStack{
                        Color("button")
                            .cornerRadius(10)
                        
                        Text("Войти в аккаунт")
                            .foregroundColor(Color.white)
                            .font(.custom("Alegreya-Medium", size: 25))
                    }
                })
                .frame(width: 321, height: 61)
                
                HStack(spacing: 3){
                    Text("Ещё нет аккаунта?")
                        .foregroundColor(Color.white)
                        .font(.custom("Alegreya-Regular", size: 20))
                    
                    Button(action: {
                        mController.currentScreen = "/onboarding/register"
                    }, label: {
                        Text("Зарегистрируйтесь")
                            .foregroundColor(Color.white)
                            .font(.custom("Alegreya-Regular", size: 20))
                    })
                    
                }
            }
        }
    }
}

