---
status: implemented
area: image-generation
platforms:
  - ios
---

# Streamed Image Results

## Purpose

Demonstrate handling images incrementally as Apple's on-device Image Playground framework generates them.

## User Story

As a user, I want every image completed during generation to appear in my results so that no generated output is omitted.

## Acceptance Criteria

- The progress view remains visible until the image stream finishes.
- After a successful stream, every received image is displayed in the results view.
- One or more received images lead to the results view.
- A stream that throws an error or finishes without an image leads to the error view.
