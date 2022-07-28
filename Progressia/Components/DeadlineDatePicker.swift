//
//  DeadlineDatePicker.swift
//  Progressia
//
//  Created by William Chrisandy on 26/07/22.
//

import SwiftUI

struct DeadlineDatePicker: View
{
    @Binding var value: Date
    
    var body: some View
    {
        DatePicker(
            selection: $value,
            in: Formatter.getStartOfDate(Date())...,
            displayedComponents: [.date],
            label:
                {
                    Text("Deadline")
                        .font(.body)
                }
        )
        .datePickerStyle(.compact)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

struct DeadlineDatePicker_Previews: PreviewProvider
{
    static var previews: some View
    {
        DeadlineDatePicker(value: .constant(Date()))
    }
}
