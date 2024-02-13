//
//  FollowerView.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/13/24.
//

import SwiftUI

struct FollowerView: View {
    var follower: Follower
    var body: some View {
       VStack {
            AsyncImage(url:URL(string: follower.avatarUrl)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                Image("avatar")
            }
           Text(follower.login)
               .bold()
               .lineLimit(1)
               .minimumScaleFactor(0.6)
        }
       .clipShape(Circle())
    }
}

struct FollowerView_Previews: PreviewProvider {
    static var previews: some View {
        FollowerView(follower: Follower(login: "SeanAllen", avatarUrl: ""))
    }
}
