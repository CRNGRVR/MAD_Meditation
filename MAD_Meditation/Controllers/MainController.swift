//
//  MainController.swift
//  MAD_Meditation
//
//  Created by Иван on 06.02.2023.
//

import Foundation
import Alamofire
import SwiftUI

class MainController: ObservableObject{
    
    //  Навигация
    @Published var currentScreen: String = ""
    
    
    //  Логин и пароль для авторизации
    @Published var mail: String
    @Published var password = ""

    var isAuthSuccess = false{
        didSet{
            if isAuthSuccess{
                currentScreen = "/main"
            }
        }
    }
    
    @Published var msg = ""
    @Published var isShowingAlert = false

    
    
    //  Загружаются из памяти и используются другими экранами
    @Published var nickName: String = ""
    @Published var imageUrl: String = ""
    
    
    
    //  Главный экран
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
    
    
    
    //  Получение стартового экрана при запуске приложения
    func getFirstScreen() -> String{
        
        if UserDefaults.standard.string(forKey: "FirstScreen") != nil {
            return UserDefaults.standard.string(forKey: "FirstScreen")!
        }
        else{
            //  Если приложение запущено впервые, то в памяти будет nil, а первый экран - onboarding
            return "/onboarding"
        }
    }

    
    //  Экран с картиночками
    @Published var selectedImage: Image? = nil  //  Выбраная картинка для перехода в ImageView
    
    
    
    init() {
        
        if UserDefaults.standard.string(forKey: "LastMail") != nil{
            mail = UserDefaults.standard.string(forKey: "LastMail")!
        }
        else{
            mail = ""
        }
        
        if UserDefaults.standard.string(forKey: "Name") != nil{
            nickName = UserDefaults.standard.string(forKey: "Name")!
        }
        
        if UserDefaults.standard.string(forKey: "ImageUrl") != nil{
            imageUrl = UserDefaults.standard.string(forKey: "ImageUrl")!
        }
        
        currentScreen = getFirstScreen()
    }
    
    

    
    
    //  Валидация полей регистрации
    func isFillAndPesik() -> Bool{
        
        msg = ""
        isShowingAlert = false
        var countPesik = 0
        
        //  Проверка пустоты полей
        if mail == "" || password == ""{
            msg = "Поля не должны пустовать."
            isShowingAlert = true
            return false
        }
        
        //  Проверка на количество "@"
        for i in mail{
            if i == "@"{
                countPesik += 1
            }
        }
        
        if countPesik == 0{
            msg = "Требуется символ \"@\"."
            isShowingAlert = true
            return false
        }
        else if countPesik > 1{
            msg = "Символ \"@\" должен быть один в строке."
            isShowingAlert = true
            return false
        }
        else{
            return true
        }
    }
    
    
    func requestAuth(){
        
        isAuthSuccess = false
        let accountData = loginInput(email: mail, password: password)
        
        AF
            .request("http://mskko2021.mad.hakta.pro/api/user/login" , method: .post, parameters: accountData, encoder: JSONParameterEncoder.default)
        
            .responseDecodable(of: loginOutput.self){responce in

                if responce.value != nil{

                    self.nickName = responce.value!.nickName
                    self.imageUrl = responce.value!.avatar
                    
                    self.isAuthSuccess = true
                }
                else{
                    
                    self.msg = "Ошибка"
                    self.isShowingAlert = true
                    
                    self.isAuthSuccess = false
                }
            }
            .responseString{str in
                print(str)
            }



        if isAuthSuccess{
            //  Когда авторизация успешна
            UserDefaults.standard.set(nickName, forKey: "Name")
            UserDefaults.standard.set(imageUrl, forKey: "ImageUrl")
            UserDefaults.standard.set("/main", forKey: "FirstScreen")
            UserDefaults.standard.set(mail, forKey: "LastMail")

            password = ""
        }
    }
    
    
    func log_in() -> Bool{
        
        if isFillAndPesik(){

            requestAuth()
            
            if isAuthSuccess{
                return true
            }
        }
        return false
    }
    
    
    func exit(){
        UserDefaults.standard.set("", forKey: "Name")
        UserDefaults.standard.set("", forKey: "ImageUrl")
        UserDefaults.standard.set("/onboarding", forKey: "FirstScreen")
    }
    
    
    
    

    
    
    
    
    
    
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
    
    
    
    
    
    
    func getTime() -> String{
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let min = calendar.component(.minute, from: date)
        
        var strh = ""
        var strm = ""
        
        
        //  Без нолика в начале плохо выглядит
        if hour < 10{
            strh = "0\(hour)"
        }
        else
        {
            strh = String(hour)
        }
        
        if min < 10{
            strm = "0\(min)"
        }
        else{
            strm = String(min)
        }
        
        
        return "\(strh):\(strm)"
    }
    
}
