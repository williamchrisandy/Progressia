//
//  ContentView.swift
//  Progressia
//
//  Created by William Chrisandy on 22/07/22.
//

import SwiftUI

struct ContentView: View
{
    var body: some View
    {
        TabView
        {
            TopicListView()
                .tabItem
                {
                    Label("Topic", systemImage: "list.bullet")
                }
            
            HistoryView()
                .tabItem
                {
                    Label("History", systemImage: "clock")
                }
        }
    }
}

 struct ContentView_Previews: PreviewProvider
 {
     static var previews: some View
     {
         ContentView()
     }
 }
