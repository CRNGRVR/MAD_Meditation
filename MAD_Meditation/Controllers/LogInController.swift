//
//  LogInController.swift
//  MAD_Meditation
//
//  Created by Иван on 05.02.2023.
//

import Foundation
import Alamofire

class LogInController: ObservableObject{
    
    @Published var mail: String
    @Published var password = ""
    
    @Published var msg = ""
    @Published var isShowingAlert = false

    //  Загружаются из памяти и используются другими экранами
    @Published var nickName: String = ""
    @Published var imageUrl: String = ""
    
    
    init(){
        
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
    }
    
    //  Валидация полей
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
        
        //  Заглушка
        nickName = "Oleg"
        imageUrl = #"https://placepic.ru/wp-content/uploads/2019/04/Koala_AH2Q1878_edbook.jpg"#
        
        // Тут должны были быть условия, пришедшие из апи
        if true{
            
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
            
            //  Возврат значения для навигации по view
            return true
        }
        
        return false
    }
    
    
    func exit(){
        UserDefaults.standard.set("", forKey: "Name")
        UserDefaults.standard.set("", forKey: "ImageUrl")
        UserDefaults.standard.set("/onboarding", forKey: "FirstScreen")
    }
    
}
