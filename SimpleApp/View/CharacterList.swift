//
//  CharacterList.swift
//  SimpleApp
//
//  Created by Phuc Nguyen Phuoc Nhu on 26/07/2022.
//
//        thehappyprogrammer.com/custom-list-in-swiftui
import SwiftUI

struct smallcardView: View {
    var p: Character
    let namespace: Namespace.ID
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: p.image)) { image in
                image.resizable()
            } placeholder: {
                Color.red
            }
            .frame(width: 150, height: 150)
//            .clipShape(RoundedRectangle(cornerRadius: 25))

            VStack {
                Text(p.name)
                Text(p.origin.name)
                Text(p.status)
            }
        }
    }
}

struct blurTags:  View {
    
    var tags: Array<String>
    let namespace: Namespace.ID
    var body: some View {
        HStack {
            ForEach(tags, id: \.self) { tag in
                Text("\(tag)")
                    .fontWeight(.semibold)
                    .foregroundColor(.yellow)
                    .font(.caption)
                    
            }
        }.matchedGeometryEffect(id: "tags", in: namespace)
    }
}

struct BlurView: View {
    var body: some View {
        HStack {
            Color.gray
        }.opacity(0.2)
    }
}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

struct BackgroundView: View {
    var body: some View {
        Image("space")
            .centerCropped()
            .edgesIgnoringSafeArea(.all)
    }
}

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(red: 0.07, green: 0.07, blue: 0.07))
             HStack {
                 TextField("Search by name...", text: $searchText) { startedEditing in
                     if startedEditing {
                         withAnimation {
                             searching = true
                         }
                     }
                 } onCommit: {
                     withAnimation {
                         searching = false
                         
                     }
                 }
                 Image(systemName: "magnifyingglass")
                     .font(.system(size: 20))
             }
                .padding()
         }
            .frame(height: 40)
            .cornerRadius(13)
            .padding()
    }
}


struct CharacterList: View {
    
    @EnvironmentObject var characterViewModel: CharacterViewModel
    @State var searchText = ""
    @State var searching = false
//    @State var filteredCharacters = [Character]()
    
    @Namespace var namespace
    var body: some View {
        NavigationView {
            ScrollView {
                SearchBar(searchText: $searchText, searching: $searching)
                
                // list
                VStack(alignment: .leading) {
                    ForEach(filteredCharacters) { p in
                        NavigationLink(destination: CharacterCard(character: p)) {
                            CharacterRow(character: p)
//                                                .padding()
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 150)
//                                                .background(BlurView(style: .regular))
                                    .background(BlurView())
                                    .cornerRadius(10)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarHidden(true)
            .background(BackgroundView())
        }
    }
    
    var filteredCharacters: [Character] {
        if searchText.isEmpty {
            return characterViewModel.characters
        } else {
            return characterViewModel.characters.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

//struct CharacterList_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterList()
//            .environmentObject(CharacterViewModel())
//    }
//}
