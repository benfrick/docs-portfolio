---
tags: pdf
category: b-use-case
position: 8
title: Merch Product
url: /doc/commerce/product/api_merch_product.html
toc:
  - h2: API at a Glance
    url: /doc/commerce/product/api_merch_product.html#api-at-a-glance
  - h2: Terms of Service
    url: /doc/commerce/product/api_merch_product.html#terms-of-service
  - h2: Use Cases
    url: /doc/commerce/product/api_merch_product.html#use-cases
  - h2: Endpoint Quick Reference
    url: /doc/commerce/product/api_merch_product.html#api-endpoint-quick-reference
  - h2: Consider Using Product Feeds
    url: /doc/commerce/product/api_merch_product.html#consider-using-product-feeds
  - h2: Gathering a Product Data Set
    url: /doc/commerce/product/api_merch_product.html#gathering-a-product-data-set
  - h2: Understanding Nike Product Data
    url: /doc/commerce/product/api_merch_product.html#understanding-nike-product-data
  - h2: Merchandised Products Concepts
    url: /doc/commerce/product/api_merch_product.html#merchandised-product-concepts
  - h2: International Considerations
    url: /doc/commerce/product/api_merch_product.html#international-considerations
  - h2: Making Your First Request
    url: /doc/commerce/product/api_merch_product.html#making-your-first-api-request
  - h2: Using Merchandised Products
    url: /doc/commerce/product/api_merch_product.html#using-merchandised-products
  - h2: Using Merchandised Product SKUs
    url: /doc/commerce/product/api_merch_product.html#using-merchandised-product-skus
  - h2: Using Merchandised Prices
    url: /doc/commerce/product/api_merch_product.html#using-merchandised-product-prices
  - h2: Using Merchandised VAS
    url: /doc/commerce/product/api_merch_product.html#using-merchandised-vas
  - h2: Using Product Content
    url: /doc/commerce/product/api_merch_product.html#using-product-content
  - h2: Upgrading to the Latest Version
    url: /doc/commerce/product/api_merch_product.html#upgrading-to-the-latest-version
  - h2: Troubleshooting
    url: /doc/commerce/product/api_merch_product.html#troubleshooting
  - h2: Glossary
    url: /doc/commerce/product/api_merch_product.html#glossary
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn ncss-brand guide-button pt2-sm pr5-sm pb2-sm pl5-sm"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# MERCHANDISED PRODUCTS <i class="g72-swoosh"></i><br>DEVELOPER'S GUIDE

---

##### Last Updated: 10/01/2018

If you've read [Using NDe APIs](/doc/getting-started/using_nike_apis.html), this guide provides the details necessary to integrate with the Nike Merchandised Products APIs.

## API at a Glance

The <b>Merchandised Products API</b> is a set of REST services that provides Nike product data in JSON format. You can list product information such as product attributes, SKU data, prices, product content, product images, and value-added services (VAS).

The following table describes the key details of the API:

