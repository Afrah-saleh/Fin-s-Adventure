//
//  BackgroundViewModel.swift
//  Fin's Adventure
//
//  Created by Afrah Saleh on 03/08/1445 AH.
//

import Foundation
import SwiftUI

struct BackgroundViewModel: View {
    
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()

    }
}
