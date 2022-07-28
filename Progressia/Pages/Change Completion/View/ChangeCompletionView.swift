//
//  ChangeCompletionView.swift
//  Progressia
//
//  Created by William Chrisandy on 29/07/22.
//

import SwiftUI

struct ChangeCompletionView: View
{
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel: ChangeCompletionViewModel

    var body: some View
    {
        NavigationView
        {
            VStack
            {
                PickerView(fieldName: "Completion", data: Task.completionDictionary, value: $viewModel.completion)

                HStack
                {
                    VStack(alignment: .leading)
                    {
                        Text("Potential points for completion status:")
                        Text("Not Started: Do not create new activity.")
                        Text("In-Progress: \(viewModel.points[1]!)")
                        Text("Done: \(viewModel.points[3]!)")
                    }
                    .bodyViewFormat()

                    Spacer()
                }

                Spacer()
            }

            .navigationTitle("New Activity")

            .toolbar
            {
                ToolbarItem(placement: .navigationBarLeading)
                {
                    Button(
                        action:
                            {
                                viewModel.cancel(view: self)
                            }
                    )
                    {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing)
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
}

struct ChangeCompletionView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ChangeCompletionView(
            viewModel:
                ChangeCompletionViewModel(
                    task: Task(),
                    basePoint: 3000,
                    mood: 0
                )
        )
    }
}
