---
id: use-product-feeds
tags: pdf
category: b-use-case
position: 1
title: Product Feeds
url: /doc/commerce/product/use-product-feeds.html
toc:
  - h2: API at a Glance
    url: /doc/commerce/product/use-product-feeds.html#api-at-a-glance
  - h2: Terms of Service
    url: /doc/commerce/product/use-product-feeds.html#terms-of-service
  - h2: Use Cases
    url: /doc/commerce/product/use-product-feeds.html#use-cases
  - h2: Endpoint Quick Reference
    url: /doc/commerce/product/use-product-feeds.html#api-endpoint-quick-reference
  - h2: Cards, Threads, and Feeds
    url: /doc/commerce/product/use-product-feeds.html#cards-threads-and-feeds
  - h2: Using Product Feeds
    url: /doc/commerce/product/use-product-feeds.html#using-product-feeds
  - h2: Upgrading to the Latest Version
    url: /doc/commerce/product/use-product-feeds.html#upgrading-to-the-latest-version
  - h2: Best Practices
    url: /doc/commerce/product/use-product-feeds.html#best-practices
  - h2: Troubleshooting
    url: /doc/commerce/product/use-product-feeds.html#troubleshooting
  - h2: Glossary
    url: /doc/commerce/product/use-product-feeds.html#glossary
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn ncss-brand guide-button pt2-sm pr5-sm pb2-sm pl5-sm"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING PRODUCT FEEDS <br>TO YOUR EXPERIENCE

---

##### Last Updated: 11/20/2018

If you've read [Using NDe APIs](/doc/getting-started/using-nike-apis.html) and [Product Feeds Overview](/doc/commerce/product/overview-product-feeds.html), this guide provides the additional details necessary to integrate with Product Feeds.

## API at a Glance

Product Feeds enables users of your app to browse a feed of relevant Nike product-related content, including details about the products with images, videos, and more.

