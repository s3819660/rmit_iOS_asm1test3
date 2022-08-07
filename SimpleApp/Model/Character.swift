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

import Foundation
import SwiftUI

// MARK: - Welcome
class CharacterAPIResponse: Codable {
    let info: Info
    let results: [Character]

    init(info: Info, results: [Character]) {
        self.info = info
        self.results = results
    }
}

// MARK: - Info
class Info: Codable {
    let count, pages: Int
    let next, prev: String

    init(count: Int, pages: Int, next: String, prev: String) {
        self.count = count
        self.pages = pages
        self.next = next
        self.prev = prev
    }
}

// MARK: - Result
class Character: Identifiable, Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    init(id: Int, name: String, status: String, species: String, type: String, gender: String, origin: Location, location: Location, image: String, episode: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

// MARK: - Location
class Location: Codable {
    let name: String
    let url: String

    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
