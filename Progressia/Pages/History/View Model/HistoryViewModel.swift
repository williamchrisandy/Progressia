//
//  HistoryViewModel.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//

import SwiftUI
import Combine

class HistoryViewModel: ObservableObject
{
    private let databaseHelper = DatabaseHelperActivity(fetchRequest: Activity.fetchRequest());
    
    @Published var activities: [Activity] = []
    @Published var totalPoints: Int = 0
    
    private var cancellable: AnyCancellable!
    
    init()
    {
        cancellable = databaseHelper.$activities.sink
        {
            [weak self] activities in
            self?.activities = activities
            self?.totalPoints = 0
            for activity in activities
            {
                self?.totalPoints += Int(activity.point)
            }
        }
    }
}

