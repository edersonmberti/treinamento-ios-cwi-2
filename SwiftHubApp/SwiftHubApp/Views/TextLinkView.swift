//
//  TextLinkView.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 03/07/21.
//

import SwiftUI

struct TextLinkView: View {
    var prefix: String? = nil
    let title: String?
    let action: () -> Void
    
    var body: some View {
        if let title = title {
            HStack(spacing: 4) {
                if let prefix = self.prefix {
                    Text(prefix)
                        .foregroundColor(.discreteGray)
                }
                Button(action: action, label: {
                    Text(title)
                        .underline()
                })
                .foregroundColor(.mainPurple)
            }
        } else {
            EmptyView()
        }
    }
}

struct TextLinkView_Previews: PreviewProvider {
    static var previews: some View {
        TextLinkView(prefix: "By:", title: "Lero lero", action: {})
            .previewLayout(.fixed(width: 100, height: 50))
    }
}
