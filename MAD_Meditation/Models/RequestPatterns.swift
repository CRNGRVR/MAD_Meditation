//
//  RequestPatterns.swift
//  MAD_Meditation
//
//  Created by Иван on 05.02.2023.
//

import Foundation

//  Чувства
struct feelingsR: Codable{
    var data: [feelings_data]
}

struct feelings_data: Codable, Hashable, Identifiable{
    var id: Int
    var title: String
    var image: String
    var position: Int
}



//  Цитаты
struct quotesR: Codable{
    var data: [quotes_data]
}

struct quotes_data: Codable, Hashable, Identifiable{
    var id: Int
    var title: String
    var image: String
    var description: String
}
