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
  - h2: Document Change Log
    url: /doc/commerce/product/use-product-feeds.html#document-change-log
  - h2: Related Links
    url: /doc/commerce/product/use-product-feeds.html#related-links
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING PRODUCT FEEDS TO YOUR EXPERIENCE

---

##### Last Updated: 01/18/2019

**Use the [Product Feeds API](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api){:target="new-tab"} to show relevant Nike product-related content, including details about the products with images, videos, and more**.

>**TIP:** Before using this guide, you should have completed [Using Nike APIs](/doc/getting-started/using-nike-apis.html) and [Product Feeds Overview](/doc/commerce/product/overview-product-feeds.html).

## Introduction

The [Product Feeds API](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api){:target="new-tab"} provides product data and content in the form of Cards, Threads, and Feeds.

### What are Cards, Threads, and Feeds?

[<img style="margin-left:5px; display:inline-block; float:right;" alt="Nike App screenshot" src="/images/commerce/product_feeds/nike_app_annotated_sm.png">](/doc/commerce/product/nike_app_annotated.html)

|**Cards** contain Nike product information or content such as notifications about upcoming Nike events.|
|Related Cards are organized into **Threads** that tell a Nike story.|
|Multiple Threads can be displayed in **Feeds**, customized for your users based on their chosen preferences in a Nike experience.|

