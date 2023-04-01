//
//  ImageView.swift
//  habit
//
//  Created by José Assis de Menezes Neto on 15/03/23.
//

import SwiftUI
import Combine

struct ImageView: View {
    
    @State var image: UIImage = UIImage()
    @ObservedObject var imageLoader: ImageLoader
    
    init(url: String) {
        
        imageLoader = ImageLoader(url: url)
        
    }
    
    var body: some View {
        
        Image(uiImage: image)
            .resizable()
            .onReceive(imageLoader.didChange) { data in
                
                self.image = UIImage(data: data) ?? UIImage()
                
            }
        
    }
}

class ImageLoader: ObservableObject {
    
    var didChange = PassthroughSubject<Data, Never>()
    
    var data = Data() {
        
        didSet {
            
            didChange.send(data)
            
        }
        
    }
    
    init(url: String) {
        
        guard let url = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
            
        }
        
        task.resume()
        
    }
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(url: "https://cdn.tiagoaguiar.co/habit_plus/517/1678884247.893884-1678884247.893573.png")
    }
}
