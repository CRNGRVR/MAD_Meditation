//
//  ContentView.swift
//  MAD_Meditation
//
//  Created by Иван on 05.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var mainController: MainController = MainController()
    
    var body: some View {

        if mainController.currentScreen == "/onboarding"{
            Onboarding(mController: mainController)
        }
        else if mainController.currentScreen == "/onboarding/logIn"{
            LogIn(mController: mainController)
        }
        else if mainController.currentScreen == "/onboarding/register"{
            Register(mController: mainController)
        }
        else if mainController.currentScreen == "/main"{
            Main(mController: mainController)
        }
        else if mainController.currentScreen == "/main/profile/picture"{
            ImageView(mController: mainController, img: mainController.selectedImage!)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
