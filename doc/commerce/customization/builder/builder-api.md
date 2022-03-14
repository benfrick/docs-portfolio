## Builder API

Invoking the `nikeIdBuilder(rootElement, config)` function returns the Builder API.

Usage:

```javascript
/**
 * Function nikeIdBuilder returns the Builder API
 * @param {HTMLElement} rootElement The DOM element in which to inject the Builder
 * @param {Object} config The configuration properties that identify which Builder instance to be returned
 * @return {Object} Returns the exposed builderApi handlers
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
  myDesignsEnabled: true,
  myDesignCapacity: 20,

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

###### Table 1:  Required Build Properties

|`pathName`|String|The product pathName for the requested build.|
|`nike-api-caller-id`|String|A platform-unique key (<<domain name>>:<<appid>>) that identifies the API caller to customization services. See [Architecture Standards](https://cuddly-sniffle-c799ad24.pages.github.io/api-standards/#identifying-a-calling-client) for more.|

##### Getting a `nike-api-caller-id`

Please contact a team member in [#nikeid-dev-systems](https://nikedigital.slack.com/messages/C0L8C4UM7) or email 
[Lst-digitaltech.customization.id.systems@nike.com](mailto:Lst-digitaltech.customization.id.systems@nike.com) to obtain 
a key for your platform in advance of making API calls. The current list of supported values is shown below (Note: items marked with * are for internal tracking purposes):

###### Table 2:  Nike Platforms with Corresponding Caller IDs

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
|Tmall.com (Desktop)|com.tmall:commerce.idpdp.desktop|
|Tmall.com (Mobile)|com.tmall:commerce.idpdp.mobile|
|WIP Tool*|com.nike:wip|
|Test*|com.nike:test|
|Localhost*|com.nike:commerce.b16.localhost|

#### Properties With Dependencies

###### Table 3:  Build Properties Having Dependencies

|`productId`|String|Product ID for the requested build. Only required when using b16Builder and passing config: builderMode: 'wip'|
|`country`|String|The current country two character abbreviation, e.g. `US`, `GB`, `CN`. Only required when using builderProductApi|
|`locale`|String|The current locale abbreviation, e.g. `en_US`, `en_GB`, `zn_CN`. Only required when using builderProductApi|

#### Optional Properties

###### Table 4:  Optional Build Properties

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
|`myDesignsEnabled`|Boolean|If set to 'true', My Designs local storage will be enabled. Default is 'false'|
|`myDesignCapacity`|Number|Number of most recent designs to be stored in local storage. If this maximum value is exceeded, the oldest design(s) will be deleted from storage. Default is '15'|

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
Called with the current buildData state of the Builder whenever a new product is loaded, or a build is applied.

### Build Data

The Builder returns a `buildData` object (also referred to as Build Data), which describes the current state of the build with sizing information, style/color, current product
question/answer pairs, and more. Here is a [sample buildData object](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example).

#### Build Data Fields

###### Table 5:  Fields in Build Data

|Field|Type|Description|Example|
|---|---|---|---|
|`pathName`|String|The product pathName for this build.|"ER2teamSP19_barca"|
|`productId`|String|The product ID for this build.|"PROD372041"|
|`consumerQuesAnswers`|Array|Collection of product question-and-answer pairs representing the current state of the Builder's pid selections.|See [here](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example)|
|`productQuesAnswers`|Array|A collection of product question-and-answer pairs representing the current state of the Builder's combination selections.|See [here](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example)|
|`sizeMarketingComponent`|Object|DEPRECATED and replaced by `sizingData` (see below)|
|`viewNumbers`|String|Comma-separated list of views currently being displayed by the Builder, in the order in which they are being displayed. Provides a way to template scene7 URLs for each angle of the product currently being shown within the Builder for your own product carousels or display pages.|"1,2,3,4,5,6"|
|`color`|String|The product color code for this build.|"994"|
|`price`|String|The product price formatted as string with the currency symbol.|$180|
|`rawPrice`|Number|The product price formatted as a number.|180|
|`style`|String|The product style code.|"CK3977"|
|`country`|String|The current country code for this build.|"US"|
|`locale`|String|The current locale code for this build.|"en_US"|
|`imageNumbers`|String|Comma-separated list of views currently being displayed by the Builder, in the order in which they are being displayed. Provides a way to template scene7 URLs for each angle of the product for your own product carousels or display pages.|See [here](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example)|
|`imageService`|String|The host of the service call used to request images of the product represented by the buildData. Use in conjunction with the viewUrlTemplate field to build scene7 image service request URLs.|See [here](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example)|
|`imageUrlTemplate`|String|Scene7 parameterized URL for making requests for product images that are returned as opaque JPGs. The URL contains tags that must be replaced with valid values. These tags are {VIEW_NUMBER} (one of the values from imageNumbers), {IMAGE_WIDTH}, {BACKGROUND_COLOR} (in the form f5f5f5), & {JPG_QUALITY} (0 - 100).|See [here](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example)|
|`imageUrlShadowTemplate`|String|This URL is the same as the imageUrlTemplate except it has added parameters that will cause a shadow to be rendered underneath the image.|See [here](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example)|
|`viewService`|String|The host of the render service call used to request images of the product represented by the buildData. Use in conjunction with the viewUrlTemplate field to build scene7 render service request URL.|See [here](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example)|
|`viewUrlTemplate`|String|Scene7 parameterized URL for making requests for product images that are uncompressed PNGs with a transparent background. The URL contains a tag {VIEW_NUMBER} (one of the values from imageNumbers) that must be replaced with a valid value. You must also add a width to the end of the string in the form &wid={imageWidth} where {imageWidth} represents the width you desire.|See [here](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example)|
|`viewUrlShadowTemplate`|String|This URL is the same as the viewUrlTemplate except it has added parameters that will cause a shadow to be rendered underneath the image.|See [here](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example)|
|`availability`|Object|The lead time in days for the product to be delivered, when `isAvailable` is true. When false, only an 'out of stock' message is returned.|See [here](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example)|
|`myDesigns`|Array|Array of locally-saved My Designs for the given pathName|See [here](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example)|
|`sizeTypes`|Array|A collection of sizeTypes based on the sizeTypeRegion that was requested in the config data.|See [here](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example)|
|`sizingData`|Array|Contains arrays of gender, width, size, and size chart data. Used for "buying" and "size" tools.|See [here](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Builder%20Reference/buildData%20Example)|

##### More about **availability**

The below table describes the contents of the `availability` object:

###### Table 6:  Fields in Availability Object

|Field|Type|Description|Example|
|---|---|---|---|
|`isAvailable`|Boolean|Whether the current style-color is available to be purchased|true|
|`leadtimeUpperBoundInDays`|Number|The lead time for the product to be delivered, in days|22|
|`longCapacityMessage`|String|The long message text describing the product availability and lead-time.|"Custom-made and delivered to you in 3 weeks or less."|
|`shortCapacityMessage`|String|The short message text describing the product availability and lead-time.|"GREAT CHOICE"|

##### More about **sizingData**

- Render the gender, width, and size questions and answer them using the `setAnswer` and `setsizeAnswer` methods as the consumer makes selections.
- If a value for the `sizeTypeRegion` field is not provided when initializing the Builder, then `sizeTypes` will default to undefined.
- If `fetchCapacity` is set to false when initializing the Builder, then all sizes will show as out of stock.
- Capacity, inventory, restrictions, sizeType and prior answers to sizing questions are all taken into consideration when generating this collection of objects.

Sample sizingData:

```
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

