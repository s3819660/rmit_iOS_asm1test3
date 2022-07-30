//
//  CharacterRow.swift
//  SimpleApp
//
//  Created by Phuc Nguyen Phuoc Nhu on 27/07/2022.
//

import SwiftUI

struct CharacterRow: View {
    var character: Character
    
    // cache image
    // www.youtube.com/watch?v=KhGyiOk3Yzk
    var body: some View {
//        let url = "https://www.hackingwithswift.com/img/paul-2.png"
        let url = character.image
        
        HStack {
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
            } placeholder: {
                Color.red
            }
            .frame(width: 128, height: 128)
            .clipShape(RoundedRectangle(cornerRadius: 25))
        }
    }
}

//struct CharacterRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterRow()
//    }
//}
