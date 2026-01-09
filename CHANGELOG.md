# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed
- Correct module name from `gitb.nvim` to `gitb_nvim` in README and documentation

## [1.0.0] - 2025-01-09

### Added
- Initial release of gitb.nvim
- Git blame virtual text display line-by-line
- Toggle command `:GitBlameToggle` for easy enable/disable
- Cache popup with `:GitBlameShowCache` command
- Customizable highlights (author, date, message)
- Configurable popup settings (max_width, max_height, border)
- Automatic highlight refresh on colorscheme change
- Lazy loading support for fast startup
- Health check command `:checkhealth gitb`
- Per-line caching to minimize git calls
- Virtual text display at end of line
- Floating popup for cache inspection

### Features
- Shows author name, commit date, and message for each line
- Displays "Not Committed Yet" for uncommitted changes
- Cache system for performance optimization
- Respects git repository structure
- Works with any git repository
- Configurable colors using Neovim highlight system
- Supports multiple border styles for popup
- Automatic cleanup when plugin is disabled

### Documentation
- Complete README with installation instructions
- Vim help documentation accessible via `:h gitb`
- Configuration examples and options reference
- Troubleshooting guide
- Usage examples

### Technical Details
- Minimum Neovim version: 0.9.0
- Pure Lua implementation
- No external dependencies beyond Neovim API
- Lazy loading via `plugin/gitb.lua`
- Health checks for proper setup validation

[Unreleased]: https://github.com/Damet24/gitb.nvim/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/Damet24/gitb.nvim/releases/tag/v1.0.0
