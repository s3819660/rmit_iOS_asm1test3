//
//  CharacterCard.swift
//  SimpleApp
//
//  Created by Phuc Nguyen Phuoc Nhu on 27/07/2022.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import MapKit

struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct CharacterCard: View {
    @EnvironmentObject var characterViewModel: CharacterViewModel
    var character: Character
    @State private var note: String = ""
    @State private var fetchedNote: String = ""
    
    let lastSeenLocations = [
        MapLocation(name: "Last seen in", coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
    ]
    
    var body: some View {
        let url = character.image
        let nameStr = character.name.components(separatedBy: " ")
        
        ScrollView {
            VStack {
                // Image
                AsyncImage(url: URL(string: url)) { image in
                    image.resizable()
                } placeholder: {
                    Color.red
                }
                    .frame(height: UIScreen.screenWidth)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .offset(y: -141)
                    .mask(LinearGradient(gradient: Gradient(stops: [
                        .init(color: .black, location: 0),
                        .init(color: .clear, location: 1),
                        .init(color: .black, location: 1),
                        .init(color: .clear, location: 1)
                    ]), startPoint: .top, endPoint: .bottom)
                        .ignoresSafeArea()
                        .offset(y: -141)
                    )
            
                // Name display style
                VStack {
                    ForEach(nameStr, id: \.self) { str in
                        Text(str)
                            .font(.system(size: 60))
                            .fontWeight(.heavy)
                            .padding(-15)
                    }
                    
                    // Character information
                    VStack {
                        Text("Status:")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 12))
                                .foregroundColor(getStatusColor(status: character.status))
                            Text(character.status)
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        VStack(alignment: .leading) {
                            Text("Species:")
                                .foregroundColor(.gray)
                                .padding(.top, 2)
                            Text(character.species)
                                .font(.system(size: 20))
                            Text("Origin:")
                                .foregroundColor(.gray)
                                .padding(.top, 2)
                            Text(character.origin.name)
                                .font(.system(size: 20))
                            Text("Gender:")
                                .foregroundColor(.gray)
                                .padding(.top, 2)
                            Text(character.gender)
                                .font(.system(size: 20))
                            Text("Type:")
                                .foregroundColor(.gray)
                                .padding(.top, 2)
                            Text(character.type)
                                .font(.system(size: 20))
                            Text("Registered Location:")
                                .foregroundColor(.gray)
                                .padding(.top, 2)
                            Text(character.location.name)
                                .font(.system(size: 20))
                        }
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                        .padding(.top, 50)
                        .padding(.horizontal, 6)

                    // Text Area with placeholder
                    Text("Note:")
                        .foregroundColor(.gray)
                        .padding(.top, 3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 6)
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $note)
                            .frame(height: 300)

                        if note.isEmpty {
                          Text("Enter your note")
                                .foregroundColor(Color.gray.opacity(0.8))
                                .offset(x: 4, y: 8)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.yellow.opacity(0.7), lineWidth: 1))
                    
                    // Last seen location in MapView
                    if (character.status.lowercased() == "alive") {
                        Text("Last seen in:")
                            .foregroundColor(.gray)
                            .padding(.top, 15)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 6)
                        MapView(coordinate: CLLocationCoordinate2D(latitude: generateLastSeenLocation(type: "lat"), longitude: generateLastSeenLocation(type: "long")), lastSeenLocations: lastSeenLocations)
                            .edgesIgnoringSafeArea(.top)
                            .frame(height: 300)
                            .cornerRadius(20)
                    }
                }
                .offset(y: -245)
            }
                .onDisappear(perform:{
                    // when closing the view, check if the note has changed
                    // if note is changed, update note to Firestore
                    if fetchedNote != note {
                        saveNoteToFirestore(id: character.id, note: note)
                    }
                })
                .onAppear(perform: {
                    // Fetch note from Firestore when rendering view
                    fetchNoteFromFirestore(characterId: character.id)
                    print(note)
                })
        }
            .background(BackgroundView())
    }

    
    func saveNoteToFirestore(id: Int, note: String) {
        db.collection("notes").document(String(id)).setData([
            "id": character.id,
            "note": note
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func fetchNoteFromFirestore(characterId: Int) {
        let ref = db.collection("notes").document(String(characterId))
        
        ref.getDocument(source: .cache) { (document, error) in
          if let document = document {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
              print("Cached document data: \(dataDescription)")
              
              fetchedNote = document.data()!["note"]! as? String ?? ""
              note = fetchedNote
          } else {
              print("Document does not exist in cache")
              note = ""
          }
        }
    }
    
    // Generate random location of the Rick and Morty character
    // Their location changes a lot because they all have teleportation ability
    func generateLastSeenLocation(type: String) -> Double {
//            40.06455686720662, -102.07430812008582
        if (type == "lat") {
            return 40.064_556 + Double.random(in: -20...20)
        }
        return -102.074_308 + Double.random(in: -16...20)
    }
}

//struct CharacterCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterCard()
//    }
//}
