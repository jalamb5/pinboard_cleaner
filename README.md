# Pinboard Cleaner
JSON to Markdown converter.

Given [recent posts](https://mastodon.social/@alexcox/112916413641632058) from the creator of pinboard, I'll be moving on.

While other services like [Raindrop.io](http://raindrop.io) are able to easily import from pinboard, I've decided to just move my bookmarks to Obsidian for the time being.

## What it does
This script reads a pinboard JSON file and exports a markdown document that can be read in Obsidian and other text editors.

For my purposes, only certain elements get written to the final file but it's trivial to update the script to include additional elements.

By default each pin is written as follows:
`[Description](href) - Extended (if available) - (Tags: (if available))`

Additionally, I've stripped any tags which include 'via:' indicating they were copied from another user.

## Usage
- clone repo
- run: ruby pinboard_cleaner.rb ~/path/to/file.json

