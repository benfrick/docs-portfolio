---
tags: pdf
#category: b-use-case
position: 4
title: Customization Builder Reference
url: /doc/commerce/customization/builder-reference.html
toc:
  - h2: Installation
    url: /doc/commerce/customization/builder-reference.html#installation
  - h2: Basic Integration
    url: /doc/commerce/customization/builder-reference.html#basic-integration
  - h2: Builder API
    url: /doc/commerce/customization/builder-reference.html#builder-api
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="new-tab" class="ncss-btn-secondary-grey guide-button"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# Customization Builder Reference <i class="g72-swoosh"></i><br>DRAFT

---

##### Last Updated: 04/30/2019

This is the official reference for the features and functionality of the Customization Experience Builder, a product in the [Customization Experience Platform (CXP)](/doc/commerce/customization/overview-customization.html)

>**TIP**: Also see [Customization Overview](/doc/commerce/customization/overview-customization.html) and [Adding Customization To Your Experience](/doc/commerce/customization/use-customization/html).

The Builder is a JavaScript bundle that is your main interface with CXP. It does the following:

- **UX**: Returns a fully-styled UX for customizing products
- **Data API**: Interact with Builder data and CXP REST APIs

## Installation

The following section describes how to install the Builder in order to serve and access it locally.

### Prerequisites
 
