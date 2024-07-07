//  SearchBar.swift
//  BestRecipes
//
//  Created by Daniil Murzin on 07.07.2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchTerm: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black)
                .padding(.leading, 10)
                .foregroundColor(.neutral90)
            
            TextField("Search recipes", text: $searchTerm)
                .frame(height: 44)
                .background(Color.white)
                .cornerRadius(10)
                .font(.custom(Poppins.regular, size: 14))
                .foregroundColor(.neutral30)
        }
        .frame(width: 360, height: 44)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.neutral25), lineWidth: 1)
        )
        .padding(.horizontal, 10)
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var searchTerm = "Find your recipe"

    static var previews: some View {
        SearchBar(searchTerm: $searchTerm)
    }
}
