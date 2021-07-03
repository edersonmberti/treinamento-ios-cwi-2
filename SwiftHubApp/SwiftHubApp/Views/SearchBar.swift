//
//  SearchBar.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 03/07/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 8)
            
            TextField("Search...", text: $text)
                .textCase(.none)
            
            Button(action: {
                text = ""
            }, label: {
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
            })
        }
        .padding(8)
        .background(Color.mainPurple.opacity(0.2))
        .cornerRadius(8)
        .padding(.vertical, 8)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBar(text: .constant(""))
                .previewLayout(.fixed(width: 375, height: 50))
            SearchBar(text: .constant("swift"))
                .previewLayout(.fixed(width: 375, height: 50))
        }
    }
}
