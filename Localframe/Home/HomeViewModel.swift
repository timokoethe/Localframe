//
//  HomeViewModel.swift
//  Localframe
//
//  Created by Timo Köthe on 23.07.25.
//

import SwiftUI
import ImagePlayground

@Observable
class HomeViewModel {
    var generatedImages: [CGImage]?
    var isGenerationStarted: Bool
    var prompt: String
    var creatorError: ImageCreator.Error?
    var generationStyle: ImagePlaygroundStyle
    var imageCreator: ImageCreator?
    var state: state = .idle
    
    let styles: [ImagePlaygroundStyle]

    init() {
        self.generatedImages = nil
        self.isGenerationStarted = false
        self.prompt = ""
        self.creatorError = nil
        self.generationStyle = .animation
        self.styles = [.animation, .illustration, .sketch]
        self.imageCreator = nil
        
        Task {
            do {
                try await self.imageCreator = ImageCreator()
            } catch {
                self.creatorError = error as? ImageCreator.Error
                self.state = .error
            }
        }
    }
    
    
    /// Checks the availability of the image creator.
    /// - Returns: true if the model is avaiable, otherwise false
    func isCreatorAvailable() -> Bool {
        return imageCreator != nil
    }
    
    
    func generateImage() async throws {
        do {
            self.state = .isGenerating
            let generationStyle = self.generationStyle
            
            let images = imageCreator!.images(
                for: [.text(self.prompt)],
                style: generationStyle,
                limit: 2)
            
            for try await image in images {
                if let generatedImages = generatedImages {
                    self.generatedImages = generatedImages + [image.cgImage]
                }
                else {
                    self.generatedImages = [image.cgImage]
                }
            }
            self.state = .generated
        }
        catch {
            print(error.localizedDescription)
            self.state = .error
        }
    }
}

enum state {
    case idle
    case isGenerating
    case generated
    case error
}
