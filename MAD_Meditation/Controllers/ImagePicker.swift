//
//  ImagePicker.swift
//  MAD_Meditation
//
//  Created by Иван on 09.02.2023.
//
//  Не знаю как, но работает
//

import Foundation
import SwiftUI
import PhotosUI

class ImagePicker: ObservableObject{
    
    @Published var images: [PictureUnit] = []
    @Published var selectedImage: PhotosPickerItem?{
        didSet{
            if let selectedImage{
                Task{
                    try await loadTransferable(from: selectedImage)
                }
            }
        }
    }
    
    
    func loadTransferable(from selectedImage: PhotosPickerItem?) async throws{
        do{
            if let data = try await selectedImage?.loadTransferable(type: Data.self){
                
                if let uiImage = UIImage(data: data){
                    images.append(PictureUnit(id: UUID(), image: Image(uiImage: uiImage)))
                }
            }
        } catch{
            print("error")
        }
    }
    
}
