//
//  ResortDetailsView.swift
//  SnowSeeker
//
//  Created by Cory Steers on 10/25/23.
//

import SwiftUI

struct ResortDetailsView: View {
    let resort: Resort
    
    var size: String {
//        ["Small", "Average", "Large"][resort.size - 1]
        
        switch resort.size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var body: some View {
        Group {
            VStack {
                Text("Size")
                    .font(.caption.bold())
                
                Text(size)
                    .font(.title3)
            }
            
            VStack {
                Text("Price")
                    .font(.caption.bold())
                
                Text(price)
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ResortDetailsView(resort: Resort.example)
}