|Topic|Details|
|---|---|
|Use this API to|Access Nike product data and content in the form of Cards, Threads, and Feeds|
|Who calls this API?|SNKRS (iOS/Android), Bootroom (Web), Nike.com (Web), Retail Wall (Apple TV)|
|Versions|v2|
|Supported Locales|See [Language/Locale Mapping](https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/localization.json){:target="blank"}|
|SLA|Response time: 250 ms for all endpoints|
|Domain|Commerce|
|Prerequisites|None (public API)|
|Contact Info|Slack: [#nde-product-feeds](https://nikedigital.slack.com/messages/CAPF62A66){:target="blank"}<br>Confluence: [Product and Feeds API](https://confluence.nike.com/display/DEN/Product+And+Feeds+API){:target="blank"}<br>Product Owner: [Andy Sun](mailto:andy.sun@nike.com)|

>**NOTE:** This guide covers the v2 Product Feeds APIs in detail, as well as the process to upgrade from v1.x to v2. The v1.x endpoints are not otherwise covered in this guide.

## Terms of Service

It is highly recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of the [Using NDe APIs](/doc/getting-started/using-nike-apis.html#registration) guide on how to create and register your caller ID.

### Authentication

There are no authentication requirements for Product Feeds except when using the **preview** query parameter to preview a Feed or Thread, which is not common. See the [Using Product Feeds v2](#using-product-feeds-v2) section for more details.

## Use Cases

|I want to...|API(s) to use|
|---|---|
|List all Product Threads for a channel, language, marketplace, feed ID, SEO slug, style-color, gender, keywords, and more|*Threads List*|
|Get a specific Product Thread by its ID|*Product Thread by ID*|

>**TIP:** See the [Threads List](#product-threads-list) section for the full list of use cases. After that, if you still didn't find your product use case, check out the [Merchandised Products API Developer's Guide](/doc/commerce/product/use-merch-product.html) for more.

### Example Implementation Diagram

Here is an example of a sequence of API calls to get content from Product Feeds v2:

![](/images/commerce/product_feeds/seq_dgm.png)

<br>

## API Endpoint Quick Reference

**Product Feeds v2 Endpoints**

|HTTP Verb|Endpoint Name|Endpoint Description|URI Format|
|---|---|---|---|
|GET|Product Threads List|[Get all threads for a channel, marketplace, language combination](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api)|`/product_feed/threads/v2{?filter,fields,anchor,count,sort,searchTerms}`|
|GET|Product Thread by ID|[Get a specific thread by its identifier](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api)|`/product_feed/threads/v2/{id}{?channel,marketplace,language,fields,preview}`|

## Cards, Threads, and Feeds

### What are Cards, Threads, and Feeds?

Use Product Feeds to get product data and content in the form of Cards, Threads, and Feeds.

<i class="g72-plus"></i> **Cards** contain Nike product information or content such as notifications about upcoming Nike events.

<i class="g72-plus"></i> Related Cards are organized into **Threads** that tell a Nike story.

<i class="g72-plus"></i> Multiple Threads make up **Feeds**, customized for your users based on their chosen preferences in a Nike experience.

To summarize, a Feed is comprised of multiple Threads, and within each Thread resides a set of Cards. For an in-depth explanation of Cards, Threads, and Feeds, see the [Product Feeds Confluence Space](https://confluence.nike.com/display/DEN/Product+And+Feeds+API){:target="blank"}.

![](/images/commerce/product_feeds/nike_app_annotated.png)

<br>

### Where Do Cards, Threads, and Feeds Come From?

The Product Feeds API combines product information with product content into Cards, Threads, and Feeds by pulling data from the following Nike Cloud APIs:

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

>**TIP:** The full response from all of the above APIs is passed along to you in the Product Feeds response, i.e. nothing is filtered out by default.

### What are Channels and Why Do I Need One?

A channel is a distinct user experience where Nike products are showcased and made available for purchase, for example in SNKRS or the Nike app. Each channel has a unique **channelId** (channel identifier) that is required by certain Product Feeds API endpoints. This allows the results in responses to be filtered appropriately for your experience.

Each **channelId** value originates in Nike CMS under a different name, **collectionGroupId**.

Each Feed can be associated with one or more channels, opening up the personalized Feed to many Nike experiences.

### Terminology Differences Between CMS and Product Feeds

As mentioned earlier, the Product Feeds API pulls product content from Nike CMS and includes it in responses. One thing to be aware of is that Nike CMS sometimes uses different names for the same field than Product Feeds. For example, the CMS **collectionGroupId** that you will see in responses is synonymous with the **channelId** query parameter you might send to Product Feeds.

Here is a terminology guide between Nike CMS and Product Feeds:

|CMS Term|Product Feeds Term|
|---|---|
|Collection Group|Channel|
|Collection|Feed|
|Content/Thread|Thread|
|Node|Card|

## Using Product Feeds

- [Product Threads List](#product-threads-list)

- [Product Thread by ID](#product-thread-by-id)

- [Product Feeds Error Handling](#product-feeds-error-handling)

The following sections explain each Product Feeds endpoint in detail.

### Product Threads List

List all threads by one or more filter criteria, e.g. channel and style-color.

#### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/product_feed/threads/v2{?filter,fields,anchor,count,sort,searchTerms}`|No|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**filter**|Query|Restrict the response by one or more criteria. **channelId**, **marketplace**, and **language** are required|String|**Required**|
|**fields**|Query|Select the fields to be included in the response|String|Optional|
|**anchor**|Query|Return elements after this anchor|String|Optional|
|**count**|Query|Maximum number of objects to return. Default: 50|String|Optional|
|**sort**|Query|Field(s) by which the results are sorted. Default: **publishedContent.viewStartDateDesc**, then **id.keywordAsc**. See below for allowed sort parameters|String|Optional|
|**searchTerms**|Query|Search for threads by one or more keywords separated with spaces. Request exact match by enclosing in double quotes. Default: partial match|String|Optional|

>**TIP:** For a list of supported locales, see the [Language/Locale Mapping JSON](https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/localization.json){:target="blank"} and the [Language/Locale Mapping README](https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/README.md){:target="blank"}.

##### Allowed Sort Parameters

The following are the allowed fields that can be sent in the **sort** query parameter:

|Sort Field|Description|
|---|---|
|**publishedContent.publishStartDateAsc**|By Content Publish Start Date, Ascending|
|**publishedContent.publishStartDateDesc**|By Content Publish Start Date, Descending|
|**publishedContent.viewStartDateAsc**|By Content View Start Date, Ascending|
|**publishedContent.viewStartDateDesc**|By Content View Start Date, Descending|
|**productInfo.merchProduct.commerceStartDateAsc**|By Commerce Start Date, Ascending|
|**productInfo.merchPrice.currentPriceAsc**|By Current Price, Ascending|
|**productInfo.merchPrice.currentPriceDesc**|By Current Price, Descending|
|**productInfo.merchProduct.commercePublishDateDesc**|By Commerce Publish Date, Descending|
|**effectiveStartSellDateAsc**|By Effective Start Sell Date, Ascending|
|**effectiveStartSellDateDesc**|By Effective Start Sell Date, Descending|
|**lastFetchTimeAsc**|By Last Fetch Time, Ascending|
|**lastFetchTimeDesc**|By Last Fetch Time, Descending|
|**idAsc**|By Thread Id, Ascending|
|**idDesc**|By Thread Id, Descending|

##### Allowed Filter Parameters

The following is a list of scenarios that illustrate which **filter** parameters are supported:

|I Want to List|Sample Query|
|---|---|
|Threads for a channelId, marketplace of US, and language of English|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)|
|Threads for a feed|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=publishedContent.properties.publish.collections(364c1c0e-f67f-45f0-a107-d0a60876d835)|
|Threads for a SEO slug (short text for search engines)|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=publishedContent.properties.seo.slug(sock-dart-university-gold-safari-2017)|
|Threads for a style-color code|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=publishedContent.properties.products.styleColor(942198-700)|
|Threads for a style code|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=productInfo.merchProduct.styleCode(942198)|
|Threads for a color code|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=productInfo.merchProduct.colorCode(001)|
|Threads for a product ID|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=productInfo.merchProduct.id(62404604-1e78-5e53-b8f1-6632543cb986)|
|Threads for a SKU ID|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=skuIds(2852f714-361b-5ce4-a8bf-a33cb0a7240a,fc42d40e-dad8-522f-bd5b-b59890ca2f53)|
|Threads for a Taxonomy ID|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=taxonomyIds(c2ec05f1-f18f-4bf7-8d39-7788feb46ff2)|
|Threads for a gender name|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=productInfo.merchProduct.genders(WOMEN)|
|Threads for a Merch Product channel name|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=productInfo.merchProduct.channels(SNKRS)|
|Threads Merch Product main color|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=productInfo.merchProduct.mainColor(true)|
|Threads for product attribute "best for"|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=productInfo.productContent.bestFor.value(Firm%20Ground)|
|Threads with buyable product|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=inStock(true)|
|Threads with a specific available size|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=availableSizes(9)|
|Threads with a specific available localized size|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=availableLocalizedSizes(27)|
|Threads for an athlete|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=productInfo.productContent.athletes.value(Kobe%20Bryant)|
|Threads for a channel with only selected fields returned|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&fields=publishedContent.properties.products.styleColor,publishedContent.nodes.nodes.properties.squarishURL,productInfo.merchPrice.currentPrice|
|Threads for keywords 'Chuck Taylor'|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&searchTerms=Chuck%20Taylor|
|Threads for a product rollup key|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=productInfo.merchProduct.productRollup.key(YPTArgON)|
|Threads for upcoming products|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=upcoming(true)&sort=productInfo.merchProduct.commerceStartDateAsc|
|Thread for a thread ID|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=id(2efdc3a4-7214-3a88-b1b0-4083dc9657d5))|
|Threads for Exclusive Access products|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=language(en)&filter=marketplace(US)&filter=exclusiveAccess(true,false)|
|Threads for a Global Trade Identification Number (GTIN)|https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=language(en)&filter=marketplace(US)&filter=productInfo.skus.gtin(00884500634190)|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>Use dot notation to indicate nesting while using the fields parameter, e.g. field1.field2. Always start your nesting below the **objects** element of the response structure, so rather than **objects.id** use **id**, for example.
>
><i class="mr2-sm g72-check"></i>Most filters allow comma-separated values to retrieve multiple values at a time: `?filter=productInfo.merchProduct.styleCode(942198,AA1697)`

##### Using Search-Based Queries

Send one or more search keywords in the **searchTerms** query parameter to list only the threads that contain those keywords. In order for a thread to be returned in the response, all included keywords must be found in a searchable field within that thread.

The searchable fields are:

- productInfo.productContent.**fullTitle**
- productInfo.productContent.**title**
- productInfo.productContent.**subtitle**
- publishedContent.properties.consumerLabels.classification.**text**
- productInfo.merchProduct.**styleColor**
- productInfo.merchProduct.**styleCode**

For example, using `searchTerms=Chuck Taylor` returns all threads with the words 'Chuck' and 'Taylor' in a searchable field.

The default search behavior is *partial match*. Limiting the search to only *full string matches* can be done by enclosing the keywords in double quotes, like `searchTerms="Chuck Taylor"`. In this case, the thread must contain the exact full string 'Chuck Taylor' in a searchable field in order to be returned in the response.

##### Pagination and Limits

The Threads List endpoint returns a paginated response when the number of threads found exceeds the count query parameter. If the count query parameter is omitted, the maximum number of threads returned is 50.

The `next` and `prev` URLs are returned in the pages section of the response for paginated results. These URLs include all the parameters originally passed to the endpoint along with an anchor parameter. The anchor parameter in the `prev` URL marks the number in the result set listed first on the previous page. Similarly, the anchor parameter marks the number in the result set listed first on the next page. For instance if you are viewing threads 26 - 50 of 100 paginated results, the anchor parameter in the `prev` URL would be 1 and 51 in the `next` URL.

If the query results contain thousands of items, the max limit that can be paged through is 10,000. When the anchor exceeds 10,000 items you should expect to get an error. This is an intentional limitation imposed on the backend data store for performance reasons. If you make a request whose response would contain the 10,000th item, the next link returned will be empty.

##### What is the Customized PreBuild Section of the Response?

If you are getting data in the **objects.productInfo.customizedPreBuild** section of the response, then one of the threads that you've requested contains a customizable prebuild product.

A prebuild is a design for a customizable (e.g., NIKEiD) product invented by merchandisers/designers to demonstrate how customers can personalize the product. These "inspiration" designs are merchandised within specific experiences and can be found on product walls, product display pages and in marketing materials.

You will be able to identify the presence of prebuilds when **objects.publishedContent.properties.threadType** field contains the value **nikeid_soldier**.

For a sample *Threads List* response body (HTTP 200) see [here](https://bitbucket.nike.com/projects/PFA/repos/productfeedv2/browse/API/response/thread/multiple.json){:target="blank"}.

### Product Thread by ID

Get a Thread by its unique identifier.

#### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/product_feed/threads/v2/{id}{?channel,marketplace,language,fields,preview,includeExclusiveAccess}`|No|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique identifier of the thread in UUID format|String|**Required**|
|**channel**|Query|Sales channel, defaults to 'snkrs'|String|Optional|
|**marketplace**|Query|ISO 3166 two-letter country code, defaults to 'US'|String|Optional|
|**language**|Query|BCP-47 language code, defaults to 'en'|String|Optional|
|**fields**|Query|Select the fields to be included in the response|String|Optional|
|**preview**|Query|Preview a thread that is not yet enabled. Requires **Authorization** header to be sent|String|Optional|
|**includeExclusiveAccess**|Query|Include exclusive and non-exclusive access threads in the results|Boolean|Optional|

>**TIP:** For a list of supported locales, see the [Language/Locale Mapping JSON](https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/localization.json){:target="blank"} and the [Language/Locale Mapping README](https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/README.md){:target="blank"}.

#### Example Scenarios

|I Want to List|Sample Query|
|---|---|
|Single thread by ID|https://api.nike.com/product_feed/threads/v2/bcbeae50-28a5-404d-9941-fbbdff0c7860|
|Single thread by ID (only selected fields returned)|https://api.nike.com/product_feed/threads/v2/bcbeae50-28a5-404d-9941-fbbdff0c7860?fields=publishedContent.properties.coverCard.properties.title,publishedContent.properties.coverCard.properties.landscapeURL|

### Product Feeds Error Handling

Following is a summary of the errors that can come back in responses from the Product Feeds v2 APIs:

|HTTP Response Code|Relevant HTTP Method(s)|Error Message|Action to Take|
|----|----|----|----|
|400|GET|MISSING_REQUIRED|Check the URL for missing path parameter or incorrectly-formatted query parameter. Correct and retry|
|401|GET|Unauthorized|Applies only to thread preview by ID. Check your Authorization header. Correct and retry|
|404|GET|Feed or thread not found|Check the feed ID, thread ID or query parameter value for validity. Correct and retry|
|404|GET|Resource does not exist|Check for malformed URL. Correct and retry|
|500|GET|Internal Server Error|Downstream service does not recognize query parameter, e.g. ?language=foo|

## Upgrading to the Latest Version

Ready to upgrade to the latest version of the Product Feeds API?

First, some considerations:

- By design, not all v1.x endpoints have a direct v2 equivalent. For example, there are no v2 endpoints which return product channels.

- All endpoints of Product Feeds exclusively feature the GET method, which has no request body, so the focus of each section will be on the differences in the response body only.

- For the 4 endpoints that have both a v1 and a v1.5 (see [Product Feeds v1 API Reference](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API?tab=api){:target="blank"} for details), the response schemas are the same between v1 and v1.5 so the upgrade process to v2 is the same for both.

>**TIP:** Upgrading from CAPI (Commerce API)? See the [CAPI Migration Guide](/doc/commerce/product/capi-migration.html) for detailed instructions.

### V1.x to V2 Endpoint Mapping

The following table lists the v1 endpoints along with the equivalent v2 endpoint for each:

|V1 Endpoint Name|Equivalent V2 Endpoint Name|
|---|---|
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

## Best Practices

Listed below are some best practices for working with Product Feeds.

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

## Glossary

See the [Glossary](/doc/commerce/reference/glossary.html).

## Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|01/23/2018|Initial Draft|
|Added upstream contact info|7/5/2018|Linked to 'Thread Response Ownership Breakdown' in Troubleshooting|
|Used valid channelId in examples|7/16/2018|Changed from using invalid to valid channelId (and collectionGroupId) in examples|
|Removed long JSON samples|11/20/2018|Removed long JSON to improve PDF output|

## Related Links

[NDe Docs Home](/index.html)

[Get Started](/doc/getting-started/get-started.html)