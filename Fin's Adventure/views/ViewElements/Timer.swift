//
//  File.swift
//  
//
//  Created by Afrah Saleh on 11/08/1445 AH.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black.opacity(0.4))
                .cornerRadius(30)
                .frame(width: 200, height: 70)

            HStack {
                Image("clock")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                Spacer()
            }
            .frame(width: 150, height: 60)
            .padding(.trailing,60 )
            .padding(.bottom,8)
        }
    }
}
struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

