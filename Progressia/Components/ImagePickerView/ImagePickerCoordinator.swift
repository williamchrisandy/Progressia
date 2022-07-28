//
//  ImagePickerController.swift
//  Progressia
//
//  Created by William Chrisandy on 27/07/22.
//

import UIKit

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    var picker: ImagePickerView
    
    init(picker: ImagePickerView)
    {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        guard let originalImage = info[.originalImage]
        else
        {
            fatalError("Error: Picker didn't have an original image.")
        }

        guard let photo = originalImage as? UIImage else
        {
            fatalError("Error: The (Camera) Image Picker's image isn't a/n \(UIImage.self) instance.")
        }

        self.picker.selectedImage = photo
    }
}
