## Quick-Start: Load the Builder

Want to load the Builder bundle and start interacting with a basic Customization experience? Read this section, otherwise skip to [Show Customizable Products](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Using%20Customization/Show%20Products).

In your app's source, create an HTML template and follow these steps:

1. **Include the Builder bundle**

    Add a `<script>` tag in the `<body>` to include the Builder JavaScript bundle like:

    ```html
    <script src="https://assets.commerce.nikecloud.com/nikeid/builder/dist/b16Builder.bundle.min.js" type="text/javascript"></script>
    ```

2. **Add a <div> for the Builder to load into**

    Add a `<div>` in the `<body>` with an `id="nikeid-app"` attribute like:

    ```html
    <div id="nikeid-app-container" style="width: 1000px; height: 800px;">
        <div id="nikeid-app">
        </div>
    </div>
    ```

3. **Load the Builder**

    Add a `<script>` tag in the `<body>` that invokes the `nikeIdBuilder(rootElement, config)` function like:

    ```html
    <script>
      const builderApi = nikeIdBuilder(document.getElementById('nikeid-app'), {
        'nike-api-caller-id': 'com.nike:commerce.b16.localhost',
        pathName: 'KobeAD2exoFA18'
      })
    </script>
    ```

    >**TIPS**:
    >- The argument for the `rootElement` parameter can be populated with a method like `document.getElementbyId('element-id-where-builder-renders')`.
    >- The argument for the `config` parameter must contain at minimum the `nike-api-caller-id` and `pathName` properties.
    >- See [Customization Builder Reference](https://developer.niketech.com/docs/projects/Commerce%20Docs/Builder%20Reference) for details about the Builder.

4. **Navigate to Your Local Host to View the Builder Experience**
    
    - The Builder loads into your chosen HTML element (in this case, a `<div>` with attribute `id="nikeid-app"`), and it invokes the necessary services to render the experience:
    
    - Browse to the HTML page on your localhost to view the Builder experience. The URL will vary depending on how your app is being served up locally.

    ![Image of Builder running locally in Chrome](../images/builder-local-web.png)

    **Example HTML template (initializes builder only):**
    
    ```html
    <!DOCTYPE html>
    <html>
    <head>
        <title>Nike By You: Example</title>
        <meta charset="utf-8">
        <meta http-equiv="cache-control" content="max-age=0,no-cache,no-store"/>
        <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT"/>
        <meta http-equiv="pragma" content="no-cache,no-store"/>
        <meta name="viewport"
              content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover"/>
        <link rel="icon" href="//www.nike.com/favicon.ico"/>
        <script type="text/javascript">
        var nsgConfig = {
          HOST: '//www.nike.com',
          PLATFORM: 'mobile'
        };
        </script>
        <script type="text/javascript" src="//www.nike.com/styleguide/init/nsg.js"></script>
    </head>
    <body>
    <div id="nikeid-app-container" style="width: 1000px; height: 800px;">
        <div id="nikeid-app">
        </div>
    </div>
    <script type="application/javascript"
            src="https://assets.commerce.nikecloud.com/nikeid/builder/dist/b16Builder.bundle.min.js"></script>
    <script>
      const builderApi = nikeIdBuilder(document.getElementById('nikeid-app'), {    
        'nike-api-caller-id': 'com.nike:commerce.b16.localhost',
        pathName: 'KobeAD2exoFA18',
      })
    </script>
    </body>
    </html>
    ```

    >**TIP**: See more at [Customization Builder Reference](https://developer.niketech.com/docs/projects/Commerce%20Docs/Builder%20Reference), which is the single source of truth for Builder functionality.