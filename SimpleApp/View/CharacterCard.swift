//
//  CharacterCard.swift
//  SimpleApp
//
//  Created by Phuc Nguyen Phuoc Nhu on 27/07/2022.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct CharacterCard: View {
    @EnvironmentObject var characterViewModel: CharacterViewModel
    var character: Character
    @State private var note: String = ""
    @State private var fetchedNote: String = ""
    
    var body: some View {
        VStack {
            Text(character.name)
//            TextField("Note", text: $note)
            
//            TextEditor(text: $note)
//                            .foregroundColor(.secondary)
//                            .padding(.horizontal)
//                            .navigationTitle("Note")
            
            ZStack(alignment: .topLeading) {
                TextEditor(text: $note)

                if note.isEmpty {
                  Text("Enter your note")
                        .foregroundColor(Color.gray.opacity(0.8))
//                        .offset(x: 20, y: 20)
                }
                
//                TextField("", text: $note)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.purple, lineWidth: 1))
            
            Spacer()
            Text(note)
        }
        .onDisappear(perform:{
//            if note.prefix(1) == "1" {
//                saveNoteToFirestore(id: character.id, note: note)
//            }
            
            if fetchedNote == note {
                print("not updated")
            } else {
                print("updated")
                saveNoteToFirestore(id: character.id, note: note)
            }
        })
        .onAppear(perform: {
            fetchNoteFromFirestore(characterId: character.id)
            print(note)
        })
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
//        var res = ""
        
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
        
//        print("res=\(res)")
//        return res
    }
}

//struct CharacterCard_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterCard()
//    }
//}
