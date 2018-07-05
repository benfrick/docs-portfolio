<link rel="stylesheet" href="https://assets.commerce.nikecloud.com/ncss/glyphs/2.0/css/glyphs.min.css"/>
<link rel="stylesheet" href="https://assets.commerce.nikecloud.com/ncss/0.17/dotcom/desktop/css/ncss.en-us.min.css"/>
<link rel="stylesheet" href="/css/style.css"/>
<script src="/js/nde.js" type="text/javascript"></script>

<!--See Bitbucket (https://bitbucket.nike.com/projects/APID/repos/api-docs/browse/commerce/product/api_product_feeds.md) for version history for this document.

Original Author: Benjamin Frick

SME Consultants: Divya Arunachalam, Mark Keller, Matt Phillips, Cherian John, Brian Jaress, Jeremy Geiger, Andy Sun-->

<div class="guide-nav-container">    <div class="guide-nav-column guide-nav-left">        <a href="/index.html"><i class="g72-arrow-fill-left"></i>&nbsp;<u>Back to NDe Documentation</u></a>    </div>    <div class="guide-nav-column guide-nav-right">        <a href="slack://channel?team=T0G3T5X2B&amp;id=C9Q1MNJ1J" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-black"><i class="g72-alert"></i>&nbsp;FIND AN ISSUE? SLACK US!</a>    </div></div>

# PRODUCT FEEDS API <i class="g72-swoosh"></i><br>DEVELOPER'S GUIDE

##### Last Updated: 07/05/2018<br>Submit Feedback: Dev Portal Slack channel <a href="slack://channel?team=T0G3T5X2B&amp;id=C9Q1MNJ1J">#devportal</a>

---

If you've read [Using NDe APIs](/doc/getting-started/using_nike_apis.html) and [Get Started With Product Feeds](/doc/commerce/product/biz_product_feeds.html), this guide provides the additional details necessary to integrate with Product Feeds.

## **In this guide:**

[API at a Glance](#api-at-a-glance)

[Terms of Service](#terms-of-service)

<span class="toc-pad">[Authentication](#authentication)

[Use Cases](#use-cases)

<span class="toc-pad">[Example Implementation Diagram](#example-implementation-diagram)

[API Endpoint Quick Reference](#api-endpoint-quick-reference)

[What are Cards, Threads, and Feeds?](#what-are-cards-threads-and-feeds)

[Where Do Cards, Threads, and Feeds Come From?](#where-do-cards-threads-and-feeds-come-from)

[What are Channels and Why Do I Need One?](#what-are-channels-and-why-do-i-need-one)

[Terminology Differences Between CMS and Product Feeds](#terminology-differences-between-cms-and-product-feeds)

[Making Your First API Request](#making-your-first-api-request)

[Using Product Feeds v2](#using-product-feeds-v2)

<span class="toc-pad">[Product Threads List](#product-threads-list)

<span class="toc-pad">[Product Thread by ID](#product-thread-by-id)

<span class="toc-pad">[Product Feeds Error Handling](#product-feeds-error-handling)

[Upgrading to the Latest Version](#upgrading-to-the-latest-version)

<span class="toc-pad">[V1.x to V2 Endpoint Mapping](#v1x-to-v2-endpoint-mapping)

<span class="toc-pad">[All Product Feeds & Product Feed by ID v1 to v2 Field Mapping](#all-product-feeds--product-feed-by-id-v1-to-v2-field-mapping)

<span class="toc-pad">[All Product Threads & Product Thread by ID v1 to v2 Field Mapping](#all-product-threads--product-thread-by-id-v1-to-v2-field-mapping)

<span class="toc-pad">[URL Patterns By Version](#url-patterns-by-version)

[Best Practices](#best-practices)

<span class="toc-pad">[Test Environment](#test-environment)

[Troubleshooting](#troubleshooting)

<span class="toc-pad">[Use Troubleshooting Tools](#use-troubleshooting-tools)

<span class="toc-pad">[Common Questions](#common-questions)

[Glossary](#glossary)

[Release Notes](#release-notes)

[Document Change Log](#document-change-log)

[Related Links](#related-links)

## <a name="api-at-a-glance"></a>API at a Glance

Product Feeds enables users of your app to browse a feed of relevant Nike product-related content, including details about the products with images, videos, and more.

|Topic|Details|
|---|---|
|Use this API to|Access Nike product data and content in the form of Cards, Threads, and Feeds|
|Who calls this API?|SNKRS (iOS/Android), Bootroom (Web), Nike.com (Web), Retail Wall (Apple TV)|
|Versions|v2|
|Supported Locales|See <a href="https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/localization.json" target="_blank">Language/Locale Mapping</a>|
|SLA|Response time: 250 ms for all endpoints|
|Domain|Commerce|
|Prerequisites|None (public API)|
|Contact Info|Slack: <a href="https://nikedigital.slack.com/messages/CAPF62A66" target="_blank">#nde-product-feeds</a><br>Confluence: <a href="https://confluence.nike.com/display/DEN/Product+And+Feeds+API" target="_blank">Product and Feeds API</a><br>Product Owner: [Andy Sun](mailto:andy.sun@nike.com)|

>**NOTE:** This guide covers the v2 Product Feeds APIs in detail, as well as the process to upgrade from v1.x to v2. The v1.x endpoints are not otherwise covered in this guide.

## <a name="terms-of-service"></a>Terms of Service

It is highly recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#registration) guide on how to create and register your caller ID.

### <a name="authentication"></a>Authentication

There are no authentication requirements for Product Feeds except when using the **preview** query parameter to preview a Feed or Thread, which is not common. See the [Using Product Feeds v2](#using-product-feeds-v2) section for more details.

## <a name="use-cases"></a>Use Cases

|I want to...|API(s) to use|
|---|---|
|List all Product Threads for a channel, language, marketplace, feed ID, SEO slug, style-color, gender, keywords, and more|*Threads List*|
|Get a specific Product Thread by its ID|*Product Thread by ID*|

>**TIP:** See the [Threads List](#product-threads-list) section for the full list of use cases. After that, if you still didn't find your product use case, check out the [Merchandised Products API Developer's Guide](/doc/commerce/product/api_merch_product.html) for more.

### <a name="example-implementation-diagram"></a>Example Implementation Diagram

Here is an example of a sequence of API calls to get content from Product Feeds v2:

![](/images/commerce/product_feeds/seq_dgm.png)

<br>

## <a name="api-endpoint-quick-reference"></a>API Endpoint Quick Reference

**Product Feeds v2 Endpoints**

|HTTP Verb|Endpoint Name|Endpoint Description|URI Format|
|---|---|---|---|
|GET|Product Threads List|Get all threads for a channel, marketplace, language combination|`/product_feed/threads/v2{?filter,fields,anchor,count,sort,searchTerms}`|
|GET|Product Thread by ID|Get a specific thread by its identifier|`/product_feed/threads/v2/{id}{?channel,marketplace,language,fields,preview}`|

## <a name="what-are-cards-threads-and-feeds"></a>What are Cards, Threads, and Feeds?

Use Product Feeds to get product data and content in the form of Cards, Threads, and Feeds.

<i class="g72-plus"></i> **Cards** contain Nike product information or content such as notifications about upcoming Nike events.

<i class="g72-plus"></i> Related Cards are organized into **Threads** that tell a Nike story.

<i class="g72-plus"></i> Multiple Threads make up **Feeds**, customized for your users based on their chosen preferences in a Nike experience.

To summarize, a Feed is comprised of multiple Threads, and within each Thread resides a set of Cards. For an in-depth explanation of Cards, Threads, and Feeds, see the <a href="https://confluence.nike.com/display/DEN/Product+And+Feeds+API" target="_blank">Product Feeds Confluence Space</a>.

![](/images/commerce/product_feeds/nike_app_annotated.png)

<br>

## <a name="where-do-cards-threads-and-feeds-come-from"></a>Where Do Cards, Threads, and Feeds Come From?

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

## <a name="what-are-channels-and-why-do-i-need-one"></a>What are Channels and Why Do I Need One?

A channel is a distinct user experience where Nike products are showcased and made available for purchase, for example in SNKRS or the Nike app. Each channel has a unique **channelId** (channel identifier) that is required by certain Product Feeds API endpoints. This allows the results in responses to be filtered appropriately for your experience.

Each **channelId** value originates in Nike CMS under a different name, **collectionGroupId**.

Each Feed can be associated with one or more channels, opening up the personalized Feed to many Nike experiences.

>NOTE: The channelIds used in examples in this guide are invalid. In order to submit requests successfully, you need a valid channelId. Work with the Product Feeds Product Owner to inquire about a channelId for your app.

## <a name="terminology-differences-between-cms-and-product-feeds"></a>Terminology Differences Between CMS and Product Feeds

As mentioned earlier, the Product Feeds API pulls product content from Nike CMS and includes it in responses. One thing to be aware of is that Nike CMS sometimes uses different names for the same field than Product Feeds. For example, the CMS **collectionGroupId** that you will see in responses is synonymous with the **channelId** query parameter you might send to Product Feeds.

Here is a terminology guide between Nike CMS and Product Feeds:

|CMS Term|Product Feeds Term|
|---|---|
|Collection Group|Channel|
|Collection|Feed|
|Content/Thread|Thread|
|Node|Card|

## <a name="making-your-first-api-request"></a>Making Your First API Request

For your first API request, call Product Feeds v2 to get a list of all Threads for a particular channel:

**1. Gather the data**

The Product Feeds v2 *Threads List* endpoint only supports the HTTP GET method, so you do not need to send a request body. Only the required request headers and URL query parameters should be sent.

The <a href="https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api" target="_blank">API.md</a> states that there are *no* required request headers and the only required query parameter is **filter** in the format of **?filter=channelId(your_channel_Id_here)**.

>**TIP:** The channelId value is in UUID format

*Don't have a channelId yet? Request that the [Product Owner](#api-at-a-glance) assign one for your app.*

**2. Create the URL**

The <a href="https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api" target="_blank">API.md</a> states that the required URL format is `[/product_feed/threads/v2{?filter,fields,anchor,count}]`.

To build the full URL, prepend `https://api.nike.com` to the above path, then append after 'v2' with the required **filter** query parameter. The resulting full URL would be:

`https://api.nike.com/product_feed/threads/v2?filter="channelId(your_channel_Id_here)"`.

**3. Execute the request**

Test the URL using the Postman app, your favorite browser or cURL. Below is an example of how to call the endpoint via cURL.

```
curl -X GET \
     'https://api.nike.com/product_feed/threads/v2?filter=channelId(your_channel_Id_here)' \
     -H 'cache-control: no-cache'
```

You will receive a response body from the Threads List endpoint similar to the JSON below.

```
{
    "pages": {
      "prev": "",
      "next": ""
    },
    "objects": [
      {
        "id": "80bbdb01-114d-474f-a4e3-99e4e70f4931",
        "marketplace": "US",
        "language": "en",
        "lastFetchTime": "2017-02-23T16:42:00.711Z",
        "publishedContent": {
          "collectionGroupId": "dc8a8c4b-4924-4e13-a04b-ba96b6b72766",
          "marketplace": "US",
          "language": "en",
          "resourceType": "publishedContent",
          "id": "80bbdb01-114d-474f-a4e3-99e4e70f4931",
          "relationalId": "80bbdb01-114d-474f-a4e3-99e4e70f4931",
          "version": "1487089517266",
          "type": "thread",
          "subType": "thread",
          "publishStartDate": "2017-02-10T17:15:00.000Z",
          "publishEndDate": "2999-01-01T08:00:00.000Z",
          "viewStartDate": "2017-02-10T17:15:00.000Z",
          "supportedLanguages": [],
          "properties": {
            "title": "BEHIND THE DESIGN",
            "coverCard": {
              "id": "f97b6bfa-4231-4e69-a3fe-7f83cae4829a",
              "version": "1486746663030",
              "type": "card",
              "subType": "image",
              "properties": {
                "altText": "",
                "colorTheme": "light",
                "landscapeURL": "https://static.nike.com/images/h54tkibftysvmsjkymg9/image.jpg",
                "portraitURL": "",
                "squarishURL": "",
                "subtitle": "Insights from Inside",
                "title": "BEHIND THE DESIGN",
                "custom": {
                  "feedImageOverride": "landscape"
                }
              }
            },
            "subtitle": "",
            "seo": {
              "slug": "behind-the-design"
            },
            "publish": {
              "countries": [
                "US"
              ],
              "collectionGroups": [
                "dc8a8c4b-4924-4e13-a04b-ba96b6b72766"
              ],
              "collections": [
                "514dcaea-b752-11e6-80f5-76304dec7eb7"
              ]
            },
            "threadType": "editorial",
            "products": [],
            "consumerLabels": [],
            "custom": {
              "snkrsDiscover": {
                "order": "6",
                "query": [
                  "Behind the Design"
                ]
              }
            }
          },
          "nodes": [
            {
              "id": "556b8a85-b58d-46ce-bb50-81a17200b44c",
              "version": "1486746676247",
              "type": "card",
              "subType": "image",
              "properties": {
                "landscapeURL": "https://static.nike.com/images/yqbuzhb5zypbdz2jfirn/image.jpg",
                "title": "",
                "colorTheme": "dark",
                "subtitle": "",
                "squarishURL": "",
                "portraitURL": "",
                "altText": "",
                "custom": {
                  "threadImageOverride": "landscape"
                }
              }
            },
            {
              "id": "3b0e3594-2875-48a5-9367-c05110d0d04c",
              "version": "1487089477265",
              "type": "card",
              "subType": "text",
              "properties": {
                "body": "Explore the design process with an inside look at the exclusive designer interviews, original sketches and prototypes.\n",
                "title": "BEHIND THE DESIGN",
                "subtitle": "INSIGHTS FROM THE INSIDE"
              }
            }
          ],
          "links": {
            "self": "/content/threads/v1/80bbdb01-114d-474f-a4e3-99e4e70f4931?collectionGroupId=dc8a8c4b-4924-4e13-a04b-ba96b6b72766&marketplace=US&language=en"
          },
          "classifications": []
        },
        "productInfo": [],
        "resourceType": "thread",
        "links": {
          "self": {
            "ref": "/product_feed/threads/v2/80bbdb01-114d-474f-a4e3-99e4e70f4931?channel=dc8a8c4b-4924-4e13-a04b-ba96b6b72766&marketplace=US&langauge=en"
          }
        }
      }
    ]
  }
  ```

**More Complex Examples**

Next, let's call the Threads List endpoint from the Product Feeds v2 API with a combination of query parameters.

Pretend that you only want to display Thread content for a NBA Finals campaign called "FINALS FRESH" for the US market and you know that the related SEO slug is 'finals-fresh'.

You can send a request with the additional parameters **marketplace**, **language**, and **publishedContentproperties.seo.slug** and get just that.

**filter=marketplace(US)**

**filter=language(en)**

**filter=publishedContent.properties.seo.slug(finals-fresh)**

Your full URL would be:

https://api.nike.com/product_feed/threads/v2?filter=channelId(your_channel_id_here)&filter=marketplace(US)&filter=language(en)&filter=publishedContent.properties.seo.slug(finals-fresh)

Finally, query the Threads List endpoint by the Nike style-color code.

Pretend that you want to display all Threads for a specific soccer boot and you know that the Nike style-color code is AA0612-706.

You can send a request with the parameter **filter=publishedContent.properties.products.styleColor** and include that style-color code:

**filter=publishedContent.properties.products.styleColor(AA0612-706)**

Your full URL would be:

https://api.nike.com/product_feed/threads/v2?filter=channelId(your_channel_here)&filter=marketplace(US)&filter=language(en)&count=50&filter=publishedContent.properties.products.styleColor(AA0612-706)

## <a name="using-product-feeds-v2"></a>Using Product Feeds v2

- [Product Threads List](#product-threads-list)

- [Product Thread by ID](#product-thread-by-id)

- [Product Feeds Error Handling](#product-feeds-error-handling)

The following sections explain each Product Feeds endpoint in detail, concluding with a section on error handling.

### <a name="product-threads-list"></a>Product Threads List

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

>**TIP:** For a list of supported locales, see the <a href="https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/localization.json" target="_blank">Language/Locale Mapping JSON</a> and the <a href="https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/README.md" target="_blank">Language/Locale Mapping README</a>.

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
|Threads for a channelId, marketplace of US, and language of English|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)|
|Threads for a feed|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)&filter=publishedContent.properties.publish.collections(364c1c0e-f67f-45f0-a107-d0a60876d835)|
|Threads for a SEO slug (short text for search engines)|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)&filter=publishedContent.properties.seo.slug(sock-dart-university-gold-safari-2017)|
|Threads for a style-color code|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)&filter=publishedContent.properties.products.styleColor(942198-700)|
|Threads for a style code|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)&filter=productInfo.merchProduct.styleCode(942198)|
|Threads for a color code|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)&filter=productInfo.merchProduct.colorCode(001)|
|Threads for a product ID|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=productInfo.merchProduct.id(62404604-1e78-5e53-b8f1-6632543cb986)|
|Threads for a SKU ID|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=skuIds(2852f714-361b-5ce4-a8bf-a33cb0a7240a,fc42d40e-dad8-522f-bd5b-b59890ca2f53)|
|Threads for a Taxonomy ID|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=taxonomyIds(c2ec05f1-f18f-4bf7-8d39-7788feb46ff2)|
|Threads for a gender name|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)&filter=productInfo.merchProduct.genders(WOMEN)|
|Threads for a Merch Product channel name|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)&filter=productInfo.merchProduct.channels(SNKRS)|
|Threads Merch Product main color|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)&filter=productInfo.merchProduct.mainColor(true)|
|Threads for product attribute "best for"|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)&filter=productInfo.productContent.bestFor.value(Firm%20Ground)|
|Threads with buyable product|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)&filter=inStock(true)|
|Threads with a specific available size|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)&filter=availableSizes(9)|
|Threads with a specific available localized size|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)&filter=availableLocalizedSizes(27)|
|Threads for an athlete|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=marketplace(US)&filter=language(en)&filter=productInfo.productContent.athletes.value(Kobe%20Bryant)|
|Threads for a channel with only selected fields returned|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&fields=publishedContent.properties.products.styleColor,publishedContent.nodes.nodes.properties.squarishURL,productInfo.merchPrice.currentPrice|
|Threads for keywords 'Chuck Taylor'|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&searchTerms=Chuck%20Taylor|
|Threads for a product rollup key|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=productInfo.merchProduct.productRollup.key(YPTArgON)|
|Threads for upcoming products|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=upcoming(true)&sort=productInfo.merchProduct.commerceStartDateAsc|
|Thread for a thread ID|https://api.nike.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=id(2efdc3a4-7214-3a88-b1b0-4083dc9657d5))|
|Threads for Exclusive Access products|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=language(en)&filter=marketplace(US)&filter=exclusiveAccess(true,false)|
|Threads for a Global Trade Identification Number (GTIN)|https://api.nike.com/product_feed/threads/v2?filter=channelId(79a3408f-590e-4f59-a22c-fd00377a6251)&filter=language(en)&filter=marketplace(US)&filter=productInfo.skus.gtin(00884500634190)|

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

'next' and 'prev' URLs are returned in the pages section of the response for paginated results. The `next` and `prev` URLs include all the parameters originally passed to the endpoint along with an anchor parameter. The anchor parameter in the `prev` URL marks the number in the result set listed first on the previous page. Similarly, the anchor parameter marks the number in the result set listed first on the next page. For instance if you are viewing threads 26 - 50 of 100 paginated results, the anchor parameter in the `prev` URL would be 1 and 51 in the `next` URL.

If the query results contain thousands of items, the max limit that can be paged through is 10,000. When the anchor exceeds 10,000 items you should expect to get an error. This is an intentional limitation imposed on the backend data store for performance reasons. If you make a request whose response would contain the 10,000th item, the next link returned will be empty.

#### <a name="threads-list-request-headers"></a>Request Headers

There are no required request headers.

#### <a name="threads-list-request-body"></a>Request Body

There is no body for a GET request.

#### <a name="threads-list-response-body"></a>Response Body

The important elements of the *Threads List* response body are as follows:

>**NOTE**: The **productInfo** array contains responses from up to 8 other APIs, and are formatted according to the same schema as the source APIs. Links are provided to the relevant API.md for you to find the corresponding response schema.

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**pages**|object|Object at top level containing link to previous and next pages of results|Required|
|pages.**prev**|string|Link to previous page of results|Required|
|pages.**next**|string|Link to next page of results|Required|
|**objects**|array|Array at top level containing feed data|Required|
|objects.**id**|string|Unique identifier for the feed in UUID format|Required|
|objects.**channelId**|string|UUID for the channel (collectionGroupId)|Optional|
|objects.**channelName**|string|Human-readable name for the channel|Optional|
|objects.**marketplace**|string|ISO 3166 two-letter country code for the user's current location|Required|
|objects.**language**|string|BCP-47 language code|Required|
|objects.**lastFetchTime**|string|Time when the data was aggregated in ISO-8601 compliant format: `yyyy-MM-ddTHH:mm:ss.SSSZZ`|Required|
|objects.**resourceType**|string|Type of HTTP resource being returned|Required|
|objects.links.self.**ref**|string|Self-link of the HTTP resource|Required|
|objects.**publishedContent**|object|Object containing display-oriented information, such as image links and prose descriptions|Required|
|objects.publishedContent.**collectionGroupId**|string|Identifier for CMS collection group in UUID format. Synonymous to channelId|Optional|
|objects.publishedContent.**marketplace**|string|Marketplace of the thread as ISO 3166 country code format, e.g. 'US'|Optional|
|objects.publishedContent.**language**|string|Language of the thread using BCP 47 format|Optional|
|objects.publishedContent.**id**|string|Thread identifier in UUID format|Required|
|objects.publishedContent.**relationalId**|string|Identifier of parent thread in UUID format. Ties various language threads to the source version|Optional|
|objects.publishedContent.**version**|string|Version of CMS content node|Required|
|objects.publishedContent.**type**|string|Type of content|Required|
|objects.publishedContent.**subtype**|string|Subtype of thread or card|Required|
|objects.publishedContent.**publishStartDate**|string|Date-time string of when the publishing schedule is set to start|Optional|
|objects.publishedContent.**publishEndDate**|string|Date-time string of when the publishing schedule is set to end|Optional|
|objects.publishedContent.**viewStartDate**|string|Date-time string of when the thread can be viewed on client apps|Optional|
|objects.publishedContent.**supportedLanguages**|array|Array containing list of languages that are currently available|Optional|
|objects.publishedContent.**properties**|object|Free-form JSON object that contains properties for the thread|Required|
|objects.publishedContent.properties.**title**|string|Thread title|Optional|
|objects.publishedContent.properties.**products**|array|Array containing thread products|Optional|
|objects.publishedContent.properties.products.**styleColor**|string|Identifier for product style-color, e.g. 831958-616|Optional|
|objects.publishedContent.properties.products.**productId**|string|Product identifier in UUID format|Optional|
|objects.publishedContent.properties.**publish**|array|Array containing relational data about thread|Optional|
|objects.publishedContent.properties.publish.**countries**|array|List of ISO 3166 country codes that the thread has been published to|Optional|
|objects.publishedContent.properties.publish.**collectionGroups**|array|List of collection groups (UUID) that the thread belongs to|Optional|
|objects.publishedContent.properties.publish.**collections**|array|List of collections (UUID) that the thread belongs to|Optional|
|objects.publishedContent.properties.**consumerLabels**|array|Array of tags/classifications on the thread|Optional|
|objects.publishedContent.properties.consumerLabels.**classification**|object|Object containing classification info|Optional|
|objects.publishedContent.properties.consumerLabels.classification.**type**|string|Type of classification, e.g. TAXONOMY|Optional|
|objects.publishedContent.properties.consumerLabels.classification.**id**|string|Identifier of the classification value in UUID format|Optional|
|objects.publishedContent.properties.consumerLabels.classification.**text**|string|Text value for the classification|Optional|
|objects.publishedContent.properties.consumerLabels.**value**|object|Object containing classification value info|Optional|
|objects.publishedContent.properties.consumerLabels.value.**type**|string|Type of classification value, e.g. TAXONOMY|Optional|
|objects.publishedContent.properties.consumerLabels.value.**id**|string|Identifier of the classification value in UUID format|Optional|
|objects.publishedContent.properties.consumerLabels.value.**text**|string|Text for the classification value|Optional|
|objects.publishedContent.properties.**threadType**|string|Type of thread, e.g. product|Optional|
|objects.publishedContent.properties.**relatedThreads**|array|Array containing a list of related threads by their UUIDs|Optional|
|objects.publishedContent.properties.**seo**|object|Object containing SEO info|Optional|
|objects.publishedContent.properties.seo.**title**|string|Title tag for SEO|Optional|
|objects.publishedContent.properties.seo.**description**|string|Meta description for SEO|Optional|
|objects.publishedContent.properties.seo.**slug**|string|URL SEO slug of the thread|Optional|
|objects.publishedContent.properties.**coverCard**|object|Object containing info about the cover card|Optional|
|objects.publishedContent.properties.coverCard.**id**|string|Identifier of cover card in UUID format|Optional|
|objects.publishedContent.properties.coverCard.**version**|string|Specific version number of the cover card|Optional|
|objects.publishedContent.properties.coverCard.**type**|string|Type of content, e.g. card|Optional|
|objects.publishedContent.properties.coverCard.**subType**|string|Subtype of card, e.g. image, video, carousel, text|Optional|
|objects.publishedContent.properties.coverCard.**properties**|object|Free-form JSON object that contains properties for the card|Optional|
|objects.publishedContent.properties.coverCard.properties.**altText**|string|Cover card image alternate text|Optional|
|objects.publishedContent.properties.coverCard.properties.**colorTheme**|string|Cover card image color theme, i.e. dark|Optional|
|objects.publishedContent.properties.coverCard.properties.**landscapeURL**|string|URL for landscape cover card image|Optional|
|objects.publishedContent.properties.coverCard.properties.**portraitURL**|string|URL for portrait cover card image|Optional|
|objects.publishedContent.properties.coverCard.properties.**squarishURL**|string|URL for squarish cover card image|Optional|
|objects.publishedContent.properties.coverCard.properties.**subtitle**|string|Cover card image subtitle|Optional|
|objects.publishedContent.properties.coverCard.properties.**title**|string|Cover card image title|Optional|
|objects.publishedContent.**nodes**|array|Array of card info|Required|
|objects.publishedContent.nodes.**id**|string|Card identifier in UUID format|Optional|
|objects.publishedContent.nodes.**version**|string|Card version identifier|Optional|
|objects.publishedContent.nodes.**type**|string|Card type, i.e. 'card'|Optional|
|objects.publishedContent.nodes.**subType**|string|Card subtype (text, image, video, carousel)|Optional|
|objects.publishedContent.nodes.**properties**|object|Object containing info about the card, varies by card type|Optional|
|objects.publishedContent.nodes.properties.**loop**|boolean|Boolean for whether video will loop or not|Optional|
|objects.publishedContent.nodes.properties.**providerId**|string|Name of video provider|Optional|
|objects.publishedContent.nodes.properties.**subtitle**|string|Subtitle for video|Optional|
|objects.publishedContent.nodes.properties.**colorTheme**|string|Color theme for video, i.e. dark|Optional|
|objects.publishedContent.nodes.properties.**videoId**|string|Identifier for video|Optional|
|objects.publishedContent.nodes.properties.**autoPlay**|boolean|Boolean for whether video will auto-play or not|Optional|
|objects.publishedContent.nodes.properties.**title**|string|Card title|Optional|
|objects.publishedContent.nodes.properties.**body**|string|Card body text|Optional|
|objects.publishedContent.nodes.properties.**actions**|array|Array of action info|Optional|
|objects.publishedContent.nodes.properties.actions.**actionType**|string|Type of action|Optional|
|objects.publishedContent.nodes.properties.actions.**product**|object|Object containing product info for the action|Optional|
|objects.publishedContent.nodes.properties.actions.product.**styleColor**|string|Style-color code|Optional|
|objects.publishedContent.nodes.properties.actions.product.**productId**|string|Product identifier in UUID format|Optional|
|objects.publishedContent.nodes.properties.actions.**destinationType**|string|Type of destination, i.e link|Optional|
|objects.publishedContent.nodes.properties.actions.**destinationId**|string|Identifier for destination, i.e. a URL|Optional|
|objects.publishedContent.nodes.properties.**speed**|string|Speed of video|Optional|
|objects.publishedContent.**classifications**|array|Array of classifications|Optional|
|objects.publishedContent.classifications.**classification**|object|Object containing classification info|Optional|
|objects.publishedContent.classifications.classification.**type**|string|Type of classification|Optional|
|objects.publishedContent.classifications.classification.**id**|string|Identifier of the classification value|Optional|
|objects.publishedContent.classifications.classification.**text**|string|Text value for the classification|Optional|
|objects.publishedContent.classifications.value.**type**|string|Type of classification value|Optional|
|objects.publishedContent.classifications.value.**id**|string|Identifier of the classification value|Optional|
|objects.publishedContent.classifications.value.**text**|string|Text for the classification value|Optional|
|objects.**productInfo**|array|Array of responses from other APIs with product info|Optional|
|objects.productInfo.**merchProduct**|object|<a href="https://developer.niketech.com/docs/projects/Merchandised%20Products%20Service%20API?tab=api" target="_blank">API.md link</a>|Optional|
|objects.productInfo.**merchPrice**|object|<a href="https://developer.niketech.com/docs/projects/Merchandised%20Prices%20Service%20API?tab=api" target="_blank">API.md link</a>|Optional|
|objects.productInfo.**availability**|object|<a href="https://developer.niketech.com/docs/projects/Availability?tab=api" target="_blank">API.md link</a>|Optional|
|objects.productInfo.**productContent**|object|<a href="https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api" target="_blank">API.md link</a>|Optional|
|objects.productInfo.**imageUrls**|object|Object containing product image URL|Optional|
|objects.productInfo.imageUrls.**productImageUrl**|string|URL for product image|Optional|
|objects.productInfo.**skus**|object|<a href="https://developer.niketech.com/docs/projects/Merchandised%20SKUs%20Service%20API?tab=api" target="_blank">API.md link</a>|Optional|
|objects.productInfo.**availableSkus**|object|<a href="https://developer.niketech.com/docs/projects/Availability?tab=api" target="_blank">API.md link</a>|Optional|
|objects.productInfo.**launchView**|object|<a href="https://developer.niketech.com/docs/projects/Launch%20Views?tab=api" target="_blank">API.md link</a>|Optional|
|objects.productInfo.**customizedPreBuild**|object|<a href="https://developer.niketech.com/docs/projects/Customization%20Designs%20and%20Prebuilds%20V1?tab=api" target="_blank">API.md link</a>|Optional|

##### What is the Customized PreBuild Section of the Response?

If you are getting data in the **objects.productInfo.customizedPreBuild** section of the response, then one of the threads that you've requested contains a customizable prebuild product.

A prebuild is a design for a customizable (e.g., NIKEiD) product invented by merchandisers/designers to demonstrate how customers can personalize the product. These "inspiration" designs are merchandised within specific experiences and can be found on product walls, product display pages and in marketing materials.

You will be able to identify the presence of prebuilds when **objects.publishedContent.properties.threadType** field contains the value **nikeid_soldier**.

Sample *Threads List* response body (HTTP 200):

>**TIP:** Scroll to the right to see the entire code snippet.

```
{
    "pages": {
        "prev": "",
        "next": ""
    },
    "objects": [
        {
            "id": "2383e522-7d71-4ad7-8d9f-506aad2d8923",
            "channelId": "dc8a8c4b-4924-4e13-a04b-ba96b6b72766",
            "channelName": "BOOTROOM",
            "marketplace": "US",
            "language": "en",
            "lastFetchTime": "2017-10-19T05:28:29.983Z",
            "active": true,
            "publishedContent": {
                "collectionGroupId": "dc8a8c4b-4924-4e13-a04b-ba96b6b72766",
                "marketplace": "US",
                "language": "en",
                "resourceType": "publishedContent",
                "id": "2383e522-7d71-4ad7-8d9f-506aad2d8923",
                "relationalId": "2383e522-7d71-4ad7-8d9f-506aad2d8923",
                "version": "1498255226090",
                "type": "thread",
                "subType": "thread",
                "publishStartDate": "2017-06-07T19:50:00.000Z",
                "publishEndDate": "3000-01-01T16:00:00.000Z",
                "viewStartDate": "2017-06-07T19:50:00.000Z",
                "supportedLanguages": [
                    "de",
                    "en-GB",
                    "fr",
                    "nl",
                    "cs",
                    "da",
                    "ca",
                    "es-ES",
                    "el",
                    "hu",
                    "it",
                    "pl",
                    "pt-PT",
                    "sv",
                    "zh-Hans",
                    "ja"
                ],
                "properties": {
                    "custom": {},
                    "title": "TIEMPO LEGEND VI SE FG",
                    "products": [
                        {
                            "styleColor": "AA0612-706",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e"
                        }
                    ],
                    "subtitle": " ",
                    "publish": {
                        "countries": [
                            "AT",
                            "BE",
                            "CZ",
                            "DE",
                            "DK",
                            "ES",
                            "FI",
                            "FR",
                            "GB",
                            "GR",
                            "HU",
                            "IE",
                            "IT",
                            "LU",
                            "NL",
                            "PL",
                            "PT",
                            "SE",
                            "SI",
                            "CN",
                            "JP",
                            "US"
                        ],
                        "collectionGroups": [
                            "79a3408f-590e-4f59-a22c-fd00377a6251"
                        ],
                        "collections": [
                            "a4f722b8-e77f-43b3-b909-168e5f43ac60"
                        ]
                    },
                    "consumerLabels": [
                        {
                            "classification": {
                                "type": "TAXONOMY",
                                "id": "a880358e-2cb6-4f11-8cc0-8de12162f648",
                                "text": "Color"
                            },
                            "value": {
                                "type": "TAXONOMY",
                                "id": "c62f73e2-a112-484e-aae4-563aefadca49",
                                "text": "Gold"
                            }
                        },
                        {
                            "classification": {
                                "type": "TAXONOMY",
                                "id": "d6508c32-7d4a-4861-be62-bf28cdb0e72e",
                                "text": "Silo"
                            },
                            "value": {
                                "type": "TAXONOMY",
                                "id": "d443095b-49d6-4a49-80e9-220c80d7e18f",
                                "text": "Tiempo"
                            }
                        },
                        {
                            "classification": {
                                "type": "TAXONOMY",
                                "id": "d81ea26f-df7c-45c8-bc4a-300c37bbcbf1",
                                "text": "Style Name"
                            },
                            "value": {
                                "type": "TAXONOMY",
                                "id": "43c86c3d-3edf-4134-bd30-4e234f051649",
                                "text": "Legend"
                            }
                        },
                        {
                            "classification": {
                                "type": "TAXONOMY",
                                "id": "ed39d5df-144e-4221-979f-acdec01ad858",
                                "text": "Shoe Height"
                            },
                            "value": {
                                "type": "TAXONOMY",
                                "id": "8d81614a-76b0-43a6-ac36-705b117d34fd",
                                "text": "Low Top"
                            }
                        },
                        {
                            "classification": {
                                "type": "TAXONOMY",
                                "id": "a0ae624a-4e4a-47bf-8b7c-ea2a9bfb3df5",
                                "text": "Year"
                            },
                            "value": {
                                "type": "TAXONOMY",
                                "id": "5ce4ba73-630f-41ea-bef9-3aa70a6370b7",
                                "text": "2017"
                            }
                        },
                        {
                            "classification": {
                                "type": "TAXONOMY",
                                "id": "0f223443-18a7-4da1-82ed-334035f03918",
                                "text": "Edition"
                            },
                            "value": {
                                "type": "TAXONOMY",
                                "id": "ceb79b72-d215-453b-a186-7c119ec3a9aa",
                                "text": "Player Edition"
                            }
                        },
                        {
                            "classification": {
                                "type": "TAXONOMY",
                                "id": "7f69c76f-4b72-4864-8393-10f399ce0bdd",
                                "text": "Athlete"
                            },
                            "value": {
                                "type": "TAXONOMY",
                                "id": "af9aa80a-c68a-4d5e-8ea8-e698fca4ba9a",
                                "text": "Francisco Totti"
                            }
                        },
                        {
                            "classification": {
                                "type": "TAXONOMY",
                                "id": "93d3e764-b222-43cb-b94a-574358c9e16c",
                                "text": "Team Global Football Club"
                            },
                            "value": {
                                "type": "TAXONOMY",
                                "id": "985310f9-851b-4d2d-b4b8-10efdc25cad2",
                                "text": "AS Roma"
                            }
                        },
                        {
                            "classification": {
                                "type": "TAXONOMY",
                                "id": "98dba0fb-df14-42c4-a43c-db51eecc134e",
                                "text": "Material"
                            },
                            "value": {
                                "type": "TAXONOMY",
                                "id": "c9214ec5-c7a6-4d9a-9391-444b80901bbf",
                                "text": "Leather"
                            }
                        }
                    ],
                    "threadType": "product",
                    "relatedThreads": [
                        "cf143512-03ab-4f86-866c-47c69035a365",
                        "b41e3514-8176-44ef-a3a6-62d9a47239dd",
                        "01ea3953-f3eb-4160-84e6-4cd41768d2d4",
                        "29806d50-3bea-4074-b49d-15a470db367b",
                        "a726484a-d2ae-4d5e-b90a-005e8f1774cf",
                        "ab73ec83-adcb-46ea-bbf9-4e71d428911d"
                    ],
                    "seo": {
                        "title": "Nike Tiempo Legend 6 'Totti Gladiator'",
                        "description": "Score the Nike Tiempo Legend 6 'Totti Gladiator'. Stay a step ahead of the competition and score the newest releases.",
                        "keywords": "Nike Tiempo Legend 6 'Totti Gladiator'",
                        "slug": "tiempo-legend-6-totti-gladiator"
                    },
                    "coverCard": {
                        "id": "e4e83656-9148-4f56-bbd1-7f5dd6bb624b",
                        "version": "1498255206913",
                        "type": "card",
                        "subType": "image",
                        "properties": {
                            "altText": "Nike Tiempo Legend 6 'Totti Gladiator'",
                            "colorTheme": "light",
                            "landscapeURL": "https://c.static-nike.com/a/images/w_1920,c_limit/cizvemmljfyngf1zxikt/tiempo-totti.jpg",
                            "portraitURL": "",
                            "squarishURL": "https://static.nike.com/images/w_960,c_limit/tcjk3q8of4pg1eqlkdyw/tiempo-totti.jpg",
                            "subtitle": "TIEMPO LEGEND VI SE FG",
                            "title": "TIEMPO TOTTI"
                        }
                    }
                },
                "nodes": [
                    {
                        "id": "92219a2e-1db7-4af1-8a5b-d63af8e9ec39",
                        "version": "1496770012134",
                        "type": "card",
                        "subType": "video",
                        "properties": {
                            "loop": false,
                            "providerId": "brightcove",
                            "subtitle": "",
                            "colorTheme": "dark",
                            "videoId": "5394526689001",
                            "autoPlay": false,
                            "title": ""
                        }
                    },
                    {
                        "id": "2c7f78ff-8cbd-40af-af29-77ab4566aa40",
                        "version": "1496877033307",
                        "type": "card",
                        "subType": "carousel",
                        "properties": {
                            "loop": false,
                            "subtitle": "TIEMPO TOTTI LEGEND VI",
                            "colorTheme": "dark",
                            "autoPlay": false,
                            "title": "LIMITED EDITION",
                            "body": "Celebrate history with the limited edition Tiempo Totti, commemorating one of the most distinguished careers in world football. Having donned the colours of AS Roma for 25 years - scoring 307 goals in 782 appearances - 2500 individually marked pairs recognize Francesco Totti’s unrivaled legacy.",
                            "actions": [
                                {
                                    "actionType": "cta_buying_tools",
                                    "product": {
                                        "styleColor": "AA0612-706",
                                        "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e"
                                    },
                                    "destinationId": "AA0612-706"
                                }
                            ],
                            "speed": 6000
                        },
                        "nodes": [
                            {
                                "id": "8f0743ec-61e9-40c1-a4c6-0d789484e3a7",
                                "version": "1496850820074",
                                "type": "card",
                                "subType": "image",
                                "properties": {
                                    "squarishURL": "https://static.nike.com/images/t_prod_ss/w_960,c_limit/cbztdyhlnfsocwcvii4d/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "altText": "Nike Tiempo Legend 6 'Totti Gladiator'",
                                    "portraitURL": "https://static.nike.com/images/t_prod_ps/w_1536,c_limit/cbztdyhlnfsocwcvii4d/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "landscapeURL": "https://static.nike.com/images/t_prod_ls/w_1920,c_limit/cbztdyhlnfsocwcvii4d/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "subtitle": "",
                                    "custom": {},
                                    "colorTheme": "dark",
                                    "title": ""
                                }
                            },
                            {
                                "id": "cdcebfd0-b478-4cf2-b782-9c20bbe5c9d5",
                                "version": "1496703452040",
                                "type": "card",
                                "subType": "image",
                                "properties": {
                                    "squarishURL": "https://static.nike.com/images/t_prod_ss/w_960,c_limit/a6fucmc3powusybmypcj/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "altText": "Nike Tiempo Legend 6 'Totti Gladiator'",
                                    "portraitURL": "https://static.nike.com/images/t_prod_ps/w_1536,c_limit/a6fucmc3powusybmypcj/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "landscapeURL": "https://static.nike.com/images/t_prod_ls/w_1920,c_limit/a6fucmc3powusybmypcj/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "subtitle": "",
                                    "custom": {},
                                    "colorTheme": "dark",
                                    "title": ""
                                }
                            },
                            {
                                "id": "ebe78c05-57e7-4cfe-bb02-8e0c26e01cd2",
                                "version": "1496703441653",
                                "type": "card",
                                "subType": "image",
                                "properties": {
                                    "squarishURL": "https://static.nike.com/images/t_prod_ss/w_960,c_limit/h28uelvln7kwsgxch8rs/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "altText": "Nike Tiempo Legend 6 'Totti Gladiator'",
                                    "portraitURL": "https://static.nike.com/images/t_prod_ps/w_1536,c_limit/h28uelvln7kwsgxch8rs/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "landscapeURL": "https://static.nike.com/images/t_prod_ls/w_1920,c_limit/h28uelvln7kwsgxch8rs/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "subtitle": "",
                                    "custom": {},
                                    "colorTheme": "dark",
                                    "title": ""
                                }
                            },
                            {
                                "id": "df56862e-5a64-4954-a9fa-9a29fea9fa0f",
                                "version": "1496703445048",
                                "type": "card",
                                "subType": "image",
                                "properties": {
                                    "squarishURL": "https://static.nike.com/images/t_prod_ss/w_960,c_limit/qsicmwkuxsu6drmurmja/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "altText": "Nike Tiempo Legend 6 'Totti Gladiator'",
                                    "portraitURL": "https://static.nike.com/images/t_prod_ps/w_1536,c_limit/qsicmwkuxsu6drmurmja/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "landscapeURL": "https://static.nike.com/images/t_prod_ls/w_1920,c_limit/qsicmwkuxsu6drmurmja/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "subtitle": "",
                                    "custom": {},
                                    "colorTheme": "dark",
                                    "title": ""
                                }
                            },
                            {
                                "id": "b5b5e0bc-42ed-480e-b0d1-83192badfa9c",
                                "version": "1496703449005",
                                "type": "card",
                                "subType": "image",
                                "properties": {
                                    "squarishURL": "https://static.nike.com/images/t_prod_sc/w_960,c_limit/ce5fnqkwewliumljwgze/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "altText": "Nike Tiempo Legend 6 'Totti Gladiator'",
                                    "portraitURL": "https://static.nike.com/images/t_prod_pc/w_1536,c_limit/ce5fnqkwewliumljwgze/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "landscapeURL": "https://static.nike.com/images/t_prod_lc/w_1920,c_limit/ce5fnqkwewliumljwgze/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "subtitle": "",
                                    "custom": {},
                                    "colorTheme": "dark",
                                    "title": ""
                                }
                            },
                            {
                                "id": "dccaf362-6fbe-4c07-98da-738234ebc528",
                                "version": "1496877029514",
                                "type": "card",
                                "subType": "image",
                                "properties": {
                                    "squarishURL": "https://static.nike.com/images/t_prod_ss/w_960,c_limit/zehawckrshwkby0uovf8/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "altText": "Nike Tiempo Legend 6 'Totti Gladiator'",
                                    "portraitURL": "https://static.nike.com/images/t_prod_ps/w_1536,c_limit/zehawckrshwkby0uovf8/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "landscapeURL": "https://static.nike.com/images/t_prod_ls/w_1920,c_limit/zehawckrshwkby0uovf8/nike-tiempo-legend-6-totti-gladiator.jpg",
                                    "subtitle": "",
                                    "custom": {},
                                    "colorTheme": "dark",
                                    "title": ""
                                }
                            }
                        ]
                    },
                    {
                        "id": "e5fc37b3-fd7b-419c-a061-479f26254057",
                        "version": "1496703493505",
                        "type": "card",
                        "subType": "image",
                        "properties": {
                            "squarishURL": "",
                            "altText": "Nike Tiempo Legend 6 'Totti Gladiator'",
                            "portraitURL": "https://static.nike.com/images/w_1536,c_limit/rcc2e1qrdzwz2acpziw9/nike-tiempo-legend-6-totti-gladiator.jpg",
                            "landscapeURL": "https://static.nike.com/images/w_1920,c_limit/jorgvtxjdlgbjvttbjlv/nike-tiempo-legend-6-totti-gladiator.jpg",
                            "subtitle": "",
                            "custom": {},
                            "colorTheme": "dark",
                            "title": ""
                        }
                    },
                    {
                        "id": "63fc4b51-1717-4b88-82ee-c259a9e75261",
                        "version": "1496703509312",
                        "type": "card",
                        "subType": "text",
                        "properties": {
                            "body": "The limited edition version of Totti's Tiempo comes in premium gold, with the player's name etched into the heel. The sockliner sports his team colours with the names 'Totti' and 'Roma' linked by the Roman numeral of Totti's famous number 10 shirt. His number also features on the boot’s tongue, constructed with the Tiempo’s former fold-over style, made famous by the Roma icon who continued to sport this style throughout his career.",
                            "title": "DESIGN DETAILS",
                            "subtitle": ""
                        }
                    },
                    {
                        "id": "57ef7963-968f-417d-82af-4f9f505a0a24",
                        "version": "1496703532958",
                        "type": "card",
                        "subType": "image",
                        "properties": {
                            "squarishURL": "",
                            "altText": "Nike Tiempo Legend 6 'Totti Gladiator'",
                            "portraitURL": "https://static.nike.com/images/w_1536,c_limit/nspchiit8bsfsctx18og/nike-tiempo-legend-6-totti-gladiator.jpg",
                            "landscapeURL": "https://static.nike.com/images/w_1920,c_limit/ore3zh1g0jfptc4vscxj/nike-tiempo-legend-6-totti-gladiator.jpg",
                            "subtitle": "",
                            "custom": {},
                            "colorTheme": "dark",
                            "title": ""
                        }
                    },
                    {
                        "id": "fa378bff-d73d-439c-9c54-22fd8fc3f2d3",
                        "version": "1496703573417",
                        "type": "card",
                        "subType": "text",
                        "properties": {
                            "body": "<p></p><ul><li>Premium kangaroo leather upper supported by an internal midfoot cage for unparalleled lockdown<br></li><li>Kangaroo leather with All Conditions Control (ACC) technology provides unrivaled ball touch and consistent control in dry or wet weather<br></li><li>Flexible plate moves with your foot for stability, traction<span> and comfort</span><br></li><li>Conical and bladed stud configuration enhances traction and underfoot ball control<br></li><li>Internal silicone dot grid grips the insole to prevent slipping<br></li></ul><p></p>",
                            "title": "BENEFITS",
                            "subtitle": ""
                        }
                    },
                    {
                        "id": "6d839350-83d0-4a05-9189-948c68dfd2d7",
                        "version": "1496703600416",
                        "type": "card",
                        "subType": "image",
                        "properties": {
                            "squarishURL": "https://static.nike.com/images/w_960,c_limit/pcepsuarxtyxgv3gricv/nike-tiempo-legend-6-totti-gladiator.png",
                            "altText": "Nike Tiempo Legend 6 'Totti Gladiator'",
                            "portraitURL": "https://static.nike.com/images/w_1536,c_limit/zaibctmj4gixpuzxwkw5/nike-tiempo-legend-6-totti-gladiator.jpg",
                            "landscapeURL": "https://static.nike.com/images/w_1920,c_limit/ku5twv87qii0mg1pspty/nike-tiempo-legend-6-totti-gladiator.jpg",
                            "subtitle": "",
                            "custom": {},
                            "colorTheme": "dark",
                            "title": ""
                        }
                    },
                    {
                        "id": "af4dfc80-a160-4486-9540-8fd088e15503",
                        "version": "1496703641075",
                        "type": "card",
                        "subType": "text",
                        "properties": {
                            "body": "<p><strong>Released: </strong>April 2017</p><p><strong>Official colors:</strong> Metallic Gold/Team Crimson/Black</p><p><strong>Traction options:</strong> FG</p><p><strong>Style number: </strong>AA0612-706</p>",
                            "title": "INFO",
                            "subtitle": ""
                        }
                    },
                    {
                        "id": "d87e862d-6cbe-4db9-bfb0-8ec8a091771d",
                        "version": "1496770041291",
                        "type": "card",
                        "subType": "image",
                        "properties": {
                            "squarishURL": "",
                            "altText": "Nike Tiempo Legend 6 'Totti Gladiator'",
                            "portraitURL": "https://static.nike.com/images/w_1536,c_limit/t2x4p8f9uqnwzvy6ifry/nike-tiempo-legend-6-totti-gladiator.jpg",
                            "landscapeURL": "https://static.nike.com/images/w_1920,c_limit/jomf4sests8oa1pqn2of/nike-tiempo-legend-6-totti-gladiator.jpg",
                            "subtitle": "",
                            "custom": {},
                            "colorTheme": "dark",
                            "title": ""
                        }
                    }
                ],
                "links": {
                    "self": "/content/threads/v1/2383e522-7d71-4ad7-8d9f-506aad2d8923?collectionGroupId=dc8a8c4b-4924-4e13-a04b-ba96b6b72766&marketplace=US&language=en&audienceId=feeds"
                },
                "classifications": [
                    {
                        "classification": {
                            "type": "TAXONOMY",
                            "id": "a880358e-2cb6-4f11-8cc0-8de12162f648",
                            "text": "Color"
                        },
                        "value": {
                            "type": "TAXONOMY",
                            "id": "c62f73e2-a112-484e-aae4-563aefadca49",
                            "text": "Gold"
                        }
                    },
                    {
                        "classification": {
                            "type": "TAXONOMY",
                            "id": "d6508c32-7d4a-4861-be62-bf28cdb0e72e",
                            "text": "Silo"
                        },
                        "value": {
                            "type": "TAXONOMY",
                            "id": "d443095b-49d6-4a49-80e9-220c80d7e18f",
                            "text": "Tiempo"
                        }
                    },
                    {
                        "classification": {
                            "type": "TAXONOMY",
                            "id": "d81ea26f-df7c-45c8-bc4a-300c37bbcbf1",
                            "text": "Style Name"
                        },
                        "value": {
                            "type": "TAXONOMY",
                            "id": "43c86c3d-3edf-4134-bd30-4e234f051649",
                            "text": "Legend"
                        }
                    },
                    {
                        "classification": {
                            "type": "TAXONOMY",
                            "id": "ed39d5df-144e-4221-979f-acdec01ad858",
                            "text": "Shoe Height"
                        },
                        "value": {
                            "type": "TAXONOMY",
                            "id": "8d81614a-76b0-43a6-ac36-705b117d34fd",
                            "text": "Low Top"
                        }
                    },
                    {
                        "classification": {
                            "type": "TAXONOMY",
                            "id": "a0ae624a-4e4a-47bf-8b7c-ea2a9bfb3df5",
                            "text": "Year"
                        },
                        "value": {
                            "type": "TAXONOMY",
                            "id": "5ce4ba73-630f-41ea-bef9-3aa70a6370b7",
                            "text": "2017"
                        }
                    },
                    {
                        "classification": {
                            "type": "TAXONOMY",
                            "id": "0f223443-18a7-4da1-82ed-334035f03918",
                            "text": "Edition"
                        },
                        "value": {
                            "type": "TAXONOMY",
                            "id": "ceb79b72-d215-453b-a186-7c119ec3a9aa",
                            "text": "Player Edition"
                        }
                    },
                    {
                        "classification": {
                            "type": "TAXONOMY",
                            "id": "7f69c76f-4b72-4864-8393-10f399ce0bdd",
                            "text": "Athlete"
                        },
                        "value": {
                            "type": "TAXONOMY",
                            "id": "af9aa80a-c68a-4d5e-8ea8-e698fca4ba9a",
                            "text": "Francisco Totti"
                        }
                    },
                    {
                        "classification": {
                            "type": "TAXONOMY",
                            "id": "93d3e764-b222-43cb-b94a-574358c9e16c",
                            "text": "Team Global Football Club"
                        },
                        "value": {
                            "type": "TAXONOMY",
                            "id": "985310f9-851b-4d2d-b4b8-10efdc25cad2",
                            "text": "AS Roma"
                        }
                    },
                    {
                        "classification": {
                            "type": "TAXONOMY",
                            "id": "98dba0fb-df14-42c4-a43c-db51eecc134e",
                            "text": "Material"
                        },
                        "value": {
                            "type": "TAXONOMY",
                            "id": "c9214ec5-c7a6-4d9a-9391-444b80901bbf",
                            "text": "Leather"
                        }
                    }
                ]
            },
            "productInfo": [
                {
                    "merchProduct": {
                        "id": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                        "snapshotId": "df391f85-5501-4b26-a84b-10fd106c7fa9",
                        "modificationDate": "2017-10-19T05:00:14.679Z",
                        "status": "HOLD",
                        "merchGroup": "US",
                        "styleCode": "AA0612",
                        "colorCode": "706",
                        "styleColor": "AA0612-706",
                        "pid": "11828027",
                        "productGroupId": "11836281",
                        "brand": "Nike",
                        "channels": [],
                        "legacyCatalogIds": [
                            "1"
                        ],
                        "genders": [
                            "MEN"
                        ],
                        "valueAddedServices": [
                            {
                                "id": "47bc9091-2965-5231-b5f1-a7216e249894"
                            }
                        ],
                        "sportTags": [
                            "Soccer/Football"
                        ],
                        "widthGroupIds": [],
                        "classificationConcepts": [],
                        "quantityLimit": 1,
                        "styleType": "INLINE",
                        "productType": "FOOTWEAR",
                        "publishType": "LAUNCH",
                        "mainColor": true,
                        "exclusiveAccess": false,
                        "hardLaunch": true,
                        "commercePublishDate": "2017-04-26T14:00:00.000Z",
                        "commerceStartDate": "2017-04-26T14:00:00.000Z",
                        "softLaunchDate": "2017-04-26T13:00:00.000Z",
                        "resourceType": "merchProduct",
                        "links": {
                            "self": {
                                "ref": "/merch/products/v2/0bd73bdf-d08d-5e32-b419-84a8f697401e"
                            }
                        }
                    },
                    "merchPrice": {
                        "id": "a91cc56d-a830-5ce3-856d-f5ee5ea3cb9a",
                        "snapshotId": "bb209052-9256-470e-b297-d115898d80cb",
                        "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                        "parentId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                        "parentType": "merchProduct",
                        "modificationDate": "2017-06-09T11:11:50.953Z",
                        "country": "US",
                        "msrp": 235,
                        "fullPrice": 235,
                        "currentPrice": 235,
                        "currency": "USD",
                        "discounted": false,
                        "promoInclusions": [],
                        "promoExclusions": [],
                        "resourceType": "merchPrice",
                        "links": {
                            "self": {
                                "ref": "/merch/prices/v2/a91cc56d-a830-5ce3-856d-f5ee5ea3cb9a"
                            }
                        }
                    },
                    "availability": {
                        "id": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                        "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                        "resourceType": "availableProducts",
                        "links": {
                            "self": {
                                "ref": "/deliver/available_products/v1/0bd73bdf-d08d-5e32-b419-84a8f697401e"
                            }
                        },
                        "available": true
                    },
                    "productContent": {
                        "globalPid": "11828027",
                        "langLocale": "en_US",
                        "colorDescription": "Metallic Gold/Team Crimson/Black",
                        "slug": "tiempo-legend-vi-se-firm-ground-soccer-cleat",
                        "fullTitle": "Nike Tiempo Legend VI SE Firm-Ground Soccer Cleat",
                        "title": "Nike Tiempo Legend VI SE FG",
                        "subtitle": "Firm-Ground Soccer Cleat",
                        "descriptionHeading": "DOMINATING TOUCH STARTS FROM WITHIN",
                        "description": "<div class=\"pi-tier3\"><div class=\"pi-pdpmainbody\"><p><b>DOMINATING TOUCH STARTS FROM WITHIN</b></p><br><p>Equipped with innovations that bring your foot closer to the ball than ever, the Nike Tiempo Legend VI SE Firm-Ground Soccer Cleat is made with weather-resistant technologies and premium leather to truly dominate on the field.</p><br><p><b>Benefits</b></p><li>Premium kangaroo leather offers exceptional ball touch</li><li>TPU plate with conical and bladed cleats for stability and multidirectional traction</li><li>All Conditions Control (ACC) technology enhances touch and control in dry or wet weather</li><li>Firm-ground (FG) cleats for use on short-grass fields that may be slightly wet but rarely muddy</li></div></div>",
                        "pdpGeneral": "<div><p>Due to high demand, this color is sold out on Nike.com. Download <a href=\"https://www.nike.com/us/en_us/c/nike-plus/nike-app\" target=\"_blank\">Nike+</a> to receive updates to future product like this.</p>\n</div>",
                        "techSpec": "",
                        "sizeChart": "unisex-shoe-sizing-chart",
                        "colors": [
                            {
                                "type": "SIMPLE",
                                "name": "Gold",
                                "hex": "E9B137"
                            },
                            {
                                "type": "PRIMARY",
                                "name": "Metallic Gold",
                                "hex": "B9A178"
                            },
                            {
                                "type": "SECONDARY",
                                "name": "Team Crimson",
                                "hex": "7A1107"
                            },
                            {
                                "type": "LOGO",
                                "name": "Black",
                                "hex": "13161A"
                            }
                        ],
                        "bestFor": [
                            {
                                "type": "GLOBAL_FOOTBALL_SURFACES",
                                "value": "Firm Ground",
                                "localizedValue": "Firm Ground"
                            }
                        ],
                        "athletes": []
                    },
                    "imageUrls": {
                        "productImageUrl": "https://secure-images.nike.com/is/image/DotCom/AA0612_706"
                    },
                    "skus": [
                        {
                            "id": "c7d6cf1b-6868-530d-b0a0-8466efb85c80",
                            "snapshotId": "36a50acb-f6ac-47d6-9d66-fcfef0c7d9d5",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentType": "merchProduct",
                            "modificationDate": "2017-10-19T05:00:14.679Z",
                            "merchGroup": "US",
                            "stockKeepingUnitId": "19894886",
                            "gtin": "00091206810081",
                            "nikeSize": "7",
                            "countrySpecifications": [
                                {
                                    "country": "US",
                                    "localizedSize": "M 7 / W 8.5",
                                    "taxInfo": {
                                        "commodityCode": "531119.200",
                                        "vat": 0
                                    }
                                }
                            ],
                            "resourceType": "merchSku",
                            "links": {
                                "self": {
                                    "ref": "/merch/skus/v2/c7d6cf1b-6868-530d-b0a0-8466efb85c80?country=US"
                                }
                            }
                        },
                        {
                            "id": "bfed5c68-f3f3-5ed1-9bdf-056624adff68",
                            "snapshotId": "0e1b5393-2292-43bb-822a-4f460558c53c",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentType": "merchProduct",
                            "modificationDate": "2017-10-19T05:00:14.679Z",
                            "merchGroup": "US",
                            "stockKeepingUnitId": "19894885",
                            "gtin": "00091206810098",
                            "nikeSize": "7.5",
                            "countrySpecifications": [
                                {
                                    "country": "US",
                                    "localizedSize": "M 7.5 / W 9",
                                    "taxInfo": {
                                        "commodityCode": "531119.200",
                                        "vat": 0
                                    }
                                }
                            ],
                            "resourceType": "merchSku",
                            "links": {
                                "self": {
                                    "ref": "/merch/skus/v2/bfed5c68-f3f3-5ed1-9bdf-056624adff68?country=US"
                                }
                            }
                        },
                        {
                            "id": "9ec146ca-3914-5945-a37f-643df9f79fa6",
                            "snapshotId": "7ef1e321-4e27-43f9-8b0b-31569b05b278",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentType": "merchProduct",
                            "modificationDate": "2017-10-19T05:00:14.679Z",
                            "merchGroup": "US",
                            "stockKeepingUnitId": "19894884",
                            "gtin": "00091206810104",
                            "nikeSize": "8",
                            "countrySpecifications": [
                                {
                                    "country": "US",
                                    "localizedSize": "M 8 / W 9.5",
                                    "taxInfo": {
                                        "commodityCode": "531119.200",
                                        "vat": 0
                                    }
                                }
                            ],
                            "resourceType": "merchSku",
                            "links": {
                                "self": {
                                    "ref": "/merch/skus/v2/9ec146ca-3914-5945-a37f-643df9f79fa6?country=US"
                                }
                            }
                        },
                        {
                            "id": "f3154985-a434-50e7-9613-e9a08c104574",
                            "snapshotId": "9effdec3-1852-4774-931d-228026d658d2",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentType": "merchProduct",
                            "modificationDate": "2017-10-19T05:00:14.679Z",
                            "merchGroup": "US",
                            "stockKeepingUnitId": "19894888",
                            "gtin": "00091206810333",
                            "nikeSize": "8.5",
                            "countrySpecifications": [
                                {
                                    "country": "US",
                                    "localizedSize": "M 8.5 / W 10",
                                    "taxInfo": {
                                        "commodityCode": "531119.200",
                                        "vat": 0
                                    }
                                }
                            ],
                            "resourceType": "merchSku",
                            "links": {
                                "self": {
                                    "ref": "/merch/skus/v2/f3154985-a434-50e7-9613-e9a08c104574?country=US"
                                }
                            }
                        },
                        {
                            "id": "3bf1bc19-b749-53b1-9ea3-bfe7a252e072",
                            "snapshotId": "be9c0f1d-6116-4ddd-a2a4-68302cb9f36f",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentType": "merchProduct",
                            "modificationDate": "2017-10-19T05:00:14.679Z",
                            "merchGroup": "US",
                            "stockKeepingUnitId": "19894882",
                            "gtin": "00091206810340",
                            "nikeSize": "9",
                            "countrySpecifications": [
                                {
                                    "country": "US",
                                    "localizedSize": "M 9 / W 10.5",
                                    "taxInfo": {
                                        "commodityCode": "531119.200",
                                        "vat": 0
                                    }
                                }
                            ],
                            "resourceType": "merchSku",
                            "links": {
                                "self": {
                                    "ref": "/merch/skus/v2/3bf1bc19-b749-53b1-9ea3-bfe7a252e072?country=US"
                                }
                            }
                        },
                        {
                            "id": "de908099-8245-5127-9741-7a28c4c3b8b4",
                            "snapshotId": "48758ddb-cbc9-4bed-8239-867aec6fd6ef",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentType": "merchProduct",
                            "modificationDate": "2017-10-19T05:00:14.679Z",
                            "merchGroup": "US",
                            "stockKeepingUnitId": "19894881",
                            "gtin": "00091206810357",
                            "nikeSize": "9.5",
                            "countrySpecifications": [
                                {
                                    "country": "US",
                                    "localizedSize": "M 9.5 / W 11",
                                    "taxInfo": {
                                        "commodityCode": "531119.200",
                                        "vat": 0
                                    }
                                }
                            ],
                            "resourceType": "merchSku",
                            "links": {
                                "self": {
                                    "ref": "/merch/skus/v2/de908099-8245-5127-9741-7a28c4c3b8b4?country=US"
                                }
                            }
                        },
                        {
                            "id": "635637c8-b2b2-52f4-a65f-92a83cbf5f14",
                            "snapshotId": "3e6694d2-5119-403f-8c88-fbb5b9895a67",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentType": "merchProduct",
                            "modificationDate": "2017-10-19T05:00:14.679Z",
                            "merchGroup": "US",
                            "stockKeepingUnitId": "19894880",
                            "gtin": "00091206810364",
                            "nikeSize": "10",
                            "countrySpecifications": [
                                {
                                    "country": "US",
                                    "localizedSize": "M 10 / W 11.5",
                                    "taxInfo": {
                                        "commodityCode": "531119.200",
                                        "vat": 0
                                    }
                                }
                            ],
                            "resourceType": "merchSku",
                            "links": {
                                "self": {
                                    "ref": "/merch/skus/v2/635637c8-b2b2-52f4-a65f-92a83cbf5f14?country=US"
                                }
                            }
                        },
                        {
                            "id": "7944ac2c-3013-511f-999a-ee5ef2b57b90",
                            "snapshotId": "1b820565-25f0-4570-afc1-6cd2c6b441f3",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentType": "merchProduct",
                            "modificationDate": "2017-10-19T05:00:14.679Z",
                            "merchGroup": "US",
                            "stockKeepingUnitId": "19894879",
                            "gtin": "00091206811064",
                            "nikeSize": "10.5",
                            "countrySpecifications": [
                                {
                                    "country": "US",
                                    "localizedSize": "M 10.5 / W 12",
                                    "taxInfo": {
                                        "commodityCode": "531119.200",
                                        "vat": 0
                                    }
                                }
                            ],
                            "resourceType": "merchSku",
                            "links": {
                                "self": {
                                    "ref": "/merch/skus/v2/7944ac2c-3013-511f-999a-ee5ef2b57b90?country=US"
                                }
                            }
                        },
                        {
                            "id": "a0d1fcc5-8b27-5a60-abb5-380c069fa536",
                            "snapshotId": "128c913b-3f77-4a8d-a302-2859ceeff596",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentType": "merchProduct",
                            "modificationDate": "2017-10-19T05:00:14.679Z",
                            "merchGroup": "US",
                            "stockKeepingUnitId": "19894878",
                            "gtin": "00091206811071",
                            "nikeSize": "11",
                            "countrySpecifications": [
                                {
                                    "country": "US",
                                    "localizedSize": "M 11 / W 12.5",
                                    "taxInfo": {
                                        "commodityCode": "531119.200",
                                        "vat": 0
                                    }
                                }
                            ],
                            "resourceType": "merchSku",
                            "links": {
                                "self": {
                                    "ref": "/merch/skus/v2/a0d1fcc5-8b27-5a60-abb5-380c069fa536?country=US"
                                }
                            }
                        },
                        {
                            "id": "36608043-cd75-5149-80e3-164a1d24dcb9",
                            "snapshotId": "33a696f9-f0ab-46ac-b142-68e07040827e",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentType": "merchProduct",
                            "modificationDate": "2017-10-19T05:00:14.679Z",
                            "merchGroup": "US",
                            "stockKeepingUnitId": "19894883",
                            "gtin": "00091206811088",
                            "nikeSize": "11.5",
                            "countrySpecifications": [
                                {
                                    "country": "US",
                                    "localizedSize": "M 11.5 / W 13",
                                    "taxInfo": {
                                        "commodityCode": "531119.200",
                                        "vat": 0
                                    }
                                }
                            ],
                            "resourceType": "merchSku",
                            "links": {
                                "self": {
                                    "ref": "/merch/skus/v2/36608043-cd75-5149-80e3-164a1d24dcb9?country=US"
                                }
                            }
                        },
                        {
                            "id": "8f25ea97-b810-56b5-9fd8-a8130ef5478c",
                            "snapshotId": "e12a0944-34b5-4276-8513-5c8fd2091395",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "parentType": "merchProduct",
                            "modificationDate": "2017-10-19T05:00:14.679Z",
                            "merchGroup": "US",
                            "stockKeepingUnitId": "19894887",
                            "gtin": "00091206811095",
                            "nikeSize": "12",
                            "countrySpecifications": [
                                {
                                    "country": "US",
                                    "localizedSize": "M 12 / W 13.5",
                                    "taxInfo": {
                                        "commodityCode": "531119.200",
                                        "vat": 0
                                    }
                                }
                            ],
                            "resourceType": "merchSku",
                            "links": {
                                "self": {
                                    "ref": "/merch/skus/v2/8f25ea97-b810-56b5-9fd8-a8130ef5478c?country=US"
                                }
                            }
                        }
                    ],
                    "availableSkus": [
                        {
                            "id": "c7d6cf1b-6868-530d-b0a0-8466efb85c80",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "resourceType": "availableSkus",
                            "links": {
                                "self": {
                                    "ref": "/deliver/available_skus/v1/c7d6cf1b-6868-530d-b0a0-8466efb85c80"
                                }
                            },
                            "available": false,
                            "skuId": "c7d6cf1b-6868-530d-b0a0-8466efb85c80"
                        },
                        {
                            "id": "bfed5c68-f3f3-5ed1-9bdf-056624adff68",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "resourceType": "availableSkus",
                            "links": {
                                "self": {
                                    "ref": "/deliver/available_skus/v1/bfed5c68-f3f3-5ed1-9bdf-056624adff68"
                                }
                            },
                            "available": false,
                            "skuId": "bfed5c68-f3f3-5ed1-9bdf-056624adff68"
                        },
                        {
                            "id": "9ec146ca-3914-5945-a37f-643df9f79fa6",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "resourceType": "availableSkus",
                            "links": {
                                "self": {
                                    "ref": "/deliver/available_skus/v1/9ec146ca-3914-5945-a37f-643df9f79fa6"
                                }
                            },
                            "available": false,
                            "skuId": "9ec146ca-3914-5945-a37f-643df9f79fa6"
                        },
                        {
                            "id": "f3154985-a434-50e7-9613-e9a08c104574",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "resourceType": "availableSkus",
                            "links": {
                                "self": {
                                    "ref": "/deliver/available_skus/v1/f3154985-a434-50e7-9613-e9a08c104574"
                                }
                            },
                            "available": false,
                            "skuId": "f3154985-a434-50e7-9613-e9a08c104574"
                        },
                        {
                            "id": "3bf1bc19-b749-53b1-9ea3-bfe7a252e072",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "resourceType": "availableSkus",
                            "links": {
                                "self": {
                                    "ref": "/deliver/available_skus/v1/3bf1bc19-b749-53b1-9ea3-bfe7a252e072"
                                }
                            },
                            "available": false,
                            "skuId": "3bf1bc19-b749-53b1-9ea3-bfe7a252e072"
                        },
                        {
                            "id": "de908099-8245-5127-9741-7a28c4c3b8b4",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "resourceType": "availableSkus",
                            "links": {
                                "self": {
                                    "ref": "/deliver/available_skus/v1/de908099-8245-5127-9741-7a28c4c3b8b4"
                                }
                            },
                            "available": true,
                            "skuId": "de908099-8245-5127-9741-7a28c4c3b8b4"
                        },
                        {
                            "id": "635637c8-b2b2-52f4-a65f-92a83cbf5f14",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "resourceType": "availableSkus",
                            "links": {
                                "self": {
                                    "ref": "/deliver/available_skus/v1/635637c8-b2b2-52f4-a65f-92a83cbf5f14"
                                }
                            },
                            "available": false,
                            "skuId": "635637c8-b2b2-52f4-a65f-92a83cbf5f14"
                        },
                        {
                            "id": "7944ac2c-3013-511f-999a-ee5ef2b57b90",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "resourceType": "availableSkus",
                            "links": {
                                "self": {
                                    "ref": "/deliver/available_skus/v1/7944ac2c-3013-511f-999a-ee5ef2b57b90"
                                }
                            },
                            "available": true,
                            "skuId": "7944ac2c-3013-511f-999a-ee5ef2b57b90"
                        },
                        {
                            "id": "a0d1fcc5-8b27-5a60-abb5-380c069fa536",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "resourceType": "availableSkus",
                            "links": {
                                "self": {
                                    "ref": "/deliver/available_skus/v1/a0d1fcc5-8b27-5a60-abb5-380c069fa536"
                                }
                            },
                            "available": false,
                            "skuId": "a0d1fcc5-8b27-5a60-abb5-380c069fa536"
                        },
                        {
                            "id": "36608043-cd75-5149-80e3-164a1d24dcb9",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "resourceType": "availableSkus",
                            "links": {
                                "self": {
                                    "ref": "/deliver/available_skus/v1/36608043-cd75-5149-80e3-164a1d24dcb9"
                                }
                            },
                            "available": false,
                            "skuId": "36608043-cd75-5149-80e3-164a1d24dcb9"
                        },
                        {
                            "id": "8f25ea97-b810-56b5-9fd8-a8130ef5478c",
                            "productId": "0bd73bdf-d08d-5e32-b419-84a8f697401e",
                            "resourceType": "availableSkus",
                            "links": {
                                "self": {
                                    "ref": "/deliver/available_skus/v1/8f25ea97-b810-56b5-9fd8-a8130ef5478c"
                                }
                            },
                            "available": false,
                            "skuId": "8f25ea97-b810-56b5-9fd8-a8130ef5478c"
                        }
                    ]
                }
            ],
            "resourceType": "thread",
            "links": {
                "self": {
                    "ref": "/product_feed/threads/v2/2383e522-7d71-4ad7-8d9f-506aad2d8923?channelId=dc8a8c4b-4924-4e13-a04b-ba96b6b72766&marketplace=US&language=en"
                }
            }
        }
    ]
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/productfeedv2/browse/API.md?raw#!/Threads/get_product_feed_threads_v2" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

<hr>

### <a name="product-thread-by-id"></a>Product Thread by ID

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

>**TIP:** For a list of supported locales, see the <a href="https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/localization.json" target="_blank">Language/Locale Mapping JSON</a> and the <a href="https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/README.md" target="_blank">Language/Locale Mapping README</a>.

#### Example Scenarios

|I Want to List|Sample Query|
|---|---|
|Single thread by ID|https://api.nike.com/product_feed/threads/v2/bcbeae50-28a5-404d-9941-fbbdff0c7860|
|Single thread by ID (only selected fields returned)|https://api.nike.com/product_feed/threads/v2/bcbeae50-28a5-404d-9941-fbbdff0c7860?fields=publishedContent.properties.coverCard.properties.title,publishedContent.properties.coverCard.properties.landscapeURL|

#### <a name="thread-by-id-request-headers"></a>Request Headers

There are no required request headers.

#### <a name="thread-by-id-request-body"></a>Request Body

There is no body for a GET request.

#### <a name="thread-by-id-response-body"></a>Response Body

The structure of the response from *Thread by ID* is the same as *Threads List* with the following exceptions:

- No **pages** section at top

- No **objects** wrapper around the thread data

See Threads List for response body details.

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/productfeedv2/browse/API.md?raw#!/Threads/get_product_feed_threads_v2_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

<hr>

### <a name="product-feeds-error-handling"></a>Product Feeds Error Handling

Following is a summary of the errors that can come back in responses from the Product Feeds v2 APIs:

|HTTP Response Code|Relevant HTTP Method(s)|Error Message|Action to Take|
|----|----|----|----|
|400|GET|MISSING_REQUIRED|Check the URL for missing path parameter or incorrectly-formatted query parameter. Correct and retry|
|401|GET|Unauthorized|Applies only to thread preview by ID. Check your Authorization header. Correct and retry|
|404|GET|Feed or thread not found|Check the feed ID, thread ID or query parameter value for validity. Correct and retry|
|404|GET|Resource does not exist|Check for malformed URL. Correct and retry|
|500|GET|Internal Server Error|Downstream service does not recognize query parameter, e.g. ?language=foo|

## <a name="upgrading-to-the-latest-version"></a>Upgrading to the Latest Version

Ready to upgrade to the latest version of the Product Feeds API? All clients of Product Feeds v1 are expected to migrate to v2 by **March 31st, 2018**.

First, some considerations:

- By design, not all v1.x endpoints have a direct v2 equivalent. For example, there are no v2 endpoints which return product channels.

- All endpoints of Product Feeds exclusively feature the GET method, which has no request body, so the focus of each section will be on the differences in the response body only.

- For the 4 endpoints that have both a v1 and a v1.5 (see <a href="https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API?tab=api" target="_blank">Product Feeds v1 API.md</a> for details), the response schemas are the same between v1 and v1.5 so the upgrade process to v2 is the same for both.

>**TIP:** Upgrading from CAPI (Commerce API)? See the <a href="/doc/commerce/product/capi_migration.html" target="_blank">CAPI Migration Guide</a> for detailed instructions.

### <a name="v1x-to-v2-endpoint-mapping"></a>V1.x to V2 Endpoint Mapping

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

### <a name="all-product-threads--product-thread-by-id-v1-to-v2-field-mapping"></a>All Product Threads & Product Thread by ID v1 to v2 Field Mapping

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

### <a name ="url-patterns-by-version"></a>URL Patterns By Version

The URL pattern used by the Product Feeds API's varies depending on the version, as described here:

**v1**

`https://api.nike.com/commerce/productfeed/products` (Note: no version number indicated in path)

**v1.5**

`https://api.nike.com/commerce/productfeed/products/v1.5`

**v2**

None

>**TIP:** Always check the specific API you are integrating with to confirm the correct URL format. Also, see the URL Patterns section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#url-patterns) guide for info on Nike standards.

## <a name="best-practices"></a>Best Practices

Listed below are some best practices for working with Product Feeds.

### <a name="test-environment"></a>Test Environment

Product Feeds v2 has a test environment available at host https://experience.test.commerce.nikecloud.com.

Apart from the host, you can use the same URL, for example: https://experience.test.commerce.nikecloud.com/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=channelId(b300bc43-bf2f-4b34-8942-fdc6f95653f9).

Some considerations about using the test environment:

- The functionality of the API is the same in test vs. production, with the exception of new features that are not yet deployed to production.

- Test has a different set of product data than production, but the test data set is similar. For example, many of the constants are the same in test, i.e. the marketplace, language, and channelId, as they are in production.

- Inventory availability data is scarce in the test environment. At the product level, i.e. the values in **productInfo.availability.available**, might show as 'false' in test most of the time. Availability data at the SKU/size level, i.e. in **productInfo.availableSkus**, is *not* present in test.

- All performance testing activities should be done in test and not in production.

## <a name="troubleshooting"></a>Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### <a name="use-troubleshooting-tools"></a>Use Troubleshooting Tools

- Use the general troubleshooting tips in the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) such as <a href="https://cdt-eng.splunkcloud.com/en-US/app/search/search?q=search%20index%3Dweb%20environment%3Dprod%20application%3Dproductfeedv2%20source%3D%2Fvar%2Flog%2Fnike%2Fproductfeedv2%2Faccess.log&display.page.search.mode=smart&dispatch.sample_ratio=1&earliest=-1h%40h&latest=now&sid=1518466951.667397_002B2083-7782-48F4-ADBB-A22C4546544D" target="_blank">this</a> to check for issues with your request.

- Use the <a href="https://insights.newrelic.com/apps/accounts/714737/product-feed-service/dashboards/483419" target="_blank">Product Feeds v2 Overview</a> dashboard in Insights (requires access) to see if the service is up and healthy.

- Contact the Product Feeds Team on the <a href="https://nikedigital.slack.com/messages/C0KEN0WQG">#cic-merch</a> Slack channel for assistance.

### Common Questions

**Who do I contact with questions about what I'm seeing in the **productInfo** or **publishedContent** sections of the response?**

- The data in **productInfo** and **publishedContent** is not owned by the Product Feeds team. Refer to <a href="https://confluence.nike.com/display/DEN/Thread+Response+Ownership+Breakdown" target="_blank">Thread Response Ownership Breakdown</a> to find the Slack channel of the team responsible for that data.

**How do I know what product attributes are available for me to use to request Threads?**

- Unless you are doing a keyword search using the **searchTerms** query parameter, you need to know in advance which product attributes to include in your requests. The source of product attributes (e.g. slugs, 'best for', and other attributes) is Nike's Prodigy system.

**Why isn't my feed showing up?**

- *The feed may have failed validation and was marked inactive*. Only active threads with a valid publish date will be returned by this API. Contact the Product Feeds Team on the <a href="https://nikedigital.slack.com/messages/C0KEN0WQG" target="_blank">#cic-merch</a> Slack channel to check if the feed failed validation and why.

- *The feed might not yet be published*. It can take up to 15 minutes to publish a change from AEM and have it be reflected in the Feeds API.

**Why am I getting an empty 200 response from *Threads List***?

- There might not be any threads that meet the criteria that you specified, particularly when using optional filters. For example, if you send a request with `filter=productInfo.merchProduct.styleCode(999999)` and there are no threads for style code 999999, you will get an empty 200 response.

- The **publishStartDate** for the requested threads might be in the future, or conversely the **publishEndDate** might be in the past. In other words, if today's date is not within the publish start/end range for the thread, the thread will not be returned in the response.

- The **softLaunchDate** on the product is in the future. The softLaunchDate, when present, overrides the publishStartDate, and thus can affect whether the thread is returned or not.

**Why am I getting a 404 error from Thread by ID when I know that the thread ID is valid?**

- Today's date might be outside the publish start/end range for the thread.

- The **catalogId** on the product might be blank. To troubleshoot, send a request to the Merchandised Products API with the affected product ID (e.g. https://api.nike.com/merch/products/v2/c98f12d7-7dee-5775-b4a6-c83d0d2dcb9a) to see if a catalog ID is present or not. If not, that is the reason that the thread is not being returned.

>**TIP:** Be careful not to confuse **legacyCatalogId**, which like **catalogId** is also present in the threads response under **productInfo.merchProduct**, but does not affect thread visibility.

## <a name="glossary"></a>Glossary

See the [Glossary](/doc/getting-started/glossary.html).

## <a name="release-notes"></a>Release Notes

No release notes available

## <a name="document-change-log"></a>Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|01/23/2018|Initial Draft|
|Updates per template|02/9/2018|Added new allowed values for **sort** and **filter** query params, added new **includeExclusiveAccess** query param|
|Layout updates|02/12/2018|Changed layout to meet new API Doc standards, added Troubleshooting content|
|Updated links|03/20/2018|Updated links to point to new dev portal|
|Updated external links|04/03/2018|Updated external links to open in new browser window|
|Updated API.md links|05/14/2018|Updated API.md links to point to new dev portal|
|Updated request/response content|07/02/2018|Added required/optional and data type columns to request/response tables|
|Removed endpoints|7/3/2018|Removed references to the deprecated product_feed/feed endpoints|
|Added upstream contact info|7/5/2018|Linked to 'Thread Response Ownership Breakdown' in Troubleshooting|

## <a name="related-links"></a>Related Links

[NDe Documentation Home](/index.html)

[Getting Started](/doc/portal/consuming.html)

[Business Guides](/doc/portal/biz-guides.html)

[Developer's Guides](/doc/portal/dev-guides.html)