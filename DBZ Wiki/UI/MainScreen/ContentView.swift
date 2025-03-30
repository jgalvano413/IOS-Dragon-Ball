//
//  ContentView.swift
//  DBZ Wiki
//
//  Created by Luis Galvan on 23/03/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            Image("dbz_logo")
                .resizable()
                .scaledToFit()
                .foregroundColor(.yellow)
                .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
            Text("¡Bienvenido! \nAl universo de Dragon Ball")
                .font(.system(size: 35, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .top)
                .padding(.horizontal,15)
            
            
            
            
            
            // CardView
            VStack {
                // Imagen (por ejemplo, una imagen del sistema)
                Image(systemName: "star.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.yellow)
                    .padding()
                
                // Título
                Text("Card Title")
                    .font(.headline)
                    .foregroundColor(.black)
                
                // Descripción
                Text("Este es un ejemplo de una CardView con una imagen predeterminada.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.top, 5)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(15)
            .shadow(color: .gray, radius: 5, x: 0, y: 5)
            .padding(.horizontal)
        }
        .background(AnimatedImage(url: URL(string: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/824db09a-100c-42c1-a47a-d450bd00e595/dc6but6-a03d853d-502b-47e1-913f-55738c886211.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzgyNGRiMDlhLTEwMGMtNDJjMS1hNDdhLWQ0NTBiZDAwZTU5NVwvZGM2YnV0Ni1hMDNkODUzZC01MDJiLTQ3ZTEtOTEzZi01NTczOGM4ODYyMTEuZ2lmIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.1lKLRUqzCMIgIeF-NyVvgROCo8JrUqycYBZ1kj_XUzk")))
        .padding(.vertical)
    }
}


#Preview {
    ContentView()
}
