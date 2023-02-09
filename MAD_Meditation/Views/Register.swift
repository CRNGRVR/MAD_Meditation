//
//  Register.swift
//  MAD_Meditation
//
//  Created by Иван on 05.02.2023.
//

import SwiftUI

struct Register: View {
    
    //@Binding var nav: String
    
    @ObservedObject var mController: MainController
    
    var body: some View {
        VStack{
            Text("Тут должна быть регистрация")
            Button(action: {
                mController.currentScreen = "/onboarding"
            }, label: {
                Text("Назад")
            })
        }
    }
}
