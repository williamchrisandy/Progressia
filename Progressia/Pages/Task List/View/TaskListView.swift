//
//  TaskListView.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//

import SwiftUI

struct TaskListView: View
{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: TaskListViewModel
    
    var body: some View
    {
        ScrollView(.vertical)
        {
            VStack(alignment: .leading, spacing: 0)
            {
                NavigationLink(
                    destination:
                        TaskDetailView(
                            viewModel:
                                TaskDetailViewModel(
                                    task: viewModel.selectedTask!
                                )
                        ),
                    isActive: $viewModel.isShowingNewTask,
                    label:
                        {
                            EmptyView()
                        }
                )
                
                TitleTextField(value: $viewModel.title)
                
                DeadlineDatePicker(value: $viewModel.deadline)
                
                BodyTextEditor(value: $viewModel.explanation)
                
                Footer()
                
                HStack
                {
                    Text("Tasks")
                        .titleLeftViewFormat()
                    
                    Spacer()
                    
                    Button(action: viewModel.addTask)
                    {
                        Label("Add Task", systemImage: "plus")
                    }
                    .bodyRightViewFormat()
                }
                
                List
                {
                    ForEach(viewModel.tasks)
                    {
                        task in
                        NavigationLink
                        {
                            TaskDetailView(
                                viewModel:
                                    TaskDetailViewModel(
                                        task: task
                                    )
                            )
                        } label:
                        {
                            Card(
                                title: task.title,
                                subtitle1: Formatter.dateToLongString(task.deadline),
                                subtitle2: Task.completionDictionary[Int(task.completion)]!
                            )
                        }
                    }
                    .onDelete(perform: viewModel.deleteTasks)
                }
                .listStyle(.plain)
                .frame(height: 300)
            }
        }
        .frame(alignment: .leading)
        
        .navigationTitle("Topic Detail")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar
        {
            ToolbarItem
            {
                Button(
                    action:
                        {
                            viewModel.saveData(view: self)
                        }
                )
                {
                    Text("Save")
                }
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider
{
    static var previews: some View
    {
        TaskListView(
            viewModel:
                TaskListViewModel(
                    topic:
                        DatabaseHelperTopic(
                            fetchRequest: Topic.fetchRequest()
                        )
                        .add(
                            title: "",
                            explanation: "",
                            deadline: Formatter.getStartOfDate(Date())
                        )
                )
        )
    }
}