- [Node.js](https://nodejs.org/en/) v4.2.x or higher
- [NPM](https://www.npmjs.com/get-npm) v3.x or higher
- [Homebrew](https://brew.sh/)

### Update Hosts File

- **Edit your /etc/hosts file**

    ```console
    $ sudo nano /etc/hosts
    ```

- **Use the arrow keys to position the cursor at the end of the file and add the following lines:**

    ```text
    127.0.0.1 localhost.nike.com
    127.0.0.1 origin-localhost.nike.com
    ```

- **Use Ctrl-O to save the file, then Ctrl-X to exit**

### Install Packages & Dependencies

- **Install the packages**

    ```console
    $ brew install pkg-config cairo libpng jpeg giflib
    ```

- **Install any dependencies**

    ```console
    $ npm install
    ```

### Local Startup

- **Start the server**

    ```console
    $ npm start
    ```

- **Access the Builder**
    
    The Builder is available at a URI like:
    
    ```
    http://localhost:3000/?pathName=<<PATH NAME>>
    ```
    
    The `pathName` value is discussed more in [Builder API](#builder-api). In the meantime, here is a working example to get you started:
    
    ```
    http://localhost:3000/?pathName=KobeAD2exoFA18
    ```
    ![](/images/customization/builder-local-web2.png)


## Basic Integration

This section describes how to complete a basic integration of the Builder into a web view or browser-based application.

>**TIPS**:
>- Make sure you've completed the steps in the [Installation](#installation) section and that you are running the server via `npm start` command.
>- For more detailed integration instructions see [Adding Customization To Your Experience](/doc/commerce/customization/use-customization.html).

### 1. Include the Builder Bundle

In your app's source (e.g. in an HTML template), include the Builder JavaScript bundle in a `<script>` tag in the `<body>` like:

```html
<script src="https://assets.commerce.nikecloud.com/nikeid/builder/dist/b16Builder.bundle.min.js" type="text/javascript"></script>
```

This loads the Builder bundle when the page is rendered.

#### Bundle URIs

The bundle URIs to be used in the Test and Production environments are provided below.

**Test**

- Builder UI: [https://assets.test.commerce.nikecloud.com/nikeid/builder/dist/b16Builder.bundle.min.js](https://assets.test.commerce.nikecloud.com/nikeid/builder/dist/b16Builder.bundle.min.js)
- Product API: [https://assets.test.commerce.nikecloud.com/nikeid/builder/dist/b16ProductApi.bundle.min.js](https://assets.test.commerce.nikecloud.com/nikeid/builder/dist/b16ProductApi.bundle.min.js)

**Production**

- Builder UI: [https://assets.commerce.nikecloud.com/nikeid/builder/dist/b16Builder.bundle.min.js](https://assets.commerce.nikecloud.com/nikeid/builder/dist/b16Builder.bundle.min.js)
- Product API: [https://assets.commerce.nikecloud.com/nikeid/builder/dist/b16ProductApi.bundle.min.js](https://assets.commerce.nikecloud.com/nikeid/builder/dist/b16ProductApi.bundle.min.js)

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

Launch the Customization experience locally by navigating to the URI with at minimum the `?pathName` query parameter. The value in `?pathName` must match what you set in the `pathName` property when the Builder was initialized, like:

```
http://localhost:3000/?pathName=KobeAD2exoFA18
```

#### Additional Query Params

- `imageSize`: sets the size of images returned by the Builder in pixels (max 666) 
- `imageQuality`: sets the bit-depth of the PNG images returned by the Builder (8/24) 
- `hideMenu`:  shows/hides the harnessMenu on page load (true/false)

Example:
```
http://localhost:3000/?imageSize=666&imageQuality=8&hideMenu=true&pathName=metcon20161601
```

### Integration Flow

- Invoke `nikeIdBuilder(rootElement, config)` to get the Builder API. The returned object also contains a method for api.onApiReady, which 
can be used as an indicator to when the Builder has loaded the necessary data to begin loading the experience. The Builder 
will invoke the necessary services to render the experience.
- Listen to price change, analytic, and "done" events coming from the Builder.
- For buying tools, use `setSizeType` and `setAnswer` for answering the size related questions.
- Invoke `setBuild` for loading a new build by prebuild id, metric id, or raw build data. This is mainly meant to "reset" the Builder.

## Builder API

Invoking the `nikeIdBuilder(rootElement, config)` function returns the Builder API.

Usage:

```javascript
/**
 * Function nikeIdBuilder returns the Builder API
 * @param {string?} rootElement An HTMLElement target to mount the Builder application into.
 * @param {string?} config The configuration properties that identify which Builder instance to be returned
 * @return 
*/
var rootElement = document.getElementById('my-app-location');
var config = {
  'nike-api-caller-id': 'XXXXX',
  locale: 'en_US',
  country: 'US',
  pathName: 'af1High14_July',
  bridge: {
    // ...
  }
  // ... etc, documented below
};

var builderApi = nikeIdBuilder(rootElement, config)
```


### Parameters

#### rootElement

The argument for the `rootElement` parameter must be an HTMLElement target to mount the Builder application into.

Example: `document.getElementById('nike-id-builder-app');`

#### config

The argument for the `config` parameter must include the configuration properties that identify which Builder instance to be returned.

At minimum, the `pathName` and `nike-api-caller-id` properties are required in order to initialize the Builder.

```javascript
{
  // required properties
  'nike-api-caller-id': 'com.nike:test',
  pathName: 'af1High14_July',

  // sometimes required properties
  productId: 'PROD359583',
  country: 'US',
  locale: 'en_US',

  // suggested bridge
  bridge: {
    onAnalyticsEvent: function() {},
    onApiReady: function(api) {}, // api ready not build
    onDone: function(buildData) {},
    onError: function(error){},
    onPriceUpdate: function(priceData) {},
    onProductLoad: function(buildData) {} // build ready
  }

  // optional properties
  abTestCookieName: null,
  builderMode: 'default',
  currentEnv: 'PROD',
  dataAsStrings: false,
  disablePalette: false,
  eMerchId: 123456,
  enableAnimationInit: false,
  fetchCapacity: false,
  fitToContainer: document.getElementById('nikeid-app-container'),
  hasTouch: true,
  isColorMatching: false,
  metricId: '42',
  prebuildId: '42',
  sizeTypeRegion: 'US',

  // optional skip price info
  skipPriceInfo: false,
  colorCode: '994',
  styleCode:'AA1617',

  // optional image quality
  imageQuality: 24,
  imageSize: 300,
  viewPortSize: 'S',
}
```

#### Required Properties

|`pathName`|String|The product pathName for the requested build.|
|`nike-api-caller-id`|String|A platform-unique key (<<domain name>>:<<appid>>) that identifies the API caller to customization services|

##### Getting a `nike-api-caller-id`

Please contact a team member in [#nikeid-dev-systems](https://nikedigital.slack.com/messages/C0L8C4UM7) or email 
[Lst-digitaltech.customization.id.systems@nike.com](mailto:Lst-digitaltech.customization.id.systems@nike.com) to obtain 
a key for your platform in advance of making API calls. The current list of supported values is shown below (Note: items marked with * are for internal tracking purposes):

|Platform|Value|
|---|---|
|Nike.com Desktop PDP|com.nike:commerce.idpdp.desktop|
|Nike.com Mobile PDP|com.nike:commerce.idpdp.mobile|
|Nike.com Jersey PDP|com.nike:commerce.jerseyidpdp.desktop|
|Nike.com Jersey Mobile PDP|com.nike:commerce.jerseyidpdp.mobile|
|Nike.com Desktop 3D Builder|com.nike:commerce.3d.builder.desktop|
|Nike.com Mobile 3D Builder|com.nike:commerce.3d.builder.mobile|
|Converse.com Desktop PDP|com.converse:commerce.idpdp.desktop|
|Converse.com Mobile PDP|com.converse:commerce.idpdp.mobile|
|Converse.com Europe Desktop PDP|com.converse.eu:commerce.idpdp.desktop|
|Converse.com Europe Mobile PDP|com.converse.eu:commerce.idpdp.mobile|
|Nike App iOS|com.nike.commerce.omega.ios|
|Nike App Android|com.nike.commerce.omega.droid|
|NikeElite.com Desktop PDP|com.nike.elite:commerce.idpdp.desktop|
|NikeElite.com Mobile PDP|com.nike.elite:commerce.idpdp.mobile|
|Nike Cultivator Desktop|com.nike.cultivator:commerce.desktop|
|Nike Cultivator Mobile|com.nike.cultivator:commerce.mobile|
|Nike Factory Collab (FC) (includes FC Lite)|com.nike.commerce.fc|
|Nike DOMS|com.nike.commerce.doms|
|Nike CSP|com.nike.commerce.csp|
|Nike Order Capture (OCP)|com.nike.commerce.ocp|
|Nike PI|com.nike.commerce.pi|
|Nike Email|com.nike.commerce.email|
|WIP Tool*|com.nike:wip|
|Test*|com.nike:test|
|Localhost*|com.nike:commerce.b16.localhost|

#### Sometimes Required Properties

|`productId`|String|Product ID for the requested build. Only required when using b16Builder and passing config: builderMode: 'wip'|
|`country`|String|The current country two character abbreviation, e.g. `US`, `GB`, `CN`. Only required when using builderProductApi|
|`locale`|String|The current locale abbreviation, e.g. `en_US`, `en_GB`, `zn_CN`. Only required when using builderProductApi|

#### Optional Properties

|`abTestCookieName`|String|A unique user id for Optimizely to use for it's a/b tests. If `anonymousId` cookie is present, it will be used over the abTestCookieName.|
|`builderMode`|String|Determines which services are used by the Builder for product data and scene7 calls. In `default` mode, the production app uses a service call to the V4 Product service in production. In `wip` mode, the Builder uses the idedit preview product service and you must also supply the `productId` to be passed along in the service call.|
|`currentEnv`|String|Determines the environment to be used for Builder backend services. Possible values: `PROD`, `ecnXX` (any ecn environment), `prdvtools1` (any preview environment). If this config value is not set, the Builder will attempt to derive it from the client host URL, and if unsuccessful will default to `PROD`.|
|`dataAsStrings`|Boolean|Pass `true` to have the Builder API methods return data as a string, avoiding unwanted marshaling side effects.|
|`disablePalette`|Boolean|Pass `true` to disable/hide the marketing components/palette navigation.|
|`eMerchId`|String|The prodigy product ID. This can be used to fetch VAS SKU data required for jerseys.|
|`enableAnimationInit`|Boolean|Pass `true` if you want to await palette item animations until `builderApi.setIsVisible(true)` is called on the Builder|
|`fetchCapacity`|Boolean|Pass `true` to fetch capacity information along with the product.|
|`fitToContainer`|HTML Element|When set to a DOM element (e.g document.getElementById('container')), the experience will only flex to the size of that container rather than attempting to use 100vh or calculating UI dimensions based on the window.|
|`hasTouch`|Boolean|Pass `true` if the experience supports touch input.|
|`isColorMatching`|Boolean|Passing `true` hides the harness menu and control buttons. This supports color matching work flow in the WIP Builder.|
|`metricId`|String|Passing a `prebuildId` or `metricId` in config will force the Builder to load the build for the product and apply all the selections in the build to the loaded product. `metricId` will always be preferred over `prebuildId` if both are supplied.|
|`prebuildId`|String|Passing a `prebuildId` or `metricId` in config will force the Builder to load the build for the product and apply all the selections in the build to the loaded product. `metricId` will always be preferred over `prebuildId` if both are supplied.|
|`sizeTypeRegion`|String|The sizeTypeRegion corresponding to the list of sizeTypes that should be returned in the build data.  Valid values are `US`, `EU`, `JP`, `CN`, `XP`.|
|`viewPortSize`|String|Sets viewport size, and creates values for `imageSize` and `imageQuality`. Can be `'S'`, `'M'`, `'L'`, `'XL'`, `'S8'`, `'M8'`, `'L8'`, `'XL8'`.|
|`imageQuality`|Number|Sets the PNG bit depth. Can be either `8` or `24`.
|`imageSize`|Number|Number of pixels at which the main shoe image will be rendered.|
|`skipPriceInfo`|Boolean|If set to `true`, the pricing information won't be returned but style-color code will still be returned. Use for any product that is not setup in Prodigy. This flag is added to support Converse EU products.|
|`styleCode`|String|Mandatory when skipPriceInfo is set to `true`. Causes the build to be saved with the styleCode from the input config.|
|`colorCode`|String|Mandatory when skipPriceInfo is set to `true`. Causes the build to be saved with the colorCode from the input config.|

#### Bridge Properties

The bridge is a set of callbacks provided to the Builder config under the `config.bridge` property. They allow you to be notified by actions within the Builder.

##### onAnalyticsEvent(type, payload)

Called upon user invoked events for capturing analytics data.

The `type` property will be an event name that is exposed for analytics. This
list includes:

* **ANALYTICS_APPLY_CUSTOMIZATION**: When the user makes any customization change
* **ANALYTICS_COMPLETE_BUILD**: When the user presses 'done' to complete the build
* **ANALYTICS_MARKETING_COMPONENT_SELECTED**: When the user selects a marketing component
* **ANALYTICS_SELECT_VIEW**: When the user selects a view from the carousel
* **ANALYTICS_ZOOM_IN**: When the user requests a higher-res image

The `payload` property contains meta information about the event type. For example, the meta information for `ANALYTICS_SELECT_VIEW` would include the
selected view number. The same applies for `ANALYTICS_MARKETING_COMPONENT_SELECTED`, which will include the id and name of the marketing component.

##### onApiReady(api)
Called when the API is ready, shortly after the product has loaded. This returns the API object.

>**NOTE**: The build is not always ready at this point. Please use `bridge.onProductLoad(buildData)` for initial build. Then use `api.getBuild()` after that.

##### onDone(buildData)
Called with the current buildData whenever is "done" editing their build.

##### onError(error)
Called when an error response is returned from product data fetching or when a
initialization error occurs on the client. Error may be either a string or a native JavaScript error.

##### onPriceUpdate(priceData)
Called with price information
whenever the user makes selection changes.

##### onProductLoad(buildData)
Called with the current buildData state of
the Builder whenever a new product is loaded, or a build is applied.

### Build Data

The `buildData` object describes the current build state of the Builder, with sizing information, style/color, the current product
question and answer pairs, and other data.

Sample object:

```
{
  "country": "US",
  "locale": "en_US",
  "pathName": "af1High14_July",
  "productId": "PROD359583",
  "productQuesAnswers": [
    {
      "quesKey": "spikePE1512:LTITEM8538:LTITEM8112:LTITEM8010:LTITEM8145",
      "ansKey": "LTITEM8129"
    }
  ],
  "consumerQuesAnswers": [
    {
      "quesKey": "spikePE1512:LTITEM78003:LTITEM214118:LTITEM128002:LTITEM179157",
      "ansKey": "LTITEM8021",
      "value": "testpid",
      "valueType": "pid"
    }
  ],
  "sizeMarketingComponent": {},
  "sizeTypes": [
    {
     sizeType: sizeTypes.US,
     isDefault: true
    },
    {
     sizeType: sizeTypes.CM,
     isDefault: false
    }
  ],
  "sizingData": [],
  "sizeChartKey": "men_footwear_default",
  "sizeId": "6",
  "sizeType": "us-mens",
  "skuSizeId": "6",
  "style": "836710",
  "width": "Regular Fit",
  "viewNumbers": "1,2,3,4,5,6,7,8,9,10",
  "viewService": "http://render.nikeid.com/ir/render/nikeidrender/",
  "viewUrlTemplate": "af1High14_July_v{VIEW_NUMBER}?obj=/s/g12&color=ffffff&show&obj=/s/g11&color=bcbdbd&show&obj=/s/g24&color=ffffff&show&obj=/s/g10&color=ffffff&show&obj=/s/g14&color=ffffff&show&obj=/s/g13&color=ffffff&show&obj=/s/g15&color=bcbdbd&show&obj=/s/g1/leather&color=ffffff&show&obj=/s/g2/leather&color=ffffff&show&obj=/s/g3/peb&color=c4af7b&show&obj=/s/g4/peb&color=343434&show&obj=/s/g5/leather&color=ffffff&show&obj=/s/g6/peb&color=343434&show&obj=/s/g7/leather&color=ffffff&show&obj=/s/g8/leather&color=ffffff&show&obj=/s/g9/leather&color=ffffff&show&obj=/s/g23/leather&color=ffffff&show&obj=/s/g16/solid&color=ffffff&show&obj=/s/g17&color=ffffff&show&obj=/s/g21&opac=100&decal=&src=is(nikeid/emb2_iD?$T=iD&$C=808080&$FN=FuturaID&$FS=84&fmt=png-alpha)&color=141414&show&obj=/s/g22&opac=100&decal=&src=is(nikeid/emb2_iD?$T=YOUR&$C=808080&$FN=FuturaID&$FS=84&fmt=png-alpha)&color=141414&show&obj=/s/g18&color=ffffff&show&obj=/s/g19/solid&color=ffffff&show&obj=/s&req=object&fmt=png-alpha"
}
```

#### **Build Data Fields**

|`country`|String|The current country code for this build|
|`locale`|String|The current locale code for this build|
|`pathName`|String|The product pathName for this build|
|`productId`String|The Product ID for this build.|
|`productQuesAnswers`|Array|Collection of product question and answer pairs representing the current state of the Builder's combination selections.|
|`consumerQuesAnswers`|Array|Collection of product question and answer pairs representing the current state of the Builder's pid selections.|
|`sizeMarketingComponent`|Object|Provides sizing data needed to drive "buying" and "size" tools.|
|`sizeTypes`|Array|Collection of sizeTypes based on the sizeTypeRegion that was requested in the config data. One of these should be passed to `builderApi.setSizeType(sizeType)` prior to answering size questions.|
|`sizeData`|Array|Collection of questions generated from the sizeMarketingComponent, but reduced down to the just the questions/answers needed.|
|`viewNumbers`|String|Comma-separated list of views currently being displayed by the Builder, in the order in which they are being displayed. Provides a way to template scene7 urls for each angle of the product currently being shown within the Builder for your own product carousels or display pages.|
|`viewService`|String|The host of the service call used to request images of the product represented by the buildData. Use in conjunction with the `viewUrlTemplate` field to build scene7 request urls.|
|`viewUrlTemplate`|String|Scene7 parameterized url for making requests for product images. Provided with a `{VIEW_NUMBER}` template string which you should target for replacement with a `viewNumber` which you would like to request. Use this field in conjunction with `viewNumbers` and `viewService` in order to template scene7 urls in order to request product images represented by the current buildData.|

##### More about **sizeData**

- Capacity, inventory, restrictions, sizeType and prior answers to sizing questions are all taken into consideration when generating this collection of objects.
- The consumer of this array of objects only needs to be concerned with rendering the questions and answering them using the setAnswer API as the user interacts.
- The use of this collection requires that you provide `fetchCapacity: true` and a value for the `sizeTypeRegion` field at initialization of the Builder. If not provided, all of the sizes will be out of stock and the sizetype will default to 'us-womens' or `us-mens`.

```json
[
  {
    "displayName":"Size Chart",
    "questionId":"huarRunESS1702:LTITEM8538:LTITEM8112:LTITEM8010:LTITEM380033",
    "type":"SzChart",
    "answers":
    [
      {
        "path":"/v2/sizecharts/men_footwear_default.xml",
        "answerId":"LTITEM10027",
        "type":"SzChart",
        "isDefualt":true
      }
    ]
  },
  {
    "displayName":"Gender",
    "questionId":"huarRunESS1702:LTITEM8538:LTITEM8112",
    "type":"Gender",
    "answers":
    [
      {
        "displayName":"Mens",
        "questionId":"huarRunESS1702:LTITEM8538:LTITEM8112",
        "answerId":"LTITEM8010",
        "type":"Gender",
        "isDefault":true,
        "isSelected":false,
        "isRestricted":false
      },
      {
        "displayName":"Womens",
        "questionId":"huarRunESS1702:LTITEM8538:LTITEM8112",
        "answerId":"LTITEM8011",
        "type":"Gender",
        "isDefault":false,
        "isSelected":false,
        "isRestricted":false
      }
    ]
  },
  {
    "displayName":"Width",
    "questionId":"huarRunESS1702:LTITEM8538:LTITEM210042",
    "type":"Width",
    "answers":
    [
      {
        "displayName":"Narrow Fit",
        "questionId":"huarRunESS1702:LTITEM8538:LTITEM210042",
        "answerId":"LTITEM8098",
        "type":"Width",
        "isDefault":false,
        "isSelected":false,
        "isRestricted":false
      }
    ]
  },
  {
    "displayName":"Size",
    "questionId":"huarRunESS1702:LTITEM8538:LTITEM8112:LTITEM8010:LTITEM380033",
    "importantInformation":"This product runs about a half-size smaller than standard Nike sizing.",
    "type":"Sz",
    "sizetype":"euro",
    "answers":
    [
      {
        "displayName":"39",
        "questionId":"huarRunESS1702:LTITEM8538:LTITEM8112:LTITEM8010:LTITEM380033",
        "answerId":"LTITEM8128",
        "type":"Sz",
        "sizetype":"euro",
        "isDefault":false,
        "isSelected":false,
        "isAvailable": true,
        "constrains": {
          "isInStock":true,
          "hasCapacity":true,
          "isRestricted":false
        }
      }
    ]
  }
]
```

## Methods

### clearMessage

Usage: `builderApi.clearMessage()`

Description: Clears the message set in the Builder.

### getAnswersByCode

Usage: `builderApi.getAnswersByCode('jersey')`

Description: Returns answers and their matching questionsId which can then be used to display an answer. Useful for tapping into specific question or answer nodes.

### getBuild

Usage: `builderApi.getBuild()`

Description: Returns the current buildData object state.

### **getCapacity**

Usage: `builderApi.getCapacity().then()` or `builderApi.getCapacity({ country, pathName }).then()`

Description: Returns a promise to get capacity. If no configuration is passed and capacity data is available on state, then that information is returned (else, it will perform the service call to the capacity endpoint).

### **getMarketingComponents**

Usage: `builderApi.getMarketingComponents()`

Description: Returns a list of normalized marketing components with nested question keys. The questions index can be used to lookup nested question values.

### **getQuestionsIndex**

Usage: `builderApi.getQuestionsIndex()`

Description: Returns a normalized array of questions keyed by their ID. Effectively, this is a flattened tree of all questions contained in the product data with nested questions as keys.

Example:

```
{
  pathName:questionId: {
    id: 'pathName:questionId',
    isHidden: false,
    questions: [
      0: 'pathName:questionId:nestedQuestionId'
    ]
  }
}
```

### **getSelectedColors**

Usage: `builderApi.getSelectedColors()`

Description: Returns a collection of all selected colors from the current build, unique by hex(attribute).

### **getSelectedColorsPatterns**

Usage: `builderApi.getSelectedColorsPatterns`

Description: Returns a collection of all selected colors and patterns from the current build. Colors are unique by hex(attribute) and patterns are unique by src(attribute).

### **getSelectedPatterns**

Usage: `builderApi.getSelectedPatterns`

Description: Returns a collection of all selected patterns from the current build, unique by src(attribute).

### **getSelectedQuestionAnswerPairs**

Usage: `builderApi.getSelectedQuestionAnswerPairs`

Description: Returns a collection of all answered questions along with their answer. For most products this will return the majority of questions, as defaults are selected in B16 APIs.

### **getUpCharges**

Usage: `builderApi.getUpCharges()`

Description: This method returns an array of applicable up-charge objects corresponding to the answered questions.

Example:

```
[
    {
      answer: "ANSWER_ID",
      displayName: "Display Name",
      question: "QUESTION:PATH",
      upCharge: "$0"_
    }
]
```

### **isPidAllowed**

Usage: `builderApi.isPidAllowed('MYPID')`

Description: Returns true if the profanity service allowed the string (no stop word matched). String passed must match records in the capacity service exactly. Currently only single strings are supported.

### **saveBuild**

Usage: `builderApi.saveBuild().then(metricId => {})`

Description: Persists build data and returns promise to be resolved with metric ID.

### **setAnswer**

Usage: `builderApi.setAnswer(quesKey, ansKey)`

Description: Returns the current buildData object after changing the answer to a question in the Builder. Send the full question path, e.g. `"af1High14_July:LTITEM8170:LTITEM12012:LTITEM236023:LTITEM213006"` and the ID of the answer you would like to apply for that question, e.g. `"LTITEM167036"`.

### **setBuild**

Usage: `builderApi.setBuild(buildData)`

Description: Allows reloading the Builder with a new product by passing one of the following:

|Param|Type|Result|
|---|---|---|
|`metricId`|String|Build is loaded and applied to the product data.|
|`prebuildId`|String|Build is loaded and applied to the product data.|
|`buildData`|Object|Product for that build is reloaded and has the build data applied to the product.|

After calling this method the `bridge.onProductLoad` callback is called with the
`buildData` for the newly-applied build.

### **setIsVisible**

Usage: `builderApi.setIsVisible(true)`

Description: Informs the Builder whether it is visible on-screen or not. To take effect, `enableAnimationInit: true` needs to be passed in the initialization config options.

### **setMessage**

Usage: `builderApi.setMessage(message)`

Description: Causes the Builder to display a message. Takes a message object consisting of the following properties:

|`header`|String|The text displayed at the top of the message.|
|`content`|String|The text displayed under the header.|
|`type`|String|The type of the message to be displayed, which also affects how the message is displayed. Possible values: 'COUNTDOWN', 'COUNTDOWN_URGENT', 'COUNTDOWN_EXPIRED'. Default is 'COUNTDOWN'.

Examples:

```javascript
var countdownMessage = { header: 'Available for', content: '22:14:54:06', type: 'COUNTDOWN' };
builderApi.setMessage(countdownMessage);

var countdownUrgentMessage = { header: 'Available for', content: '00:00:10:06', type: 'COUNTDOWN_URGENT' };
builderApi.setMessage(countdownUrgentMessage);

var countdownExpiredMessage = { header: 'Great choice but...', content: 'This one sold out fast. Check back soon for availability. Keep customizing, save your design and share it with friends.', type: 'COUNTDOWN_EXPIRED' };
builderApi.setMessage(countdownExpiredMessage);

```

### **setSizeType**

Usage: `builderApi.setSizeType(sizeType)`

Description: Allows updating the Builder's internal state for selected size type, which updates the size, price, and color data when the Builder creates the buildData.

### **showNotification**

Usage: `builderApi.showNotification(message)`

Description: Causes the Builder to display a growl notification. It takes a message object consisting of the following properties:

|`type`|String|The type of message. Only one message of a given type will be displayed.|
|`message`|String|The message text.|
|`level`|String|Optional - Determines the message level. Possible values: 'alert', undefined/null.|
|`title`|String|Optional - The message title.|

Examples:

```javascript
var alert = { message: 'This is an alert with the orange thing', level: 'alert', type: 'some val' };
builderApi.showNotification(alert);

var titled = { message: 'This is just a plain message, but with a title', title: 'Hey yo!', type: 'some val' };
builderApi.showNotification(titled);

var plain = { message: 'just a plain old message. not that fun, sorry.', type: 'some val' };
builderApi.showNotification(plain);
```