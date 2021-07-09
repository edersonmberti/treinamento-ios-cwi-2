//
//  IssueView.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 05/07/21.
//

import SwiftUI

struct IssueView: View {
    let issue: Issue
    
    private var state: (image: String, color: Color) {
        issue.state == Issue.State.open
            ? ("plus.circle", .greenOpen)
            : ("car.circle", .redClosed)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(issue.title)
                Text(issue.description)
                    .font(.subheadline)
                    .foregroundColor(.discreteGray)
                    .minimumScaleFactor(0.8)
                    .lineLimit(2)
                
                Spacer()
                
                HStack {
                    IssueInfo(title: "creation date", value: issue.created.formatted)
                    Spacer()
                    IssueInfo(title: "creator", value: issue.creator.login)
                    Spacer()
                    IssueInfo(title: "comments", value: "\(issue.comments)")
                }
            }
            
            VStack {
                Image(systemName: state.image).foregroundColor(state.color)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
        .padding(.vertical, 14)
    }
}

struct IssueInfo: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack {
            Text(value)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.discreteGray)
        }
    }
}

struct IssueView_Previews: PreviewProvider {
    static var previews: some View {
        IssueView(issue: .mocked).previewLayout(.fixed(width: 375, height: 122))
    }
}
