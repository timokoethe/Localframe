# Localframe for iOS 26

[![License: MIT](https://img.shields.io/badge/license-MIT-orange)](https://opensource.org/license/mit)
![Framework](https://img.shields.io/badge/SwiftUI-orange)
![Platform](https://img.shields.io/badge/Platforms-iOS-orange)
![Xcode](https://img.shields.io/badge/Xcode-26-orange)
![iOS](https://img.shields.io/badge/iOS-26-orange)
![Apple](https://img.shields.io/badge/Apple-000000?style=flat&logo=apple)

**Localframe** is a small SwiftUI showcase app for experimenting with Apple’s Image Playground framework on iOS 26. It demonstrates how to create an `ImageCreator`, stream generated images from a text prompt, and present the result in a minimal native interface.

This project is intentionally lightweight. It is meant to document and demonstrate the API shape, not to serve as a production image generation product.

> [!WARNING]
> Localframe is a demonstration app and is not production-ready. Model output may be inaccurate, incomplete, or misleading.

> [!IMPORTANT]
> This app uses Apple’s `ImageCreator` class for direct programmatic on-device image generation. `ImageCreator` is deprecated as of iOS 27. Apple announced on June 11, 2026 that the class is being discontinued and will no longer work on iOS 27, iPadOS 27, macOS 27, and visionOS 27 or later.
> What that means for this repository:
> - iOS 26 is the intended showcase target.
> - On iOS 27 beta releases, the code continues to compile with Xcode warnings, but apps using `ImageCreator` do not function in TestFlight and cause a runtime error.
> - For public iOS 27 releases, code using `ImageCreator` no longer compiles and those features no longer work.
> - Apple recommends migrating to the system-managed Image Playground sheet or another image generation service. A remote service is intentionally outside this repository's fully on-device scope.
>
> See Apple’s announcement: [Deprecation of the ImageCreator class](https://developer.apple.com/news/?id=dz9wvq0r).

## ✨ Features

- 🖼️ **Image Playground integration**: Uses Apple’s `ImageCreator` API.
- 🌊 **Streaming results**: Consumes generated images asynchronously as they arrive.
- 🧑‍🎨 **Minimalist Prompt UI**: Clean SwiftUI interface for crafting prompts and viewing output.
- 🗑️ **No persistent storage**: Generated images are kept in memory only and are not saved by the app.

## Requirements

- Xcode 26
- iOS 26 deployment target
- A real Apple Intelligence-compatible iPhone
- Apple Intelligence enabled on the device
- Supported device and Siri language

The iOS Simulator is not a supported runtime for Image Playground image generation. If you run the app in Simulator, `ImageCreator` can return `.notSupported`.

## Known limitations

- Image generation does not work in the iOS Simulator.
- The app targets iOS 26 and depends on `ImageCreator`.
- `ImageCreator` is deprecated as of iOS 27, and Apple has announced that it will no longer work on iOS 27 or later.
- Error handling is intentionally minimal for showcase purposes.

## 🛠 API walkthrough

### Import the framework

```swift
import ImagePlayground
```

### Create an `ImageCreator`

```swift
do {
    self.imageCreator = try await ImageCreator()
} catch {
    self.error = error as? ImageCreator.Error
}
```

### Generate images

```swift
guard let imageCreator else { return }

let images = imageCreator.images(
    for: [.text(inputPrompt)],
    style: selectedStyle,
    limit: 2
)
```

### Display streamed results

```swift
for try await image in images {
    generatedCGImages.append(image.cgImage)
}
```

## License

Localframe is available under the MIT License. See [LICENSE](LICENSE) for the full license text.
