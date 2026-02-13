# My Vim/Neovim Guide

Personal reference for keybindings and workflows. Leader key is `Space`.

---

## Navigation

| Key | Mode | Action |
|-----|------|--------|
| `h/j/k/l` | Normal | Move left/down/up/right |
| `w` | Normal | Jump forward to start of word |
| `b` | Normal | Jump backward to start of word |
| `e` | Normal | Jump forward to end of word |
| `E` | Normal | Jump backward to end of previous word (custom, normally `ge`) |
| `Shift+H` | Normal | Jump to start of line (custom, uses `g^`) |
| `Shift+L` | Normal | Jump to end of line (custom, uses `g$`) |
| `Ctrl+u` | Normal | Half page up (centered) |
| `Ctrl+d` | Normal | Half page down (centered) |
| `gg` | Normal | Go to top of file |
| `G` | Normal | Go to bottom of file |
| `{number}G` | Normal | Go to line number |
| `%` | Normal | Jump to matching bracket |
| `Ctrl+h/j/k/l` | Normal | Switch between split windows |

## Editing

| Key | Mode | Action |
|-----|------|--------|
| `i` | Normal | Insert before cursor |
| `a` | Normal | Insert after cursor |
| `o` | Normal | New line below and insert |
| `O` | Normal | New line above and insert |
| `x` | Normal | Delete character (without yanking, custom) |
| `dd` | Normal | Delete line |
| `cc` | Normal | Change entire line |
| `ciw` | Normal | Change inner word |
| `ci"` | Normal | Change inside quotes |
| `di"` | Normal | Delete inside quotes |
| `Y` | Normal | Yank to end of line (custom, normally `yy`) |
| `p` | Normal | Paste after cursor |
| `p` | Visual | Paste over selection without yanking replaced text (custom) |
| `u` | Normal | Undo |
| `Ctrl+r` | Normal | Redo |
| `.` | Normal | Repeat last change |

## Visual Mode & Selection

| Key | Mode | Action |
|-----|------|--------|
| `v` | Normal | Enter visual (character) mode |
| `V` | Normal | Enter visual line mode |
| `Ctrl+v` | Normal | Enter visual block mode |
| `Shift+H` | Visual | Select to start of line |
| `Shift+L` | Visual | Select to end of line |
| `<` | Visual | Indent left (stays in visual mode) |
| `>` | Visual | Indent right (stays in visual mode) |
| `<` | Normal | Indent current line left |
| `>` | Normal | Indent current line right |

## Line Dragging

| Key | Mode | Action |
|-----|------|--------|
| `Alt+j` | Normal | Move current line down |
| `Alt+k` | Normal | Move current line up |
| `Alt+j` | Visual | Move selected lines down |
| `Alt+k` | Visual | Move selected lines up |

## Search & Replace

| Key | Mode | Action |
|-----|------|--------|
| `/pattern` | Normal | Search forward |
| `?pattern` | Normal | Search backward |
| `n` | Normal | Next search result |
| `N` | Normal | Previous search result |
| `Enter` | Normal | Clear search highlights (custom) |
| `*` | Normal | Search for word under cursor |
| `:%s/old/new/g` | Command | Replace all occurrences in file |
| `:%s/old/new/gc` | Command | Replace all with confirmation |

## Renaming (LSP)

To rename a variable/function across the project:
1. Place cursor on the symbol
2. Press `Space r a` to open NvChad's renamer
3. Type the new name and confirm

Other LSP navigation:
| Key | Mode | Action |
|-----|------|--------|
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `K` | Normal | Show hover documentation |
| `Space D` | Normal | Go to type definition |
| `Space r a` | Normal | Rename symbol across project |
| `Space d s` | Normal | Show diagnostics list |
| `Space f m` | Normal | Format file |

## File Tree (NvimTree)

| Key | Mode | Action |
|-----|------|--------|
| `Space e` | Normal | Toggle file explorer |
| `Ctrl+n` | Normal | Toggle file explorer (NvChad default) |

Inside NvimTree:
| Key | Action |
|-----|--------|
| `Enter` | Open file/expand folder |
| `a` | Create new file |
| `d` | Delete file |
| `r` | Rename file |
| `c` | Copy file |
| `p` | Paste file |
| `x` | Cut file |
| `y` | Copy filename |

## Find Files (Telescope)

| Key | Mode | Action |
|-----|------|--------|
| `Space f f` | Normal | Find files |
| `Space f a` | Normal | Find all files (including hidden) |
| `Space f w` | Normal | Live grep (search in files) |
| `Space f b` | Normal | Find open buffers |
| `Space f h` | Normal | Search help tags |
| `Space f o` | Normal | Recent files |
| `Space f z` | Normal | Fuzzy find in current buffer |

## Buffers

| Key | Mode | Action |
|-----|------|--------|
| `Tab` | Normal | Next buffer |
| `Shift+Tab` | Normal | Previous buffer |
| `Space b` | Normal | New buffer |
| `Space x` | Normal | Close buffer |

## Terminal

| Key | Mode | Action |
|-----|------|--------|
| `Alt+i` | Normal | Toggle floating terminal |
| `Alt+h` | Normal | Toggle horizontal terminal |
| `Alt+v` | Normal | Toggle vertical terminal |
| `Space h` | Normal | New horizontal terminal |
| `Space v` | Normal | New vertical terminal |
| `Ctrl+x` | Terminal | Escape terminal mode |

## AI / Claude Code

| Key | Mode | Action |
|-----|------|--------|
| `Space a c` | Normal | Toggle Claude Code terminal |
| `Space a f` | Normal | Focus Claude Code terminal |
| `Space a s` | Visual | Send selection to Claude |
| `Space a b` | Normal | Add current buffer as Claude context |
| `Space a a` | Normal | Accept Claude's diff |
| `Space a d` | Normal | Deny Claude's diff |

## Debugger (DAP)

| Key | Mode | Action |
|-----|------|--------|
| `Space d b` | Normal | Toggle breakpoint |
| `Space d d` | Normal | Set conditional breakpoint |
| `Space d c` | Normal | Continue |
| `Space d l` | Normal | Step into |
| `Space d j` | Normal | Step over |
| `Space d k` | Normal | Step out |
| `Space d e` | Normal | Terminate debugger |
| `Space d r` | Normal | Run last debug session |

## General

| Key | Mode | Action |
|-----|------|--------|
| `Ctrl+s` | Normal | Save file |
| `Space W` | Normal | Save all files |
| `Space c` | Normal | Close all (quit) |
| `Space /` | Normal/Visual | Toggle comment |
| `Space n` | Normal | Toggle line numbers |
| `Space r n` | Normal | Toggle relative line numbers |
| `Space t h` | Normal | Change theme |
| `Space c h` | Normal | NvChad cheatsheet |

## Which-Key

Press `Space` and wait to see all available leader keybindings grouped by category.

## Tips

- **Repeat commands**: Use `.` to repeat the last edit. For example, `ciw` + type new word + `Esc`, then move to another word and press `.` to change it too.
- **Undo branches**: `u` undoes, `Ctrl+r` redoes. Vim remembers all undo history, even across branches.
- **Macros**: `qa` starts recording to register `a`, do your edits, `q` to stop. `@a` to replay, `@@` to replay last macro.
- **Dot formula**: The most efficient editing pattern is: search (`/` or `*`), change (`cgn` to change next match), then repeat with `.` across the file.
- **Text objects**: `i` = inner, `a` = around. Works with `w`ord, `"`quotes, `(`parens, `{`braces, `t`ag, etc. Example: `da"` deletes quotes and content, `di"` deletes only content.
