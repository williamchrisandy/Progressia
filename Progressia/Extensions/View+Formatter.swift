//
//  View+Formatter.swift
//  Progressia
//
//  Created by William Chrisandy on 26/07/22.
//

import SwiftUI

extension View
{
    func titleViewFormat() -> some View
    {
        modifier(Formatter.TitleViewFormat())
    }
    
    func titleLeftViewFormat() -> some View
    {
        modifier(Formatter.TitleLeftViewFormat())
    }
    
    func titleRightViewFormat() -> some View
    {
        modifier(Formatter.TitleRightViewFormat())
    }
    
    func bodyViewFormat() -> some View
    {
        modifier(Formatter.BodyViewFormat())
    }
    
    func bodyLeftViewFormat() -> some View
    {
        modifier(Formatter.BodyLeftViewFormat())
    }
    
    func bodyRightViewFormat() -> some View
    {
        modifier(Formatter.BodyRightViewFormat())
    }
}
