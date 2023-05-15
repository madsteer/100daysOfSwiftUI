//
//  MainListView.swift
//  Moodshot
//
//  Created by Cory Steers on 5/15/23.
//

import SwiftUI

struct MainListView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]

    var body: some View {
        LazyVStack {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .padding()
                        
                        HStack {
                            Spacer()
                            
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        .frame(maxHeight: .infinity)
                        .background(.lightBackground)

                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                }
            }
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MainListView(astronauts: astronauts, missions: missions)
            .preferredColorScheme(.dark)
    }
}
