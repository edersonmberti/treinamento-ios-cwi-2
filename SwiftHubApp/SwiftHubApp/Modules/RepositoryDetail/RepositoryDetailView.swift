//
//  RepositoryDetailView.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 03/07/21.
//

import SwiftUI

struct RepositoryDetailView: View {
    let repository: Repository
    let language: Language?
    
    init(repository: Repository) {
        self.repository = repository
        self.language = .init(name: repository.language)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let language = self.language {
                PillView(language: language)
            } else {
                Text(repository.language ?? "NA")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.mainPurple)
            }
            
            Spacer().frame(height: 20)
            
            Text(repository.description ?? "NA")
            
            Spacer().frame(height: 20)
            
            Group {
                TextLinkView(prefix: "by:", title: repository.owner.name) {}
                TextLinkView(prefix: "license", title: repository.license?.name) {}
                TextLinkView(title: repository.webPage) {}
            }
            
            Spacer()
            
            DateView(title: "created at:", date: repository.created)
            DateView(title: "last update at:", date: repository.lastUpdated)
            
            Spacer()
            
            HStack {
                NumericInfoView(value: repository.watchers, title: "watchers")
                Spacer()
                NavigationLink(destination: IssueListView(owner: repository.owner.name, repo: repository.name)) {
                    NumericInfoView(value: self.repository.openIssues, title: "open issues")
                }
                Spacer()
                NumericInfoView(value: repository.forks, title: "forks")
            }
        }
        .navigationBarTitle(repository.name, displayMode: .inline)
        .padding(40)
    }
}

struct DateView: View {
    let title: String
    let date: Date
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.light)
                .foregroundColor(.discreteGray)
            Spacer()
            Text("\(date.formatted)")
        }
    }
}

struct RepositoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryDetailView(repository: .mocked)
    }
}
