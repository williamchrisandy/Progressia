//
//  TopicListView.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//

import SwiftUI

struct TopicListView: View
{
    @StateObject var viewModel = TopicListViewModel()

    var body: some View
    {
        NavigationView
        {
            VStack
            {
                NavigationLink(
                    destination:
                        TaskListView(
                            viewModel:
                                TaskListViewModel(
                                    topic: viewModel.selectedTopic!
                                )
                        ),
                    isActive: $viewModel.isShowingNewTopic,
                    label:
                        {
                            EmptyView()
                        }
                )
                List
                {
                    ForEach(viewModel.topics)
                    {
                        topic in
                        NavigationLink
                        {
                            TaskListView(
                                viewModel:
                                    TaskListViewModel(
                                        topic: topic
                                    )
                            )
                        } label:
                        {
                            Card(
                                title: topic.title,
                                subtitle1: Formatter.dateToLongString(topic.deadline),
                                subtitle2: topic.getCompletionStatus()
                            )
                        }
                    }
                    .onDelete(perform: viewModel.deleteTopics)
                }
                .listStyle(.insetGrouped)
            }
            
            .toolbar
            {
                ToolbarItem(placement: .automatic)
                {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing)
                {
                    Button(action: viewModel.addTopic)
                    {
                        Label("Add Topic", systemImage: "plus")
                    }
                }
            }
            
            .navigationTitle("Topic List")
            
            Text("Select an item")
        }
    }
}

struct TopicListView_Previews: PreviewProvider
{
    static var previews: some View
    {
        TopicListView()
    }
}
