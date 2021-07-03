//
//  UserDetailView.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 02/07/21.
//

import SwiftUI

struct UserDetailView: View {
    @ObservedObject var viewModel: UserDetailViewModel
    @Binding var isPresented: Bool
    
    init(url: String, isPresented: Binding<Bool>) {
        viewModel = .init(url: url)
        self._isPresented = isPresented
    }
    
    var body: some View {
        NavigationView {
            Group {
                if let user = viewModel.user {
                    UserDetailBody(user: user)
                } else {
                    EmptyView()
                }
            }
            .navigationBarTitle(viewModel.user?.type.rawValue ?? "NA", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isPresented = false
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
            }))
        }
    }
}

struct UserDetailBody: View {
    let user: User
    
    var body: some View {
        VStack(spacing: 20) {
            RoundedImage(url: user.pictureURL, size: 190)
            Text(user.name)
                .font(.title)
                .fontWeight(.heavy)
            Text(user.bio ?? "NA")
                .foregroundColor(.description)
                .multilineTextAlignment(.center)
                .padding()
            
            TextLinkView(title: user.email) { }
            TextLinkView(title: user.blog) { }
            
            Spacer()
            
            HStack {
                NumericInfoView(value: user.repos, title: "repos")
                Spacer()
                NumericInfoView(value: user.followers, title: "followers")
                Spacer()
                NumericInfoView(value: user.following, title: "following")
            }.padding(40)
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let view = UserDetailView(url: mockUserURL, isPresented: .constant(false))
        view.viewModel.user = .mocked
        view.configNavigationBar()
        return view
    }
}