|Topic|Details|
|---|---|
|Use this API to|List product and SKU details, pricing, value-added services|
|Who calls this API|Examples include Product Feed API, SNKRs App, CMS, and the Inventory domain|
|Current Version|Merchandised Products Service v2<br>Merchandised SKUs Service v2<br>Merchandised Prices Service v2<br>Merchandised Value-Added Services v1<br>Product Content Service v1|
|Scope/Limitations|<br>NIKEiD is not supported. Although NIKEiD Master products are available in the Merchandised Products API, NIKEiD Prebuild products and paths are not supported. These are required to properly render the NIKEiD experience.<br>Retail data product is available, but not supported. Contact the Product Owner for details.<br>Bulk download of all product data is not supported.<br>Nike Outfits are not supported.<br>No product data metrics are currently sent to Analytics (Business Intelligence).<br>The v2 Merchandised Products SKUs service does not determine if a SKU is in stock. Use the Inventory API to determine if a SKU has inventory.|
|SLAs|Response time (RT) and request per second (RPS): <br>RT: 250ms <br>RPS: 500ms|
|Domain|Commerce|
|Prerequisites|[API Registration](/doc/getting-started/using_nike_apis.html#registration)|
|Contact Info|Slack [#pdm-merch-product](https://nikedigital.slack.com/messages/pdm-merch-product){:target="blank"}<br>Confluence space: [Merchandised Products API Team](https://confluence.nike.com/collector/pages.action?key=MPA){:target="blank"}<br> Mailing List: [Lst-nde.pdm.merch.dev@nike.com](mailto:Lst-digitaltech.merch.apis)<br>Product Owner: [Arun KannanGeetha](mailto:arun.kannangeetha@nike.com)|

## Terms of Service

To use the Merchandised Products API, you must send a caller ID header in every API request to help troubleshoot unexpected responses. See the Registration section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#registration) guide on how to create your caller ID.

### Authentication Requirements

If you are retrieving products that are publicly available, no authentication or authorization is required. If you need product data that is not available to the public and you are an internal Nike team, you can contact the Product Owner for details on setting up authentication.

## Use Cases

|I want to...|API(s) to use|
|---|---|
|List merchandised product information such as product state, gender, merchandising tags, product type, and launch dates for a list of style-colors|Merchandised Products API|
|List the prices of a style-color in a certain country<br/>Includes retail price, employee price, sale price, current price, and MSRP|Merchandised Products API<p>Price API|
|List all products that can be gift wrapped<p>Returns all value-added services of products that can be gift wrapped|Merchandised Value-Added Services API|
|List the sizes and SKU detail such as Nike size, localized size description, value-added tax (VAT) and Commodity Code for a style-color|Merchandised Products API<br/>Merchandised SKUs API|
|List the available images and localized product information such as title, subtitle, and description for a product<p>Lists all images in the Scene7 or Cloudinary image set|Product Content API|
|List product information for a product at a specific point in time using a Snapshot ID|Merchandised Products API|

## API Endpoint Quick Reference

For more information about each service and to try them out though the UI, visit the Nike Developer Portal through the links below.

### [MERCHANDISED PRODUCT INFORMATION SERVICE](https://developer.niketech.com/docs/projects/Merchandised%20Products%20Service%20API?tab=api){:target="blank"}

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|[MERCHANDISED PRODUCTS LIST](https://developer.niketech.com/docs/projects/Merchandised%20Products%20Service%20API?tab=api){:target="blank"}|/merch/products/v2|GET|
|[MERCHANDISED PRODUCTS BY ID](https://developer.niketech.com/docs/projects/Merchandised%20Products%20Service%20API?tab=api){:target="blank"}|/merch/products/v2/{id}|GET|
|[MERCHANDISED PRODUCTS CREATE](https://developer.niketech.com/docs/projects/Merchandised%20Products%20Service%20API?tab=api){:target="blank"}|/merch/product/v2|POST|
|[MERCHANDISED PRODUCTS DELETE](https://developer.niketech.com/docs/projects/Merchandised%20Products%20Service%20API?tab=api){:target="blank"}|/merch/products/v2/{id}|DELETE|

### [MERCHANDISED SKU INFORMATION SERVICE](https://developer.niketech.com/docs/projects/Merchandised%20SKUs%20Service%20API?tab=api){:target="blank"}

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|[MERCHANDISED PRODUCT SKU LIST](https://developer.niketech.com/docs/projects/Merchandised%20SKUs%20Service%20API?tab=api){:target="blank"}|/merch/skus/v2|GET|
|[MERCHANDISED PRODUCT SKU BY ID](https://developer.niketech.com/docs/projects/Merchandised%20SKUs%20Service%20API?tab=api){:target="blank"}|/merch/skus/v2/{id}|GET|
|[MERCHANDISED PRODUCT SKU CREATE](https://developer.niketech.com/docs/projects/Merchandised%20SKUs%20Service%20API?tab=api){:target="blank"}|/merch/skus/v2|POST|
|[MERCHANDISED PRODUCT SKUS DELETE](https://developer.niketech.com/docs/projects/Merchandised%20SKUs%20Service%20API?tab=api){:target="blank"}|/merch/skus/v2|DELETE|
|[MERCHANDISED PRODUCT SKUS DELETE](https://developer.niketech.com/docs/projects/Merchandised%20SKUs%20Service%20API?tab=api){:target="blank"}|/merch/skus/v2/{id}|DELETE|

### [MERCHANDISED PRODUCT PRICE SERVICE](https://developer.niketech.com/docs/projects/Merchandised%20Prices%20Service%20API?tab=api){:target="blank"}

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|[MERCHANDISED PRICES LIST](https://developer.niketech.com/docs/projects/Merchandised%20Prices%20Service%20API?tab=api){:target="blank"}|/merch/prices/v2|GET|
|[MERCHANDISED PRICES BY ID](https://developer.niketech.com/docs/projects/Merchandised%20Prices%20Service%20API?tab=api){:target="blank"}|/merch/prices/v2/{id}|GET|
|[MERCHANDISED PRICES CREATE](https://developer.niketech.com/docs/projects/Merchandised%20Prices%20Service%20API?tab=api){:target="blank"}|/merch/prices/v2|POST|
|[MERCHANDISED PRICES DELETE](https://developer.niketech.com/docs/projects/Merchandised%20Prices%20Service%20API?tab=api){:target="blank"}|/merch/prices/v2/{id}|DELETE|

### [MERCHANDISED VALUE-ADDED SERVICES](https://developer.niketech.com/docs/projects/Merchandised%20Value%20Added%20Services%20Service%20API?tab=api){:target="blank"}

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|[MERCHANDISED VALUE ADDED SERVICES LIST](https://developer.niketech.com/docs/projects/Merchandised%20Value%20Added%20Services%20Service%20API?tab=api){:target="blank"}|/merch/value_added_services/v1|GET|
|[MERCHANDISED VALUE ADDED SERVICES BY ID](https://developer.niketech.com/docs/projects/Merchandised%20Value%20Added%20Services%20Service%20API?tab=api){:target="blank"}|/merch/value_added_services/v1/{id}|GET|
|[MERCHANDISED VALUE ADDED SERVICES CREATE](https://developer.niketech.com/docs/projects/Merchandised%20Value%20Added%20Services%20Service%20API?tab=api){:target="blank"}|/merch/value_added_services/v1|POST|
|[MERCHANDISED VALUE ADDED SERVICES DELETE](https://developer.niketech.com/docs/projects/Merchandised%20Value%20Added%20Services%20Service%20API?tab=api){:target="blank"}|/merch/value_added_services/v1/{id}|DELETE|

### [PRODUCT CONTENT](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api){:target="blank"}

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|[PRODUCT CONTENT BY STYLE COLOR](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api){:target="blank"}|/merch/contents/v1/{style-color}/content{?country,locale}|GET|
|[PRODUCT CONTENT ITEM BY STYLE COLOR](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api){:target="blank"}|/merch/contents/v1/{style-color}/content/{itemName}{?country,locale}|GET|
|[PRODUCT CONTENT BY STYLE COLOR LIST](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api){:target="blank"}|/merch/contents/v1/content{?country,locale,stylecolors}|GET|
|[PRODUCT CONTENT FIELD BY STYLE COLOR LIST](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api){:target="blank"}|/merch/contents/v1/content/{fieldname}{?country,locale,stylecolors}|GET|
|[PRODUCT IMAGE SET BY STYLE COLOR](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api){:target="blank"}|/merch/contents/v1/{style-color}/images{?country}|GET|
|[PRODUCT IMAGE SET BY STYLE COLOR LIST](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api){:target="blank"}|/merch/contents/v1/images{?country,stylecolors}|GET|
|[PRODUCT BASE IMAGE URL BY STYLE COLOR](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api){:target="blank"}|/merch/contents/v1/{styleColor}/images/base{?country}|GET|
|[PRODUCT BASE IMAGE URL BY STYLE COLOR LIST](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api){:target="blank"}|/merch/contents/v1/images/base|GET|

## Consider Using Product Feeds

Before you start using the Merchandised Products APIs, you should evaluate whether you could accomplish the same objectives by using the Product Feeds API.

The Product Feeds API aggregates product information, inventory data, and brand content from various sources including the Merchandised Products API. The Product Feeds API organizes the data into Cards (product data or events), Threads (groups of related cards) and Feeds (groups of related Threads). Using Product Feeds rather than the Merchandised Products API has the following advantages:

- Product Feeds remains in sync with multiple data providers (including Merchandised Products), which reduces the number of service contracts for which you need to keep track.
- Since Product Feeds is an aggregation service, you only need to make a single call to get most of the information you would need. By contrast, calling Merchandised Products APIs directly requires a minimum of 4-5 calls to get the complete portrait of a single product.
- Product Feeds enforces business-critical rules around product visibility in experiences. For example, Nike restricts the sale and presentation of some products in countries. Product Feeds eliminates the logic required to comply with these rules.

There are a few caveats:

- Product Feeds responses are larger, so response times may be slightly slower - but still within SLAs.
- Product Feeds does not provide all of the data that is provided in every service with which it integrates. The data points in some cases are selective.

For the full list of use cases to evaluate if that API is better suited to your product needs, see [Product Threads List](/doc/commerce/product/api_product_feeds.html#product-threads-list).

## Gathering a Product Data Set

The following example describes the set of Merchandised Products service calls you can make to assemble the product details of a style-color. These are all public services, so feel free to experiment with the endpoints. Note that the style-color in this example is not a current, active style-color. Product availability changes all the time, so you should get a current product from Nike.com to try this out.

Follow these steps to assemble a complete set of product data:

1. Using style-color 526628-009 (example), get the Product ID and a few product details from the Merch Product endpoint (filtered by style-color and Merch Group):
https://api.nike.com/merch/products/v2?filter=merchGroup(US)&filter=styleColor(526628-009)&filter=merchgroup(US)

2. Using the product ID from the Merch Product response, get prices from the Merch Price endpoint (filtered by product ID and country US):
https://api.nike.com/merch/prices/v2?filter=productid(22d2ea87-d7ce-50e7-a5ca-884788e1d958)&filter=country(US)

3. Using the same product ID, get the SKU data from the Merch SKUs endpoint (filtered by country US):
https://api.nike.com/merch/skus/v2?filter=productId(22d2ea87-d7ce-50e7-a5ca-884788e1d958)&filter=country(US)

4. Using style-color 526628-009 (not product ID), get the product images from the images endpoint of the Product Content service:
https://api.nike.com/merch/contents/v1/526628-009/images?country=US

<span class="toc-pad">**Note**: Images are returned from the Product Content service without a URL; but all of the necessary information is returned to build it. The experience is responsible for assembling the image URL.</span>

5. Using style-color 526628-009 (not product ID), get the localized content for the product from the Product Content endpoint of the Product Content service:
https://api.nike.com/merch/contents/v1/526628-009/content?country=US&locale=en_US

## Understanding Nike Product Data

Nike product data is a complex set of information that flows from multiple origin systems and processes.

### Where Does Product Data Come From?

Product data originates from two primary upstream systems: <b>Prodigy</b> (via <b>eMerch</b>), and the cloud-based <b>Catalog</b> service. Prodigy and the Catalog service are the systems of record for product data, and are not managed within the Merchandised Products domain.

The following diagram illustrates the most common patterns for data flow.

![](/images/commerce/merch_product/product_data_simplified_flow.png)

After a notification from the system of record is received, the Merchandised Products services then decorate the product data with domain-specific elements such as Product UUIDs for each service. Generally Merchandised Products does not modify the data provided by the systems of record. For more information on the IDs that are returned within the Merchandised Products domain, see [Understanding the Various IDs Returned Within Each Response](#understanding-the-various-ids-returned-within-each-response).

>**TIPS:**
>
>When a Merchandised Products object is created, the object remains in the application cache for 30 seconds.
>
>Because Prodigy is the source of data, product data that is served through any Merchandised Products API is subject to change at any time.

### How Does Product Data Get Published?

When a change to a product is saved in Prodigy, a notification that a new product has been published is received by Merchandised Products cloud services. This initiates the creation of a fresh snapshot of all product data.

Prodigy uses a first-in-first-out queue, however an individual product update is pushed to the top of the queue so that it takes precedence over larger bulk updates. For example, the queue may contain 100k updates when a global product attribute has been applied. Since a producer who manually updates and publishes a single product likely wants that change to take place as quickly as possible, Prodigy gives preference to that manual update.

<b>NOTE:</b> When a Merchandised Products object is updated, the object remains in the application cache for 30 seconds.

### Where Do I Get Inventory Information?

Inventory is available via the Inventory domain. For example, product availability can be found [here](https://developer.niketech.com/docs/projects/Availability?tab=api){:target="blank"}.

### How To Find a Current Product

The easiest way to find a current product is to go to Nike.com and find a style-color that is offered on the site. With the exception of NIKEiD products, if the style-color is available on Nike.com, the data is available in our services.

## Merchandised Products Concepts

The Merchandised Products API uses underlying concepts as the foundation for how the API is designed and consumed.

### How Product Data is Organized in the Merchandised Products API

Depending upon the information you are looking for, you may need to chain together several service calls, using the output of one service call as input to another service call.

In the Nike data ecosystem, every product has the following fundamental characteristics:

- One or more SKUs
- One set of prices
- One or more associated value-added services
- A body of content
- A set of product images

These items are divided into a set of microservices. The relationship between the Merchandised Products objects is illustrated below.

![](/images/commerce/merch_product/relationships.png){:width="40%"}

### Finding the Data Points You Need

Microservice architecture specifies that data should be divided into logical groupings within semantically-named resources. You can use the following general guidelines to find the data points among the Merchandised Products resources:
- If the data can be localized, it is typically in the Content API.
- If you are looking for size information, it is in the Merchandised SKUs API.
- If you are looking for launch-related information or dates associated with a product, look in the Merchandised Products API.

### Understanding the Various IDs Returned Within Each Response

The resources provided by the <b>Merchandised Products API</b> include a wide range of IDs that are used for various current and historical purposes. The following table describes the concepts and common uses for each of these IDs.

|ID|Services|Description|
|---|---|---|
|**id**|Merchandised Products, Price, SKU, and VAS| UUID for the object (and any nested object) that is returned. Each value in the object's **id** field is generated within the Merchandised Products domain, and is not used by legacy systems. Each ID is unique to the Merch Group that was specified in the request, but is not globally unique. For a globally unique ID, use the value in the **catalogId** field.|
|**productId**|Merchandised Price, SKU, and VAS| UUID of the parent product to which the data is tied. Each product returned in the Merchandised Products service can be thought of as a parent for the data returned by the other APIs in the domain. For example, if you want to retrieve the SKUs for a specific product, you need to first know the product UUID for the parent of those SKUs.|
|**parentId**|Merchandised Price, SKU, and VAS| UUID of the parent product to which the data is tied.<br><br><b>NOTE:</b> In practical terms, the parent ID is identical to the product UUID.|
|**snapshotId**|Merchandised Products, Price, SKU, and VAS| UUID for a record of what was returned with the response. Snapshot IDs are used for historical lookup purposes. For example, Checkout stores a record for every transaction that occurs on Nike.com. Within that record, the Snapshot ID is stored to later retrieve the exact details of the transaction at the moment that product data was requested.<br><br><b>NOTE:</b> There is no lookup provided to retrieve a previous Snapshot ID for a given time. You can only use a Snapshot ID that you stored when the request occurred.|
|**styleCode**, **colorCode**, and **styleColor**|All| Consumer-facing product style and color for the requested product. The style-color is visible on the Product Detail Page on Nike.com, for example, in the product description. <br><br><b>NOTE:</b> Style-colors are not globally unique. For example, occasionally a style-color ID is identical in two different Merch Groups, but that identical ID represents two distinct physical products. These collisions are rare, but can occur.|
|**catalogId**|Merchandised Products| Globally unique product UUID that is generated by the Catalog domain.|
|**pid**|Merchandised Products| Deprecated Product ID (PID) that is used by various internal systems at Nike, as well as in legacy URLs on Nike.com. PIDs are generally included for historical mapping purposes for legacy systems that are not completely cloud-enabled.|
|**productGroupId**| Merchandised Products | Deprecated Product Group ID (PGID) that is used by various internal systems at Nike, as well as in legacy URLs on Nike.com. PGIDs were used to group products together in a merchandised experience. PGIDs are included generally for historical mapping purposes for legacy systems that are not completely cloud-enabled.|
|**legacyCatalogIds**| Merchandised Products | Deprecated IDs that are returned for use by legacy systems.|
|**stockKeepingUnitId**|Merchandised Price| Deprecated SKU ID that is used for historical purposes by legacy systems.|
|**gtin**|Merchandised SKU| Globally unique 14-digit number that used to identify retail SKUs. These are commonly called UPC codes, though the technical specification for the two is slightly different.|
|**catalogSkuId**| Merchandised SKU | Deprecated IDs that are returned for use by legacy systems.|

### Caching Data

The Merchandised Products API caching strategy includes three layers: application, Akamai and experience.

The first cache layer is at the application level where each instance of the Merchandised Products application has its own cache. There is no distributed caching, so the service instances do not share cache information with one another. Application cache times vary between services.

The second cache layer is Akamai caching, utilized when the client calls the services through the public router. There is no caching performed when an application calls the application directly.

The third type of caching should occur within the client experience, depending on the client's architectural patterns. Caching client-side is recommended to reduce network calls and unnecessary load on the system.

### Create, Update, and Delete Capabilities of the API

In addition to listing product data, the API creates, modifies and deletes merchandised product data that flows into the system from Prodigy, which is the primary system of record. Every update call made to the Merchandised Products services from Prodigy (including deletion) is versioned, creating an audit trail. In this way, no merchandised product data is physically deleted from the data store. A timestamped deletion record in inserted instead. Each version has a unique **snapshotId** representing a snapshot of the object in time. The create, update and delete endpoints are restricted and only certain applications can call them.

## International Considerations

Generally the rules and behaviors for products are the same regardless of geography. However, there are a few key concepts and exceptions.

### Working with Merch Groups, Countries, and Languages

A Merch Group is a collection of countries defined in Prodigy. Merch Groups are used to manage product information and inventory at a group level. The Merchandised Products API uses the Merch Group as a foundational element in how the data is organized and presented.

Within each Merch Group, each country may include translations and size conversions for more than one language-dialect.

For most API calls, Merch Group and Country are required. For the current list of supported Merch Groups, countries, and languages see [Merchandised Products API Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products).

### Excluding Countries where a Specific Product Should Not Be Offered

In some cases, Nike does not offer a specific product in a certain country, even if it is offered in other countries within the same Merch Group. This may be for a variety of reasons, including legal implications of selling a product that is not within the trade guidelines for a given country. If you are building a public or consumer-facing experience, it is essential that you do not show that product in an excluded country.

The Merchandised Products API includes two fields that are used for this purpose:

- **commerceCountryInclusions**
- **commerceCountryExclusions**

The two data points reflect two views of essentially the same data. You should use **commerceCountryExclusions** to exclude a product from being displayed in the specified country. The **commerceCountryInclusions** field is an inverse view that is primarily used for legacy systems, and may be deprecated soon.

## Making Your First API Request

To try out the following examples, you need a valid style-color, style number, or ID, depending upon the service. If you find that the data in any of these examples is no longer available, go to a product page on the [store.nike.com](https://store.nike.com) to get the style-color of an active, in-stock product.

For your first Merchandised Products API request, you will list the product details for style-colors SX7037-657 and SX5593-010.

1. Gather data needed for the request

|HTTP Method|Endpoint URI|
|---|---|
|GET|https://api.nike.com/merch/products/v2|
    
|Filter Parameter Name|Filter Value|
|---|---|
|**merchgroup**|US|
|**stylecolor**|SX7037-657,SX5593-010|

2. Execute the request

The complete URI is:

https://api.nike.com/merch/products/v2?filter=merchgroup(US)&filter=stylecolor(SX7037-657,SX5593-010)

This GET request does not require special headers and can be executed in any browser.

3. Parse the response

See the output of the successful JSON 200 response below.

>**What id to use:** **id** is the UUID assigned when the product first flowed into the Merchandising Product API. **pid** is a legacy ID that maps to the product UUID and will eventually be deprecated.

```
{
  "pages" : { },
  "objects" : [ {
    "id" : "8653b383-22a0-55a1-ba7e-56174e5ab1e7",
    "snapshotId" : "c59808d1-0945-4bcc-9c47-dcb34cc40824",
    "modificationDate" : "2017-10-05T20:55:33.734Z",
    "status" : "ACTIVE",
    "merchGroup" : "US",
    "styleCode" : "SX7037",
    "colorCode" : "657",
    "styleColor" : "SX7037-657",
    "pid" : "11808665",
    "catalogId" : "a922ed59-1c27-3884-8fa3-2d29f4114352",
    "productGroupId" : "11943433",
    "brand" : "Nike",
    "channels" : [ ],
    "legacyCatalogIds" : [ "1" ],
    "genders" : [ "WOMEN", "MEN" ],
    "valueAddedServices" : [ {
      "id" : "47bc9091-2965-5231-b5f1-a7216e249894"
    } ],
    "sportTags" : [ "Basketball" ],
    "widthGroupIds" : [ ],
    "classificationConcepts" : [ ],
    "commerceCountryInclusions" : [ ],
    "commerceCountryExclusions" : [ ],
    "quantityLimit" : 10,
    "styleType" : "INLINE",
    "productType" : "EQUIPMENT",
    "mainColor" : false,
    "exclusiveAccess" : false,
    "hardLaunch" : true,
    "commercePublishDate" : "2017-09-29T13:00:00.000Z",
    "commerceStartDate" : "2017-09-29T12:00:00.000Z",
    "resourceType" : "merchProduct",
    "links" : {
      "self" : {
        "ref" : "/merch/products/v2/8653b383-22a0-55a1-ba7e-56174e5ab1e7"
      }
    }
  }, {
    "id" : "4878287a-c51f-5219-a0f5-5fc2d3a9065b",
    "snapshotId" : "38b2c057-8aab-4d4a-8039-3d74205929bb",
    "modificationDate" : "2017-09-21T00:41:45.433Z",
    "status" : "ACTIVE",
    "merchGroup" : "US",
    "styleCode" : "SX5593",
    "colorCode" : "010",
    "styleColor" : "SX5593-010",
    "pid" : "11374423",
    "catalogId" : "68f9414c-56aa-317b-a9d2-329b53dd6189",
    "productGroupId" : "11621641",
    "brand" : "Nike",
    "channels" : [ ],
    "legacyCatalogIds" : [ "1" ],
    "genders" : [ "WOMEN", "MEN", "GIRLS", "BOYS" ],
    "valueAddedServices" : [ {
      "id" : "47bc9091-2965-5231-b5f1-a7216e249894"
    } ],
    "sportTags" : [ "Basketball" ],
    "widthGroupIds" : [ ],
    "classificationConcepts" : [ ],
    "commerceCountryInclusions" : [ ],
    "commerceCountryExclusions" : [ ],
    "quantityLimit" : 10,
    "styleType" : "INLINE",
    "productType" : "EQUIPMENT",
    "mainColor" : true,
    "exclusiveAccess" : false,
    "commercePublishDate" : "2017-06-28T16:46:59.000Z",
    "commerceStartDate" : "2017-04-01T07:00:00.000Z",
    "commerceEndDate" : "2017-07-01T07:00:00.000Z",
    "resourceType" : "merchProduct",
    "links" : {
      "self" : {
        "ref" : "/merch/products/v2/4878287a-c51f-5219-a0f5-5fc2d3a9065b"
      }
    }
  } ],
  "errors" : [ ]
}
```

>**TIP:** For detailed information on this service, see [Merchandised Product List](#merchandised-product-list).

## Using Merchandised Products

- [Merchandised Products Overview](#merchandised-products-overview)

- [Merchandised Product List](#merchandised-product-list)

- [Merchandised Product by ID](#merchandised-product-by-id)

### Merchandised Products Overview

Use the Merchandised Products service to list, create, update, and delete merchandised product information.

- Search for a specific version of the object by product ID or snapshot ID. Searching by a filter other than **snapshotId** returns the most recent version.
- Filter field names are case-insensitive.
- One product is returned if searching by product ID.
- If country is not specified, all countries are returned.
- This is a synchronous service.

### Merchandised Product List

The Merchandised Products service returns all products matching the filter query parameter up to the value supplied in the count parameter. If no count parameter is supplied, up to 25 products are returned. When the count parameter is supplied, the maximum number of products is 25. Product results are sorted by product ID, style-color or style, depending upon the filter query parameters passed in. If the count parameter restricts the results, a **pages** object is returned in the response that the caller can use for pagination.

This is not a [JWT-restricted](/doc/getting-started/using_nike_apis.html#jwt-json-web-token) service but results differ based on whether or not this header is sent in the request. If no JWT header is supplied, the response contains products matching the criteria and have an ACTIVE status. If a valid JWT header is supplied, the response contains products matching the criteria regardless of status.

List product information for a specific version by ID and by Snapshot ID. If no **snapshotId** parameter is supplied, the most recent version of the product is returned.

Filter field names are case insensitive.

The caller does not have to send an access token in the Authorization header (indicating the customer is logged in) to use this service.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/products/v2{?filter,snapshotId,count,anchor}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**filter**|query|Fields and values used to filter the results.<br>Maximum of one [merchgroup](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) is required.<br>id + style or style-color is required.<br>Maximum of one style is supported.|String|Required|
|**snapshotId**|query|ID representing the product version<br>Allowed in listing by product ID only|String|Optional|
|**count**|query|Number of results to return, default = 25, max = 25|Integer|Optional|
|**anchor**|query|If the value is 10, results returned start with result 11|Integer|Optional|

Let's take a look at some *Merchandised Product List* scenarios.

|I Want to List|Sample Query|
|---|---|
|EU products with style 849560|https://api.nike.com/merch/products/v2?filter=merchgroup(EU)&filter=style(849560)|
|EU products with style-color 849560-001 and 849560-002|https://api.nike.com/merch/products/v2?filter=merchgroup(EU)&filter=stylecolor(849560-100,849560-002)|
|US product with ID 58aaa694-5889-5965-a781-6abcc3e4ff68|https://api.nike.com/merch/products/v2?filter=merchgroup(US)&filter=id(58aaa694-5889-5965-a781-6abcc3e4ff68)|
|US products with style 919704, limiting the results to 10|https://api.nike.com/merch/products/v2/?filter=merchgroup(US)&filter=style(919704)&count=10|
|US product with product ID 8653b383-22a0-55a1-ba7e-56174e5ab1e7 and Snapshot ID c59808d1-0945-4bcc-9c47-dcb34cc40824|https://api.nike.com/merch/products/v2?filter=merchgroup(US)&filter=snapshotId(c59808d1-0945-4bcc-9c47-dcb34cc40824)&filter=id(8653b383-22a0-55a1-ba7e-56174e5ab1e7)|
|More than one product in a single response: US product with product ID b9c9789-1a35-503c-8a22-95a745c35df8 and US product with product ID 30e88273-bc07-5a51-bb8a-9c58a789c504|https://api.nike.com/merch/products/v2?filter=id(ab9c9789-1a35-503c-8a22-95a745c35df8,30e88273-bc07-5a51-bb8a-9c58a789c504)|

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body
No body is required for a GET request.

Sample *Merchandised Product List* URI:
```
https://api.nike.com/merch/products/v2?filter=merchgroup(EU)&filter=style(AJ8646)
```

### Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**pages**|object|Object with a **next** and **prev** link used to paginate results|Optional|
|pages.**prev**|string|Relative URL to the previous page of results|Optional|
|pages.**next**|string|Relative URL to the next page of results|Optional|
|**id**|string|ID of the product in UUID format, generated when product flows into Merch Product from Prodigy, will eventually replace **pid**|Required|
|**snapshotId**|string|ID of the most recent snapshot of the SKU in UUID format, generated when the product is updated|Required|
|**modificationDate**|string|Timestamp the product was last modified|Required|
|**status**|string|Product status, see [Merchandised Product Field Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) for a complete list|Required|
|**merchGroup**|string|Group this product is merchandised to, see [Merchandised Product Field Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) for a complete list|Required|
|**styleCode**|string|Code indicating Nike style|Required|
|**colorCode**|string|Code indicating Nike color|Required|
|**styleColor**|string|Concatenation of **styleCode**-**colorCode**|Required|
|**pid**|string|Product ID from legacy system used to map to the product UUID|Required|
|**catalogId**|string|Catalog ID in UUID format from the [Catalog Product](https://developer.niketech.com/docs/projects/Product%20Catalog%20V3?tab=api){:target="blank"} service, will eventually replace **legacyCatalogIds**|Optional|
|**productGroupId**|string|ID used to group products together such as products with the same styleCode, from legacy system|Optional|
|**nikeIdStyleCode**|string|Nike ID style code, only populated for products of styleType `NIKEID`|Optional|
|**brand**|string|Nike brand associated to this product such as "Jordan"|Optional|
|**channels**|array|Array of channels this product is sold in|Optional|
|**legacyCatalogIds**|array|Array of legacy system catalog ids the product is in, used to map to the **catalogId** UUID|Optional|
|**genders**|array|Array of genders this product is associated with, see [Merchandised Product Field Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) for a complete list|Optional|
|**valueAddedServices**|array|Array of value-added service objects associated with this product|Optional|
|valueAddedServices.**id**|string|Value-added-service UUID associated with this product that can be used in the [Merchandised Value Added Services by ID](#merchandised-value-added-services-by-id) endpoint call|Optional|
|valueAddedServices.**publishDate**|string|Timestamp value-added service was published|Optional|
|valueAddedServices.**startDate**|string|Timestamp value-added service begins|Optional|
|valueAddedServices.**endDate**|string|Timestamp value-added service ends|Optional|
|**customization**|array|Array of NIKEiD-related customizations available for this product|Optional|
|customization.**nikeIdStyleCode**|string|Style code of matching NIKEiD product|Optional|
|customization.**nikeIdSlug**|string|NIKEiD slug code associated with this product|Optional|
|**sportTags**|array|Array of sport tags associated with this product|Optional|
|**widthGroupIds**|array|Group of product IDs with same style but different width, not currently used|Optional|
|**classificationConcepts**|array|Array of Taxonomy concept objects associated with this product. See the [Taxonomy Service](https://bitbucket.nike.com/projects/TAX/repos/taxonomy/browse/API-v2.md){:target="blank"} for more information.|Optional|
|classificationConcepts.**broaderConceptId**|string|UUID of the broad Taxonomy concept associated with this product, e.g. `Platinum Tint`|Required|
|classificationConcepts.**narrowerConceptIds**|array|Array of narrower Taxonomy concept UUIDs associated with this product|Required|
|**commerceCountryInclusions**|array|Array of ISO2 country codes where this product can be sold, e.g. CN,JP|Optional|
|**commerceCountryExclusions**|array|Array of ISO2 country codes where this product can not be sold, e.g. AT,BE|Optional|
|**productRollup**|object|Object containing Prodigy rollup attributes|Optional|
|productRollup.**type**|string|Type of Prodigy rollup attribute associated to the product|Optional|
|productRollup.**key**|string|Key of Prodigy rollup attribute associated to the product|Optional|
|**quantityLimit**|integer|Integer restricting how many of this product a customer can purchase at one time|Optional|
|**nikeidStyleNumber**|string|Nike ID style code, only populated for products of styleType `NIKEID`|Optional|
|**styleType**|string|Type of style, see [Merchandised Product Field Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) for a complete list|Optional|
|**productType**|string|Type of product, see [Merchandised Product Field Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) for a complete list|Optional|
|**publishType**|string|Type of publishing, see [Merchandised Product Field Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) for a complete list|Optional|
|**mainColor**|boolean|True or false, indicating this is the main color of the style|Optional|
|**exclusiveAccess**|boolean|True or false, indicating whether or not the user must have an access code to unlock the product in order to purchase it|Required|
|**preOrder**|boolean|True or false, true indicates the PDP should display in preOrder status|Optional|
|**hardLaunch**|boolean|True or false, true indicates the PDP should not display before the commerceStartDate or after the commerceEndDate regardless of inventory|Optional|
|**hidePayment**|boolean|True or false, true indicates certain payment types are not allowed to purchase the product, such as COD in China|Optional|
|**commercePublishDate**|string|Timestamp indicating when this product was published. e.g. if date is within 30 days of current date, product is considered a New Release|Optional|
|**commerceStartDate**|string|Timestamp indicating when the product product can be sold|Optional|
|**commerceEndDate**|string|Timestamp indicating when the product can no longer be sold|Optional|
|**preorderAvailabilityDate**|string|Timestamp indicating when the product can be pre-ordered|Optional|
|**preorderByDate**|string|Timestamp, not currently used|Optional|
|**softLaunchDate**|string|Timestamp e.g. used for products with a publishType of `LAUNCH`. if **hardLaunch** is true, current date is between the **commerceStartDate** and **softLaunchDate**, display product in Coming Soon status|Optional|
|**resourceType**|string|Type of resource, always merchProduct|Required|
|links.self.**ref**|string|Referrer link to result|Required|
|**errors**|array|Array of errors associated with this request|Optional|
|errors.**requested**|string|Error message indicating which field or parameter caused the error|Required|
|errors.**httpStatus**|integer|HTTP error response code|Required|
|errors.**message**|string|Detailed error message|Required|

Sample *Merchandised Product List* 200 successful response:

```
{
  "pages" : { },
  "objects" : [ {
    "id" : "4e2c6888-8a46-5a70-a7ed-1f20c7e26690",
    "snapshotId" : "f553c583-645d-45bd-a9b9-8ce46596792b",
    "modificationDate" : "2017-11-14T07:26:05.278Z",
    "status" : "ACTIVE",
    "merchGroup" : "EU",
    "styleCode" : "AJ8646",
    "colorCode" : "001",
    "styleColor" : "AJ8646-001",
    "pid" : "12115143",
    "catalogId" : "ff699142-04a5-3edc-819e-a7b5824dcafd",
    "productGroupId" : "12263238",
    "brand" : "Nike",
    "channels" : [ ],
    "legacyCatalogIds" : [ "300" ],
    "genders" : [ "WOMEN" ],
    "valueAddedServices" : [ {
      "id" : "47bc9091-2965-5231-b5f1-a7216e249894"
    } ],
    "sportTags" : [ "Lifestyle" ],
    "classificationConcepts" : [ ],
    "commerceCountryInclusions" : [ ],
    "commerceCountryExclusions" : [ ],
    "quantityLimit" : 10,
    "styleType" : "INLINE",
    "productType" : "FOOTWEAR",
    "mainColor" : true,
    "exclusiveAccess" : false,
    "hardLaunch" : true,
    "commercePublishDate" : "2017-11-24T08:00:00.000Z",
    "commerceStartDate" : "2017-11-24T08:00:00.000Z",
    "softLaunchDate" : "2017-11-22T08:00:00.000Z",
    "resourceType" : "merchProduct",
    "links" : {
      "self" : {
        "ref" : "/merch/products/v2/4e2c6888-8a46-5a70-a7ed-1f20c7e26690"
      }
    }
  }, {
    "id" : "b419ffdf-1a18-52d0-bfb1-a51a9763b83d",
    "snapshotId" : "0547ffcf-ebaa-4d9a-8307-89659fa6aa97",
    "modificationDate" : "2017-11-14T11:17:26.018Z",
    "status" : "ACTIVE",
    "merchGroup" : "EU",
    "styleCode" : "AJ8646",
    "colorCode" : "002",
    "styleColor" : "AJ8646-002",
    "pid" : "12115144",
    "catalogId" : "897f228d-d776-3ac3-8804-b9e6f5a140ec",
    "productGroupId" : "12263238",
    "brand" : "Nike",
    "channels" : [ ],
    "legacyCatalogIds" : [ "300" ],
    "genders" : [ "WOMEN" ],
    "valueAddedServices" : [ {
      "id" : "47bc9091-2965-5231-b5f1-a7216e249894"
    } ],
    "sportTags" : [ "Lifestyle" ],
    "classificationConcepts" : [ ],
    "commerceCountryInclusions" : [ ],
    "commerceCountryExclusions" : [ ],
    "quantityLimit" : 10,
    "styleType" : "INLINE",
    "productType" : "FOOTWEAR",
    "publishType" : "LAUNCH",
    "mainColor" : false,
    "exclusiveAccess" : false,
    "commercePublishDate" : "2017-11-14T11:12:31.000Z",
    "commerceStartDate" : "2017-10-01T10:00:00.000Z",
    "softLaunchDate" : "2017-11-27T08:00:00.000Z",
    "resourceType" : "merchProduct",
    "links" : {
      "self" : {
        "ref" : "/merch/products/v2/b419ffdf-1a18-52d0-bfb1-a51a9763b83d"
      }
    }
  }, {
    "id" : "069f4950-12a9-554c-a645-b3e532ee30b2",
    "snapshotId" : "1155fc28-6c12-4fe0-8441-e4288c528345",
    "modificationDate" : "2017-11-14T11:17:26.158Z",
    "status" : "ACTIVE",
    "merchGroup" : "EU",
    "styleCode" : "AJ8646",
    "colorCode" : "600",
    "styleColor" : "AJ8646-600",
    "pid" : "12115145",
    "catalogId" : "19352cdf-2b40-3cbc-b29e-066fb4829455",
    "productGroupId" : "12263238",
    "brand" : "Nike",
    "channels" : [ ],
    "legacyCatalogIds" : [ "300" ],
    "genders" : [ "WOMEN" ],
    "valueAddedServices" : [ {
      "id" : "47bc9091-2965-5231-b5f1-a7216e249894"
    } ],
    "sportTags" : [ "Lifestyle" ],
    "classificationConcepts" : [ ],
    "commerceCountryInclusions" : [ ],
    "commerceCountryExclusions" : [ ],
    "quantityLimit" : 10,
    "styleType" : "INLINE",
    "productType" : "FOOTWEAR",
    "publishType" : "LAUNCH",
    "mainColor" : false,
    "exclusiveAccess" : false,
    "commercePublishDate" : "2017-11-14T11:13:02.000Z",
    "commerceStartDate" : "2017-10-01T10:00:00.000Z",
    "softLaunchDate" : "2017-11-27T08:00:00.000Z",
    "resourceType" : "merchProduct",
    "links" : {
      "self" : {
        "ref" : "/merch/products/v2/069f4950-12a9-554c-a645-b3e532ee30b2"
      }
    }
  } ],
  "errors" : [ ]
}
```

Sample *Merchandised Product List* 200 successful response when no products matching the filters are found:

```
{
  "pages" : {
    "next" : "/merch/products/v2?count=25&anchor=0&filter=merchgroup(US)&filter=style(111111)"
  },
  "objects" : [ ],
  "errors" : [ ]
}
```

Sample *Merchandised Product List* 400 error response:

```
{
    "httpStatus": 400,
    "code": "40000",
    "timestamp": "2017-10-10T23:35:05.737+0000",
    "service": "merchproductsv2",
    "message": "Invalid request parameters"
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/merchcommonapi/browse/apis/products/API.md?raw#!/Merchandised_Product/get_merch_products_v2" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

<p>&nbsp;</p>

### Merchandised Product By ID

---

This service returns product information for the **id** path parameter and **snapshotId** query parameter, if supplied. This endpoint returns the same fields as the [Merchandised Product List](#merchandised-product-list) endpoint except for the pages object, because the endpoint only returns one result.

The caller does not have to send an access token in the **Authorization** header (indicating the customer is logged in) to use this service.

>**TIP:** If you know the product ID, this endpoint yields faster results than the [Merchandised Product List](#merchandised-product-list) endpoint does because it locates the product record directly by ID rather than filtering the results.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/products/v2/{id}{?snapshotId}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|path|ID of product|String|Required|
|**snapshotId**|query|ID representing the product version|String|Optional|

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body

No body is required for GET requests.

Sample request URI to list product information for ID 58aaa694-5889-5965-a781-6abcc3e4ff68 and Snapshot ID 34cec674-4200-4001-8632-1f4f3cec5078:

```
https://api.nike.com/merch/products/v2/58aaa694-5889-5965-a781-6abcc3e4ff68?snapshotId=34cec674-4200-4001-8632-1f4f3cec5078 
```

Sample request URI to list product information for ID 30e88273-bc07-5a51-bb8a-9c58a789c504:

```
https://api.nike.com/merch/products/v2/30e88273-bc07-5a51-bb8a-9c58a789c504
```

### Response Body

See the [Merchandised Product List](#merchandised-product-list) endpoint to view the list of response body field definitions.

Sample *Merchandised Product By ID* 200 successful response:

```
{
    "id": "30e88273-bc07-5a51-bb8a-9c58a789c504",
    "snapshotId": "114d21ad-8fbf-49c9-b552-9173f279b8a9",
    "modificationDate": "2017-10-09T16:51:54.050Z",
    "status": "ACTIVE",
    "merchGroup": "US",
    "styleCode": "919704",
    "colorCode": "006",
    "styleColor": "919704-006",
    "pid": "11825501",
    "catalogId": "ac7cbede-de38-30d7-bb24-1c7ac8a975c1",
    "productGroupId": "11937976",
    "brand": "Jordan",
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
        "Lifestyle"
    ],
    "widthGroupIds": [],
    "classificationConcepts": [],
    "quantityLimit": 1,
    "styleType": "INLINE",
    "productType": "FOOTWEAR",
    "publishType": "FLOW",
    "mainColor": false,
    "exclusiveAccess": false,
    "hardLaunch": true,
    "commercePublishDate": "2017-10-07T07:00:00.000Z",
    "commerceStartDate": "2017-10-07T14:00:00.000Z",
    "resourceType": "merchProduct",
    "links": {
        "self": {
            "ref": "/merch/products/v2/30e88273-bc07-5a51-bb8a-9c58a789c504"
        }
    }
}
```

Sample 404 response:

```
{
    "httpStatus": 404,
    "timestamp": "2017-10-12T17:56:13.922+0000",
    "service": "merchproductsv2",
    "message": "Product not found."
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/merchcommonapi/browse/apis/products/API.md?raw#!/Merchandised_Product/get_merch_products_v2_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

## Using Merchandised Product SKUs

- [MERCHANDISED PRODUCT SKU LIST](#merchandised-product-sku-list)

- [MERCHANDISED PRODUCT SKU BY ID](#merchandised-product-sku-by-id)

### Merchandised Product SKU Overview

Use this service to list, add, update and delete merchandised SKU information.

- Search for a specific version of the object by ID and Snapshot ID. Searching by a filter other than **snapshotId** returns the most recent version.
- Filter field names are case-insensitive.
- One product’s SKU data is returned if searching by SKU ID.
- If country is not specified, all countries are returned.
- This is a synchronous service.

The following sections describe each endpoint of the Merchandised Product SKU API in detail.

### Merchandised Product SKU List

Use this service to search for multiple SKUs by filter. Search results are sorted in ascending order by the **displayOrder** field and then **stockKeepingUnitId**. Note that the **displayOrder** field is not returned in the results.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/skus/v2{?filter,snapshotId,count,anchor}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**filter**|query|**id** (SKU UUID), **productid** (product UUID from Merch Product endpoint), **gtin** (from Merch Product endpoint) or **stockkeepingunitid** (from Merch Product endpoint) is required<br/>[country](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) is optional|String|**Required**|
|**snapshotId**|query|Unique ID in UUID format indicating a version of the SKU|String|Optional|
|**count**|query|Number of results to return. Max = 25|String|Optional|
|**anchor**|query|If the value is 10, results returned start with result 11|Integer|Optional|

#### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in the response. The only accepted value is <b>application/json</b>|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

#### Request Body

No request body is required for GET requests.

Let's take a look at some sample *Merchandised Product SKU* scenarios.

|I Want to List SKUs for filter|Sample Query|
|---|---|
|Product ID 2c4282cc-9fd1-5250-94a5-0c74735443dc|https://api.nike.com/merch/skus/v2?filter=productid(2c4282cc-9fd1-5250-94a5-0c74735443dc)|
|GTIN 00887225865153|https://api.nike.com/merch/skus/v2/?filter=gtin(00887225865153)|
|Legacy SKU (**stockkeepingunitid**) 18925450|https://api.nike.com/merch/skus/v2/?filter=stockkeepingunitid(18925450)|

Sample Merchandised Product SKU List request URI:

```
https://api.nike.com/merch/skus/v2/?filter=productid(ab9c9789-1a35-503c-8a22-95a745c35df8)&filter=country(US)
```

#### Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|ID of the SKU|Required|
|**snapshotId**|string|ID of the most recent snapshot of the SKU|Required|
|**productId**|string|ID of the product (as passed in the query parameter)|Required|
|**parentId**|string|Same as the productId if the SKUs product has no parent|Optional|
|**parentType**|string|Type of parent product. In the current version, this is always merchProduct.|Optional|
|**catalogSkuId**|string|UUID of catalog product. See [Product Catalog Service](https://developer.niketech.com/docs/projects/Product%20Catalog%20V3?tab=api){:target="blank"} for more information.|Optional|
|**modificationDate**|string|Date the SKU was last modified|Required|
|**merchGroup**|string|Merchandising group to which this SKU belongs. For more information on Merch Groups, see [Merchandised Product Field Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) for a complete list|Optional|
|**stockKeepingUnitId**|string|Deprecated SKU ID that is used for historical purposes by legacy systems.[legacy SKUID](#glossary)|Optional|
|**gtin**|string|[Global Trade Item Number](#glossary)|Required|
|**nikeSize**|string|Internal size|Optional|
|**countrySpecifications**|array|Array of specifications based on country parameter|Required|
|countrySpecifications.**country**|string|Country, matches the country filter|Optional|
|countrySpecifications.**localizedSize**|string|Localized SKU size based on country filter|Optional|
|countrySpecifications.taxInfo.**commodityCode**|string|Category code of SKU|Optional|
|countrySpecifications.taxInfo.**vat**|string|Value-added tax based on the country filter, 0 if none|Optional|
|**resourceType**|string|Type of resource, always merchSku|Required|
|links.self.**ref**|string|Referrer link to result|Required|
|errors.**requested**|string|Error message indicating which field caused the error|Optional|
|errors.**httpStatus**|integer|HTTP error response code|Optional|
|errors.**message**|string|Detailed error message|Optional|

Sample HTTP 200 success response from *Merchandised Product SKU List*:

```
{
    "pages": {},
    "objects": [
        {
            "id": "afb793c5-1bfe-5ec3-a7f7-63e7ea59db13",
            "snapshotId": "1292dfcb-b817-4595-b9f9-2dd582c988f0",
            "productId": "ab9c9789-1a35-503c-8a22-95a745c35df8",
            "parentId": "ab9c9789-1a35-503c-8a22-95a745c35df8",
            "parentType": "merchProduct",
            "catalogSkuId": "227ccd8a-3b4c-3320-8888-5d2f535c7217",
            "modificationDate": "2017-09-07T12:39:48.223Z",
            "merchGroup": "US",
            "stockKeepingUnitId": "19281872",
            "gtin": "00885176589166",
            "nikeSize": "7",
            "countrySpecifications": [
                {
                    "country": "US",
                    "localizedSize": "7",
                    "taxInfo": {
                        "commodityCode": "531119.100",
                        "vat": 0
                    }
                }
            ],
            "resourceType": "merchSku",
            "links": {
                "self": {
                    "ref": "/merch/skus/v2/afb793c5-1bfe-5ec3-a7f7-63e7ea59db13?country=US"
                }
            }
        },
        {
            "id": "817e6fa3-fba3-52a2-b851-808218528775",
            "snapshotId": "196fd2cb-76d0-4009-9764-aee7e16e7bce",
            "productId": "ab9c9789-1a35-503c-8a22-95a745c35df8",
            "parentId": "ab9c9789-1a35-503c-8a22-95a745c35df8",
            "parentType": "merchProduct",
            "catalogSkuId": "07306de8-1316-3e7c-895c-d237f21d35d3",
            "modificationDate": "2017-09-07T12:39:48.223Z",
            "merchGroup": "US",
            "stockKeepingUnitId": "19281867",
            "gtin": "00885176589180",
            "nikeSize": "7.5",
            "countrySpecifications": [
                {
                    "country": "US",
                    "localizedSize": "7.5",
                    "taxInfo": {
                        "commodityCode": "531119.100",
                        "vat": 0
                    }
                }
            ],
            "resourceType": "merchSku",
            "links": {
                "self": {
                    "ref": "/merch/skus/v2/817e6fa3-fba3-52a2-b851-808218528775?country=US"
                }
            }
        }
     ],
    "errors":[]
}
```

Sample 404 error response from *Merchandised Product SKU List*:

```
{
    "pages": {},
    "objects": [],
    "errors": [
        {
            "requested": "productid(null)",
            "httpStatus": 404,
            "message": "Resource Not Found"
        }
    ]
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/merchcommonapi/browse/apis/skus/API.md?raw#!/Sku/get_merch_skus_v2" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

### Merchandised Product SKU by ID

Use this service to search for SKU information by SKU ID. This service returns the same data as the [Merchandised Product SKU List](#merchandised-product-sku-list) endpoint returns except for the pages object because the endpoint only returns one result. In order to get a SKU ID, you can query the *Merchandised Product SKU List* endpoint filtering by productid.

>**TIP:** If you know the SKU ID, this endpoint yields faster results than the [Merchandised Product SKU List](#merchandised-product-sku-list) endpoint does because it locates the SKU record directly by ID rather than filtering the results.

### Merchandised Product SKU by ID Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/skus/v2/{id}`|No|

### Path and Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|path|SKU ID|string|**Required**|
|**snapshotId**|query|Unique ID in UUID format indicating a version of the SKU|string|Optional|
|**fields**|query|List of fields to return. if not sent, all fields are returned|string|Optional|
|**country**|query|[Country](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) used to localize results|string|Optional|

#### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|No|
|**Content-Type**|Content type of the request, application/json is only value allowed|No|

#### Request Body

Required parts of the request body:

No body is required for a GET request.

|I Want to List SKU UUID|Sample Query|
|---|---|
|036006d4-fdb7-55f6-9430-9eaf239ce22f|https://api.nike.com/merch/skus/v2/036006d4-fdb7-55f6-9430-9eaf239ce22f|
|036006d4-fdb7-55f6-9430-9eaf239ce22f in Finland|https://api.nike.com/merch/skus/v2/036006d4-fdb7-55f6-9430-9eaf239ce22f?country=FI|

Sample Product SKU by ID request URI:

```
https://api.nike.com/merch/skus/v2/afb793c5-1bfe-5ec3-a7f7-63e7ea59db13
```

#### Response Body

Sample *Merchandised Product SKU By ID* 200 successful response:

>**TIP:** See the [Merchandised Product SKU List](#merchandised-product-sku-list) endpoint to view the list of field definitions.

```
{
    "id": "afb793c5-1bfe-5ec3-a7f7-63e7ea59db13",
    "snapshotId": "1292dfcb-b817-4595-b9f9-2dd582c988f0",
    "productId": "ab9c9789-1a35-503c-8a22-95a745c35df8",
    "parentId": "ab9c9789-1a35-503c-8a22-95a745c35df8",
    "parentType": "merchProduct",
    "catalogSkuId": "227ccd8a-3b4c-3320-8888-5d2f535c7217",
    "modificationDate": "2017-09-07T12:39:48.223Z",
    "merchGroup": "US",
    "stockKeepingUnitId": "19281872",
    "gtin": "00885176589166",
    "nikeSize": "7",
    "countrySpecifications": [
        {
            "country": "US",
            "localizedSize": "7",
            "taxInfo": {
                "commodityCode": "531119.100",
                "vat": 0
            }
        }
    ],
    "resourceType": "merchSku",
    "links": {
        "self": {
            "ref": "/merch/skus/v2/afb793c5-1bfe-5ec3-a7f7-63e7ea59db13"
        }
    }
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/merchcommonapi/browse/apis/skus/API.md?raw#!/Sku/get_merch_skus_v2_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

## Using Merchandised Product Prices

- [MERCHANDISED PRICES LIST](#merchandised-prices-list)

- [MERCHANDISED PRICES BY ID](#merchandised-prices-by-id)

### Merchandised Product Prices Overview

Use this API to list, create and delete product prices.

- Search for a specific version of the object by ID and Snapshot ID. Searching by a filter other than **snapshotId** returns the most recent version.
- Filter field names are case-insensitive.
- One product’s price data is returned if searching by price ID.
- All endpoints are synchronous.

The following sections describe each endpoint of the Merchandised Product Price API in detail.

### Merchandised Prices List

Use this endpoint to list price data by price ID or by product ID and [country](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products). Because price values and currency are localized, both country and productid are required parameters when searching by productid. Country is not required when searching by price ID because the price record for a price ID is for a specific country. To get the price ID in the results, first search by productid and country. If you do not know the product id, use the [Merchandised Product List](#merchandised-product-list) endpoint to search by style-color or style. Product ID is returned in the results.

No special headers are required to use this endpoint so it can be executed in any browser, and the customer does not have to be logged in.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/prices/v2{?filter,fields,anchor,count}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**filter**|query|productId + [country](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) or price ID|String|**Required**|
|**snapshotId**|query|ID representing the price version|String|Optional|
|**count**|query|Number of results to return, default = 25, max = 25|Integer|Optional|
|**anchor**|query|If the value is 10, results returned start with result 11|Integer|Optional|

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body

There is no request body for a GET request.

Let's take a look at *Merchandised Price List* scenarios.

|I Want to List Prices for|Sample Query|
|---|---|
|Product UUID and a specific location (e.g. Ireland)|https://api.nike.com/merch/prices/v2/?filter=productid(58aaa694-5889-5965-a781-6abcc3e4ff68)&filter=country(IE)|
|Price UUID 486d098c-a403-5fb7-8305-243d71625d4c and snapshotId 678408f9-0eea-4560-b537-e85c131e9495|https://api.nike.com/merch/prices/v2/?filter=id(486d098c-a403-5fb7-8305-243d71625d4c)&filter=snapshotId(85ebb452-f61c-46a2-b0ce-14a89a542816)|

Note that for the **productid** + [**country**](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) price queries, there is a different price record for each country. Querying by ID is for a specific country.

### Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**pages**|object|Object with a **next** and **prev** link used to paginate results|Optional|
|pages.**prev**|string|Relative URL to the previous page of results|Optional|
|pages.**next**|string|Relative URL to the next page of results|Optional|
|**id**|string|ID of the price in UUID format, generated when product flows into Merchandised Price from Prodigy|Required|
|**snapshotId**|string|ID of the most recent snapshot of the price in UUID format|Required|
|**productId**|string|ID of product this price belongs to|Required|
|**parentId**|string|ID of parent product this price belongs to, alias for productId|Optional|
|**parentType**|string|Type of parent product, always merchProduct|Optional|
|**modificationDate**|string|Timestamp the price was last modified|Required|
|**country**|string|Country of this price, see [Merchandised Product Field Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) for a complete list|Required|
|**msrp**|number|Manufacturer's recommended retail price. often not provided or may be 0|Required|
|**fullPrice**|number|Nike's original, retail price used for display purposes when a product is discounted and the full retail price is displayed with a strike-through (e.g. a clearance product) and used by the [Buy API](/doc/commerce/checkout/api_checkout.html#using-checkouts) to calculate the difference between current retail price and full retail price to send to fulfillment system|Required|
|**currentPrice**|number|Purchase price of product. if discounted, price is calculated in Prodigy/PI|Required|
|**employeePrice**|number|Employee price of product|Required|
|**currency**|string|Localized currency according to country|Required|
|**discounted**|boolean|True or false indicating this product is on sale set by the Price Class field in Prodigy/PI|Required|
|**promoInclusions**|array|Array of promotions associated with this price|Required|
|**promoExclusions**|array|Array of true or false values indicating if promo exclusions apply to this price|Required|
|**resourceType**|string|Type of resource, always merchSku|Required|
|links.self.**ref**|string|Referrer link to result|Required|
|errors.**requested**|string|Error message indicating which field caused the error|Required|
|errors.**httpStatus**|integer|HTTP error response code|Required|
|errors.**message**|string|Detailed error message|Required|

Sample *Merchandised Prices List* 200 successful response:

```
{
  "pages" : { },
  "objects" : [ {
    "id" : "486d098c-a403-5fb7-8305-243d71625d4c",
    "snapshotId" : "85ebb452-f61c-46a2-b0ce-14a89a542816",
    "productId" : "58aaa694-5889-5965-a781-6abcc3e4ff68",
    "parentId" : "58aaa694-5889-5965-a781-6abcc3e4ff68",
    "parentType" : "merchProduct",
    "modificationDate" : "2017-06-06T17:39:16.405Z",
    "country" : "IE",
    "msrp" : 170,
    "fullPrice" : 170,
    "currentPrice" : 118.99,
    "currency" : "EUR",
    "discounted" : true,
    "promoInclusions" : [ ],
    "promoExclusions" : [ ],
    "resourceType" : "merchPrice",
    "links" : {
      "self" : {
        "ref" : "/merch/prices/v2/486d098c-a403-5fb7-8305-243d71625d4c"
      }
    }
  } ],
  "errors" : [ ]
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/merchcommonapi/browse/apis/prices/API.md?raw#!/Prices/get_merch_prices_v2" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

### Merchandised Prices by ID

Use this endpoint to list price data by price ID. To get the price ID, search by productid and [country](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) using the [Merchandised Prices List](#merchandised-prices-list) endpoint and Price ID is returned in the results. If you do not know the product id, use the [Merchandised Product List](#merchandised-product-list) endpoint to search by style-color or style. Product ID is returned in the results.

Results from this endpoint are almost identical to those returned from the [Merchandised Product List](#merchandised-product-list) endpoint. The difference is no pagination data is returned and you can only search by one price ID at a time.

No special headers are required to use this endpoint so it can be executed in any browser, and the customer does not have to be logged in.

>**TIP:** If you know the price ID, this endpoint yields faster results than the [Merchandised Prices List](#merchandised-prices-list) endpoint does because it locates the price record directly by ID rather than filtering the results.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/prices/v2/{id}?{snapshotId}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**filter**|Path|Field list and values to search for. ID or productid + country is required.<br>maximum of one country is supported|String|**Required**|
|**snapshotId**|Query|ID representing the product version, allowed in listing by price ID only|String|Optional|

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body

There is no request body for a GET request.

Let's take a look at some *Merchandised Price by ID* scenarios.

|I Want to List Merchandised Price for|Sample Query|
|---|---|
|price ID 486d098c-a403-5fb7-8305-243d71625d4c|https://api.nike.com/merch/prices/v2/486d098c-a403-5fb7-8305-243d71625d4c|
|price ID 486d098c-a403-5fb7-8305-243d71625d4c and snapshotId 85ebb452-f61c-46a2-b0ce-14a89a542816|https://api.nike.com/merch/prices/v2/486d098c-a403-5fb7-8305-243d71625d4c?filter=snapshotId(85ebb452-f61c-46a2-b0ce-14a89a542816)

Sample *Merchandised Price by ID* request URI:

```
https://api.nike.com/merch/prices/v2/486d098c-a403-5fb7-8305-243d71625d4c
```

### Response Body

See the [Merchandised Prices List](#merchandised-product-list) endpoint for a description of response body field descriptions.

Sample *Merchandised Price by ID* 200 success response:

```
{
  "id" : "486d098c-a403-5fb7-8305-243d71625d4c",
  "snapshotId" : "85ebb452-f61c-46a2-b0ce-14a89a542816",
  "productId" : "58aaa694-5889-5965-a781-6abcc3e4ff68",
  "parentId" : "58aaa694-5889-5965-a781-6abcc3e4ff68",
  "parentType" : "merchProduct",
  "modificationDate" : "2017-06-06T17:39:16.405Z",
  "country" : "IE",
  "msrp" : 170,
  "fullPrice" : 170,
  "currentPrice" : 118.99,
  "currency" : "EUR",
  "discounted" : true,
  "promoInclusions" : [ ],
  "promoExclusions" : [ ],
  "resourceType" : "merchPrice",
  "links" : {
    "self" : {
      "ref" : "/merch/prices/v2/486d098c-a403-5fb7-8305-243d71625d4c"
    }
  }
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/merchcommonapi/browse/apis/prices/API.md?raw#!/Prices/get_merch_prices_v2_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

----

## Using Merchandised VAS

- [MERCHANDISED VALUE ADDED SERVICES LIST](#merchandised-value-added-services-list)

- [MERCHANDISED VALUE ADDED SERVICES BY ID](#merchandised-value-added-services-by-id)

### Merchandised Value Added Services Overview

Products can be merchandised with one or more Value Added Services (VAS) such as gift wrap or personalization. Digital and physical gift cards are another example of VAS as customers can personalize the gift message and configure the amount. A VAS can be merchandised to an unlimited number of products. Use this service to list, add, and delete VAS.

- Search for a specific version of the object by ID and Snapshot ID. Searching by a filter other than **snapshotId** returns the most recent version.
- Filter field names are case-insensitive.
- One VAS is returned if searching by VAS ID.
- All endpoints are synchronous.

Note that the VAS services return a field named pid. Even though this field implies a one-to-one relationship between product and VAS, this field is a legacy ID used for reporting purposes in Prodigy. Products can have several Value-Added Service objects associated with them.

The following sections describe each endpoint of the Merchandised Value Added Services API in detail.

### Merchandised Value Added Services List

Use this endpoint to list VAS by type or by VAS ID. Listing by multiple IDs is supported.

If you want to search by VAS ID but do not know it, call the [Merchandised Product List](#merchandised-product-list) endpoint first. The value_added_service ID will be returned in the search results for each product that has one or more value-added service attributes.

The customer does not have to be logged in to call this endpoint.

This endpoint requires no special headers so you can execute test calls in any browser.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/value_added_services/v1{?filter,fields,count,anchor}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**filter**|Query|Values to search for, ID or type is supported|String|Optional|
|**fields**|query|List of fields to return. if not sent, all fields are returned|string|Optional|
|**count**|Query|Number of results to return, default = 25, max = 25|Integer|Optional|
|**anchor**|Query|If the value is 10, results returned start with result 11|Integer|Optional|

Let's take a look at some *Merchandised Value Added Services List* scenarios.

|I Want to List VAS Details for|Sample Query|
|---|---|
|VAS type DIGITAL_GIFT_CARD|https://api.nike.com/merch/value_added_services/v1?filter=type(DIGITAL_GIFT_CARD)|
|VAS ID 47bc9091-2965-5231-b5f1-a7216e249894|https://api.nike.com/merch/value_added_services/v1?filter=id(47bc9091-2965-5231-b5f1-a7216e249894)|
|VAS ID 124ae4cb-0506-5b52-98c0-06eaf7b7ea67 and VAS ID 47bc9091-2965-5231-b5f1-a7216e249894|https://api.nike.com/merch/value_added_services/v1?filter=id(124ae4cb-0506-5b52-98c0-06eaf7b7ea67,47bc9091-2965-5231-b5f1-a7216e249894)|
|VAS ID 47bc9091-2965-5231-b5f1-a7216e249894 and Snapshot ID 52ca6f5b-fde9-4daf-af65-3993ef7eb428|https://api.nike.com/merch/value_added_services/v1?filter=id(afd90c5b-230f-5fd3-b3a4-af36c5dbd55d)&filter=snapshotId(e0861083-f3a3-4120-bc30-29888113e940)|
|all available VAS|https://api.nike.com/merch/value_added_services/v1|

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body

There is no body in a GET request.

### Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**pages**|object|Object with a **next** and **prev** link used to paginate results|Optional|
|pages.**prev**|string|Relative URL to the previous page of results|Optional|
|pages.**next**|string|Relative URL to the next page of results|Optional|
|**id**|string|ID of the VAS in UUID format, generated when VAS flows into Merchandised VAS from Prodigy|Required|
|**snapshotId**|string|ID of the most recent snapshot of the VAS in UUID format|Required|
|**modificationDate**|string|Timestamp the VAS was last modified|Required|
|**status**|string|VAS status, see [Merchandised Product Field Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) for a complete list|Required|
|**merchGroup**|string|Merchandising group this VAS is merchandised to, see [Merchandised Product Field Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) for a complete list|Required|
|**pid**|string|Legacy product id used to map to the product UUID|Required|
|**type**|string|VAS type|Required|
|**displayName**|string|VAS display name|Optional|
|**commercePublishDate**|string|Timestamp indicating when this VAS was published|Optional|
|**commerceStartDate**|string|Timestamp indicating when the VAS is available|Optional|
|**resourceType**|string|Type of resource, always "merchValueAddedService"|Required|
|links.self.**ref**|string|Referrer link to result|Required|

Sample *Merchandised Value Added Services List* 200 successful response:

```
{
  "pages" : {
    "prev" : "/merch/value_added_services/v1?count=25&filter=type(PERSONALIZATION)"
  },
  "objects" : [ {
    "id" : "4a5c81c4-840d-5672-9db0-958105676ead",
    "snapshotId" : "798f7ea0-e100-4f9a-a9f9-566d147f6841",
    "modificationDate" : "2017-02-01T03:38:30.741Z",
    "status" : "ACTIVE",
    "merchGroup" : "US",
    "pid" : "11820995",
    "type" : "PERSONALIZATION",
    "displayName" : "VAS0011-996 MyPrint VAS - 20 USD",
    "commercePublishDate" : "2016-12-15T21:19:18.000Z",
    "commerceStartDate" : "2016-12-15T17:00:00.000Z",
    "resourceType" : "merchValueAddedService",
    "links" : {
      "self" : {
        "ref" : "/merch/value_added_services/v1/4a5c81c4-840d-5672-9db0-958105676ead"
      }
    }
  }, {
    "id" : "59277764-f748-5572-8195-f1958d9baccb",
    "snapshotId" : "4b8c149f-0296-4cf9-b5a4-266aee02f00a",
    "modificationDate" : "2017-05-22T01:33:46.744Z",
    "status" : "CLOSEOUT",
    "merchGroup" : "US",
    "pid" : "11067215",
    "type" : "PERSONALIZATION",
    "displayName" : "VAS0007-996 PiD VAS - Black Text only",
    "commercePublishDate" : "2015-09-21T18:29:32.000Z",
    "commerceStartDate" : "2015-09-11T23:05:00.000Z",
    "resourceType" : "merchValueAddedService",
    "links" : {
      "self" : {
        "ref" : "/merch/value_added_services/v1/59277764-f748-5572-8195-f1958d9baccb"
      }
    }
  }
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/merchcommonapi/browse/apis/value_added_services/API.md?raw#!/Value_Added_Services/get_merch_value_added_services_v1" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

### Merchandised Value Added Services by ID

Use this endpoint when you want to list the fields for one VAS ID. This endpoint returns almost identical results as the [Merchandised Value Added Services List](#merchandised-value-added-services-list) endpoint returns except that it does not return pagination information because it returns only one VAS object. This endpoint returns a quicker response than the Merchandised Value Added Services List endpoint because it does not filter or paginate the results.

If you do not know the VAS ID, call the [Merchandised Product List](#merchandised-product-list) endpoint first. The value_added_service ID will be returned in the search results for each product that has one or more VAS attributes.

The customer does not have to be logged in to call this endpoint.

This endpoint requires no special headers so you can execute test calls in any browser.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/value_added_services/v1/{id}/{?snapshotId,fields}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|VAS ID|String|**Required**|
|**snapshotId**|Query|ID representing the product version, allowed in listing by price ID only|String|Optional|
|**fields**|Query|List of fields to return. If not supplied, all fields are returned|String|Optional|

Let's take a look at some *Merchandised Value Added Services by ID* scenarios.

|I Want to List VAS Details for|Sample Query|
|---|---|
|ID 56e48cf5-050f-51a7-b6ce-1ca5ab9d415b|https://api.nike.com/merch/value_added_services/v1?filter=id(47bc9091-2965-5231-b5f1-a7216e249894)|
|ID 56e48cf5-050f-51a7-b6ce-1ca5ab9d415b and Snapshot ID 52ca6f5b-fde9-4daf-af65-3993ef7eb428|https://api.nike.com/merch/value_added_services/v1/56e48cf5-050f-51a7-b6ce-1ca5ab9d415b?snapshotId=566ba45b-898b-4f19-a743-c12e8a753945|
|ID 56e48cf5-050f-51a7-b6ce-1ca5ab9d415b and only return pid and type fields|https://api.nike.com/merch/value_added_services/v1/56e48cf5-050f-51a7-b6ce-1ca5ab9d415b?fields=(status,pid,type)|

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body

There is no body in a GET request.

### Response Body

See the [Merchandised Value Added Services List Response Body](#merchandised-value-added-services-list) endpoint for a list of VAS field descriptions returned in the response.

Sample *Merchandised Value Added Services by ID* 200 successful response:

```
{
  "id" : "124ae4cb-0506-5b52-98c0-06eaf7b7ea67",
  "snapshotId" : "99e78ccb-182c-4b65-9e21-bc7214d757d7",
  "modificationDate" : "2017-02-03T07:04:15.797Z",
  "status" : "CLOSEOUT",
  "merchGroup" : "US",
  "pid" : "10085087",
  "type" : "DIGITAL_GIFT_CARD",
  "displayName" : "Nike Gift Card",
  "commerceStartDate" : "2010-12-01T00:00:00.000Z",
  "resourceType" : "merchValueAddedService",
  "links" : {
    "self" : {
      "ref" : "/merch/value_added_services/v1/124ae4cb-0506-5b52-98c0-06eaf7b7ea67"
    }
  }
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/merchcommonapi/browse/apis/value_added_services/API.md?raw#!/Value_Added_Services/get_merch_value_added_services_v1_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

## Using Product Content

- [PRODUCT CONTENT BY STYLE COLOR](#product-content-by-style-color)
- [PRODUCT CONTENT BY STYLE COLOR LIST](#product-content-by-style-color-list)
- [PRODUCT CONTENT ITEM BY STYLE COLOR](#product-content-item-by-style-color)
- [PRODUCT CONTENT FIELD BY STYLE COLOR LIST](#product-content-field-by-style-color-list)
- [PRODUCT IMAGE SET BY STYLE COLOR](#product-image-set-by-style-color)
- [PRODUCT BASE IMAGE URL BY STYLE COLOR](#product-base-image-url-by-style-color)
- [PRODUCT IMAGE SET BY STYLE COLOR LIST](#product-image-set-by-style-color-list)
- [PRODUCT BASE IMAGE URL BY STYLE COLOR LIST](#product-base-image-url-by-style-color-list)

### Product Content Overview

Use these services to list product content such as title, subtitle, description, and images by [country](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) and locale.

There are two sets of Product Content services, internal and external. External services go through the public router (api.nike.com and snkrs.prod.commerce.nikecloud.com) and return product information for products in the ACTIVE and CLOSEOUT status. Internal services go through the frame router (frame.prod.commerce.nikecloud.com). These services return identical fields to the external services but they return all products regardless of status. When making service to service calls, use the internal Product Content endpoints.

All endpoints are synchronous.

The following sections describe each endpoint of the Product Content Services API in detail.

### Product Content by Style Color

Use this endpoint to list localized product content for a style-color, [country](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) and locale.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/contents/v1/{style-color}/content{?country,locale}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**style-color**|Path|Style-color code of content|String|Required|
|**country**|Query|Country used to localize the content for the correct country, see [Merchandised Product Field Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) for a complete list|String|Required|
|**locale**|Query|Locale used to localize the content for the correct language|String|Required|

Let's take a look at some *Product Content by Style Color* scenarios.

|I Want to List Product Content for|Sample Query|
|---|---|
|Style-color code 919704-006 in Spain for locale es_ES|https://api.nike.com/merch/contents/v1/919704-006/content?country=ES&locale=es_ES|

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body

There is no request body for a GET request.

Sample *Product Content by Style Color* URI:

```
https://api.nike.com/merch/contents/v1/919704-006/content?country=ES&locale=es_ES
```

### Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**globalPid**|string|Global product ID from legacy system|Optional|
|**parentId**|string|ID of parent product in UUID format|Optional|
|**parentType**|string|Type of parent product, always merchProduct|Optional|
|**langLocale**|string|Locale of product content|Optional|
|**colorDescription**|string|Localized color description|Optional|
|**slug**|string|Slug ID of the product|Optional|
|**fullTitle**|string|Localized full title of product|Required|
|**title**|string|Localized short title of product|Optional|
|**subtitle**|string|Localized subtitle of product|Optional|
|**descriptionHeading**|string|Localized heading description|Optional|
|**description**|string|Localized long description of product|Optional|
|**headLine**|string|Localized headline of product|Optional|
|**preOrder**|string|Localized preorder text|Optional|
|**softLaunch**|string|Localized soft launch text|Optional|
|**outOfStock**|string|Localized out of stock text|Optional|
|**notifyMe**|string|Localized notify me text|Optional|
|**accessCode**|string|Localized access code text|Optional|
|**pdpGeneral**|string|Key for custom messaging e.g. preOrder or notifyMe|Optional|
|**productName**|string|Localized product name|Optional|
|**techSpec**|string|Localized technical specification text|Optional|
|**benefitSummaryList**|string|Localized list of benefits text|Optional|
|**benefitSummaryVideo**|string|Localized benefits video URI|Optional|
|**manufacturingCountryOfOrigin**|string|Localized name of country where product was manufactured|Optional|
|**shippingDelay**|integer|Integer value representing when the customer must be notified of a shipping delay|Optional|
|**sizeChart**|string|Key of size chart for this product|Optional|
|**imageBadgeResource**|string|Relative URI to image such as "Editor's Choice" image|Optional|
|**colors**|array|Array of color items associated with this product|Optional|
|colors.**type**|string|Type of color e.g. simple, primary or secondary|Optional|
|colors.**name**|string|Localized color|Optional|
|colors.**hex**|string|Color hex value|Optional|
|**bestFor**|array|Array of bestFor items|Optional|
|bestFor.**value**|string|'Best for' value such as surface best used on|Optional|
|bestFor.**localizedValue**|string|Localized value such as surface best used on|Optional|
|bestFor.**type**|string|'Best for' type|Optional|
|**athletes**|array|Array of athlete items|Optional|
|athletes.**value**|string|Athlete value, such as athlete's name|Optional|
|athletes.**localizedValue**|string|Athlete value, localized athlete name|Optional|
|**widths**|array|Array of widths|Optional|
|widths.**type**|string|Width type|Optional|
|widths.**value**|string|Internal width value|Optional|
|widths.**localizedValue**|string|Localized width value|Optional|

Sample *Product Content by Style Color* response body:

```
{
  "globalPid" : "11825501",
  "parentId" : "d48fbb0b-4516-5075-8a8f-32401eed44af",
  "parentType" : "merchProduct",
  "langLocale" : "es_ES",
  "colorDescription" : "Negro/Blanco/Royal juego",
  "slug" : "air-jordan-1-retro-high-flyknit-zapatillas",
  "fullTitle" : "Air Jordan 1 Retro High Flyknit Zapatillas - Hombre",
  "title" : "Air Jordan 1 Retro High Flyknit",
  "subtitle" : "Zapatillas - Hombre",
  "descriptionHeading" : "AIRE RETRO. TOQUES MODERNOS.",
  "description" : "<div class=\"pi-tier3\"><div class=\"pi-pdpmainbody\"><p><b>AIRE RETRO. TOQUES MODERNOS.</b></p><br><p>Las zapatillas Air Jordan 1 Retro High Flyknit para hombre actualizan el icónico diseño original con un tejido Flyknit ligero y flexible.</p><br><p><b>Ventajas</b></p><br>Ligero material Flyknit para una mayor transpirabilidad y flexibilidad<br>Detalles de piel de cuero de cerdo para un look premium<br>Confección con cupsole de goma para proporcionar una sujeción resistente y una mayor tracción<br>Unidad Nike Air para disfrutar de una amortiguación ligera<br><p><b>Orígenes de Flyknit</b></p>La tecnología Nike Flyknit se inspira en las opiniones de atletas que llevan tiempo buscando unas zapatillas con el ajuste ceñido y la sensación de no llevar nada, como la de un calcetín. Nike se embarcó en un proyecto de cuatro años con equipos de programadores, ingenieros y diseñadores para crear una tecnología que ayudase a confeccionar una parte superior tejida con propiedades estáticas que aportara estructura y durabilidad. Más adelante, se ajustó la distribución precisa de las partes que aportan sujeción, transpirabilidad y flexibilidad, todo en una sola capa. El resultado es una parte superior extremadamente ligera, ceñida y prácticamente sin costuras. Esta precisión sin precedentes multiplica el rendimiento y disminuye el desperdicio de materiales en un 60 % en comparación con la confección tradicional, lo que permite reducir drásticamente las enormes cantidades de materiales que se depositan en los vertederos.</div></div>",
  "headLine" : null,
  "preOrder" : null,
  "softLaunch" : null,
  "outOfStock" : null,
  "notifyMe" : null,
  "accessCode" : null,
  "pdpGeneral" : null,
  "fit" : null,
  "legal" : null,
  "marketing" : null,
  "shippingDelay" : null,
  "productName" : null,
  "techSpec" : "",
  "benefitSummaryList" : null,
  "benefitSummaryVideo" : null,
  "manufacturingCountryOfOrigin" : null,
  "sizeChart" : "mens-shoe-sizing-chart",
  "imageBadgeResource" : null,
  "colors" : [ {
    "type" : "SIMPLE",
    "name" : "Negro",
    "hex" : "13161A"
  }, {
    "type" : "PRIMARY",
    "name" : "Negro",
    "hex" : "13161A"
  }, {
    "type" : "SECONDARY",
    "name" : "Blanco",
    "hex" : "FFFFFF"
  }, {
    "type" : "LOGO",
    "name" : "Royal juego",
    "hex" : "3F518E"
  } ],
  "bestFor" : [ ],
  "athletes" : [ ],
  "widths" : [ {
    "type" : null,
    "value" : "REGULAR",
    "localizedValue" : "Normal"
  } ]
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/productcontentservice/browse/API.md?raw#public-product-content-product-content-by-style-color-get" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

### Product Content by Style Color List

Use this endpoint to list localized product content for a list of style-colors, [country](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) and locale. Only one country and locale is supported.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/contents/v1/content{?country,locale,stylecolors}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**style-color**|Query|Comma-separated list of style-color codes|String|**Required**|
|**country**|Query|Country used to localize the content for the correct country|String|**Required**|
|**locale**|Query|Locale used to localize the content for the correct language|String|**Required**|

Let's take a look at some *Product Content by Style Color List* scenarios.

|I Want to List Product Content for|Sample Query|
|---|---|
|Style-color codes 852395-601 and 919704-006, country Spain and locale es_ES|https://api.nike.com/merch/contents/v1/content?stylecolors=852395-601,919704-006&country=ES&locale=es_ES|

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body

There is no request body for a GET request.

Sample *Product Content by Style Color List* URI:

```
https://api.nike.com/merch/contents/v1/content?stylecolors=852395-601,919704-006&country=ES&locale=es_ES
```

### Response Body

See the complete response body field list in the [Product Content by Style Color Response Body](#product-content-by-style-color).

Sample *Product Content by Style Color List* response body:

```
{
  "852395-601" : {
    "globalPid" : "11993007",
    "parentId" : "78587369-2879-5dea-9b8e-adc1c389765a",
    "parentType" : "merchProduct",
    "langLocale" : "es_ES",
    "colorDescription" : "Rojo universitario/Gris lobo/Rojo universitario",
    "slug" : "kyrie-3-zapatillas-de-baloncesto",
    "fullTitle" : "Kyrie 3 Zapatillas de baloncesto",
    "title" : "Kyrie 3",
    "subtitle" : "Zapatillas de baloncesto",
    "descriptionHeading" : "DISEÑADAS PARA REALIZAR CORTES RÁPIDOS",
    "description" : "<div class=\"pi-tier3\"><div class=\"pi-pdpmainbody\"><p><b>DISEÑADAS PARA REALIZAR CORTES RÁPIDOS</b></p><br><p>Las zapatillas de baloncesto Kyrie 3 para hombre combinan una excelente tracción, sujeción flexible y amortiguación de máxima respuesta para permitir cortes precisos y un juego rápido y fluido.</p><br><p><b>Tracción excelente</b></p><p>La suela redondeada y la tracción adicional en los bordes de las zapatillas te permiten jugar desde cualquier ángulo. Las dos almohadillas debajo del antepié se agarran con firmeza al suelo cuando cambias rápidamente de dirección.</p><br><p><b>Sujeción flexible</b></p><p>En la parte superior de las zapatillas, una resistente correa elástica se flexiona con el pie para ofrecer sujeción durante los recortes rápidos y los sprints. La tecnología Flywire, con cables ultraligeros y superresistentes que se integran con los cordones, añade aún más sujeción.</p><br><p><b>Amortiguación de máxima respuesta</b></p><p>La amortiguación Nike Zoom Air de perfil bajo en el talón ofrece la máxima respuesta y comodidad durante todo el partido.</p><br><p><b>Más información</b></p><br>Ligera espuma Phylon inyectada en el antepié que aumenta al máximo la sensación en la cancha<br>Construcción HyperFuse para una sujeción y transpirabilidad duraderas<br>Diseño moldeado de tres cuartos para una mayor cantidad de detalles texturizados</div></div>",
    "headLine" : null,
    "preOrder" : null,
    "softLaunch" : null,
    "outOfStock" : null,
    "notifyMe" : null,
    "accessCode" : null,
    "pdpGeneral" : null,
    "fit" : null,
    "legal" : null,
    "marketing" : null,
    "shippingDelay" : null,
    "productName" : null,
    "techSpec" : "",
    "benefitSummaryList" : null,
    "benefitSummaryVideo" : null,
    "manufacturingCountryOfOrigin" : null,
    "sizeChart" : "unisex-shoe-sizing-chart",
    "imageBadgeResource" : null,
    "colors" : [ {
      "type" : "SIMPLE",
      "name" : "Rojo",
      "hex" : "B40033"
    }, {
      "type" : "PRIMARY",
      "name" : "Rojo universitario",
      "hex" : "982433"
    }, {
      "type" : "SECONDARY",
      "name" : "Gris lobo",
      "hex" : "A2A5AC"
    }, {
      "type" : "LOGO",
      "name" : "Rojo universitario",
      "hex" : "982433"
    } ],
    "bestFor" : [ ],
    "athletes" : [ {
      "type" : null,
      "value" : "Kyrie Irving",
      "localizedValue" : "Kyrie Irving"
    } ],
    "widths" : [ {
      "type" : null,
      "value" : "REGULAR",
      "localizedValue" : "Normal"
    } ]
  },
  "919704-006" : {
    "globalPid" : "11825501",
    "parentId" : "d48fbb0b-4516-5075-8a8f-32401eed44af",
    "parentType" : "merchProduct",
    "langLocale" : "es_ES",
    "colorDescription" : "Negro/Blanco/Royal juego",
    "slug" : "air-jordan-1-retro-high-flyknit-zapatillas",
    "fullTitle" : "Air Jordan 1 Retro High Flyknit Zapatillas - Hombre",
    "title" : "Air Jordan 1 Retro High Flyknit",
    "subtitle" : "Zapatillas - Hombre",
    "descriptionHeading" : "AIRE RETRO. TOQUES MODERNOS.",
    "description" : "<div class=\"pi-tier3\"><div class=\"pi-pdpmainbody\"><p><b>AIRE RETRO. TOQUES MODERNOS.</b></p><br><p>Las zapatillas Air Jordan 1 Retro High Flyknit para hombre actualizan el icónico diseño original con un tejido Flyknit ligero y flexible.</p><br><p><b>Ventajas</b></p><br>Ligero material Flyknit para una mayor transpirabilidad y flexibilidad<br>Detalles de piel de cuero de cerdo para un look premium<br>Confección con cupsole de goma para proporcionar una sujeción resistente y una mayor tracción<br>Unidad Nike Air para disfrutar de una amortiguación ligera<br><p><b>Orígenes de Flyknit</b></p>La tecnología Nike Flyknit se inspira en las opiniones de atletas que llevan tiempo buscando unas zapatillas con el ajuste ceñido y la sensación de no llevar nada, como la de un calcetín. Nike se embarcó en un proyecto de cuatro años con equipos de programadores, ingenieros y diseñadores para crear una tecnología que ayudase a confeccionar una parte superior tejida con propiedades estáticas que aportara estructura y durabilidad. Más adelante, se ajustó la distribución precisa de las partes que aportan sujeción, transpirabilidad y flexibilidad, todo en una sola capa. El resultado es una parte superior extremadamente ligera, ceñida y prácticamente sin costuras. Esta precisión sin precedentes multiplica el rendimiento y disminuye el desperdicio de materiales en un 60 % en comparación con la confección tradicional, lo que permite reducir drásticamente las enormes cantidades de materiales que se depositan en los vertederos.</div></div>",
    "headLine" : null,
    "preOrder" : null,
    "softLaunch" : null,
    "outOfStock" : null,
    "notifyMe" : null,
    "accessCode" : null,
    "pdpGeneral" : null,
    "fit" : null,
    "legal" : null,
    "marketing" : null,
    "shippingDelay" : null,
    "productName" : null,
    "techSpec" : "",
    "benefitSummaryList" : null,
    "benefitSummaryVideo" : null,
    "manufacturingCountryOfOrigin" : null,
    "sizeChart" : "mens-shoe-sizing-chart",
    "imageBadgeResource" : null,
    "colors" : [ {
      "type" : "SIMPLE",
      "name" : "Negro",
      "hex" : "13161A"
    }, {
      "type" : "PRIMARY",
      "name" : "Negro",
      "hex" : "13161A"
    }, {
      "type" : "SECONDARY",
      "name" : "Blanco",
      "hex" : "FFFFFF"
    }, {
      "type" : "LOGO",
      "name" : "Royal juego",
      "hex" : "3F518E"
    } ],
    "bestFor" : [ ],
    "athletes" : [ ],
    "widths" : [ {
      "type" : null,
      "value" : "REGULAR",
      "localizedValue" : "Normal"
    } ]
  }
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/productcontentservice/browse/API.md?raw#public-product-content-product-content-by-stylecolor-list-get" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

### Product Content Item by Style Color

Use this endpoint to list one item (field) of product content for a style-color, [country](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) and locale. Only one style-color, itemName, country and locale is supported. You can use any valid itemName in the path parameter.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/contents/v1/{styleColor}/content/{itemName}{?country,locale}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**style-color**|Path|Style-color code|String|**Required**|
|**itemName**|Path|Any product content item name e.g. colorDescription or title|String|**Required**|
|**country**|Query|Country used to localize the content, see [Merchandised Product Field Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) for a complete list|String|**Required**|
|**locale**|Query|Locale used to localize the content for the correct language|String|**Required**|

Let's take a look at some *Product Content Item by Style Color* scenarios.

|I Want to List Product Content for|Sample Query|
|---|---|
|Title information for style-color code 919704-006, country Spain and locale es_ES|https://api.nike.com/merch/contents/v1/919704-006/content/title?country=ES&locale=es_ES|

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body

There is no request body for a GET request.

Sample *Product Content by Style Color List* URI:

```
https://api.nike.com/merch/contents/v1/919704-006/content/title?country=ES&locale=es_ES
```

### Response Body

Sample *Product Content Item by Style Color List* response body:

>**TIP:** The response body returns the value of the **itemName** path parameter and the locale query parameter.

```
{
  "locale" : "es_ES",
  "title" : "Air Jordan 1 Retro High Flyknit"
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/productcontentservice/browse/API.md?raw#public-product-content-product-content-item-by-style-color-get" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

### Product Content Field by Style Color List

Use this endpoint to list one item (field) of product content for a list of style-colors, [country](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products) and locale. Only one itemName, country and locale is supported. You can use any valid itemName in the path parameter.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/contents/v1/content/{fieldname}{?country,locale,stylecolors}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**fieldname**|Path|Any product content item name e.g. colorDescription or title|String|**Required**|
|**style-color**|Query|Comma-separated list of style-color codes|String|**Required**|
|**country**|Query|Country used to localize the content for the correct country|String|**Required**|
|**locale**|Query|Locale used to localize the content for the correct language|String|**Required**|

Let's take a look at some *Product Content Field by Style Color List* scenarios.

|I Want to List Product Content for|Sample Query|
|---|---|
|Title information for style-color codes 852395-601 and 919704-006, country Spain and locale es_ES|https://api.nike.com/merch/contents/v1/content/descriptionHeading?country=ES&locale=es_ES&stylecolors=852395-601,919704-006|

### Request Headers

Required request headers:

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body

There is no request body for a GET request.

Sample *Product Content Item by Style Color List* URI:

```
https://api.nike.com/merch/contents/v1/content/descriptionHeading?country=ES&locale=es_ES&stylecolors=852395-601,919704-006
```

### Response Body

Sample *Product Content Item by Style Color List* response body:

>**TIP:** The response body returns the value of the itemName path parameter and the style-color query parameter.

```
{
  "852395-601" : "DISEÑADAS PARA REALIZAR CORTES RÁPIDOS",
  "919704-006" : "AIRE RETRO. TOQUES MODERNOS."
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/productcontentservice/browse/API.md?raw#public-product-content-product-content-field-by-stylecolor-list-get" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

### Product Image Set by Style Color

Use this endpoint to list the images associated with a style-color and country.

Product images are stored in Scene 7. A Nike product often has multiple images associated with it, each displaying the product from a different angle. This group of images is called an image set in Scene 7.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/contents/v1/{styleColor}/images{?country}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**style-color**|Path|Style-color code|String|**Required**|
|**country**|Query|Image country|String|**Required**|

Let's take a look at some *Product Image Set by Style Color* scenarios.

|I Want to List Product Image Set for|Sample Query|
|---|---|
|Style-color code 919704-006 and country Spain|hhttps://api.nike.com//merch/contents/v1/919704-006/images?country=ES|

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body

There is no request body for a GET request.

Sample *Product Image Set by Style Color* URI:

```
https://api.nike.com//merch/contents/v1/919704-006/images?country=ES
```

### Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**name**|string|Image set name, usually the style-color code|Required|
|**type**|string|Image set type, always img_set|Required|
|**title**|string|Image set title e.g. Air-Jordan-1-Retro-High-Flyknit|Required|
|**defaultDomains**|array|Array of domains the image set is served from|Required|
|**images**|array|Array of image objects that make up the image set|Required|
|images.**company**|string|Image company code|Required|
|images.**view**|string|Key of image view of product, usually in the format stylecode_colorcode_imageletter_type|Required|

Sample *Product Image Set by Style Color* response body:

```
{
  "name" : "919704_006",
  "type" : "img_set",
  "title" : "Air-Jordan-1-Retro-High-Flyknit",
  "defaultDomains" : [ "images.nike.com/is/image", "images2.nike.com/is/image", "images3.nike.com/is/image" ],
  "images" : [ {
    "company" : "DotCom",
    "view" : "919704_006_A_PREM"
  }, {
    "company" : "DotCom",
    "view" : "919704_006_B_PREM"
  }, {
    "company" : "DotCom",
    "view" : "919704_006_C_PREM"
  }, {
    "company" : "DotCom",
    "view" : "919704_006_D_PREM"
  }, {
    "company" : "DotCom",
    "view" : "919704_006_E_PREM"
  }, {
    "company" : "DotCom",
    "view" : "919704_006_F_PREM"
  } ]
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/productcontentservice/browse/API.md?raw#public-product-images-product-image-set-by-style-color-get" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

### Product Base Image URL by Style Color

Use this endpoint to list the first image in the image set for a style-color. This is also known as the base image.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/contents/v1/{styleColor}/images/base{?country}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**style-color**|Path|Style-color code|String|**Required**|
|**country**|Query|Image country|String|**Required**|

Let's take a look at some *Product Base Image URL by Style Color* scenarios.

|I Want to List the Base Product Image for|Sample Query|
|---|---|
|Style-color code 919704-006 and country Spain|https://api.nike.com/merch/contents/v1/919704-006/images/base?country=ES|

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body

There is no request body for a GET request.

Sample *Product Base Image URL by Style Color* URI:

```
https://api.nike.com//merch/contents/v1/919704-006/images?country=ES
```

### Response Body

Sample *Product Base Image URL by Style Color* response body:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**base**|string|URI of base image|Required|

```
{
  "base" : "https://images.nike.com/is/image/DotCom/919704_006_A_PREM"
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/productcontentservice/browse/API.md?raw#public-product-images-product-base-image-url-by-style-color-get" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

### Product Image Set by Style Color List

Use this endpoint to list the image set for a list of style-color codes and country. Only one country is supported.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/contents/v1/images{?country,stylecolors}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**country**|Query|Image country|String|**Required**|
|**style-colors**|Query|List of style-color codes separated by commas|String|**Required**|

Let's take a look at some *Product Image Set by Style Color List* scenarios.

|I Want to List the Image Set for|Sample Query|
|---|---|
|Style-color codes 919704-006 and 852395-601 and country Spain|https://api.nike.com/merch/contents/v1/images%3Fcountry=ES&stylecolors=919704-006,852395-601|

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body

There is no request body for a GET request.

Sample *Product Image Set by Style Color List* URI:

```
https://api.nike.com/merch/contents/v1/images?country=ES&stylecolors=919704-006,852395-601
```

### Response Body

Sample *Product Image Set by Style Color List* response body:

See the [Product Image Set by Style Color List Response Body](#product-image-set-by-style-color-list) for a list of response body field descriptions.

```
{
  "919704-006" : {
    "name" : "919704_006",
    "type" : "img_set",
    "title" : "Air-Jordan-1-Retro-High-Flyknit",
    "defaultDomains" : [ "images.nike.com/is/image", "images2.nike.com/is/image", "images3.nike.com/is/image" ],
    "images" : [ {
      "company" : "DotCom",
      "view" : "919704_006_A_PREM"
    }, {
      "company" : "DotCom",
      "view" : "919704_006_B_PREM"
    }, {
      "company" : "DotCom",
      "view" : "919704_006_C_PREM"
    }, {
      "company" : "DotCom",
      "view" : "919704_006_D_PREM"
    }, {
      "company" : "DotCom",
      "view" : "919704_006_E_PREM"
    }, {
      "company" : "DotCom",
      "view" : "919704_006_F_PREM"
    } ]
  },
  "852395-601" : {
    "name" : "852395_601",
    "type" : "img_set",
    "title" : "Kyrie-3",
    "defaultDomains" : [ "images.nike.com/is/image", "images2.nike.com/is/image", "images3.nike.com/is/image" ],
    "images" : [ {
      "company" : "DotCom",
      "view" : "852395_601_A_PREM"
    }, {
      "company" : "DotCom",
      "view" : "852395_601_B_PREM"
    }, {
      "company" : "DotCom",
      "view" : "852395_601_C_PREM"
    }, {
      "company" : "DotCom",
      "view" : "852395_601_D_PREM"
    }, {
      "company" : "DotCom",
      "view" : "852395_601_E_PREM"
    }, {
      "company" : "DotCom",
      "view" : "852395_601_F_PREM"
    }, {
      "company" : "DotCom",
      "view" : "852395_601_G_PREM"
    } ]
  }
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/productcontentservice/browse/API.md?raw#public-product-images-product-image-set-by-stylecolor-list-get" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

### Product Base Image URL by Style Color List

Use this endpoint to list the base image for a list of style-color codes and country. Only one country is supported.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**GET**|`/merch/contents/v1/images/base{?country,stylecolors}`|No|

### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**country**|Query|Image country|String|**Required**|
|**style-colors**|Query|List of style-color codes separated by commas|String|**Required**|

Let's take a look at some *Product Base Image URL by Style Color List* scenarios.

|I Want to List the Base Product Image URL for|Sample Query|
|---|---|
|Style-color codes 919704-006 and 852395-601 and country Spain|https://api.nike.com/merch/contents/v1/images/base?country=ES&stylecolors=919704-006,852395-601|

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|Optional|
|**Content-Type**|Content type of the request, application/json is only value allowed|Optional|

### Request Body

There is no request body for a GET request.

Sample *Product Base Image URL by Style Color List* URI:

```
https://api.nike.com/merch/contents/v1/images/base?country=ES&stylecolors=919704-006,852395-601
```

### Response Body

Sample *Product Image Set by Style Color List* response body:

```
{
  "919704-006" : "https://images.nike.com/is/image/DotCom/919704_006_A_PREM",
  "852395-601" : "https://images.nike.com/is/image/DotCom/852395_601_A_PREM"
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPROD/repos/productcontentservice/browse/API.md?raw#public-product-images-product-base-image-url-by-style-color-list-get" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

## Upgrading to the Latest Version

All clients are currently calling the most recent version of Merchandised Products services. There are no upgrade notes at this time.

## Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### Use Troubleshooting Tools

Use the [Recently Published Merch Products](https://nike.splunkcloud.com/en-US/app/nike_search/search/merchproducts_){:target="blank"} Splunk dashboard to view product and VAS data recently loaded into the Merch v2 APIs. You can query products by time, environment, Merch Group and status. This is especially useful to get fresh data for testing.

Use the [Merch Products Publish Log](https://nike.splunkcloud.com/en-US/app/nike_search/search//merch_publish_debug){:target="blank"} Splunk dashboard to view the complete publish history of a style-color and Merch Group. Click a result to view all Splunk log entries associated with that publish event for a style-color and Merch Group. The results list the TraceId, useful if you need to contact the Merch Product Team for troubleshooting.

### Common Questions

**I published a change in Prodigy but it is not returned when using the Merch Product API**

It takes approximately 30 seconds for an add/update/delete record to flow to the Merchandised Products Database once it is published in Prodigy. If a change does not appear after 30 seconds by Merchandised Products API, it may be in the Prodigy queue behind other jobs with higher priority. Republish the change in Prodigy to push it again. Note that Prodigy gives a higher queue priority to an individual project change than to a change made to several products at once in a bulk update.

**The fields I need are not returned by the Merch Product API**

There could be several reasons why the product data you expect is not listed.

1. You may not be calling the correct service.
Depending upon the product data you are looking for, you may need to chain together services to get the input to the service that returns the data you need. See the [Portrait of a Product](#try-it-out-gathering-a-complete-data-set-for-a-product) section for the chain of calls you need to make to get all details for a product.

2. The data you are looking for is not set up in the upstream system.
Check the product in Prodigy to verify that it is merchandised as you expect.

3. The product data may be queued or in transit from Prodigy to the Merchandised Products database.
Wait 30 seconds and call the API again.

If none of these scenarios apply, contact the Merchandised Product team on the [#pdm-merch-product](https://nikedigital.slack.com/messages/pdm-merch-product) Slack channel for help. Supply as much of the information below to the Team as possible to help them troubleshoot the issue:

* Date/time of request
* URI, headers and body (if POST request)
* Context in which your request was executed (service-to-service, app, web)
* Environment in which your request was executed (test, prod, performance)
* Splunk [TraceId](/doc/getting-started/using_nike_apis.html#query-logs-with-a-trace-id)

## Glossary

|Term|Definition|
|---|---|
|Image Base|Full path to a product image in an image set in Scene 7. Does not include resizing parameters.|
|Image Set|Set of product images stored in Scene 7 representing different views of the product. Build the URI to the product image using domain + company + view from the list image results call.|
|GTIN|Global Trade Item Number. Nike leases a block of GTINs and recycles them seasonally. GTIN is commonly called UPC code, although the technical specification is slightly different for the two.|
|Master Product|A Nike iD product that has SKUs and is purchasable.|
|Merch Group|Merchandising Group representing a Nike geographical region. See a list of supported Merchandising Groups in the Enumerations section of the Merchandised Product service.|
|Prebuild Product|A non-purchasable Nike iD product that has no SKUs. Each Prebuild product is associated to one Master product that is purchasable.|
|Prodigy|System of record for all product data. All products are merchandised in this system and flow into the Merchandised Product database when they are published in Prodigy.|
|SLA|Service Level Agreement. Commitment to caller from the service regarding service response times and service availability |
|SKU|Stock Keeping Unit. Has unique ID associated with a SKU in the ATG legacy system. A product has one or more SKUs. A SKU represents one size and has inventory.|
|VAS|Value-Added Service associated with a product such as gift wrap and product customization|

## Document Change Log

|Summary |Date |Description|
|---|---|---|
|V1.0 Published|1 December, 2017 | The initial, reviewed version of the document was published.|
|Edits, Internationalization, Product sections | 7 December, 2017 | Updated documentation with new content on how products flow, international considerations, and editing/formatting changes. |
|Clarification on **count**|12 February, 2018|Clarified that when **count** query parameter is supplied that the maximum number of products returned is 25.|
|Updated external links|3 April, 2018|Updated external links to open in new browser window|
|Updated API.md links|14 May, 2018|Updated API.md links to point to new dev portal|
|Edits for style|1 June, 2018|Edits for capitalization, formatting consistency|
|Normalized table formatting|2 July, 2018|Edits for request/response table formatting and content|
|Updated TOC|10/01/2018|Removed 'In this guide', replaced with sidebar TOC|

## Related Links

[NDe Docs Home](/index.html)

[Get Started](/doc/getting-started/get-started.html)

[Merchandised Product Field Reference Guide](/doc/commerce/product/merch_product_field_reference.html#using-merchandised-products)