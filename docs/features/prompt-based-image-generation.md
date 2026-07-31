---
status: implemented
area: image-generation
platforms:
  - ios
---

# Prompt-Based Image Generation

## Purpose

Generate images from a text prompt with Apple's on-device Image Playground framework.

## User Story

As a user, I want to describe an image so that Localframe can create matching results on my iPhone.

## Acceptance Criteria

- The user can submit any non-empty prompt after `ImageCreator` is ready.
- Generation uses `ImagePlayground.ImageCreator` fully on-device and makes no network request.
- A generation produces up to two images by default.
- Generation requires iOS 26 and a supported Apple Intelligence-capable iPhone.
- Direct generation with `ImageCreator` is unavailable on iOS 27 or later.