### Working with imageServer Images

The buildData that is returned includes URLs for generating images from the **image server**. These images are opaque JPGs, as opposed to the transparent PNGs provided by the [render server](#working-with-viewserver-images).

- `imageNumbers`
- `imageService`
- `imageUrlTemplate`
- `imageUrlShadowTemplate`

These can be processed to generate the urls you need by adding this function to your code:

```javascript
/**
* Get the imageUrls for the current design from the image server
*
* @param {Object} buildData - the buildData
* @param {String} backgroundColor - the background color to use i.e. ('f5f5f5')
* @param {Integer} imageWidth - the width value of the image
* @param {Integer} jpgQuality - the jpeg compression quality (0 - 100), I recommend 90
* @param {Boolean} includeShadow - whether or not to include shadow
* @returns {Array} - an array of urls
*/
getImageUrls(buildData, backgroundColor, imageWidth, jpgQuality, includeShadow) {
    const imageUrls = [];
    const imageService = buildData.imageService;
    const imageTemplate = (includeShadow ? buildData.imageUrlShadowTemplate : buildData.imageUrlTemplate);
 
    if (buildData && buildData.imageNumbers && imageService && imageTemplate) {
        const viewNumbers = buildData.imageNumbers.split(',');
        const baseViewUrl = `${imageService}${imageTemplate}`;
 
        for (let viewIndex = 0; viewIndex < viewNumbers.length; viewIndex += 1) {
            let imageUrl = baseViewUrl.replace(/{VIEW_NUMBER}/, viewNumbers[viewIndex])
            .replace(/{IMAGE_WIDTH}/, imageWidth)
            .replace(/{BACKGROUND_COLOR}/, backgroundColor)
            .replace(/{JPG_QUALITY}/, jpgQuality);
 
            imageUrls.push(imageUrl);
        }
    }
 
    return imageUrls;
}
```

### Working with viewServer Images

The buildData that is returned will include image URLs for generating images from the **render server**. These images are transparent PNGs, as opposed to the JPGs provided by the [image server](#working-with-imageserver-images).

- `viewNumbers`
- `viewService`
- `viewUrlTemplate`
- `viewUrlShadowTemplate`

These can be processed to generate the URLs you need by adding this function to your code:

```javascript
/**
* Get the viewUrls for the current design
*
* @param {Object} buildData - the buildData
* @param {Integer} imageWidth - the width value of the image
* @param {Boolean} includeShadow - whether or not to include shadow
* @returns {Array} - an array of urls
*/
getViewUrls(buildData, imageWidth, includeShadow) { // eslint-disable-line class-methods-use-this
    const viewUrls = [];
    const viewService = buildData.viewService;
    const viewTemplate = (includeShadow ? buildData.viewUrlShadowTemplate : buildData.viewUrlTemplate);
 
    if (buildData && buildData.viewNumbers && viewService && viewTemplate) {
        const viewNumbers = privateData.getBuildData().viewNumbers.split(',');
        const baseViewUrl = `${viewService}${viewTemplate}`;
 
        for (let viewIndex = 0; viewIndex < viewNumbers.length; viewIndex += 1) {
            const viewUrl = `${baseViewUrl.replace(/{VIEW_NUMBER}/, viewNumbers[viewIndex])}&wid=${imageWidth}`;
 
            viewUrls.push(viewUrl);
        }
    }
 
    return viewUrls;
}
```