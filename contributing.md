---
title: Contributing
url: /contributing.html
---
# Contributing to Commerce Docs

We encourage content additions and updates from all teams in an effort to keep Commerce Docs content as accurate and useful as possible. 

Read on to find out how easy it is to maintain your team's documentation on Commerce Docs as a self-service.

## Submitting a Content PR (Non-technical)

To add/edit pages on the Commerce Docs site:
1. Contact the Tech Docs team regarding your proposed changes. The Tech Docs team will reach out to discuss them with you.
   - Slack the [#tech-docs](slack://channel?team=T0G3T5X2B&id=C6A18NT7W) channel
   - OR
   - Fill out a [Jira ticket](https://jira.nike.com/secure/RapidBoard.jspa?rapidView=14727) using the Feedback button available on every page of the Commerce Docs site
1. When you are ready to make your changes, select the **Main** branch of the [techdocs.site GitHub repo](https://github.com/nike-internal/techdocs.site/tree/main/doc). All content is located in the /doc folder. 
   - **Add Page**: Navigate to the folder of your new Markdown file. Click "Add file" and choose "Create new file" from the dropdown.
   - **Edit Page**: Open the Markdown (.md) file that you want to edit and click the pencil button to enter Edit mode
   
1. Add/edit content using [Markdown](https://www.markdownguide.org/cheat-sheet/) syntax and the standards outlined in the Tech Docs [Doc Style Guide](https://confluence.nike.com/display/APID/Tech+Docs+Style+Guide)
1. (Optional) Toggle to the Preview tab to see an HTML preview with basic styling before you submit your changes. 
>**NOTE**: To view your changes with Commerce Docs formatting, see [Running Commerce Docs Locally](#running-commerce-docs-locally-technical) 
1. Scroll down to the "Commit changes" dialogue box and select "Create a new branch for this commit and start a pull request"
1. Add a commit name and a branch name that explains the changes you are making, for example "Updating Checkout v3" and "updating-checkout-to-v3"

   ![Image of GitHub's Commit changes dialog](images/gh-edit-md-commit.png "Image of GitHub's Commit changes dialog")

1. Click "Propose changes" to submit your pull request. Some considerations:
>NOTE: You do not need to add PR reviewers. The Tech Docs team is notified by default.
1. When everyone is satisfied with the changes, the Tech Docs team approves the PR and merges your changes into the codebase.

Your changes publish immediately to the Commerce Docs site!


## Running Commerce Docs Locally (Technical)

You can review your documentation changes locally before checking them into Github by using the Jekyll static HTML site generator. Jekyll generates HTML from your Markdown and runs as a local content server. You can view your pages formatted exactly as they will appear on the Commerce Docs site.

Commerce Docs source content is written in Markdown and runs on a GitHub Pages site. GitHub Pages automatically converts Markdown (.md) files to HTML by GitHub.

For more info on Jekyll, visit https://jekyllrb.com/docs/.

>**NOTE**: We assume that you are using macOS where the Ruby language and the Ruby Gems package manager are installed by default.

To run Commerce Docs locally:

|---|---|
|Fork the Commerce Docs Repo|https://github.com/nike-internal/techdocs.site|
|Install Jekyll|https://jekyllrb.com/docs/installation/macos/|
|Start the Jekyll server| From the techdocs.site folder in Terminal, start the Jekyll server (which also builds the project) using the `s` (serve) command:<br/>`jekyll s`<br/>If you get errors, use the `bundle exec` command to ensure that the project dependencies play well together:<br/>`bundle exec jekyll s`|
|Test Commerce Docs and Jekyll server|Navigate http://localhost:4000/ in your browser|
|Troubleshoot| Configuration Options: https://jekyllrb.com/docs/configuration/options/<br/>Default Configuration: https://jekyllrb.com/docs/configuration/default/<br/>Bundle Info: https://bundler.io/rationale.html<br/><br/>To list and remove a certain version of a gem, replace the "[gem-name]" below:<br/>`$ gem uninstall [gem-name]`<br/>Select gem to uninstall:<br/>1. [gem-name]-0.8.7<br/>2. [gem-name]-0.9.2<br/>3. All versions<br/>> 2<br/>Successfully uninstalled [gem-name]-0.9.2|