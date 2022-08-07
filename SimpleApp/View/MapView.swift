//
//  MapView.swift
//  SimpleApp
//
//  Created by Phuc Nguyen Phuoc Nhu on 06/08/2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    var lastSeenLocations: [MapLocation]
    
    @State private var region = MKCoordinateRegion()

    var body: some View {
        
        
        Map(coordinateRegion: $region, annotationItems: lastSeenLocations) { location in
//            MapMarker(coordinate: location.coordinate)
//            MapMarker(coordinate: coordinate)
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
