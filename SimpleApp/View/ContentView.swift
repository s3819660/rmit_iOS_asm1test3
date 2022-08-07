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

// global actor that uses the main queue for executing its work
// this means methods or types can safely modify the UI because
// it will always be running on the main queue
@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters = [Character]()
}

struct ContentView: View {
    enum LoadState {
        /// Download currently in progress
        case loading

        /// Download finished, and characters can now be displayed
        case success

        /// Download failed
        case failed
    }
    
    @StateObject var characterViewModel = CharacterViewModel()

    /// The current state of downloading our articles.
    @State private var loadState = LoadState.loading

    /// The text in our search box, which filters the articles array.
    @State private var searchText = ""
    
    var body: some View {
        Group {
            switch loadState {
            case .loading:
                VStack {
                    Text("Downloading…")
                    ProgressView()
                }
            case .success:
                CharacterList()

            case .failed:
                VStack {
                    Text("Failed to download articles")

                    Button("Retry") {
                        // When the user attempts to retry, immediately switch back to
                        // the loading state.
                        loadState = .loading

                        Task {
                            // Important: wait 0.5 seconds before retrying the download, to
                            // avoid jumping straight back to .failed in case there are
                            // internet problems.
                            try await Task.sleep(nanoseconds: 500_000_000)
                            await fetchCharacters()
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .navigationTitle("Rick And Morty")
        .task(fetchCharacters)
        .environmentObject(characterViewModel)
        .environment(\.colorScheme, .dark) // dark mode
    }
    
    @Sendable func fetchCharacters() async {
        do {
            let url = URL(string: "https://rickandmortyapi.com/api/character/?page=19")!
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601

            var result: CharacterAPIResponse?
            do {
                result = try decoder.decode(CharacterAPIResponse.self, from: data)
                
            } catch {
                print("\(error)")
            }
            
            guard let final = result else {
                print("cannot get result")
                return
            }
            
            // await background task (function fetchCharacter) and execute the code below in the main thread
            // instead of in the background because this is an async function
            await MainActor.run {
                characterViewModel.characters = final.results
            }
            
            loadState = .success
        } catch {
            loadState = .failed
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
