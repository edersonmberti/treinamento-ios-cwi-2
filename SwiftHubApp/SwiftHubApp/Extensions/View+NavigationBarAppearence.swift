//
//  View+NavigationBarAppearence.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 01/07/21.
//

import SwiftUI

extension View {
    func configNavigationBar() {
        let appearance = UINavigationBarAppearance()

        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        appearance.backgroundColor = .mainPurple
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
