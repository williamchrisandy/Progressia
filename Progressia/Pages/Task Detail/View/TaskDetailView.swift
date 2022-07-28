//
//  TaskDetailView.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//

import SwiftUI

struct TaskDetailView: View
{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: TaskDetailViewModel
    
    var body: some View
    {
        ScrollView(.vertical)
        {
            VStack
            {
                TitleTextField(value: $viewModel.title)

                DeadlineDatePicker(value: $viewModel.deadline)

                PickerView(fieldName: "Difficulty", data: Task.difficultyDictionary, value: $viewModel.difficulty)
                
                HStack
                {
                    Text("Completion: \(Task.completionDictionary[viewModel.completion]!)")
                        .bodyViewFormat()
                    Spacer()
                }

                BodyTextEditor(value: $viewModel.explanation)

                Footer()
                
                Button(action: viewModel.showImagePicker)
                {
                    Text("Update Task Completion (Progress)")
                }
                .buttonStyle(.bordered)
                .padding()
                .padding(.top, 16)
                
                Text("Completion status cannot be changed without taking a selfie to detect your mood.")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .padding([.horizontal, .bottom])
            }
            
        }
        
        .navigationTitle("Task Detail")
        .navigationBarTitleDisplayMode(.inline)
        
        .sheet(isPresented: $viewModel.isShowingImagePicker)
        {
            ImagePickerView(selectedImage: $viewModel.selectedImage)
        }
        .sheet(isPresented: $viewModel.isShowingPicker, onDismiss: viewModel.dismissPicker)
        {
            ChangeCompletionView(
                viewModel: ChangeCompletionViewModel(
                    task: viewModel.task,
                    basePoint: viewModel.basePoint,
                    mood: viewModel.mood
                )
            )
        }
        
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

struct TaskDetailView_Previews: PreviewProvider
{
    static var previews: some View
    {
        TaskDetailView(
            viewModel:
                TaskDetailViewModel(
                    task: Task()
                )
        )
    }
}
