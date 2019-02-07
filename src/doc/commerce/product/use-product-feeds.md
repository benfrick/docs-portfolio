---
id: use-product-feeds
tags: pdf
category: b-use-case
position: 1
title: Product Feeds
url: /doc/commerce/product/use-product-feeds.html
toc:
  - h2: Introduction
    url: /doc/commerce/product/use-product-feeds.html#introduction
  - h2: Get a List of Product Threads
    url: /doc/commerce/product/use-product-feeds.html#get-a-list-of-product-threads
  - h2: Get a Product Thread by ID
    url: /doc/commerce/product/use-product-feeds.html#get-a-product-thread-by-id
  - h2: Upgrading to the Latest Version
    url: /doc/commerce/product/use-product-feeds.html#upgrading-to-the-latest-version
  - h2: API Quick Reference
    url: /doc/commerce/product/use-product-feeds.html#api-quick-reference
  - h2: Best Practices
    url: /doc/commerce/product/use-product-feeds.html#best-practices
  - h2: Troubleshooting
    url: /doc/commerce/product/use-product-feeds.html#troubleshooting
  - h2: Terms of Service
    url: /doc/commerce/product/use-product-feeds.html#terms-of-service
  - h2: Contacting the Team
    url: /doc/commerce/product/use-product-feeds.html#contacting-the-team  
  - h2: Glossary
    url: /doc/commerce/product/use-product-feeds.html#glossary
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn-secondary-grey guide-button"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING PRODUCT FEEDS <br>TO YOUR EXPERIENCE

---

##### Last Updated: 01/18/2019

Use the [Product Feeds API](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api) to show relevant Nike product-related content, including details about the products with images, videos, and more.

>**TIP:** Before using this guide, you should have completed [Using NDe APIs](/doc/getting-started/using-nike-apis.html) and [Product Feeds Overview](/doc/commerce/product/overview-product-feeds.html).

## Introduction

The [Product Feeds API](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api) provides product data and content in the form of Cards, Threads, and Feeds.

### What are Cards, Threads, and Feeds?

* **Cards** contain Nike product information or content such as notifications about upcoming Nike events.

* Related Cards are organized into **Threads** that tell a Nike story.

* Multiple Threads can be displayed in **Feeds**, customized for your users based on their chosen preferences in a Nike experience.

