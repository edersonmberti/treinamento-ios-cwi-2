//
//  RepositoryView.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 01/07/21.
//

import SwiftUI

struct RepositoryView: View {
    let repository: Repository
    @State private var userDetailPresented: Bool = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(repository.name)
                    .bold()
                    .font(.title2)
                
                Text(repository.description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.discreteGray)
                    .minimumScaleFactor(0.8)
                    .lineLimit(2)
                
                Spacer()
                
                Text("\(repository.starCount) ⭐️")
                    .font(.footnote)
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                RoundedImage(url: repository.owner.pictureURL, size: 60)
                
                Text(repository.owner.name)
                    .frame(maxWidth: 70)
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
            }
            .onTapGesture {
                userDetailPresented = true
            }
            .sheet(isPresented: $userDetailPresented, content: {
                UserDetailView(url: repository.owner.profileURL, isPresented: $userDetailPresented)
            })
            
        }
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
        .padding(.all, 10)
    }
}

struct RepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView(repository: .mocked)
            .previewLayout(.fixed(width: 385, height: 100))
    }
}
