import SwiftUI

// global actor that uses the main queue for executing its work
// this means methods or types can safely modify the UI because
// it will always be running on the main queue
@MainActor
class CharacterViewModel: ObservableObject {
    @Published var characters = [Character]()
    
//    @Published var characters = [Character]
//    init() {
//        self.characters = []
//    }
}

struct ContentView: View {
    enum LoadState {
        /// The download is currently in progress. This is the default.
        case loading

        /// The download has finished, and articles can now be displayed.
        case success

        /// The download failed.
        case failed
    }
    
    /// All the articles we have downloaded from the server.
//    @State private var characters = [CharacterAPIResponse]()
//    @State private var characters: [Character] = []
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
//                List(filteredArticles, rowContent: ArticleRow.init)
//                    .refreshable(action: downloadArticles)
//                    .searchable(text: $searchText)
//                Text("success")
                CharacterList()
//                    .environmentObject(characterViewModel)

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
        .navigationTitle("SimpleNews")
        .task(fetchCharacters)
        .environmentObject(characterViewModel)
        .environment(\.colorScheme, .dark) // dark mode
    }
    
    /// Downloads the latest news JSON from Hacking with Swift, decodes it into an array of `Article`
    /// objects, then assigns it to the `articles` property. This will also update the `loadState`
    /// based on how the whole process went.
    ///
    // infinite list
    // www.donnywals.com/implementing-an-infinite-scrolling-list-with-swiftui-and-combine/
    @Sendable func fetchCharacters() async {
        do {
            let url = URL(string: "https://rickandmortyapi.com/api/character/?page=19")!
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
//
//            characters = try decoder.decode([Character].self, from: data).sorted()
//            print(characters)
            var result: CharacterAPIResponse?
            do {
//                let obj = try decoder.decode([Character].self, from: data)
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
//            characters = final.results
//            for dat in final.results {
//                print("data=\(dat.name)")
//
//            }
//            for dat in characters {
//                print(dat.name)
//            }
            
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
