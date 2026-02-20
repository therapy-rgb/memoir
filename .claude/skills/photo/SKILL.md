# Photo

Prepare an image for the site: resize to fit the content column, convert to WebP, and save to `images/`.

## Arguments

The argument is a **file path** to the source image. Examples:
- `/photo ~/Downloads/baby-park.jpg`
- `/photo /tmp/screenshot.png`
- `/photo ~/Desktop/IMG_4032.HEIC`

Optionally a custom output name can follow a comma:
- `/photo ~/Downloads/baby-park.jpg, park-morning`

## Steps

### 1. Validate the input
- Confirm the source file exists.
- If no argument was provided, ask the user for the image path.

### 2. Determine the output filename
- If the user provided a custom name after a comma, use that (slugified, lowercase, hyphens).
- Otherwise, use the source file's base name, lowercased and with spaces/underscores replaced by hyphens.
- The extension is always `.webp`.
- Output directory is `/Users/marcusberley/Documents/Projects/memoir/images/`.

### 3. Resize and convert
Use ImageMagick to resize and convert in one step:
```bash
magick "<source>" -resize "1200x>" -quality 80 -strip "/Users/marcusberley/Documents/Projects/memoir/images/<output>.webp"
```

Flags explained:
- `-resize "1200x>"` — shrink to 1200px wide max, keep aspect ratio, never upscale (the `>` means "only if larger")
- `-quality 80` — WebP quality 80 is a good balance of size and clarity
- `-strip` — remove EXIF metadata (privacy, smaller files)

### 4. Report results
Show the user:
- Source file size (before)
- Output file path and size (after)
- The Pollen tag to paste into a `.pm` file:
  ```
  ◊figure["images/<output>.webp"]{Caption text here}
  ```
- Remind them to replace "Caption text here" with a real caption, or remove the braces for no caption.
