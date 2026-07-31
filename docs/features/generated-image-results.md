---
status: implemented
area: generation-results
platforms:
  - ios
---

# Generated Image Results

## Purpose

Present the images returned by Image Playground after generation completes.

## User Story

As a user, I want to view all generated images so that I can inspect the result of my prompt.

## Acceptance Criteria

- One or more returned images lead to the results view.
- Every returned image is displayed, including result counts other than the default two.
- Images are scaled to fit and displayed with rounded corners.
- An empty result stream does not display an empty results view and instead enters the error state.
