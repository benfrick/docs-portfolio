---
title: Contributing
url: /contributing.html
---
# Contributing to Commerce Docs

We encourage content additions and updates from all teams in an effort to keep Commerce Docs content as accurate and useful as possible. 

Read on to find out how easy it is to maintain your team's documentation on Commerce Docs as a self-service.

## Submitting a Content PR
To add/edit pages on the Commerce Docs site:
1. Contact the Tech Docs team regarding your proposed changes using one of the methods below. The Tech Docs team will reach out to discuss the proposed changes/additions with you.
   - Slack [#tech-docs](slack://channel?team=T0G3T5X2B&id=C6A18NT7W)
   - Fill out a [Jira ticket](https://jira.nike.com/secure/RapidBoard.jspa?rapidView=14727) using the Feedback button available on every page of the Commerce Docs site
1. Fork the [Commerce Docs Repository](https://github.com/nike-internal/techdocs.site). 
1. Create a branch named according to the changes you are making, for example "updating-checkout-to-v3."
1. Add/edit content using [Markdown](https://www.markdownguide.org/cheat-sheet/) syntax, following the standards in the Tech Docs [Style Guide](https://confluence.nike.com/display/APID/Tech+Docs+Style+Guide).
>**TIP**: Content is located in the /doc folder of the Commerce Docs repository.
1. To view your changes with Commerce Docs formatting, see [Running Commerce Docs Locally](#running-commerce-docs-locally).
1. Submit your PR for review. The Tech Docs team members are assigned as PR reviewers by default.
1. When everyone is satisfied with the changes, the Tech Docs team approves the PR and merges your changes into the codebase.

Once merged, your changes publish immediately to the Commerce Docs site!


## Running Commerce Docs Locally

Review your documentation changes locally before checking them into GitHub by using the Jekyll static HTML site generator. Jekyll generates HTML files from your Markdown and runs as a local content server. You can view your pages formatted exactly as they will appear on the Commerce Docs site. 

Jekyll puts the static HTML files it generates in the `_site` directory along with the assets it needs to run the site, including javascript, images, and css.

For more info on Jekyll, visit https://jekyllrb.com/docs/.

>NOTE: Commerce Docs is a GitHub Pages site. Unlike Jekyll that creates HTML files from .md files, GitHub Pages automatically converts Markdown (.md) files to HTML on the fly. When checking in changes to the techdocs.site GitHub repo, do not check in files from the `_site` directory.

These instructions assume that you are using macOS where the [Ruby](https://www.ruby-lang.org/en/documentation/installation/) language and the [RubyGems](https://guides.rubygems.org/rubygems-basics/#installing-gems) package manager are installed by default.

To run Commerce Docs locally:

|---|---|
|Install Jekyll|https://jekyllrb.com/docs/installation/macos/|
|Start the Jekyll server| From the techdocs.site folder in Terminal, start the Jekyll server (which also builds the project) using the `s` (serve) command:<br/>`jekyll s`<br/>If you get errors, use the `bundle exec` command to ensure that the project dependencies play well together. The `livereload` option displays changes in your browser immediately without having to reload the page:<br/>`bundle exec jekyll s --livereload`|
|Test Commerce Docs and Jekyll server|Navigate http://localhost:4000/ in your browser|
|Troubleshoot| Configuration Options: https://jekyllrb.com/docs/configuration/options/<br/>Default Configuration: https://jekyllrb.com/docs/configuration/default/<br/>Bundle Info: https://bundler.io/rationale.html<br/><br/>To list and remove a certain version of a gem, replace the "[gem-name]" below:<br/>`$ gem uninstall [gem-name]`<br/>Select gem to uninstall:<br/>1. [gem-name]-0.8.7<br/>2. [gem-name]-0.9.2<br/>3. All versions<br/>> 2<br/>Successfully uninstalled [gem-name]-0.9.2|