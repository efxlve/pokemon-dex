//
//  SamplePokemon.swift
//  Dex3
//
//  Created by Muharrem Efe Çayırbahçe on 1.01.2025.
//

import Foundation
import CoreData

struct SamplePokemon {
    @MainActor static let samplePokemon = {
        let context = PersistenceController.preview.container.viewContext
        
        let fetchRequest: NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try! context.fetch(fetchRequest)
        
        return results.first!
    }()
}
    
