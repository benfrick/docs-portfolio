# Customization Builder Reference

##### Last Updated: 04/24/2020

This is the official reference for the features and functionality of the Customization Experience Builder, a product in the [Customization Experience Platform (CXP)](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Using&20Customization).

>**TIP**: Also see [Customization Overview](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization) and [Adding Customization To Your Experience](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Using&20Customization).

The Builder is a JavaScript bundle that is your main interface with CXP. It offers the following:

- **UX**: Returns a fully-styled UX for customizing products
- **Data API**: Interact with [Build Data](#build-data) and CXP REST APIs

## Basic Integration

This section describes how to complete a basic integration of the Builder into a web view or browser-based application.

>**TIP**: For more detailed integration instructions see [Adding Customization To Your Experience](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Using&20Customization).

### 1. Include the Builder Bundle

In your app's source (e.g. in an HTML template), include the Builder JavaScript bundle in a `<script>` tag in the `<body>` like:

```html
<script src="https://assets.commerce.nikecloud.com/nikeid/builder/dist/b16Builder.bundle.min.js" type="text/javascript"></script>
```

This loads the Builder bundle when the page is rendered.

#### Bundle URIs

The bundle URIs to be used in the Test and Production environments are provided below. Reach out to the CXP team to determine which version you should be using.

**Test**

- Builder UI: https://assets.test.commerce.nikecloud.com/nikeid/builder/dist/b16Builder.[bundleVersion].min.js
- Product API: https://assets.test.commerce.nikecloud.com/nikeid/builder/dist/b16ProductApi.[bundleVersion].min.js

**Production**

- Builder UI: https://assets.commerce.nikecloud.com/nikeid/builder/dist/b16Builder.[bundleVersion].min.js
- Product API: https://assets.commerce.nikecloud.com/nikeid/builder/dist/b16ProductApi.[bundleVersion].min.js

### 2. Add a <div> for the Builder to Load Into

Add a `<div>` in the `<body>` with an `id="nikeid-app"` attribute like:

```html
<div id="nikeid-app-container" style="width: 1000px; height: 800px;">
    <div id="nikeid-app">
    </div>
</div>
```

You can name the `id` attribute however you want, just be sure to use the same name in the next step.

### 3. Initialize the Builder

Initialize the Builder by invoking the `nikeIdBuilder(rootElement, config)` function in a `<script>` tag in the `<body>` like:

```html
<script>
  const builderApi = nikeIdBuilder(document.getElementById('nikeid-app'), {
    'nike-api-caller-id': 'com.nike:commerce.b16.localhost',
    pathName: 'KobeAD2exoFA18'
  })
</script>
```

This returns the [Builder API](#builder-api) and renders the Customization UX into the specified HTMLElement.

>**TIPS**:
>- Make sure to use the same `id` used in Step 2 in the `document.getElementById()` argument.
>- The `nikeIdBuilder` function is described in detail in [Builder API](#builder-api)

### 4. Navigate to the URI to Launch the Experience

- Serve your app/page locally by running `npm start` or `yarn start`.

- Launch the Customization experience by navigating to the URI with at least the `?pathName` query parameter. The value in `?pathName` must match what you set in the `pathName` property when the Builder was initialized, like:

```
http://localhost:3000/?pathName=KobeAD2exoFA18
```

#### Additional Query Params

The following optional query parameters can be used in the URI to affect how the Customization experience is rendered.

- `imageSize`: sets the size of images returned by the Builder in pixels (max 666) 
- `imageQuality`: sets the quality (as bit-depth) of the PNG images returned by the Builder (8/24) 
- `hideMenu`:  shows/hides the harnessMenu on page load (true/false)

Example:
```
http://localhost:3000/?imageSize=666&imageQuality=8&hideMenu=true&pathName=metcon20161601
```

### Integration Flow

- Invoke `nikeIdBuilder(rootElement, config)` to get the Builder API. The returned object also contains a method for api.onApiReady, which indicates that the Builder has loaded.
- Listen to price change, analytic, and "done" events coming from the Builder.
- For buying tools, use `setSizeType` and `setSizeAnswer` for answering the size-related questions. Use `setAnswer` for answering Gender and Width questions.
- Invoke `setBuild` for loading a new build by prebuild id, metric id, or raw build data. This is mainly meant to "reset" the Builder.