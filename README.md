# hela_watermark Script for RedM

## Overview

The **hela_watermark** script displays a watermark image in your server. The watermark can be automatically shown or hidden based on UI visibility, and it can be toggled using a command.

## Features

- **Auto Watermark Display:** The watermark shows or hides based on whether the map or UI is active.
- **Toggle Command:** Use `/watermark` to toggle the watermark on or off.
- **Framework Support:** Works with VORP, RSG, and RedEMRP frameworks.
- **Character Selection:** Watermark appears 30 seconds after a character is selected.

## Installation

1. Download the script and place it in your `resources` folder.
2. Add `ensure hela_watermark` to your `server.cfg`.
3. Restart your server.

## Configuration

Edit the `config.framework` to match your server framework (`'vorp'`, `'rsg'`, `'redemrp'`).

You can also enable or disable the watermark toggle with `config.allowoff`.

## Watermark Image

Place your watermark image as `logo.png` in the `img` folder.

## Usage

- Use `/watermark` to toggle the watermark. If disabled, players will see a message indicating that the option is not available.
- The watermark will show after character selection, with a 30-second delay.

## License

This script is free to use and modify. Credit to [Jordan.#2139](https://github.com/Jordan2139/Logo-Watermark) for the original FiveM version.

---

For help or issues, feel free to reach out.
