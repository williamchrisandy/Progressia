//
//  Card.swift
//  Progressia
//
//  Created by William Chrisandy on 26/07/22.
//

import SwiftUI

struct Card: View
{
    let title: String
    let subtitle1: String
    let subtitle2: String
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            Text(title)
                .font(.headline)
                .padding(.bottom, 1)
            Text(subtitle1)
                .font(.subheadline)
            Text(subtitle2)
                .font(.subheadline)
        }
        .padding(.vertical, 8)
    }
}

struct Card_Previews: PreviewProvider
{
    static var previews: some View
    {
        Card(title: "Title", subtitle1: "Subtitle 1", subtitle2: "Subtitle 2")
    }
}
