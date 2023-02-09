//
//  MainController.swift
//  MAD_Meditation
//
//  Created by Иван on 06.02.2023.
//

import Foundation
import Alamofire

class MainController: ObservableObject{
    
    
    //  Навигация
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
    
    
    
    
    
    
    
    //  Главный экран
    @Published var name = ""
    @Published var imageUrl = ""
    
    @Published var feelings: feelingsR? = nil{
        
        didSet{
            if feelings != nil{
                isFeelingsLoaded = true
            }
            else{
                isFeelingsLoaded = false
            }
        }
    }
    
    @Published var quotes: quotesR? = nil{
        
        didSet{
            if quotes != nil{
                isQuotesLoaded = true
            }
            else{
                isQuotesLoaded = false
            }
        }
    }
    
    //  Пришли ли данные с сервера
    //  Если нет, то ScrollView не появляется
    @Published var isFeelingsLoaded = false
    @Published var isQuotesLoaded = false
    
    
    func getFeelings(){
        
        AF
            .request("http://mskko2021.mad.hakta.pro/api/feelings")
            .responseDecodable(of: feelingsR.self){response in
                if response.value != nil{
                    self.feelings = response.value!
                }
            }
    }
    
    
    func getQuotes(){
        
        AF
            .request("http://mskko2021.mad.hakta.pro/api/quotes")
            .responseDecodable(of: quotesR.self){response in
                if response.value != nil{
                    self.quotes = response.value
                }
            }
    }
    
    
    
    
    
}