For more on Cards, Threads, and Feeds, see the [Product Feeds Confluence Space](https://confluence.nike.com/display/DEN/Product+And+Feeds+API){:target="new-tab"}.

### What Product Data and Content are Available?

The [Product Feeds API](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api){:target="new-tab"} combines data from many Nike Cloud APIs. To understand the variety of data available, and the sources of data, use the following table:

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

>**TIP:** Another great way to evaluate the types of data returned is to analyze a [sample API response](https://bitbucket.nike.com/projects/PFA/repos/productfeedv2/browse/API/response/thread/multiple.json){:target="new-tab"}.

### What are Channels and Why Do I Need One?

A channel is a distinct experience where Nike products are showcased and made available for purchase, e.g. SNKRS, Nike.com. Each channel has a unique **channelId** (channel identifier), which along with **language** and **marketplace**, allows you to get the appropriate data for your experience.

>**TIP:** A Feed can be associated with one or more channels, opening up the personalized Feed to many Nike experiences.

## Get a List of Product Threads

<i class="g72-check"></i>&nbsp;&nbsp;**List all Product Threads for a channel, language, marketplace, feed ID, SEO slug, style-color, gender, keywords, and more**

Now you know what Cards, Threads, and Feeds are, but how do you get them and use them?

To get a list of Threads, execute a request to the [Threads List](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api#threads-threads-list-get){:target="new-tab"} endpoint, including at minimum the required filter query parameters for **channelId**, **language**, and **marketplace**.

Sample [Threads List](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api#threads-threads-list-get){:target="new-tab"} request URI:

`https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=language(en)&filter=marketplace(US)`

>**TIPS:**
>- For a list of supported locales, see the [Language/Locale Mapping JSON](https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/localization.json){:target="new-tab"} and the [Language/Locale Mapping README](https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/README.md){:target="new-tab"}.
>- For a sample *Threads List* response, see [here](https://bitbucket.nike.com/projects/PFA/repos/productfeedv2/browse/API/response/thread/multiple.json){:target="new-tab"}.

### How to Get Only the Threads You Need

If there are more threads in the API response than you want, add more specific identifiers to the request as follows.

1. **Filters**

    Use any of the [supported **filter** query parameters](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api){:target="new-tab"} to get more specific results in the response. For example, to only get content for a specific Nike style-color code, append a query parameter like `filter=publishedContent.properties.products.styleColor(942198-700)` to the request URI.

2. **Sorting**
    
    Sort the results using any of the [supported **sort** query parameters](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api){:target="new-tab"}. For example, to sort by the current price in ascending order, append query parameter `sort=productInfo.merchPrice.currentPriceAsc` to the request URI.

3. **Fields**

    Request only the fields that you want in the response by using the **fields** query parameter. For example, to return fields threadId, styleColor, and MSRP, append query parameter `fields=id,channelId,productInfo.merchProduct.styleColor,productInfo.merchPrice.msrp` to the request URI.

>**TIP:** The [Product Feeds API Reference](https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api){:target="new-tab"} is the source of truth for all supported query parameters.

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

![](/images/commerce/product_feeds/seq_dgm.png){:style="max-width:80%;"}

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

- Use the general troubleshooting tips in the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) such as [this](https://nike.splunkcloud.com/en-US/app/nike_search/search/search?q=search%20index%3Dweb%20environment%3Dprod%20application%3Dproductfeedv2%20source%3D%2Fvar%2Flog%2Fnike%2Fproductfeedv2%2Faccess.log&display.page.search.mode=smart&dispatch.sample_ratio=1&earliest=-1h%40h&latest=now&sid=1518466951.667397_002B2083-7782-48F4-ADBB-A22C4546544D){:target="new-tab"} to check for issues with your request.

- Use the [Product Feeds v2 Overview](https://insights.newrelic.com/apps/accounts/714737/product-feed-service/dashboards/483419){:target="new-tab"} dashboard in Insights (requires access) to see if the service is up and healthy.

- Contact the Product Feeds Team on the [#nde-product-feeds](https://nikedigital.slack.com/messages/CAPF62A66){:target="new-tab"} Slack channel for assistance.

### Common Questions

**Who do I contact with questions about what I'm seeing in the **productInfo** or **publishedContent** sections of the response?**

- The data in **productInfo** and **publishedContent** is not owned by the Product Feeds team. Refer to [Thread Response Ownership Breakdown](https://confluence.nike.com/display/DEN/Thread+Response+Ownership+Breakdown){:target="new-tab"} to find the Slack channel of the team responsible for that data.

**How do I know what product attributes are available for me to use to request Threads?**

- Unless you are doing a keyword search using the **searchTerms** query parameter, you need to know in advance which product attributes to include in your requests. The source of product attributes (e.g. slugs, 'best for', and other attributes) is Nike's Prodigy system.

**Why isn't my feed showing up?**

- The feed may have failed validation and was marked inactive. Only active threads with a valid publish date will be returned by this API. Contact the Product Feeds Team on the [#nde-product-feeds](https://nikedigital.slack.com/messages/CAPF62A66){:target="new-tab"} Slack channel to check if the feed failed validation and why.

- The feed might not yet be published. It can take up to 15 minutes to publish a change from AEM and have it be reflected in the Feeds API.

**Why am I getting an empty 200 response from *Threads List***?

- There might not be any threads that meet the criteria that you specified, particularly when using optional filters. For example, if you send a request with `filter=productInfo.merchProduct.styleCode(999999)` and there are no threads for style code 999999, you will get an empty 200 response.

- The **publishStartDate** for the requested threads might be in the future, or conversely the **publishEndDate** might be in the past. In other words, if today's date is not within the publish start/end range for the thread, the thread will not be returned in the response.

- The **softLaunchDate** on the product is in the future. The softLaunchDate, when present, overrides the publishStartDate, and thus can affect whether the thread is returned or not.

**Why am I getting a 404 error from Thread by ID when I know that the thread ID is valid?**

- Today's date might be outside the publish start/end range for the thread.

- The **catalogId** on the product might be blank. To troubleshoot, send a request to the Merchandised Products API with the affected product ID (e.g. https://api.nike.com/merch/products/v2/c98f12d7-7dee-5775-b4a6-c83d0d2dcb9a) to see if a catalog ID is present or not. If not, that is the reason that the thread is not being returned.

>**TIP:** Be careful not to confuse **legacyCatalogId**, which like **catalogId** is also present in the threads response under **productInfo.merchProduct**, but does not affect thread visibility.

## Terms of Service

It is highly recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#registration) guide on how to create and register your caller ID.

### Authentication

There are no authentication requirements for Product Feeds except when using the **preview** query parameter to preview a Feed or Thread, which is not common. See the [Using Product Feeds v2](#using-product-feeds-v2) section for more details.

## Contacting the Team

Need to contact the Product Feeds team?

|Slack|[#nde-product-feeds](https://nikedigital.slack.com/messages/CAPF62A66){:target="new-tab"}|
|Confluence Space|[Product and Feeds API](https://confluence.nike.com/display/DEN/Product+And+Feeds+API){:target="new-tab"}|
|Team Contacts|[Andy Sun](mailto:andy.sun@nike.com)|

## Document Change Log

|Summary|Date|
|---|---|
|Initial publish|01/23/2018|

## Related Links

- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)