//
//  LanguagePillView.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 01/07/21.
//

import SwiftUI

struct LanguagePillView: View {
    @EnvironmentObject var viewModel: RepositoryListViewModel
    let language: Language

    private var isSelected: Bool {
        viewModel.selectedLanguage == language
    }
    
    init(language: Language) {
        self.language = language
    }
    
    var body: some View {
        PillView(language: language, isSelected: isSelected)
        .onTapGesture {
            viewModel.selectedLanguage = language
        }
    }
}

struct PillView: View {
    let language: Language
    var isSelected: Bool = true
    
    private var fontWeight: Font.Weight {
        isSelected ? .regular : .light
    }
    private var borderWidth: CGFloat {
        isSelected ? 1 : 0.4
    }
    private var opacity: Double {
        isSelected ? 1 : 0.4
    }
    
    var body: some View {
        HStack {
            Image(language.rawValue)
            Text(language.rawValue)
                .font(.subheadline)
                .fontWeight(fontWeight)
        }
        .opacity(opacity)
        .frame(width: 100, height: 35)
        .overlay(RoundedRectangle(cornerRadius: 35/2).stroke(Color.mainPurple, lineWidth: borderWidth))
    }
}

struct LanguagePillView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = RepositoryListViewModel()
        viewModel.selectedLanguage = .java
        
        return Group {
            LanguagePillView(language: .objc)
                .previewLayout(.fixed(width: 200, height: 50))
            LanguagePillView(language: .swift)
                .previewLayout(.fixed(width: 200, height: 50))
            LanguagePillView(language: .java)
                .previewLayout(.fixed(width: 200, height: 50))
            LanguagePillView(language: .kotlin)
                .previewLayout(.fixed(width: 200, height: 50))
        }.environmentObject(viewModel)
    }
}
