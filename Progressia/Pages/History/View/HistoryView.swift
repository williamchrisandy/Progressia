//
//  HistoryView.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//

import SwiftUI

struct HistoryView: View
{
    @StateObject var viewModel: HistoryViewModel = HistoryViewModel()
    
    var body: some View
    {
        HStack
        {
            VStack(alignment: .leading)
            {
                Text("Level: \(viewModel.totalPoints/10000)")
                    .titleViewFormat()
                
                Text("Total Points: \(viewModel.totalPoints)")
                    .bodyViewFormat()
                
                List
                {
                    ForEach(viewModel.activities)
                    {
                        activity in
                        Card(
                            title: "\(activity.task?.title ?? activity.topic?.title ?? "Deleted Topic/Task")",
                            subtitle1: Formatter.dateToFullString(activity.date),
                            subtitle2: "+\(activity.point) points"
                        )
                    }
                }
                .listStyle(.insetGrouped)
                .deleteDisabled(true)
            }
            Spacer()
        }
    }
}

struct HistoryView_Previews: PreviewProvider
{
    static var previews: some View
    {
        HistoryView()
    }
}
