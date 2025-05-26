//
//  ContentView.swift
//  Zikirler
//
//  Created by osman dogan on 15.05.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Ana Ekran")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                NavigationLink(destination: StatisticsView()) {
                    Text("İstatistikleri Görüntüle")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 20) // Add some space above the button

                Spacer() // Add spacer to push content to the top
            }
            .navigationTitle("Zikirler") // Set navigation bar title
            .navigationBarTitleDisplayMode(.inline) // Optional: Use inline display mode
        }
    }
}

#Preview {
    ContentView()
}
