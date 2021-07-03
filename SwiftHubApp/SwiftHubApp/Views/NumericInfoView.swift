//
//  NumericInfoView.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 03/07/21.
//

import SwiftUI

struct NumericInfoView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(value)")
                .font(.title3)
                .fontWeight(.semibold)
            Text(title)
                .font(.footnote)
                .foregroundColor(.discreteGray)
        }
    }
}

struct NumericInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NumericInfoView(value: 1000, title: "forks")
            .previewLayout(.fixed(width: 100, height: 50))
    }
}
