//
//  HealthBarView.swift
//  Fin's Adventure
//
//  Created by Afrah Saleh on 01/08/1445 AH.
//

import SwiftUI

struct HealthBarView: View {
    let maxHealth: Int = 10 
    var health: Int
    
    private var totalHearts: Int {
        maxHealth / 2
    }
    
    private var fullHearts: Int {
        health / 2
    }
    
    private var halfHeart: Bool {
        health % 2 != 0
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 5) {
            // Full hearts
            ForEach(0..<fullHearts, id: \.self) { _ in
                Image("fullHeart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            
            // Half heart
            if halfHeart {
                Image("halfHeart")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            
            // Empty hearts
            ForEach(0..<(totalHearts - fullHearts - (halfHeart ? 1 : 0)), id: \.self) { _ in
                Image("emptyHerat")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
        }
    }
}
struct HealthBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HealthBarView(health: 10)
            HealthBarView(health: 5)
            HealthBarView(health: 3)
            HealthBarView(health: 1)
            HealthBarView(health: 0)
        }
    }
}
