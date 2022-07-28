//
//  TaskDetailViewModel.swift
//  Progressia
//
//  Created by William Chrisandy on 24/07/22.
//

import SwiftUI

class TaskDetailViewModel: ObservableObject
{
    private let databaseHelper = DatabaseHelper()
    private let imagePredictor = ImagePredictor()
    
    @Published var task: Task
    @Published var title: String
    @Published var deadline: Date
    @Published var difficulty: Int
    @Published var completion: Int
    @Published var explanation: String
    @Published var basePoint: Int = 0
    @Published var mood: Double = 0
    @Published var isShowingImagePicker: Bool = false
    @Published var isShowingPicker: Bool = false
    @Published var selectedImage: UIImage?
    {
        didSet
        {
            isShowingImagePicker = false
            classifyImage(selectedImage ?? UIImage())
        }
    }
    
    init(task: Task)
    {
        self.task = task
        title = task.title
        deadline = task.deadline
        difficulty = Int(task.difficulty)
        completion = Int(task.completion)
        explanation = task.explanation

        if title == "Untitled Task"
        {
            title = ""
        }

        if explanation == ""
        {
            explanation = "Tap to add explanation."
        }
    }
    
    func showImagePicker()
    {
        isShowingImagePicker = true
    }
    
    func saveData(view: TaskDetailView)
    {
        task.title = title
        task.deadline = Formatter.getStartOfDate(deadline)
        task.difficulty = Int16(difficulty)
        task.completion = Int16(completion)
        task.explanation = explanation

        if title == ""
        {
            task.title = "Untitled Task"
        }

        if explanation == "Tap to add explanation."
        {
            task.explanation = ""
        }

        databaseHelper.saveContext()
        view.presentationMode.wrappedValue.dismiss()
    }
    
    func dismissPicker()
    {
        isShowingPicker = false
        completion = Int(task.completion)
    }
    
    // MARK: Image prediction methods
    /// Sends a photo to the Image Predictor to get a prediction of its content.
    /// - Parameter image: A photo.
    private func classifyImage(_ image: UIImage)
    {
        do
        {
            try imagePredictor.makePredictions(for: image, completionHandler: imagePredictionHandler)
        }
        catch
        {
            print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
        }
    }

    /// The method the Image Predictor calls when its image classifier model generates a prediction.
    /// - Parameter predictions: An array of predictions.
    /// - Tag: imagePredictionHandler
    private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?)
    {
        mood = calculateMood(predictions)
        
        basePoint = 0
        basePoint += difficulty * 1000
        basePoint += Formatter.dateDifferences(Date(), deadline) * 10
        isShowingPicker = true
    }
    
    private func calculateMood(_ predictions: [ImagePredictor.Prediction]?) -> Double
    {
        var overallMood: Double = 0
        var neutralMood: Double = 0
        if let detectedPredictions = predictions
        {
            for prediction in detectedPredictions
            {
                let weight = ImagePredictor.Prediction.predictionWeight[prediction.classification] ?? 0
                let mood = prediction.confidence * weight
                
                if prediction.classification == "Neutral"
                {
                    neutralMood = mood
                }
                else
                {
                    overallMood += mood
                }
            }
        }
        else
        {
            print("Error: No predictions. (Check console log.)")
            overallMood = 0
        }
        
        if overallMood > 0
        {
            if overallMood > neutralMood
            {
                overallMood -= neutralMood
            }
        }
        else
        {
            if overallMood < -neutralMood
            {
                overallMood = neutralMood
            }
            else
            {
                overallMood += neutralMood
            }
        }
        
        return overallMood
    }
}
