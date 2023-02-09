//
//  Controller.swift
//  MAD_Meditation
//
//  Created by Иван on 05.02.2023.
//
//

//  Рудимент

import Foundation

class VController: ObservableObject{

    @Published var currentScreen: String = ""

    func getFirstScreen() -> String{
        
        if UserDefaults.standard.string(forKey: "FirstScreen") != nil {
            return UserDefaults.standard.string(forKey: "FirstScreen")!
        }
        else{
            //  Если приложение запущено впервые, то в памяти будет nil, а первый экран - onboarding
            return "/onboarding"
        }
    }
    
    init() {
        currentScreen = getFirstScreen()
    }
}
