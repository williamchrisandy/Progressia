//
//  PickerView.swift
//  Progressia
//
//  Created by William Chrisandy on 26/07/22.
//

import SwiftUI


struct PickerView: View
{
    let fieldName: String
    let data: [Int: String]
    @Binding var value: Int
    
    var body: some View
    {
        HStack(alignment: .firstTextBaseline, spacing: 0)
        {
            
            Text("\(fieldName):")
                .bodyLeftViewFormat()
            Picker(selection: $value, label: Text("Picker"))
            {
                ForEach(Array(data.keys), id: \.self)
                {
                    key in
                    Text("\(data[key]!)").tag(key)
                }
            }
            .bodyRightViewFormat()
            
            Spacer()
        }
    }
}


struct PickerView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PickerView(fieldName: "Completion", data: [1: "Not Done", 2: "Done"], value: .constant(1))
    }
}
