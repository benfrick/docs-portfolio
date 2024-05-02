# Docs Portfolio

This project provides documentation samples, templates, and a fully working site with search.

## Using

See the /doc dir for all the Markdown files.

## Running Locally

macOS:

1. Install [Jekyll](https://jekyllrb.com/docs/installation/macos/)
2. Start the Jekyll server:
    3. From project root in Terminal,
       run `jekyll s` to start the Jekyll server and builds the site
    4. If you get errors,
       use the `bundle exec jekyll s` command instead, which helps manage/fix project dependencies on the fly
    5. The `livereload` option displays changes in your browser
       immediately without having to reload the page:<br/>`bundle exec jekyll s --livereload`
4. Navigate to http://127.0.0.1:4000/ in your browser

Jekyll puts the static HTML files it generates in the `_site` directory along with the assets
it needs to run the site, including JS, CSS, and images.

>**TIP**: When checking in changes, do not check in files from the `_site` directory.

For more info on Jekyll, visit https://jekyllrb.com/docs/.