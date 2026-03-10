# JOYCO Lab

Public registry of [JOYCO Studio](https://joyco.studio) experiments.

Each experiment lives in its own isolated repository and gets listed here via [`experiments.json`](./experiments.json) — the single source of truth consumed by the [Hub](https://hub.joyco.studio) to render the experiments showcase.

## How it works

1. Scaffold a new experiment using the JOYCO CLI:
   ```sh
   joyco lab init
   ```
   This lets you pick a template (`3d` or `motion`), creates a new repo, and sets everything up.

2. Build and deploy your experiment.

3. Publish it to the registry:
   ```sh
   joyco lab publish
   ```
   This opens a PR adding your experiment to `experiments.json`.

## Schema

Each entry in `experiments.json` follows this shape:

| Field          | Type       | Required | Description                              |
| -------------- | ---------- | -------- | ---------------------------------------- |
| `slug`         | `string`   | yes      | URL-friendly unique identifier           |
| `title`        | `string`   | yes      | Display name                             |
| `description`  | `string`   | yes      | What the experiment explores             |
| `href`         | `string`   | yes      | Live deployment URL                      |
| `repo`         | `string`   | no       | Source repository URL                    |
| `template`     | `string`   | yes      | Template used (`3d` \| `motion`)         |
| `tags`         | `string[]` | no       | Freeform tags for filtering              |
| `previewImage` | `string`   | no       | URL to a preview/thumbnail image         |
| `date`         | `string`   | yes      | Publication date (`YYYY-MM-DD`)          |

The full JSON Schema is in [`schema.json`](./schema.json).

## Templates

| Template | Repository |
| -------- | ---------- |
| `3d`     | [lab-template-3d](https://github.com/joyco-studio/lab-template-3d) |
| `motion` | [lab-template-motion](https://github.com/joyco-studio/lab-template-motion) |
