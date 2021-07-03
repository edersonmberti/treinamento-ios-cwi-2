//
//  RepositoryListView.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 01/07/21.
//

import SwiftUI

struct RepositoryListView: View {
    @ObservedObject var viewModel: RepositoryListViewModel = .init()
    
    init() {
        configNavigationBar()
    }
    
    var loaderView: some View {
        Group {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .mainPurple))
            Spacer()
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Language.allCases, id: \.self) {
                            LanguagePillView(language: $0)
                                .environmentObject(viewModel)
                        }
                    }.padding(.init(top: 16, leading: 8, bottom: 16, trailing: 8))
                }
                
                if let error = viewModel.requestError {
                    ErrorView(message: error.rawValue, tryAgainCallback: viewModel.fetchData)
                } else if viewModel.isLoading {
                    loaderView
                } else {
                    List(viewModel.repositories) { item in
                        NavigationLink(destination: RepositoryDetailView(repository: item)) {
                            RepositoryView(repository: item)
                        }
                    }.listStyle(PlainListStyle())
                }
            }.navigationBarTitle("Repositories", displayMode: .large)
        }
        .accentColor(.white)
    }
}

struct ErrorView: View {
    let message: String
    let tryAgainCallback: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Text("Deu ruim, partrão. \(message).")
            Spacer()
            Button("Try again", action: tryAgainCallback)
            Spacer()
        }
        .padding(20)
    }
}

struct RepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        let view = RepositoryListView()
        
        view.viewModel.repositories = [
            .mocked, .mocked, .mocked,
            .mocked, .mocked, .mocked,
            .mocked, .mocked, .mocked,
        ]
        
        return Group {
            view.previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
            view.previewDevice(PreviewDevice(rawValue: "iPhone 11"))
            view.previewDevice(PreviewDevice(rawValue: "iPhone 5s"))
            view.previewDevice(PreviewDevice(rawValue: "iPhone 4s"))
        }
    }
}
