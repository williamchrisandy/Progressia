//
//  Footer.swift
//  Progressia
//
//  Created by William Chrisandy on 26/07/22.
//

import SwiftUI


struct Footer: View
{
    var body: some View
    {
        HStack
        {
            Spacer()
            
            Text("Tap text to edit")
                .foregroundColor(.gray)
                .font(.footnote)
                .padding(.top, 8)
            
            Spacer()
        }
    }
}

struct Footer_Previews: PreviewProvider
{
    static var previews: some View
    {
        Footer()
    }
}
