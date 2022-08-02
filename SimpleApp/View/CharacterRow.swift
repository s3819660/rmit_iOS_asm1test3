//
//  CharacterRow.swift
//  SimpleApp
//
//  Created by Phuc Nguyen Phuoc Nhu on 27/07/2022.
//

import SwiftUI

func getStatusColor(status: String) -> Color {
    var color = Color.green
    if status == "Dead" {
        color = Color.red
    } else if status == "unknown" {
        color = Color.gray
    }
    
    return color
}

struct CharacterRow: View {
    var character: Character
    
    // cache image
    // www.youtube.com/watch?v=KhGyiOk3Yzk
    var body: some View {
//        let url = "https://www.hackingwithswift.com/img/paul-2.png"
        let url = character.image
        
        HStack(spacing: 0) {
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
            } placeholder: {
                Color.red
            }
            .frame(width: 150, height: 150)
            .frame(maxWidth: .infinity, alignment: .leading)

//            .frame(width: .infinity, alignment: .leading)
//            .clipShape(RoundedRectangle(cornerRadius: 25))

            VStack(alignment: .leading) {
                Text(character.name)
                    .fontWeight(.heavy)
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                HStack {
                    
                    
                    Image(systemName: "circle.fill")
                        .font(.system(size: 10))
                        .foregroundColor(getStatusColor(status: character.status))
                    Text(character.status)
                        .foregroundColor(.white)
                        .font(.system(size: 15))
                }

                Spacer()
                Text("Species:")
                    .foregroundColor(.gray)
                    .font(.system(size: 13.5))
                Text(character.species)
                    .foregroundColor(.white)
                Spacer()
                Text("Origin:")
                    .foregroundColor(.gray)
                    .font(.system(size: 13.5))
                Text(character.origin.name)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .offset(x: -28)
                
            .padding(10)
        }
    }
}

//struct CharacterRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CharacterRow()
//    }
//}
