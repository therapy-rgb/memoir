# New Chapter

Create a new chapter or poem with boilerplate and add it to `index.ptree`.

## Arguments

The argument should include the **title** and optionally the **type** (chapter or poem). Examples:
- `/new-chapter The Long Walk` → creates next chapter
- `/new-chapter poem Morning Coffee` → creates next poem

If no type is specified, default to **chapter**.

## Steps

### 1. Determine the type and title
Parse the argument:
- If it starts with `poem` (case-insensitive), the type is **poem** and the title is the rest.
- Otherwise, the type is **chapter** and the full argument is the title.

### 2. Find the next number
Look at existing files in `/Users/marcusberley/Documents/Projects/memoir/`:
- For chapters: find the highest `chapter-NN.html.pm` and increment.
- For poems: find the highest `poem-NN.html.pm` and increment.

Zero-pad to two digits (e.g., `01`, `02`, ... `10`).

### 3. Create the source file
Write the `.pm` file with the correct boilerplate.

**For chapters:**
```
#lang pollen

◊(define-meta title "THE TITLE")
◊(define-meta date "CURRENT DATE")
◊(define-meta section "prose")

◊chapter-title{THE TITLE}

```

**For poems:**
```
#lang pollen

◊(define-meta title "THE TITLE")
◊(define-meta template "template-poems.html")
◊(define-meta section "poems")

◊poem{

}
```

- Use the actual title provided by the user.
- Use today's date formatted as `Month Day, Year` (e.g., `February 13, 2026`).

### 4. Add to index.ptree
Read `/Users/marcusberley/Documents/Projects/memoir/index.ptree` and insert the new output filename (`chapter-NN.html` or `poem-NN.html`) in the correct position:
- Chapters go after the last existing `chapter-NN.html` line (before poems).
- Poems go after the last existing `poem-NN.html` line (before `notes.html`).

### 5. Confirm
Tell the user:
- What file was created and where
- That it was added to `index.ptree`
- **Remind them to restart the dev server** if it's running (index.ptree changes require a restart)
