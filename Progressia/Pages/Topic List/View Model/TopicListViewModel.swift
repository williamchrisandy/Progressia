//
//  TopicListViewModel.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//

import SwiftUI
import Combine

class TopicListViewModel: ObservableObject
{
    private let databaseHelper = DatabaseHelperTopic(fetchRequest: Topic.fetchRequest());
    
    @Published var topics: [Topic] = []
    @Published var selectedTopic: Topic?
    @Published var isShowingNewTopic: Bool = false
    
    private var cancellable: AnyCancellable!
    
    init()
    {
        cancellable = databaseHelper.$topics.sink
        {
            [weak self] topics in
            self?.topics = topics
        }
    }
    
    func addTopic()
    {
        withAnimation
        {
            selectedTopic = databaseHelper.add(title: "Untitled Topic", explanation: "", deadline: Formatter.getStartOfDate(Date()))
            isShowingNewTopic = true
        }
    }
    
    func deleteTopics(offsets: IndexSet)
    {
        withAnimation
        {
            let _ = offsets.map{ let _ = databaseHelper.delete(topics[$0]) }
        }
    }
}
