//
//  RoundedImage.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 02/07/21.
//

import Nuke
import NukeUI
import SwiftUI

struct RoundedImage: View {
    var url: String?
    var size: CGFloat
    
    var body: some View {
        LazyImage(source: url)
            .processors([ImageProcessors.Resize(width: size)])
            .frame(width: size, height: size)
            .clipShape(Circle())
    }
}

struct RoundedImage_Previews: PreviewProvider {
    static var previews: some View {
        RoundedImage(url: babyCorgiPic, size: 300)
    }
}
