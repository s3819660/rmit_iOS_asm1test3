/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen Phuoc Nhu Phuc
  ID: 3819660
  Created  date: 26/07/2022
  Last modified: 07/08/2022
  Acknowledgement:
    - https://rickandmortyapi.com
    - https://thehappyprogrammer.com/custom-list-in-swiftui
    - https://firebase.google.com/docs/firestore/quickstart
    - https://stackoverflow.com/questions/62741851/how-to-add-placeholder-text-to-texteditor-in-swiftui
    - https://github.com/twostraws/simple-swiftui/tree/main/SimpleNews
*/

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
