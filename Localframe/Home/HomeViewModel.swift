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
    // MARK: - UI State
    var generatedCGImages: [CGImage] = []
    var inputPrompt: String = ""
    var error: ImageCreator.Error?
    var selectedStyle: ImagePlaygroundStyle = .animation
    var viewState: ViewState = .idle

    // MARK: - Dependencies
    private var imageCreator: ImageCreator?

    // MARK: - Configuration
    let availableStyles: [ImagePlaygroundStyle] = [.animation, .illustration, .sketch]

    init() {
        Task { await loadCreator() }
    }

    private func loadCreator() async {
        do {
            imageCreator = try await ImageCreator()
        } catch {
            self.error = error as? ImageCreator.Error
            self.viewState = .error
        }
    }
    
    /// Generates images based on the user's current prompt and selected style.
    func generateImages(limit: Int = 2) async {
        guard let imageCreator else {
            self.viewState = .error
            return
        }

        do {
            viewState = .isGenerating
            generatedCGImages.removeAll(keepingCapacity: true)

            let stream = imageCreator.images(
                for: [.text(inputPrompt)],
                style: selectedStyle,
                limit: limit
            )

            for try await image in stream {
                generatedCGImages.append(image.cgImage)
            }

            viewState = .generated
        } catch {
            // Falls ImageCreator.Error sinnvoll ist, hier mappen:
            self.error = error as? ImageCreator.Error
            viewState = .error
        }
    }
    
    /// Returns a SwiftUI `Image` created from a `CGImage`.
    /// - Parameter cgimage: a `CGImage` that should be transformed
    /// - Returns: a SwiftUI `Image`
    func image(for cgimage: CGImage) -> Image {
        return Image(uiImage: UIImage(cgImage: cgimage))
    }
    
    /// Resets the generation workflow and clears all user-visible state.
    func reset() {
        error = nil
        generatedCGImages.removeAll()
        viewState = .idle
        inputPrompt = ""
    }
}

enum ViewState {
    case idle
    case isGenerating
    case generated
    case error
}
