//
//  ContentView.swift
//  BucketList
//
//  Created by Cory Steers on 8/21/23.
//

import MapKit
import SwiftUI

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    let locations = [
        Location(name: "Buckingham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),
        Location(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076)),
    ]
    
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//                .padding()
//        }
        
        NavigationView {
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                //            MapMarker(coordinate: location.coordinate)
                MapAnnotation(coordinate: location.coordinate) {
                    //                VStack {
                    //                    Circle()
                    //                        .stroke(.red, lineWidth: 3)
                    //                        .frame(width: 44, height: 44)
                    //                    Text(location.name)
                    //                        .bold()
                    //                }
                    
//                    Circle()
//                        .stroke(.red, lineWidth: 3)
//                        .frame(width: 44, height: 44)
//                        .onTapGesture {
//                            print("Tapped on \(location.name)")
//                        }
                    
                    NavigationLink {
                        Text(location.name)
                    } label: {
                        Circle()
                            .stroke(.red, lineWidth: 3)
                            .frame(width: 44, height: 44)
                    }
                }
            }
            .navigationTitle("London Explorer")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
