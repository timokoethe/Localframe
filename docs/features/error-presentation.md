---
status: implemented
area: error-handling
platforms:
  - ios
---

# Error Presentation

## Purpose

Communicate when Image Playground initialization or image generation cannot complete.

## User Story

As a user, I want generation failures to be visible so that I understand why no images are shown.

## Acceptance Criteria

- Image creator initialization failures enter the error view.
- Generation errors and empty result streams enter the error view.
- Recognized `ImageCreator.Error` values display their localized description.
- Unknown or unavailable framework errors display a generic unexpected-error message.
- Unsupported devices and the iOS Simulator may report that image generation is not supported.
