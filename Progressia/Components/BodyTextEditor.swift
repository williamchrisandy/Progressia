//
//  BodyTextEditor.swift
//  Progressia
//
//  Created by William Chrisandy on 26/07/22.
//

import SwiftUI


struct BodyTextEditor: View
{
    @Binding var value: String
    var body: some View
    {
        VStack(alignment: .leading, spacing: 0)
        {
            HStack(spacing: 0)
            {
                Text("Explanation:")
                    .padding(.horizontal, 16)
                    .padding(.top, 4)
                
                Spacer()
            }
            
            TextEditor(text: $value)
                .padding(.horizontal, 12)
                .padding(.bottom, 4)
                .frame(height: 200)
        }
    }
}

struct BodyTextEditor_Previews: PreviewProvider
{
    static var previews: some View
    {
        BodyTextEditor(value: .constant("Input your text here"))
    }
}