For more on Cards, Threads, and Feeds, see the [Product Feeds Confluence Space](https://confluence.nike.com/display/DEN/Product+And+Feeds+API){:target="blank"}.

![](/images/commerce/product_feeds/nike_app_annotated.png)

### What Product Data and Content are Available?

The [Product Feeds API](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api) combines data from many Nike Cloud APIs. To understand the variety of data available, and the sources of data, use the following table:

|Cloud API|Data Type|Examples|Data Source|
|---|---|---|---|
|Merchandised Product Information|Product attributes per style-color, country|styleCode, colorCode, status, genders, sportTags|Prodigy & Product Information Services|
|Merchandised Product Price|Pricing per style-color, country|msrp, currentPrice, discounted, currency|Prodigy & Product Information Services|
|Merchandised Product SKU|SKU-related attributes per style-color-size, country|gtin, nikeSize, localizedSize, commodityCode|Prodigy & Product Information Services|
|Merchandised Product Content|Display-oriented content by style, country|colorDescription, fullTitle, colors, bestFor, athletes, widths|Prodigy & Product Information Services|
|Product Inventory Availability|Inventory availability by style-color|true/false|Sterling|
|SKU Inventory Availability|Inventory availability by style-color-size|true/false|Sterling|
|Published Content|Authored cards and threads|title, seo slug, image URL, video URL, text|Nike CMS (Content Management System)|
|Launch Views|Launch attributes by style-color (SNKRS, Bootroom only)|method, startEntryDate, stopEntryDate|Launch Admin Tool|
|Customized PreBuilds|Customized prebuild (e.g. suggested NikeID shoe design)|designId, status, merchGroup|Consumer experiences, Prodigy|

>**TIP:** Another great way to evaluate the types of data returned is to analyze a [sample API response](https://bitbucket.nike.com/projects/PFA/repos/productfeedv2/browse/API/response/thread/multiple.json){:target="blank"}.

### What are Channels and Why Do I Need One?

A channel is a distinct experience where Nike products are showcased and made available for purchase, e.g. SNKRS, Nike.com. Each channel has a unique **channelId** (channel identifier), which along with **language** and **marketplace**, allows you to get the appropriate data for your experience.

>**TIP:** A Feed can be associated with one or more channels, opening up the personalized Feed to many Nike experiences.

## Get a List of Product Threads

<i class="g72-check"></i>&nbsp;&nbsp;**List all Product Threads for a channel, language, marketplace, feed ID, SEO slug, style-color, gender, keywords, and more**

Now you know what Cards, Threads, and Feeds are, but how do you get them and use them?

To get a list of Threads, execute a request to the [Threads List](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api#threads-threads-list-get){:target="blank"} endpoint, including at minimum the required filter query parameters for **channelId**, **language**, and **marketplace**.

Sample [Threads List](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api#threads-threads-list-get){:target="blank"} request URI:

`https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=language(en)&filter=marketplace(US)`

>**TIPS:**
>- For a list of supported locales, see the [Language/Locale Mapping JSON](https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/localization.json){:target="blank"} and the [Language/Locale Mapping README](https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/README.md){:target="blank"}.
>- For a sample *Threads List* response, see [here](https://bitbucket.nike.com/projects/PFA/repos/productfeedv2/browse/API/response/thread/multiple.json){:target="blank"}.

### How to Get Only the Threads You Need

If there are more threads in the API response than you want, add more specific identifiers to the request as follows.

1. **Filters**

    Use any of the [supported **filter** query parameters](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api) to get more specific results in the response. For example, to only get content for a specific Nike style-color code, append a query parameter like `filter=publishedContent.properties.products.styleColor(942198-700)` to the request URI.

2. **Sorting**
    
    Sort the results using any of the [supported **sort** query parameters](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api). For example, to sort by the current price in ascending order, append query parameter `sort=productInfo.merchPrice.currentPriceAsc` to the request URI.

3. **Fields**

    Request only the fields that you want in the response by using the **fields** query parameter. For example, to return fields threadId, styleColor, and MSRP, append query parameter `fields=id,channelId,productInfo.merchProduct.styleColor,productInfo.merchPrice.msrp` to the request URI.

>**TIP:** The [Product Feeds API Reference](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api) is the source of truth for all supported query parameters.

### Can I Use Product Feeds to Search for Products?

You can use the Product Feeds API for basic product search by including the **searchTerms** query parameter. The API attempts to match the string sent in searchTerms to a fixed set of fields in the product data (see [Product Feeds API Reference](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api) for the list of fields).

However, for a more accurate search, or if you are merchandising a product wall, it's strongly recommended that you use the [Rollup Threads API](https://developer.niketech.com/docs/projects/Product%20Feed%20Rollup%20Threads%20Service%20API%20V2?tab=api). Rollup Threads can be used in conjunction with Smart Search rules to influence the search results based on your specific use case.

See [Adding Rollup Threads to Your Experience](https://developer.niketech.com/nde-docs/doc/commerce/product/use-rollup-threads.html#using-rollup-threads) and [Understanding Search Results](https://developer.niketech.com/nde-docs/doc/commerce/search/use-search.html) for more.

### Terminology Differences Between CMS and Product Feeds

The [Product Feeds API](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api) includes product content from Nike CMS in responses. Nike CMS sometimes uses different names for the same field than Product Feeds. For example, the CMS **collectionGroupId** that you will see in responses is the same as the **channelId** query parameter you might send to Product Feeds.

Here is a terminology guide between Nike CMS and Product Feeds:

|CMS Term|Product Feeds Term|
|---|---|
|Collection Group|Channel|
|Collection|Feed|
|Content/Thread|Thread|
|Node|Card|

### What is the Customized PreBuild Section of the Response?

If you are getting data in the **objects.productInfo.customizedPreBuild** section of the response, then one of the threads that you've requested contains a customizable prebuild product.

A prebuild is a design for a customizable (e.g., NIKEiD) product invented by merchandisers/designers to demonstrate how customers can personalize the product. These "inspiration" designs are merchandised within specific experiences and can be found on product walls, product display pages and in marketing materials.

You will be able to identify the presence of prebuilds when **objects.publishedContent.properties.threadType** field contains the value **nikeid_soldier**.

## Get a Product Thread by ID

<i class="g72-check"></i>&nbsp;&nbsp;**Get a Specific Product Thread by its ID**

Get a single product thread by its unique identifier by executing a request to the [Thread by ID](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api#threads-thread-by-id-get-1) endpoint.

Sample [Thread by ID](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api#threads-thread-by-id-get-1) request URI:

`https://api.nike.com/product_feed/threads/v2/bcbeae50-28a5-404d-9941-fbbdff0c7860`

## Upgrading to the Latest Version

Ready to upgrade to the latest version of the Product Feeds API?

First, some considerations:

- By design, not all v1.x endpoints have a direct v2 equivalent. For example, there are no v2 endpoints which return a list of product channels.

- All endpoints of Product Feeds exclusively feature the GET method, which has no request body, so the focus of each section will be on the differences in the response body only.

- For the 4 endpoints that have both a v1 and a v1.5 (see [Product Feeds v1 API Reference](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API?tab=api){:target="blank"} for details), the response schemas are the same between v1 and v1.5 so the upgrade process to v2 is the same for both.

>**TIP:** Upgrading from CAPI (Commerce API)? See the [CAPI Migration Guide](/doc/commerce/product/capi-migration.html) for detailed instructions.

### V1.x to V2 Endpoint Mapping

The following table lists the v1 endpoints along with the equivalent v2 endpoint for each:

|V1 Endpoint Name|Equivalent V2 Endpoint Name|
|---|---|s
|All Product Channels|None|
|Product Channel by Name|None|
|Product Feed by Feed ID|None|
|All Product Threads|Product Threads List|
|Product Thread by ID|Product Thread by ID|
|Product Thread by Thread ID|None|
|Product Thread by Style-Color|Product Threads List|
|Product Thread by SEO Slug|Product Threads List|
|All Admin Threads|None|
|Product Card by ID|None|

### All Product Threads & Product Thread by ID v1 to v2 Field Mapping

The response structure of the v1 *All Product Threads* and *Product Thread by ID* endpoints is the same, with a few minor exceptions, so for the purposes of upgrading to v2 they can be discussed together.

The following table describes how the response body fields map from the v1 to the v2 endpoints.

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|**country**|Country in which the thread exists|**marketplace**|ISO 3166 two-letter country code for the user's current location||
|**locale**|Locale of the thread content|**language**|BCP-47 language code||
|**channel**|Channel in which the thread exists|**channelId**|UUID for the channel (collectionGroupId)||
|**totalRecords**|Total number of threads that match the criteria|N/A|No equivalent|Deprecated|
|**threads**|Array containing one or more threads that match the critera|**objects**|Array containing one or more threads||
|**id**|Unique identifier for a particular thread|**id**|Unique identifier for the thread|v1 and v2 IDs are not the same, also v2 is in UUID format|
|**threadId**|Unique ID coming from the relative path of the object in AEM/Authoring tool|N/A|No equivalent|Deprecated|
|**interestId**|Unique ID coming from the Social interests|N/A|No equivalent|Deprecated|
|**name**|Name of the thread describing the campaign|publishedContent.properties.**title**|Thread title||
|**createdDate**|Time when the object was created in AEM/Authoring tool|N/A|No equivalent|Deprecated|
|**lastUpdatedDate**|Last time this object was updated|**lastFetchTime**|date-time the data was aggregated, in this ISO-8601 compliant format: `yyyy-MM-ddTHH:mm:ss.SSSZZ`||
|**publishedDate**|The first time any card in this thread should be visible|publishedContent.**publishStartDate**|Date time string of when the publishing schedule is set to start||
|**product**|Object containing product info|**productInfo**|Array of product info||
|product.**id**|Unique ID coming from Merchandised Products API|productInfo.merchProduct.**id**|Unique identifier for the product object||
|product.**interestId**|Unique ID coming from the Social interests|N/A|No equivalent|Deprecated|
|product.**style**|Style identifier for the style of the product|productInfo.merchProduct.**styleCode**|Style code of the product||
|product.**colorCode**|Three-digit color code identifier|productInfo.merchProduct.**colorCode**|Color code of the product||
|product.**globalPid**|Global identifier of the product|productInfo.merchProduct.**pid**|Product identifier for the product||
|product.**fullTitle**|Full title of the product|productInfo.productContent.**fullTitle**|Full title of the product||
|product.**title**|Title of the product|productInfo.productContent.**title**|Title of the product||
|product.**subtitle**|Subtitle of the product|productInfo.productContent.**subtitle**|Subtitle of the product||
|product.**description**|Description of the product|productInfo.productContent.**description**|Description of the product||
|product.**imageUrl**|URL for product images|productInfo.imageURLs.**productImageUrl**|URL for product images||
|product.**genders**|Array of relevant genders for the product|productInfo.merchProduct.**genders**|Genders that the product is for||
|product.**price**|Object containing product price info|productInfo.**merchPrice**|Object containing product price info||
|product.price.**onSale**|Indicates if the product is on clearance or not|productInfo.merchPrice.**discounted**|Indication if the product is on sale||
|product.price.**msrp**|Maximum stated retail price of the product|productInfo.merchPrice.**msrp**|Maximum stated retail price of the product||
|product.price.**fullRetailPrice**|Full retail price of the product|productInfo.merchPrice.**fullPrice**|Full price of the product||
|product.price.**currentRetailPrice**|Current retail price of the product. For discounted products it will be different from fullRetailPrice|productInfo.merchPrice.**currentPrice**|Current price of the product||
|product.price.**formattedFullRetailPrice**|Formatted full retail price|N/A|No equivalent|Deprecated|
|product.price.**formattedCurrentRetailPrice**|Formatted current retail price|N/A|No equivalent|Deprecated|
|product.**estimatedLaunchDate**|Deprecated, do not use|N/A|||
|product.**publishedDate**|Date when a product was published in launch admin tool||||
|product.**quantityLimit**|Quantity limit of the product|productInfo.merchProduct.**quantityLimit**|Quantity limit of the product||
|product.**status**|Status of the product|productInfo.merchProduct.**status**|Status of the product||
|product.**selectionEngine**|Selection engine of the product|N/A|No equivalent|Deprecated|
|product.**colorDescription**|Description of the color of the product|N/A|No equivalent|Deprecated|
|product.**productType**|Type of product|productInfo.merchProduct.**productType**|Type of product||
|product.**salesChannel**|Sales channel of product|productInfo.merchProduct.**channels**|Sales channel of product||
|product.**accessCode**|Boolean indicator for whether access code is required or not|productInfo.merchProduct.**exclusiveAccess**|Boolean indicator for whether access code is required or not||
|product.**startSellDate**|Date when a product is estimated to launch|productInfo.launchView.**startEntryDate** OR product.Info.merchProduct.**commerceStartDate**|Date when launch entries will start being accepted||
|product.**timeToStartSelectionSeconds**|Number of seconds until the product drawing is started|N/A|No equivalent|Deprecated|
|product.**timeToStartSellSeconds**|Number of seconds until the product drawing ends and the product is available to sell|N/A|No equivalent|Deprecated|
|product.**endDrawDate**|Date that the drawing ends|productInfo.launchView.**endEntryDate**|Date when launch entries will stop being accepted||
|product.**waitlineEnabled**|Boolean for whether wait line for the product was enabled or not|N/A|No equivalent|Deprecated|
|product.**available**|Boolean for whether any size of the product is available or not|productInfo.availability.**available**|Boolean for whether any size of the product is available or not||
|product.**sportTags**|Array of sport tags|productInfo.merchProduct.**sportTags**|Array of sport tags||
|product.**skus**|Array of SKU info|productInfo.**skus**|Array of SKU info||
|product.skus.**id**|UUID for the SKU|productInfo.skus.**id**|UUID for the SKU||
|product.skus.**localizedSize**|Localized size for this SKU|productInfo.skus.countrySpecifications.**localizedSize**|Localized size for the SKU||
|product.skus.**nikeSize**|Nike size for this SKU|productInfo.skus.**nikeSize**|Nike size for the SKU||
|product.skus.**available**|Boolean for whether SKU is available for purchase or not|productInfo.availableSkus.**available**|Boolean for whether SKU is available for purchase or not||
|**restricted**|Boolean for whether an access code is tied the thread or not|N/A|No equivalent||
|**feed**|Feeds this thread belongs to|publishedContent.properties.publish.**collections**||Not a true equivalent, but has similar info|
|**title**|Title of the thread|publishedContent.**title**|Title of the thread||
|**subtitle**|Subtitle of the thread|publishedContent.**subtitle**|Subtitle of the thread||
|**imageUrl**|URL where the image exists|publishedContent.properties.coverCard.properties.**landscapeURL**|URL where cover card image exists||
|**altText**|Alt text for the image|publishedContent.properties.coverCard.properties.**altText**|Alt text for the cover card||
|**tabletImageUrl**|URL where the image for the tablet exists|N/A|No equivalent|Deprecated|
|**tabletAltText**|Alt text for the tablet image|N/A|No equivalent|Deprecated|
|**desktopImageUrl**|URL where the image for desktop exists|N/A|No equivalent|Deprecated|
|**desktopAltText**|Alt text for desktop image|N/A|No equivalent|Deprecated|
|**tags**|Array of tags that can be applied to content to relate them|N/A|No equivalent|Deprecated|
|**cards**|Array of card info|publishedContent.**nodes**|Array of card info||
|cards.**country**|Country of the card|N/A|No equivalent|Deprecated|
|cards.**locale**|Locale of the card|N/A|No equivalent|Deprecated|
|cards.**channel**|Channel of the card|N/A|No equivalent|Deprecated|
|cards.**id**|Unique identifier for a particular card|publishedContent.nodes.**id**|Unique identifier for the card||
|cards.**cardId**|Unique ID coming from the relative path of the object in AEM/Authoring tool|N/A|No equivalent|Deprecated|
|cards.**sortOrder**|Order in which the card should appear in the thread|N/A|No equivalent|Deprecated|
|cards.**interestId**|Unique ID coming from the social interests|N/A|No equivalent|Deprecated|
|cards.**type**|Type of card (photo, photo-carousel, video or text)|publishedContent.nodes.**subType**|Type of card||
|cards.**title**|Title of the card|publishedContent.nodes.properties.**title**|Title of the card||
|cards.**subtitle**|Subtitle of the card|publishedContent.nodes.properties.**subtitle**|Subtitle of the card||
|cards.**description**|Description of the card|publishedContent.nodes.properties.**body**|Description of the card||
|cards.**images**|Array of image info related to the card|publishedContent.nodes.**properties**||No distinct section for images, instead evaluate subType field|
|cards.images.**type**|Type of image (card, thread or alternate)|N/A|No equivalent|Deprecated|
|cards.images.**imageUrl**|URL where the image exists|publishedContent.nodes.properties.**portraitURL**||Also available are landscapeURL, squarishURL fields|
|cards.images.**alt**|Alt text for the image|publishedContent.nodes.properties.**altText**|Alt text for the card||
|cards.images.**sortOrder**|Sort order in which images should be displayed|N/A|No equivalent|Deprecated|
|cards.images.**desktopImageUrl**|URL where the image for desktop exists|N/A|No equivalent|Deprecated|
|cards.images.**desktopAltText**|Alt text for desktop image|N/A|No equivalent|Deprecated|
|cards.images.**tabletImageUrl**|URL where the image for the tablet exists|N/A|No equivalent|Deprecated|
|cards.images.**tabletAltText**|Alt text for the tablet image|N/A|No equivalent|Deprecated|
|cards.**videos**|Array of video info for the card|publishedContent.nodes.**properties**||No distinct section for videos, instead evaluate subType field|
|cards.videos.**type**|Type of video object (nikeserver, brightcove or youtube)|publishedContent.nodes.properties.**providerId**|Name of video provider||
|cards.videos.**stillImageUrl**|URL of still image to be shown as placeholder for the video|publishedContent.nodes.properties.**startImageURL**|Still image to be shown as placeholder for the video||
|cards.videos.**videoUrl**|Video URL that can be retrieved to display on the card|publishedContent.nodes.properties.**videoId**|Identifier for the video||
|cards.videos.**alt**|Text string that verbally describes the video for accessibility|publishedContent.nodes.properties.**altText**|Alt text for the card||
|cards.videos.**sortOrder**|Order in which the multiple videos on the card need to be presented|N/A|No equivalent|Deprecated|
|cards.videos.**desktopImageUrl**|URL of still image to be shown as placeholder for the video on a desktop|N/A|No equivalent|Deprecated|
|cards.videos.**desktopAltText**|Text string that verbally describes the video on a desktop|N/A|No equivalent|Deprecated|
|cards.videos.**tabletImageUrl**|URL of still image to be shown as placeholder for the video on a tablet|N/A|No equivalent|Deprecated|
|cards.videos.**tabletAltText**|Text string that verbally describes the video on a tablet|N/A|No equivalent|Deprecated|
|cards.**createdDate**|Time when the object was created in AEM/Authoring tool|N/A|No equivalent|Deprecated|
|cards.**lastUpdatedDate**|Last time this object was updated|N/A|No equivalent|Deprecated|
|cards.**colorHint**|Object containing color hint info|N/A|No equivalent|Deprecated|
|cards.colorHint.**text**|RGB hex color code ranging from 000000 for black to FFFFFF for white|N/A|No equivalent|Deprecated|
|cards.colorHint.**active**|RGB hex color code ranging from 000000 for black to FFFFFF for white|N/A|No equivalent|Deprecated|
|cards.colorHint.**inactive**|RGB hex color code ranging from 000000 for black to FFFFFF for white|N/A|No equivalent|Deprecated|
|cards.colorHint.**pressed**|RGB hex color code ranging from 000000 for black to FFFFFF for white|N/A|No equivalent|Deprecated|
|cards.**cta**|Object containing call-to-action info|publishedContent.nodes.properties.title.actions.**actionType**|Type of call-to-action info||
|cards.cta.**text**|Custom call to action text that can be presented on a content card, when there is no product object associated with it|N/A|No equivalent|Deprecated|
|cards.cta.**buyingTools**|Boolean indicating the need to present buying tools on the card|N/A|No equivalent|Deprecated|
|cards.**iOSOnly**|Flag to indicate if the card is only for IOS|N/A|No equivalent|Deprecated|
|**relations**|Array of related threads data|N/A|No equivalent|Deprecated|
|relations.**name**|Name (RELATED)|N/A|No equivalent|Deprecated|
|relations.**threads**|Identifier (threadId) of related threads|N/A|No equivalent|Deprecated|
|**locations**||N/A|No equivalent|Deprecated|
|**active**|Boolean for whether the thread is active or not|**active**|Boolean for whether the thread is active or not||
|**seoSlug**|The SEO slug of the thread|publishedContent.seo.**slug**|The SEO slug of the thread||
|**seoTitle**|Title tag for SEO|publishedContent.seo.**title**|Title tag for SEO||
|**seoDescription**|Meta description for SEO|publishedContent.seo.**description**|Meta description for SEO||
|**relationalId**||publishedContent.**relationalId**|The ID of the parent thread. Ties various language threads to the source version||
|**socialPattern**||N/A|No equivalent|Deprecated|

>**TIP:** For the v2 URI format and available parameters, see the [Product Thread by ID](#product-thread-by-id) and [Product Threads List](#product-threads-list) sections of this document.

### URL Patterns By Version

The URL pattern used by the Product Feeds API's varies depending on the version, as described here:

**v1**

`https://api.nike.com/commerce/productfeed/products` (Note: no version number indicated in path)

**v1.5**

`https://api.nike.com/commerce/productfeed/products/v1.5`

**v2**

None

>**TIP:** Always check the specific API you are integrating with to confirm the correct URL format. Also, see the URL Patterns section of the [Using NDe APIs](/doc/getting-started/using-nike-apis.html#url-patterns) guide for info on Nike standards.

## API Quick Reference

**Product Feeds v2 Endpoints**

|HTTP Verb|Endpoint Name|Endpoint Description|URI Format|
|---|---|---|---|
|GET|Product Threads List|[Get all threads for a channel, marketplace, language combination](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api)|`/product_feed/threads/v2{?filter,fields,anchor,count,sort,searchTerms}`|
|GET|Product Thread by ID|[Get a specific thread by its identifier](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api)|`/product_feed/threads/v2/{id}{?channel,marketplace,language,fields,preview}`|

## Best Practices

Listed below are some best practices for working with Product Feeds.

### Example Implementation Diagram

Here is an example of a sequence of API calls to get content from Product Feeds v2:

![](/images/commerce/product_feeds/seq_dgm.png)

### Test Environment

Product Feeds v2 has a test environment available at host https://experience.test.commerce.nikecloud.com.

Apart from the host, you can use the same URL, for example: https://experience.test.commerce.nikecloud.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647).

Some considerations about using the test environment:

- The functionality of the API is the same in test vs. production, with the exception of new features that are not yet deployed to production.

- Test has a different set of product data than production, but the test data set is similar. For example, many of the constants are the same in test, i.e. the marketplace, language, and channelId, as they are in production.

- Inventory availability data is scarce in the test environment. At the product level, i.e. the values in **productInfo.availability.available**, might show as 'false' in test most of the time. Availability data at the SKU/size level, i.e. in **productInfo.availableSkus**, is *not* present in test.

- All performance testing activities should be done in test and not in production.

## Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### Use Troubleshooting Tools

- Use the general troubleshooting tips in the [Using NDe APIs](/doc/getting-started/using-nike-apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) such as [this](https://nike.splunkcloud.com/en-US/app/nike_search/search/search?q=search%20index%3Dweb%20environment%3Dprod%20application%3Dproductfeedv2%20source%3D%2Fvar%2Flog%2Fnike%2Fproductfeedv2%2Faccess.log&display.page.search.mode=smart&dispatch.sample_ratio=1&earliest=-1h%40h&latest=now&sid=1518466951.667397_002B2083-7782-48F4-ADBB-A22C4546544D){:target="blank"} to check for issues with your request.

- Use the [Product Feeds v2 Overview](https://insights.newrelic.com/apps/accounts/714737/product-feed-service/dashboards/483419){:target="blank"} dashboard in Insights (requires access) to see if the service is up and healthy.

- Contact the Product Feeds Team on the [#nde-product-feeds](https://nikedigital.slack.com/messages/CAPF62A66){:target="blank"} Slack channel for assistance.

### Common Questions

**Who do I contact with questions about what I'm seeing in the **productInfo** or **publishedContent** sections of the response?**

- The data in **productInfo** and **publishedContent** is not owned by the Product Feeds team. Refer to [Thread Response Ownership Breakdown](https://confluence.nike.com/display/DEN/Thread+Response+Ownership+Breakdown){:target="blank"} to find the Slack channel of the team responsible for that data.

**How do I know what product attributes are available for me to use to request Threads?**

- Unless you are doing a keyword search using the **searchTerms** query parameter, you need to know in advance which product attributes to include in your requests. The source of product attributes (e.g. slugs, 'best for', and other attributes) is Nike's Prodigy system.

**Why isn't my feed showing up?**

- *The feed may have failed validation and was marked inactive*. Only active threads with a valid publish date will be returned by this API. Contact the Product Feeds Team on the [#nde-product-feeds](https://nikedigital.slack.com/messages/CAPF62A66){:target="blank"} Slack channel to check if the feed failed validation and why.

- *The feed might not yet be published*. It can take up to 15 minutes to publish a change from AEM and have it be reflected in the Feeds API.

**Why am I getting an empty 200 response from *Threads List***?

- There might not be any threads that meet the criteria that you specified, particularly when using optional filters. For example, if you send a request with `filter=productInfo.merchProduct.styleCode(999999)` and there are no threads for style code 999999, you will get an empty 200 response.

- The **publishStartDate** for the requested threads might be in the future, or conversely the **publishEndDate** might be in the past. In other words, if today's date is not within the publish start/end range for the thread, the thread will not be returned in the response.

- The **softLaunchDate** on the product is in the future. The softLaunchDate, when present, overrides the publishStartDate, and thus can affect whether the thread is returned or not.

**Why am I getting a 404 error from Thread by ID when I know that the thread ID is valid?**

- Today's date might be outside the publish start/end range for the thread.

- The **catalogId** on the product might be blank. To troubleshoot, send a request to the Merchandised Products API with the affected product ID (e.g. https://api.nike.com/merch/products/v2/c98f12d7-7dee-5775-b4a6-c83d0d2dcb9a) to see if a catalog ID is present or not. If not, that is the reason that the thread is not being returned.

>**TIP:** Be careful not to confuse **legacyCatalogId**, which like **catalogId** is also present in the threads response under **productInfo.merchProduct**, but does not affect thread visibility.

## Terms of Service

It is highly recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of the [Using NDe APIs](/doc/getting-started/using-nike-apis.html#registration) guide on how to create and register your caller ID.

### Authentication

There are no authentication requirements for Product Feeds except when using the **preview** query parameter to preview a Feed or Thread, which is not common. See the [Using Product Feeds v2](#using-product-feeds-v2) section for more details.

## Contacting the Team

Need to contact the Product Feeds team?

|Slack|[#nde-product-feeds](https://nikedigital.slack.com/messages/CAPF62A66){:target="blank"}|
|Confluence Space|[Product and Feeds API](https://confluence.nike.com/display/DEN/Product+And+Feeds+API){:target="blank"}|
|Team Contacts|[Andy Sun](mailto:andy.sun@nike.com)|

## Glossary

See the [Glossary](/doc/commerce/reference/glossary.html).

## Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|01/23/2018|Initial Draft|

## Related Links

[NDe Docs Home](/index.html)

[Get Started](/doc/getting-started/get-started.html)