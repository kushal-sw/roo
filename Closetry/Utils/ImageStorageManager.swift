//
//  ImageStorageManager.swift
//  Closetry
//
//  Created by kushal sw on 29/08/26.
//

import UIKit

/// Handles saving and loading wardrobe item photos to/from the app's sandboxed Documents directory.
final class ImageStorageManager {
    static let shared = ImageStorageManager()

    private init() {}

    private var documentsDirectory: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    /// Saves a UIImage as JPEG to the Documents directory and returns the generated filename.
    @discardableResult
    func saveImage(_ image: UIImage) -> String? {
        let fileName = "\(UUID().uuidString).jpg"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        guard let data = image.jpegData(compressionQuality: 0.85) else {
            return nil
        }

        do {
            try data.write(to: fileURL)
            return fileName
        } catch {
            print("ImageStorageManager: failed to save image — \(error)")
            return nil
        }
    }

    /// Loads a UIImage from the Documents directory by filename. Returns nil if not found.
    func loadImage(fileName: String) -> UIImage? {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = try? Data(contentsOf: fileURL) else {
            return nil
        }
        return UIImage(data: data)
    }

    /// Deletes a stored image by filename.
    func deleteImage(fileName: String) {
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        try? FileManager.default.removeItem(at: fileURL)
    }
}
