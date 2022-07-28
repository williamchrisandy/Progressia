//
//  TitleTextField.swift
//  Progressia
//
//  Created by William Chrisandy on 26/07/22.
//

import SwiftUI

struct TitleTextField: View
{
    @Binding var value: String
    var body: some View
    {
        HStack(alignment: .firstTextBaseline, spacing: 0)
        {
            Text("Title:")
                .titleLeftViewFormat()
            
            VStack
            {
                TextField("Title", text: $value)
                    .titleRightViewFormat()
                Divider()
                    .frame(height: 1)
            }
        }
    }
}

struct TitleTextField_Previews: PreviewProvider
{
    static var previews: some View
    {
        TitleTextField(value: .constant(""))
    }
}
