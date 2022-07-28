//
//  ImagePickerView.swift
//  Progressia
//
//  Created by William Chrisandy on 27/07/22.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable
{
    @Binding var selectedImage: UIImage?
        
    func makeUIViewController(context: Context) -> UIImagePickerController
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context)
    {
        
    }

    func makeCoordinator() -> ImagePickerCoordinator
    {
        return ImagePickerCoordinator(picker: self)
    }
}

struct ImagePickerView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ImagePickerView(selectedImage: .constant(UIImage()))
    }
}
