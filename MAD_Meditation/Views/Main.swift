//
//  Main.swift
//  MAD_Meditation
//
//  Created by Иван on 05.02.2023.
//

                            
import SwiftUI
import SDWebImageSwiftUI
import PhotosUI

struct Main: View {
    
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
                profile(mContr: mController, lgContr: loginController, nav: $internalNav)
            }
            
            
            //  Это должен был быть таббар
            ZStack{
                Color("LogIn_background")
                    .frame(width: 600, height: 70)
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
                .padding(.bottom, 20)
            }
            .padding(.top, 780)
            .padding(.trailing, 25)
        }
    }
}



struct home: View{
    
    @Binding var nav: String
    
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
                        
                        AsyncImage(url: URL(string: lController.imageUrl)){phase in
                            // Без клоужера нормально свойств не применить
                            if let image = phase.image{
                                image
                                    .resizable()
                                    .frame(width: 36, height: 36)
                                    .clipShape(Circle())
                            }
                        }
                            
                        
                    }
                    .padding(.top, 60)
                    
                    
                    Text("С возвращением, \(lController.nickName)")
                        .font(.custom("Alegreya-Bold", size: 30))
                        .foregroundColor(Color.white)
                    
                    Text("Каким ты себя ощущаешь сегодня?")
                        .font(.custom("Alegreya-Regular", size: 22))
                        .foregroundColor(Color.gray)
                    
                    if mController.isFeelingsLoaded{
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(spacing: 25){
                                ForEach(mController.feelings!.data){item in
                                    feelButton(title: item.title, imgUrl: item.image, position: item.position)
                                }
                            }
                            .padding(.leading, 30)
                        }
                        .padding(.bottom, 20)
                        .frame(width: 390)
                        
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
            .frame(height: 820)
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
    @ObservedObject var picker = ImagePicker()
    
    @Binding var nav: String
    
    var columns: [GridItem] = [
        GridItem(.fixed(150), spacing: 16),
        GridItem(.fixed(150), spacing: 16)
    ]
    
    
    var body: some View{
        ZStack{
            Color("LogIn_background")
                .ignoresSafeArea(.all)
            
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
                        
                        Button(action: {
                            lgContr.exit()
                            mContr.currentScreen = "/onboarding"
                            
                        }, label: {
                            Text("exit")
                                .foregroundColor(Color.white)
                        })
                    }
                    .padding(.top, 30)
                    
                    
                    AsyncImage(url: URL(string: lgContr.imageUrl)){phase in
                        
                        if let image = phase.image{
                            image
                                .resizable()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                        }
                    }
                    
                    
                    Text(lgContr.nickName)
                        .foregroundColor(Color.white)
                        .font(.custom("Alegreya-Bold", size: 35))
                        .padding(.bottom, 17)
                    
                    
                    LazyVGrid(columns: columns, alignment: .center, spacing: 16 ,content: {
                        
                        ForEach(picker.images){pic in
                            
                            if picker.images != nil{
                                Button(action: {
                                    mContr.selectedImage = pic.image
                                    mContr.currentScreen = "/main/profile/picture"
                                }, label: {
                                    ZStack{
                                        pic.image!
                                            .resizable()
                                            .frame(width: 153, height: 115)
                                            .cornerRadius(20)
                                        
                                        Text(mContr.getTime())
                                            .foregroundColor(Color.white)
                                            .font(.custom("Alegreya-Bold", size: 18))
                                            .padding(.trailing, 75)
                                            .padding(.top, 75)
                                        
                                    }
                                })
                                
                            }
                            
                        }
                        
                        PhotosPicker(selection: $picker.selectedImage, label: {
                            ZStack{
                                Color("plus_green")
                                    .frame(width: 153, height: 115)
                                    .cornerRadius(20)
                                
                                Image(systemName: "plus")
                                    .foregroundColor(Color.white)
                            }
                        })
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
                    
                    Text(String(title))
                        .foregroundColor(Color.white)
                        .font(.custom("Alegreya-Bold", size: 12))
                        .padding(.top, 90)
                    
                }
            })
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
                    .font(.custom("Alegreya-Bold", size: 25))
                    .foregroundColor(Color("LogIn_background"))
                    .padding(.leading, 40)
                
                
                
                Text(description)
                    .font(.custom("Alegreya-Medium", size: 15))
                    .foregroundColor(Color("LogIn_background"))
                    .frame(width: 200)
                    .padding(.leading, 35)
                
                Button(action: {}, label: {
                    ZStack{
                        Color("LogIn_background")
                            .frame(width: 138, height: 39)
                            .cornerRadius(10)
                        
                        Text("подробнее")
                            .foregroundColor(Color.white)
                    }
                })
                .padding(.leading, 40)
            }
            .padding(.trailing, 115)
            
            
        }
    }
}




struct ImageView: View{
    
    @ObservedObject var mController: MainController
    
    var img: Image
    @State var isZoomed = false
    
    var body: some View{
        
        ZStack{
            Color("LogIn_background")
                .ignoresSafeArea(.all)
            
            VStack{
                img
                    .resizable()
                    .aspectRatio(contentMode: isZoomed ? .fill : .fit)
                    .onTapGesture(count: 2) {
                        isZoomed.toggle()
                    }
                    .gesture(
                        DragGesture(minimumDistance: 100)
                            .onEnded({value in
                                
                                //  Слева направо ->
                                if value.translation.width > 0{
                                    mController.currentScreen = "/main"
                                }
                            })
                    )
                    .padding(.top, 200)
                    .padding(.bottom, 200)
                 
                HStack(spacing: 100){
                    
                    Button(action: {
                        
                    }, label: {
                        Text("удалить")
                            .foregroundColor(Color.white)
                            .font(.custom("Alegreya-Medium", size: 20))
                    })
                    
                    Button(action: {
                        mController.currentScreen = "/main"
                    }, label: {
                        Text("закрыть")
                            .foregroundColor(Color.white)
                            .font(.custom("Alegreya-Medium", size: 20))
                    })
                }
                
            }
        }
    }
}
