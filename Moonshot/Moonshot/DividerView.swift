//
//  DividerView.swift
//  Moonshot
//
//  Created by Cory Steers on 5/15/23.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
    }
}

struct DividerView_Previews: PreviewProvider {
    static var previews: some View {
        DividerView()
            .preferredColorScheme(.dark)
    }
}
