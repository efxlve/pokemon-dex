//
//  ContentView.swift
//  Dex3
//
//  Created by Muharrem Efe Çayırbahçe on 28.12.2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        animation: .default)
    private var pokedex: FetchedResults<Pokemon>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Pokemon.id, ascending: true)],
        predicate: NSPredicate(format: "favorite = %d", true),
        animation: .default
    ) private var favorites: FetchedResults<Pokemon>
    
    @State var filterByFavorites = false
    @StateObject private var pokemonVM = PokemonViewModel(controller: FetchController())
    
    @State private var searchText = ""
    @State private var animatedPokemon: [Pokemon] = [] // Animasyon için geçici liste
    
    var body: some View {
        switch pokemonVM.status {
        case .success:
            NavigationStack {
                List(animatedPokemon) { pokemon in
                    NavigationLink(value: pokemon) {
                        AsyncImage(url: pokemon.sprite!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        
                        Text(pokemon.name!.capitalized)
                        
                        if pokemon.favorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        }
                    }
                }
                .navigationTitle("Pokedex")
                .navigationDestination(for: Pokemon.self, destination: { pokemon in
                    PokemonDetail()
                        .environmentObject(pokemon)
                })
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation {
                                filterByFavorites.toggle()
                                updateAnimatedPokemon()
                            }
                        } label: {
                            Label("Filter by Favorites", systemImage: filterByFavorites ? "star.fill" : "star")
                        }
                        .font(.title)
                        .foregroundColor(.yellow)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search Pokémon")
            .onChange(of: searchText) { _ in
                withAnimation {
                    updateAnimatedPokemon()
                }
            }
            .onChange(of: filterByFavorites) { _ in
                withAnimation {
                    updateAnimatedPokemon()
                }
            }
            .onAppear {
                updateAnimatedPokemon()
            }
        default:
            ProgressView()
        }
    }
    
    private func updateAnimatedPokemon() {
        let source = filterByFavorites ? favorites : pokedex
        if searchText.isEmpty {
            animatedPokemon = Array(source)
        } else {
            animatedPokemon = source.filter { pokemon in
                pokemon.name?.localizedCaseInsensitiveContains(searchText) ?? false
            }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
