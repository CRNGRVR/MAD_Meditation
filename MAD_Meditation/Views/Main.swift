//
//  Main.swift
//  MAD_Meditation
//
//  Created by Иван on 05.02.2023.
//

                            
import SwiftUI
import SDWebImageSwiftUI

struct Main: View {
    
    //@Binding var nav: String
    
    @ObservedObject var mController: MainController
    @ObservedObject var loginController: LogInController
    
    @State var internalNav = "/home"
    
    var body: some View {
        ZStack{
            
            Color("LogIn_background")
                .ignoresSafeArea(.all)
            
            
            if internalNav == "/home" || internalNav == "/home/menu"{
                home(nav: $internalNav, mController: mController, lController: loginController)
            }
            else if internalNav == "/sound"{
                sound()
            }
            else if internalNav == "/profile"{
                profile(mContr: mController, lgContr: loginController)
            }
            
            
            //  Это должен был быть таббар
            ZStack{
                Color("LogIn_background")
                    .frame(width: 600, height: 50)
                    .ignoresSafeArea(.all)
                
                HStack(spacing: 95){
                    Button(action: {
                        internalNav = "/home"
                    }, label: {
                        Image("Logo")
                            .resizable()
                            .frame(width: 50, height: 60)
                            .opacity(internalNav == "/home" ? 0.4 : 0.2)
                    })
                    
                    Button(action: {
                        internalNav = "/sound"
                    }, label: {
                        Image("Sound")
                            .opacity(internalNav == "/sound" ? 1 : 0.3)
                    })
                    
                    Button(action: {
                        internalNav = "/profile"
                    }, label: {
                        Image("Profile")
                            .opacity(internalNav == "/profile" ? 1 : 0.3)
                    })
                }
            }
            .padding(.top, 745)
            .padding(.trailing, 25)
        }
    }
}



struct home: View{
    
    @Binding var nav: String
    //@Binding var name: String
    
    @ObservedObject var mController: MainController
    @ObservedObject var lController: LogInController
    
    var body: some View{
        if nav == "/home"{
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    HStack(spacing: 80){
                        Button(action: {
                            nav = "/home/menu"
                        }, label: {
                            Image("Hamburger")
                        })
                        
                        Image("Logo")
                            .resizable()
                            .frame(width: 100, height: 120)
                        
                        AsyncImage(url: URL(string: lController.imageUrl))
                            .clipShape(Circle())
                            .frame(width: 40, height: 40)

                    }
                    .padding(.top, 30)
                    
                    
                    Text("С возвращением, \(lController.nickName)")
                        .font(.system(size: 30))
                        .foregroundColor(Color.white)
                    
                    Text("Каким ты себя чувствуешь сегодня?")
                        .font(.system(size: 21))
                        .foregroundColor(Color.gray)
                    
                    if mController.isFeelingsLoaded{
                        ScrollView(.horizontal, showsIndicators: true){
                            HStack(spacing: 25){
                                ForEach(mController.feelings!.data){item in
                                    feelButton(title: item.title, imgUrl: item.image, position: item.position)
                                }
                            }
                            //.padding(.leading, 100)
                            .padding(.leading, 30)
                        }
                        //.padding(.leading, 150)
                        .padding(.bottom, 20)
                        .frame(width: 390)
                        //.padding(.leading, 50)
                        
                    }
                    
                    
                    if mController.isQuotesLoaded{
                        
                        VStack(spacing: 25){
                            ForEach(mController.quotes!.data){item in
                                    quoteCard(title: item.title, description: item.description, imageUrl: item.image)
                            }
                        }
                    }
                    
                    
                }
                .onAppear(perform: {
                    //  Загрузка данных
                    mController.getFeelings()
                    mController.getQuotes()
                })
            }
            .frame(height: 770)
            .padding(.bottom, 120)
        }
        else if nav == "/home/menu"{
            menu(nav: $nav)
        }
    }
}

struct sound: View{
    var body: some View{
        ZStack{
            Text("Тут должно было быть прослушивание")
                .foregroundColor(Color.white)
            
        }
    }
}



struct profile: View{
    
    @ObservedObject var mContr: MainController
    @ObservedObject var lgContr: LogInController
    
    var body: some View{
        ZStack{
            Color("LogIn_background")
                .ignoresSafeArea(.all)
            
            VStack{
                
                
                HStack{
                    
                    
                    Button(action: {
                        
                        lgContr.exit()
                        mContr.currentScreen = "/onboarding"
                        
                    }, label: {
                        Text("exit")
                            .foregroundColor(Color.white)
                    })
                }
            }
        }
    }
}



struct menu: View{
    
    @Binding var nav: String
    
    var body: some View{
        VStack{
            
            Text("Тут должно быть меню")
                .foregroundColor(Color.white)
            
            Button(action: {
                nav = "/home"
            }, label: {
                Text("Назад")
            })
        }
    }
}






struct feelButton: View{
    
    var title: String
    var imgUrl: String
    var position: Int
    
    var body: some View{
        
        VStack{
            Button(action: {}, label: {
                ZStack{
                    Color("feelings_color")
                        .frame(width: 70, height: 70)
                        .cornerRadius(20)
                    
                    AsyncImage(url: URL(string: imgUrl))
                }
            })
            
            Text(title)
                .foregroundColor(Color.white)
                .font(.system(size: 10))
        }
    }
}

struct quoteCard: View{
    
    var title: String
    var description: String
    var imageUrl: String
    
    var body: some View{
        
        ZStack{
            Color("quotes_color")
                .frame(width: 339, height: 170)
                .cornerRadius(20)
            
            AsyncImage(url: URL(string: imageUrl))
                .padding(.leading, 180)
                .padding(.top, 30)
            
            
            
            VStack(alignment: .leading){
                Text(title)
                    .font(.system(size: 22))
                    .foregroundColor(Color("LogIn_background"))
                    .padding(.leading, 40)
                    
                    
                
                Text(description)
                    .font(.system(size: 14))
                    .foregroundColor(Color("LogIn_background"))
                    .frame(width: 200)
                    .padding(.leading, 40)
                
                Button(action: {}, label: {
                    ZStack{
                        Color("LogIn_background")
                            .frame(width: 138, height: 39)
                            .cornerRadius(10)
                        
                        Text("Подробнее")
                            .foregroundColor(Color.white)
                    }
                })
                .padding(.leading, 40)
            }
            .padding(.trailing, 115)
            
            
            
        }
    }
}





//
//struct Main_Previews: PreviewProvider {
//    static var previews: some View {
//        Main()
//    }
//}
