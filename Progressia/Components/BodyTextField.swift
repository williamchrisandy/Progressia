//
//  BodyTextField.swift
//  Progressia
//
//  Created by William Chrisandy on 26/07/22.
//

import SwiftUI

struct BodyTextField: View
{
    let fieldName: String
    @Binding var value: String
    
    var body: some View
    {
        HStack(alignment: .firstTextBaseline, spacing: 0)
        {
            Text("\(fieldName):")
                .bodyLeftViewFormat()
            
            VStack
            {
                TextField(fieldName, text: $value)
                Divider()
                    .frame(height: 1)
            }
            .bodyRightViewFormat()
        }
    }
}

struct BodyTextField_Previews: PreviewProvider
{
    static var previews: some View
    {
        BodyTextField(fieldName: "Name", value: .constant(""))
    }
}
