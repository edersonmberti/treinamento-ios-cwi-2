//
//  IssueListView.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 05/07/21.
//

import SwiftUI

struct IssueListView: View {
    @ObservedObject var viewModel: IssueListViewModel
    
    init(owner: String, repo: String) {
        viewModel = .init(owner: owner, repo: repo)
    }
    
    var body: some View {
        VStack {
            switch viewModel.status {
            case .loading:
                Text("Loading...")
            case .error:
                Group {
                    Text("Error...")
                    Button("Try again", action: viewModel.fetchData)
                        .foregroundColor(.black)
                }
            default:
                List(viewModel.issues) { item in
                    NavigationLink(destination: WebView(url: URL(string: item.url), title: "Issue \(item.number)")) {
                        IssueView(issue: item)
                    }
                }
            }
        }
        .navigationBarTitle("Issues", displayMode: .inline)
    }
}

struct IssueListView_Previews: PreviewProvider {
    static var previews: some View {
        let view = IssueListView(owner: "", repo: "")
        view.viewModel.issues = [
            .mocked, .mocked, .mocked,
            .mocked, .mocked, .mocked,
            .mocked, .mocked, .mocked,
            .mocked, .mocked, .mocked,
        ]
        view.viewModel.status = .success
        return view
    }
}
