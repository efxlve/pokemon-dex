//
//  FetchedImage.swift
//  Dex3
//
//  Created by Muharrem Efe Çayırbahçe on 1.01.2025.
//

import SwiftUI

struct FetchedImage: View {
    let url: URL?
    
    var body: some View {
        if let url, let imageData = try? Data(contentsOf: url), let uIImage = UIImage(data: imageData) {
            Image(uiImage: uIImage)
                .resizable()
                .scaledToFit()
                .shadow(color: .black, radius: 6)
        } else {
            Image("bulbasaur")    
        }
    }
}

#Preview {
    FetchedImage(url: SamplePokemon.samplePokemon.sprite)
}
