//
//  ContentView.swift
//  MAD_Meditation
//
//  Created by Иван on 05.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    //@ObservedObject var vController: VController = VController()
    
    @ObservedObject var mainController: MainController = MainController()
    @ObservedObject var loginController: LogInController = LogInController()
    
    var body: some View {
        
//        if vController.currentScreen == "/onboarding"{
//            Onboarding(nav: $vController.currentScreen)
//        }
//        else if vController.currentScreen == "/onboarding/logIn"{
//            LogIn(nav: $vController.currentScreen)
//        }
//        else if vController.currentScreen == "/onboarding/register"{
//            Register(nav: $vController.currentScreen)
//        }
//        else if vController.currentScreen == "/main"{
//            //Main(nav: $vController.currentScreen)
//        }
        
        
                if mainController.currentScreen == "/onboarding"{
                    Onboarding(mController: mainController)
                }
                else if mainController.currentScreen == "/onboarding/logIn"{
                    LogIn(logController: loginController, mController: mainController)
                }
                else if mainController.currentScreen == "/onboarding/register"{
                    Register(mController: mainController)
                }
                else if mainController.currentScreen == "/main"{
                    Main(mController: mainController, loginController: loginController)
                }
      
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
