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
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    var lastSeenLocations: [MapLocation]
    
    @State private var region = MKCoordinateRegion()

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: lastSeenLocations) { location in
            // Map marker with text
            MapAnnotation(coordinate: coordinate) {
                VStack {
                    Group {
                        Image(systemName: "mappin.circle.fill")
                          .resizable()
                          .frame(width: 30.0, height: 30.0)
                        Circle()
                          .frame(width: 8.0, height: 8.0)
                    }
                      .foregroundColor(.red)
                      Text("Last seen here")
                }
            }
        }
            .onAppear {
                setRegion(coordinate)
            }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
        )
    }
}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
//    }
//}
