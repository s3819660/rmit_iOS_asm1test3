//
//  CharacterList.swift
//  SimpleApp
//
//  Created by Phuc Nguyen Phuoc Nhu on 26/07/2022.
//

import SwiftUI

struct CharacterList: View {
    
    @EnvironmentObject var characterViewModel: CharacterViewModel
    
//    var body: some View {
////        Text("hello world")
//        Text("hello world, \(characterViewModel.characters[characterViewModel.characters.startIndex].name)")
//    }
    
    var body: some View {
        NavigationView {
            List(characterViewModel.characters){
                contact in
                NavigationLink{
                    CharacterCard(character: contact)
                } label: {
                    CharacterRow(character: contact)
                }
                .navigationTitle("SSET Contact 📒")
            }
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
            .environmentObject(CharacterViewModel())
    }
}
