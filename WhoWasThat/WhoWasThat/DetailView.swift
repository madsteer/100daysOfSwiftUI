//
//  DetailView.swift
//  WhoWasThat
//
//  Created by Cory Steers on 9/6/23.
//

import MapKit
import SwiftUI

struct DetailView: View {
    @State var contact: Contact
    @State private var image: Image?
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    var body: some View {
        NavigationView {
            VStack {
                image?
                    .resizable()
                    .scaledToFit()
                
                if contact.location != nil {
                    Spacer()
                    
                    ZStack {
                        Map(coordinateRegion: $mapRegion)
                        
                        Circle()
                            .fill(.blue)
                            .opacity(0.3)
                            .frame(width: 32, height:32)
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    
                    Spacer()

                }
            }
            .navigationTitle("\(contact.firstName) \(contact.lastName)")
        }
        .onAppear {
            if let uiimage = UIImage(data: contact.picture) {
                image = Image(uiImage: uiimage)
            }
            
            if let location = contact.location {
               mapRegion = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        @State var contact = Contact.example
        
        NavigationView {
            DetailView(contact: contact)
        }
    }
}
