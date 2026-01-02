//
//  HomeViewModel.swift
//  Localframe
//
//  Created by Timo Köthe on 23.07.25.
//

import SwiftUI
import ImagePlayground


/// View model for the Home screen responsible for managing image generation.
///
/// `HomeViewModel` handles the state and logic required to generate images from user prompts
/// using the `ImageCreator` class from the `ImagePlayground` framework. It maintains the list of
/// generated images, current prompt, selected style, and tracks the generation process state.
/// Additionally, it stores errors that may occur during image creation and provides a way to reset
/// the state. The view model is observable and is designed for use with SwiftUI views.
///
/// - Properties:
///   - `generatedImages`: Stores the images generated from the prompt.
///   - `isGenerationStarted`: Indicates if the generation process has started.
///   - `prompt`: The user input prompt for image generation.
///   - `creatorError`: Stores any errors from the image generation process.
///   - `generationStyle`: The selected visual style for image generation.
///   - `imageCreator`: The image creator instance responsible for generating images.
///   - `state`: The current state of the generation process (idle, isGenerating, generated and error).
///   - `styles: The available styles for image generation.
///
/// - Methods:
///   - `generateImage()`: Asynchronously generates images from the prompt and updates state.
///   - `reset()`: Resets all properties to their initial values.
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
    
    /// Generates an image based on the user's current input.
    func generateImage() async {
        do {
            self.state = .isGenerating
            
            let images = imageCreator!.images(
                for: [.text(self.prompt)],
                style: self.generationStyle,
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
        } catch {
            print(error.localizedDescription)
            self.state = .error
        }
    }
    
    /// Resets the user interface including the reset of all used variables.
    func reset() {
        self.creatorError = nil
        self.generatedImages = nil
        self.state = .idle
        self.prompt = ""
    }
}

enum state {
    case idle
    case isGenerating
    case generated
    case error
}
