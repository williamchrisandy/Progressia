//
//  Formatter.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//

import SwiftUI

class Formatter
{
    struct TitleViewFormat: ViewModifier
    {
        func body(content: Content) -> some View
        {
            content
                .font(.title)
                .padding([.top, .horizontal], 16)
                .padding(.bottom, 4)
        }
    }
    
    struct TitleLeftViewFormat: ViewModifier
    {
        func body(content: Content) -> some View
        {
            content
                .font(.title)
                .padding([.top, .leading], 16)
                .padding(.trailing, 8)
                .padding(.bottom, 4)
        }
    }
    
    struct TitleRightViewFormat: ViewModifier
    {
        func body(content: Content) -> some View
        {
            content
                .font(.title)
                .padding([.top, .trailing], 16)
                .padding(.bottom, 4)
        }
    }
    
    struct BodyViewFormat: ViewModifier
    {
        func body(content: Content) -> some View
        {
            content
                .font(.body)
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
        }
    }
    
    struct BodyLeftViewFormat: ViewModifier
    {
        func body(content: Content) -> some View
        {
            content
                .font(.body)
                .padding(.leading, 16)
                .padding([.vertical, .trailing], 4)
        }
    }
    
    struct BodyRightViewFormat: ViewModifier
    {
        func body(content: Content) -> some View
        {
            content
                .font(.body)
                .padding(.trailing, 16)
                .padding(.vertical, 4)
        }
    }
    
    static func dateToLongString(_ date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    static func dateToFullString(_ date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    static func getStartOfDate(_ date: Date) -> Date
    {
        let calendar = Calendar.current
        return calendar.startOfDay(for: date)
    }
    
    static func dateDifferences(_ firstDate: Date, _ secondDate: Date) -> Int
    {
        let calendar = Calendar.current
        
        let date1 = getStartOfDate(firstDate)
        let date2 = getStartOfDate(secondDate)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        return components.day ?? 0
    }
}
