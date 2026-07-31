---
status: implemented
area: privacy
platforms:
  - ios
---

# In-Memory Data Handling

## Purpose

Keep prompts and generated images local and temporary in this showcase app.

## User Story

As a user, I want my prompt and generated images to remain on my device so that the showcase does not upload or retain them.

## Acceptance Criteria

- Prompts and generated images remain in memory only.
- The app does not upload prompts or generated images.
- The app does not provide persistence or automatic export.
- Restart clears the current prompt and generated images.
- Relaunching the app does not restore earlier prompts or generated images.
