---
id: use-merch-product
tags: pdf
category: b-use-case
position: 14
title: Merch Product
url: /doc/commerce/product/use-merch-product.html
toc:
  - h2: Introduction
    url: /doc/commerce/product/use-merch-product.html#introduction
  - h2: Key Terms
    url: /doc/commerce/product/use-merch-product.html#key-terms
  - h2: Terms of Service
    url: /doc/commerce/product/use-merch-product.html#terms-of-service
  - h2: Use Cases
    url: /doc/commerce/product/use-merch-product.html#use-cases
  - h2: API Quick Reference
    url: /doc/commerce/product/use-merch-product.html#api-quick-reference
  - h2: Gathering a Product Data Set
    url: /doc/commerce/product/use-merch-product.html#gathering-a-product-data-set
  - h2: Understanding Nike Product Data
    url: /doc/commerce/product/use-merch-product.html#understanding-nike-product-data
  - h2: Merch Products Concepts
    url: /doc/commerce/product/use-merch-product.html#merch-products-concepts
  - h2: International Considerations
    url: /doc/commerce/product/use-merch-product.html#international-considerations
  - h2: Using Merch Products
    url: /doc/commerce/product/use-merch-product.html#using-merch-products
  - h2: Using Merch Product SKUs
    url: /doc/commerce/product/use-merch-product.html#using-merch-product-skus
  - h2: Using Merch Prices
    url: /doc/commerce/product/use-merch-product.html#using-merch-product-prices
  - h2: Using Merch VAS
    url: /doc/commerce/product/use-merch-product.html#using-merch-vas
  - h2: Using Product Content
    url: /doc/commerce/product/use-merch-product.html#using-product-content
  - h2: Troubleshooting
    url: /doc/commerce/product/use-merch-product.html#troubleshooting
  - h2: Contacting the Team
    url: /doc/commerce/product/use-merch-product.html#contacting-the-team
  - h2: Document Change Log
    url: /doc/commerce/product/use-merch-product.html#document-change-log
  - h2: Related Links
    url: /doc/commerce/product/use-merch-product.html#related-links
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING MERCH PRODUCTS <br>TO YOUR EXPERIENCE

---

##### Last Updated: 06/09/2020

Use the **Merch Products API** to get global product, sku, price, content, and value-added service (VAS) information, tailored to the needs of Nike consumers.

>**TIPS**:
>- Before using this guide, read [Using Nike APIs](/doc/getting-started/using-nike-apis.html).
>- Use this Developer's Guide as a supplement to the API Reference for detailed use cases. See [API Quick Reference](#api-quick-reference) for links to all the API Reference docs discussed in this guide.

## Introduction

The **Merch Products API** gives you detailed product information in any Nike-supported language for display in your app or experience.


**Scope/Limitations**:
- NIKEiD is not supported. Although NIKEiD Master products are available in the Merch Products API, NIKEiD Prebuild products and paths are not supported. These are required to properly render the NIKEiD experience.
- Retail data product is available, but not supported. Contact the <a href="#product-owner">Product Owner</a> for details.
- Bulk download of all product data is not supported.
- Nike Outfits are not supported.
- No product data metrics are currently sent to Analytics (Business Intelligence).
- The [Merch Products SKUs](#using-merch-product-skus) API does not determine if a SKU is in stock. Call the [Availability API](https://developer.niketech.com/docs/projects/Availability%20V2?tab=api){:target="new-tab"} to determine if a SKU is available for purchase.

### Consider Using Product Feeds Instead

The [Product Feeds API](/doc/commerce/product/use-product-feeds.html) aggregates product information, inventory data, and brand content from various sources including the **Merch Products API**. It organizes the data into Cards (product data or events), Threads (groups of related cards) and Feeds (groups of related Threads).

The **Product Feeds API** offers these advantages:

- Remains in sync with multiple data providers (including **Merch Products**), which reduces the number of service contracts you need to keep track of.
- Since it is an aggregation service, you only need to make one endpoint call. In contrast, you need to make 4-5 **Merch Product** endpoint calls to get the complete portrait of a single product.
- Enforces business-critical rules around product visibility in experiences. For example, Nike restricts the sale and presentation of some products in certain countries. **Product Feeds** eliminates the logic required to comply with these rules.

There are a few caveats when calling **Product Feeds**:

- Responses are larger, so response times may be slightly slower than the **Merch Product API** - but still within SLAs.
- Does not provide all data available from the services it aggregates.

See [Product Feeds](/doc/commerce/product/use-product-feeds.html) for use-cases and detailed API information.


## Key Terms

|Term|Definition|
|---|---|
|**Image Base**|Full path to a product image in an image set in Scene 7. Does not include resizing parameters.|
|**Image Set**|Set of product images stored in Scene 7 representing different views of the product. Build the URL to the product image using domain + company + view from the [Product Base Image URL by Style Color](#api-quick-reference) results call.|
|**GTIN**|Global Trade Item Number. Nike leases a block of GTINs and recycles them seasonally. GTIN is commonly called UPC code, although the technical specification is slightly different for the two.|
|**Master Product**|A Nike iD product that has SKUs and is purchasable.|
|**Merch Group**|Merchandising Group representing a Nike geographical region. See a list of supported Merchandising Groups in the Enumerations section of the [Merch Product List](https://developer.niketech.com/docs/projects/Merchandised%20Products%20Service%20API?tab=api#merchandised-product-merchandised-product-list){:target="new-tab"} service.|
|**Prebuild Product**|A non-purchasable Nike iD product that has no SKUs. Each Prebuild product is associated to one Master product that is purchasable.|
|**Prodigy**|System of record for all product data. All products are merchandised in this system and flow into the Merch Product database when they are published in Prodigy.|
|**SLA**|Service Level Agreement. A commitment from the service to the caller regarding service response times and service availability.|
|**SKU**|Stock Keeping Unit. Has unique ID associated with a SKU in the ATG legacy system. A product has one or more SKUs. A SKU represents one size and has inventory.|
|**VAS**|Value-added Service associated with a product such as gift wrap and product customization.|

## Terms of Service

To use the Merch Products API, you must send a caller ID header in every API request to help troubleshoot unexpected responses. See the Registration section of the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#registration) guide on how to create your caller ID.

### Authentication Requirements

If you are retrieving products that are publicly available, no authentication or authorization is required. If you need product data that is not available to the public and you are an internal Nike team, you can contact the <a href="#product-owner">Product Owner</a> for details on setting up authentication.

## Use Cases

|I want to...|API(s) to use|
|---|---|
|List merchandised product information such as product state, gender, merchandising tags, product type, and launch dates for a list of style-colors|Merch Products API|
|List the prices of a style-color in a certain country<br/>Includes retail price, employee price, sale price, current price, and MSRP|Merch Products API<br/>Price API|
|List all products that can be gift wrapped<p>Returns all value-added services of products that can be gift wrapped|Merchandised Value-Added Services API|
|List the sizes and SKU detail such as Nike size, localized size description, value-added tax (VAT) and Commodity Code for a style-color|Merch Products API<br/>Merchandised SKUs API|
|List the available images and localized product information such as title, subtitle, and description for a product<br/>Lists all images in the Scene7 or Cloudinary image set|Product Content API|
|List product information for a product at a specific point in time using a Snapshot ID|Merch Products API|

## API Quick Reference

**Merch Product V2**

- [Merch Product List](https://developer.niketech.com/docs/projects/Merchandised%20Products%20Service%20API?tab=api#merchandised-product-merchandised-product-list){:target="new-tab"}
- [Merch Product by Id](https://developer.niketech.com/docs/projects/Merchandised%20Products%20Service%20API?tab=api#merchandised-product-merchandised-product-by-id){:target="new-tab"}
- [Merch Product Create](https://developer.niketech.com/docs/projects/Merchandised%20Products%20Service%20API?tab=api#merchandised-product-merchandised-product-create){:target="new-tab"}
- [Merch Product Delete](https://developer.niketech.com/docs/projects/Merchandised%20Products%20Service%20API?tab=api#merchandised-product-merchandised-product-delete){:target="new-tab"}

**Merch Product Sku V2**

- [Merch Product Sku List](https://developer.niketech.com/docs/projects/Merchandised%20SKUs%20Service%20API?tab=api#sku-merchandised-product-sku-list){:target="new-tab"}
- [Merch Product Sku by Id](https://developer.niketech.com/docs/projects/Merchandised%20SKUs%20Service%20API?tab=api#sku-merchandised-product-sku-by-id){:target="new-tab"}
- [Merch Product Sku Create](https://developer.niketech.com/docs/projects/Merchandised%20SKUs%20Service%20API?tab=api#sku-merchandised-product-sku-create){:target="new-tab"}
- [Merch Product Skus Delete](https://developer.niketech.com/docs/projects/Merchandised%20SKUs%20Service%20API?tab=api#sku-merchandised-product-skus-delete){:target="new-tab"}
- [Merch Product Skus Batch Delete](https://developer.niketech.com/docs/projects/Merchandised%20SKUs%20Service%20API?tab=api#sku-merchandised-product-skus-batch-delete){:target="new-tab"}

**Merch Product Price V2**

- [Merch Prices List](https://developer.niketech.com/docs/projects/Merchandised%20Prices%20Service%20API?tab=api#prices-merchandised-prices-list){:target="new-tab"}
- [Merch Prices by Id](https://developer.niketech.com/docs/projects/Merchandised%20Prices%20Service%20API?tab=api#prices-merchandised-prices-by-id){:target="new-tab"}
- [Merch Prices Create](https://developer.niketech.com/docs/projects/Merchandised%20Prices%20Service%20API?tab=api#prices-merchandised-prices-create){:target="new-tab"}
- [Merch Prices Delete](https://developer.niketech.com/docs/projects/Merchandised%20Prices%20Service%20API?tab=api#prices-merchandised-prices-delete){:target="new-tab"}

**Merch Value Added Services V1**

- [Merch Value Added Services List](https://developer.niketech.com/docs/projects/Merchandised%20Value%20Added%20Services%20Service%20API?tab=api#value-added-services-merchandised-value-added-services-list){:target="new-tab"}
- [Merch Value Added Services by Id](https://developer.niketech.com/docs/projects/Merchandised%20Value%20Added%20Services%20Service%20API?tab=api#value-added-services-merchandised-value-added-services-by-id){:target="new-tab"}
- [Merch Value Added Services Create](https://developer.niketech.com/docs/projects/Merchandised%20Value%20Added%20Services%20Service%20API?tab=api#value-added-services-merchandised-value-added-services-create){:target="new-tab"}
- [Merch Value Added Services Delete](https://developer.niketech.com/docs/projects/Merchandised%20Value%20Added%20Services%20Service%20API?tab=api#value-added-services-merchandised-value-added-services-delete){:target="new-tab"}

**Product Content V1**

- [Product Content by Style Color](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api#public-product-content-product-content-by-style-color){:target="new-tab"}
- [Product Content Item by Style Color](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api#public-product-content-product-content-item-by-style-color){:target="new-tab"}
- [Product Content By Style Color List](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api#public-product-content-product-content-by-stylecolor-list){:target="new-tab"}
- [Product Content Field By Style Color List](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api#public-product-content-product-content-field-by-stylecolor-list){:target="new-tab"}


- [Product Image Set by Style Color](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api#public-product-images-product-image-set-by-style-color){:target="new-tab"}
- [Product Image Set By Style Color List](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api#public-product-images-product-image-set-by-stylecolor-list){:target="new-tab"}
- [Product Base Image URL by Style Color List](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api#public-product-images-product-base-image-url-by-style-color-list){:target="new-tab"}
- [Product Base Image URL by Style Color](https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api#public-product-images-product-base-image-url-by-style-color){:target="new-tab"}

## Gathering a Product Data Set

Follow the steps below to assemble a complete set of product data for a style-color.

>**Note**: The style-color in this example is not a current, active product. Product availability changes constantly, so visit Nike.com to get an available product before trying this out.

<i class="numberCircle green">1</i> Using style-color 526628-009 (example), get the Product ID and a few product details from the Merch Product endpoint (filtered by style-color and Merch Group):
`https://api.nike.com/merch/products/v2?filter=merchGroup(US)&filter=styleColor(526628-009)&filter=merchgroup(US)`

<i class="numberCircle green">2</i> Using the product ID from the Merch Product response, get prices from the Merch Price endpoint (filtered by product ID and country US):
`https://api.nike.com/merch/prices/v2?filter=productid(22d2ea87-d7ce-50e7-a5ca-884788e1d958)&filter=country(US)`

<i class="numberCircle green">3</i> Using the same product ID, get the SKU data from the Merch SKUs endpoint (filtered by country US):
`https://api.nike.com/merch/skus/v2?filter=productId(22d2ea87-d7ce-50e7-a5ca-884788e1d958)&filter=country(US)`

<i class="numberCircle green">4</i> Using style-color 526628-009 (not product ID), get the product images from the images endpoint of the Product Content service:

`https://api.nike.com/merch/contents/v1/526628-009/images?country=US`

<span class="toc-pad">**Note**: Images are returned from the Product Content service without a URL, but the necessary information is returned to build it. The experience is responsible for assembling the image URL.</span>

<i class="numberCircle green">5</i> Using style-color 526628-009 (not product ID), get the localized content for the product from the Product Content endpoint of the Product Content service:
`https://api.nike.com/merch/contents/v1/526628-009/content?country=US&locale=en_US`

## Understanding Nike Product Data

Nike product data is a complex set of information that flows from multiple origin systems and processes.

### Where Does Product Data Come From?

Product data originates from two primary upstream systems: <b>Prodigy</b> (via <b>eMerch</b>), and the cloud-based <b>Catalog</b> service. Prodigy and the Catalog service are the systems of record for product data, and are not managed within the Merch Products domain.

The following diagram illustrates the most common patterns for data flow.

![](/images/commerce/merch_product/product_data_simplified_flow.png)


### How Does Product Data Get Published?

**New Products**

Prodigy sends **Merch Products** cloud services a new product notification. **Merch Products** cloud services creates several objects using the data from the new product notification and decorates the data with domain-specific elements such as UUIDs for each service. Generally, **Merch Products** does not modify data provided by the systems of record. For more information on **Merch Product** IDs, see [Understanding IDs](#understanding-ids).

>**TIPS:**
>
>When a Merch Products object is created, the object remains in the application cache for 30 seconds.
>
>Because Prodigy is the source of data, product data that is served through the **Merch Products API** is subject to change at any time.

**Product Updates**

Prodigy sends **Merch Products** cloud services an update product notification. This initiates the creation of a fresh snapshot of all product data.

Prodigy uses a first-in-first-out queue. However, an individual product update is pushed to the top of the queue and takes precedence over larger bulk updates. For example, the queue may contain 100k updates when a global product attribute has been applied. Since a producer who manually updates and publishes a single product likely wants that change to take place as quickly as possible, Prodigy gives preference to the manual update.

>**TIP:** When a Merch Products object is updated, the object remains in the application cache for 30 seconds.

### Where Do I Get Inventory Information?

Call the [Availability API](https://developer.niketech.com/docs/projects/Availability%20V2?tab=api){:target="new-tab"} to check if a product is saleable.

### How To Find a Current Product

The easiest way to find a current product is to go to Nike.com and find a style-color that is offered on the site. With the exception of NIKEiD products, if the style-color is available on Nike.com, the data is available in our services.

## Merch Products Concepts

### How Product Data is Organized in the Merch Products API

Depending upon the information you are looking for, you may need to chain together several service calls, using the output of one service call as input to another.

Every Nike product has:

- One or more SKUs
- One set of prices
- One or more associated value-added services
- A body of content
- A set of product images

These items are divided into a set of microservices. The relationship between the Merch Products objects is illustrated below.

![](/images/commerce/merch_product/relationships.png){:width="40%"}

### Finding the Data Points You Need

Use these guidelines to find the endpoints to call to get the product data you need:

- If the data can be localized, use the [Content API](#using-product-content).
- If you are looking for size information, use the [Merch SKUs API](#using-merch-product-skus).
- If you are looking for launch-related information or dates associated with a product, use the [Merch Products API](#using-merch-products).

### Understanding IDs

The resources provided by the <b>Merch Products API</b> include a wide range of IDs that are used for various current and historical purposes. The following table describes the concepts and common uses for each of these IDs.

|ID|Services|Description|
|---|---|---|
|**id**|Merch Products, Price, SKU, and VAS|UUID for an object (and any nested object). Each value in the object's **id** field is generated within the Merch Products domain, and is not used by legacy systems. Each ID is unique to the Merch Group that was specified in the request, but is not globally unique. For a globally unique ID, use the value in the **catalogId** field.|
|**productId**|Merch Price, SKU, and VAS| UUID of the parent product to which the data is tied. Each product returned in the Merch Products service is the parent for the data returned by the other APIs in the domain. For example if you want to retrieve the SKUs for a specific product, you need the parent product UUID of those SKUs.|
|**parentId**|Merch Price, SKU, and VAS|UUID of the parent product to which the data is tied.<br><br><b>NOTE:</b> The parent ID is identical to the product UUID.|
|**snapshotId**|Merch Products, Price, SKU, and VAS|UUID representing a snapshot of a product at a point in time. Snapshot IDs are used for historical lookup purposes as product data changes frequently. For example, [Checkout](/doc/commerce/checkout/use-checkout.html) stores a record of every transaction that occurs on Nike.com. The Snapshot ID is stored in that record so the details of the transaction can be retrieved when the product data was requested.<br><br><b>NOTE:</b> **Merch Products** cloud services does not provide a way to lookup a Snapshot ID. Your app or experience should store the Snapshot ID returned in the response.|
|**styleCode**, **colorCode**, and **styleColor**|All|Consumer-facing style and color of a product.<br><br><b>NOTE:</b> Style-colors are not globally unique. Occasionally a style-color ID is identical in two different Merch Groups, but that identical ID represents two distinct, physical products. Collisions are rare, but can occur.|
|**catalogId**|Merch Products| Globally unique product UUID that is generated by the Catalog domain.|
|**pid**|Merch Products| Deprecated Product ID (PID) that is used by various internal systems at Nike, as well as in legacy URLs on Nike.com. PIDs are generally included for historical mapping purposes for legacy systems that are not completely cloud-enabled.|
|**productGroupId**| Merch Products |Deprecated Product Group ID (PGID) that is used by various internal systems at Nike, as well as in legacy URLs on Nike.com. PGIDs were used to group products together in a merchandised experience. PGIDs are included generally for historical mapping purposes for legacy systems that are not completely cloud-enabled.|
|**legacyCatalogIds**| Merch Products |Deprecated IDs that are returned for use by legacy systems.|
|**stockKeepingUnitId**|Merchandised Price|Deprecated SKU ID that is used for historical purposes by legacy systems.|
|**gtin**|Merchandised SKU| Globally unique 14-digit number that used to identify retail SKUs. These are commonly called UPC codes, though the technical specification for the two is slightly different.|
|**catalogSkuId**|Merchandised SKU|Deprecated IDs that are returned for use by legacy systems.|

### Caching Data

The Merch Products API caching strategy includes three layers: application, Akamai and experience.

The first cache layer is at the application level where each instance of the Merch Products application has its own cache. There is no distributed caching, so the service instances do not share cache information with one another. Application cache times vary between services.

The second cache layer is Akamai caching, utilized when the client calls the services through the public router. There is no caching performed when an application calls the application directly.

The third cache layer should occur within the client experience, depending on the client's architectural patterns. Caching client-side is recommended to reduce network calls and unnecessary load on the system.

### Create, Update, and Delete Capabilities of the API

In addition to listing product data, the API creates, modifies and deletes merch product data that flows into the system from Prodigy, which is the primary system of record. Every update call made to the Merch Products services from Prodigy (including deletion) is versioned, creating an audit trail. In this way, no merch product data is physically deleted from the data store. A timestamped deletion record in inserted instead. Each version has a unique **snapshotId** representing a snapshot of the object in time. The create, update and delete endpoints are restricted to certain applications.

## International Considerations

The rules and behaviors for products are the generally the same regardless of geography. However, there are a few key concepts and exceptions.

### Working with Merch Groups, Countries, and Languages

A Merch Group is a collection of countries defined in Prodigy. Merch Groups are used to manage product information and inventory at a group level. The Merch Products API uses the Merch Group as a foundational element in how the data is organized and presented.

Within each Merch Group, each country may include translations and size conversions for more than one language-dialect.

For most API calls, Merch Group and Country are required. For the current list of supported Merch Groups, countries, and languages see [Merch Products Field Reference](/doc/commerce/product/merch-product-field-reference.html#using-merchandised-products) guide.

### Excluding Countries Where a Specific Product Should Not Be Offered

In some cases, Nike does not offer a product in a certain country, even if it is offered in other countries within the same Merch Group. This may be for a variety of reasons, including legal implications of selling a product that is not within the trade guidelines for a given country. If you are building a public or consumer-facing experience, it is essential that you do not show that product in an excluded country.

The Merch Products API includes two fields that are used for this purpose:

- **commerceCountryInclusions**
- **commerceCountryExclusions**

The two data points reflect two views of the same data. You should use **commerceCountryExclusions** to exclude a product from display in the specified country. The **commerceCountryInclusions** field is an inverse view that is primarily used for legacy systems.

## Using Merch Products

- [Merch Products Overview](#merch-products-overview)

- [Merch Product List](#merch-product-list)

- [Merch Product by ID](#merch-product-by-id)

### Merch Products Overview

Use the Merch Products service to list, create, update, and delete merch product information.

- Search for a specific version of the object by product ID or snapshot ID. Searching by a filter other than **snapshotId** returns the most recent version.
- Filter field names are case-insensitive.
- One product is returned if searching by product ID.
- If country is not specified, all countries are returned.
- This is a synchronous service.

### Merch Product List

The Merch Products service returns all products matching the filter query parameter up to the value supplied in the count parameter. If no count parameter is supplied, up to 25 products are returned. When the count parameter is supplied, the maximum number of products is 25. Product results are sorted by product ID, style-color or style, depending upon the filter query parameters passed in. If the count parameter restricts the results, a **pages** object is returned in the response that the caller can use for pagination.

This is not a [JWT-restricted](/doc/getting-started/using-nike-apis.html#jwt-json-web-token) service but results differ based on whether or not this header is sent in the request. If no JWT header is supplied, the response contains products matching the criteria and have an ACTIVE status. If a valid JWT header is supplied, the response contains products matching the criteria regardless of status.

List product information for a specific version by ID and by Snapshot ID. If no **snapshotId** parameter is supplied, the most recent version of the product is returned.

Filter field names are case insensitive.

The caller does not have to send an access token in the Authorization header (indicating the consumer is logged in) to use this service.

Let's take a look at some *Merch Product List* scenarios.

|I Want to List|Sample Query|
|---|---|
|EU products with style 849560|https://api.nike.com/merch/products/v2?filter=merchgroup(EU)&filter=style(849560)|
|EU products with style-color 849560-001 and 849560-002|https://api.nike.com/merch/products/v2?filter=merchgroup(EU)&filter=stylecolor(849560-100,849560-002)|
|US product with ID 58aaa694-5889-5965-a781-6abcc3e4ff68|https://api.nike.com/merch/products/v2?filter=merchgroup(US)&filter=id(58aaa694-5889-5965-a781-6abcc3e4ff68)|
|US products with style 919704, limiting the results to 10|https://api.nike.com/merch/products/v2/?filter=merchgroup(US)&filter=style(919704)&count=10|
|US product with product ID 8653b383-22a0-55a1-ba7e-56174e5ab1e7 and Snapshot ID c59808d1-0945-4bcc-9c47-dcb34cc40824|https://api.nike.com/merch/products/v2?filter=merchgroup(US)&filter=snapshotId(c59808d1-0945-4bcc-9c47-dcb34cc40824)&filter=id(8653b383-22a0-55a1-ba7e-56174e5ab1e7)|
|More than one product in a single response: US product with product ID b9c9789-1a35-503c-8a22-95a745c35df8 and US product with product ID 30e88273-bc07-5a51-bb8a-9c58a789c504|https://api.nike.com/merch/products/v2?filter=id(ab9c9789-1a35-503c-8a22-95a745c35df8,30e88273-bc07-5a51-bb8a-9c58a789c504)|

### Merch Product By ID

This service returns product information for the **id** path parameter and **snapshotId** query parameter, if supplied. This endpoint returns the same fields as the [Merch Product List](#merch-product-list) endpoint except for the pages object, because the endpoint only returns one result.

The caller does not have to send an access token in the **Authorization** header (indicating the consumer is logged in) to use this service.

>**TIP:** If you know the product ID, this endpoint yields faster results than the [Merch Product List](#merch-product-list) endpoint does because it locates the product record directly by ID rather than filtering the results.

Sample request URI to list product information for ID 58aaa694-5889-5965-a781-6abcc3e4ff68 and Snapshot ID 34cec674-4200-4001-8632-1f4f3cec5078:

```
https://api.nike.com/merch/products/v2/58aaa694-5889-5965-a781-6abcc3e4ff68?snapshotId=34cec674-4200-4001-8632-1f4f3cec5078 
```

Sample request URI to list product information for ID 30e88273-bc07-5a51-bb8a-9c58a789c504:

```
https://api.nike.com/merch/products/v2/30e88273-bc07-5a51-bb8a-9c58a789c504
```

## Using Merch Product SKUs

- [Merch Product Sku List](#merch-product-sku-list)

- [Merch Product Sku by ID](#merch-product-sku-by-id)

### Merch Product SKU Overview

Use this service to list, add, update and delete merchandised SKU information.

- Search for a specific version of the object by ID and Snapshot ID. Searching by a filter other than **snapshotId** returns the most recent version.
- Filter field names are case-insensitive.
- One product’s SKU data is returned if searching by SKU ID.
- If country is not specified, all countries are returned.
- This is a synchronous service.

### Merch Product SKU List

Use this service to search for multiple SKUs by filter. Search results are sorted in ascending order by the **displayOrder** field and then **stockKeepingUnitId**. Note that the **displayOrder** field is not returned in the results.

Let's take a look at some sample *Merch Product SKU* scenarios.

|I Want to List SKUs for filter|Sample Query|
|---|---|
|Product ID 2c4282cc-9fd1-5250-94a5-0c74735443dc|https://api.nike.com/merch/skus/v2?filter=productid(2c4282cc-9fd1-5250-94a5-0c74735443dc)|
|GTIN 00887225865153|https://api.nike.com/merch/skus/v2/?filter=gtin(00887225865153)|
|Legacy SKU (**stockkeepingunitid**) 18925450|https://api.nike.com/merch/skus/v2/?filter=stockkeepingunitid(18925450)|

### Merch Product SKU by ID

Use this service to search for SKU information by SKU ID. This service returns the same data as the [Merch Product SKU List](#merch-product-sku-list) endpoint returns except for the pages object because the endpoint only returns one result. In order to get a SKU ID, you can query the *Merchandised Product SKU List* endpoint filtering by **productid**.

>**TIP:** If you know the SKU ID, this endpoint yields faster results than the [Merch Product SKU List](#merch-product-sku-list) endpoint does because it locates the SKU record directly by ID rather than filtering the results.

### Merch Product SKU by ID Details

|I Want to List SKU UUID|Sample Query|
|---|---|
|036006d4-fdb7-55f6-9430-9eaf239ce22f|https://api.nike.com/merch/skus/v2/036006d4-fdb7-55f6-9430-9eaf239ce22f|
|036006d4-fdb7-55f6-9430-9eaf239ce22f in Finland|https://api.nike.com/merch/skus/v2/036006d4-fdb7-55f6-9430-9eaf239ce22f?country=FI|

## Using Merch Product Prices

- [Merch Prices List](#merch-prices-list)

- [Merch Prices by ID](#merch-prices-by-id)

### Merch Product Prices Overview

Use this API to list, create and delete product prices.

- Search for a specific version of the object by ID and Snapshot ID. Searching by a filter other than **snapshotId** returns the most recent version.
- Filter field names are case-insensitive.
- One product’s price data is returned if searching by price ID.
- All endpoints are synchronous.

The following sections describe each endpoint of the Merch Product Price API in detail.

### Merch Prices List

Use this endpoint to list price data by price **id** or by **productId** and [country](/doc/commerce/product/merch-product-field-reference.html#using-merchandised-products).

Because price values and currency are localized, both **country** and **productId** are required parameters when searching by **productId**. **country** is not required when searching by price **id** because the price record is for a specific country. To get the price **id** in the results, first search by **productid** and **country**. If you do not know the **productid**, use the [Merch Product List](#merch-product-list) endpoint to search by style-color or style. **productid** is returned in the results.

No special headers are required to use this endpoint so it can be executed in any browser, and the consumer does not have to be logged in.

|I Want to List Prices for|Sample Query|
|---|---|
|Product UUID and a specific location (e.g. Ireland)|https://api.nike.com/merch/prices/v2/?filter=productid(58aaa694-5889-5965-a781-6abcc3e4ff68)&filter=country(IE)|
|Price UUID 486d098c-a403-5fb7-8305-243d71625d4c and snapshotId 678408f9-0eea-4560-b537-e85c131e9495|https://api.nike.com/merch/prices/v2/?filter=id(486d098c-a403-5fb7-8305-243d71625d4c)&filter=snapshotId(85ebb452-f61c-46a2-b0ce-14a89a542816)|

### Merch Prices by ID

Use this endpoint to list price data by price **id**. To get the price **id**, search by **productid** and [country](/doc/commerce/product/merch-product-field-reference.html#using-merchandised-products) using the [Merchandised Prices List](#merch-prices-list) endpoint and Price ID is returned in the results. If you do not know the product id, use the [Merch Product List](#merch-product-list) endpoint to search by style-color or style. Product ID is returned in the results.

Results from this endpoint are almost identical to those returned from the [Merch Product List](#merch-product-list) endpoint. The difference is no pagination data is returned and you can only search by one price **id** at a time.

No special headers are required to use this endpoint so it can be executed in any browser, and the consumer does not have to be logged in.

>**TIP:** If you know the price **id**, this endpoint yields faster results than the [Merch Prices List](#merch-prices-list) endpoint does because it locates the price record directly by **id** rather than filtering the results.


|I Want to List Merchandised Price for|Sample Query|
|---|---|
|price ID 486d098c-a403-5fb7-8305-243d71625d4c|https://api.nike.com/merch/prices/v2/486d098c-a403-5fb7-8305-243d71625d4c|
|price ID 486d098c-a403-5fb7-8305-243d71625d4c and snapshotId 85ebb452-f61c-46a2-b0ce-14a89a542816|https://api.nike.com/merch/prices/v2/486d098c-a403-5fb7-8305-243d71625d4c?filter=snapshotId(85ebb452-f61c-46a2-b0ce-14a89a542816)

## Using Merch VAS

- [Merch Value-added Services List](#merch-value-added-services-list)

- [Merch Value-added Services by ID](#merch-value-added-services-by-id)

### Merch Value Added Services Overview

Products can be merchandised with one or more Value Added Services (VAS) such as gift wrap or personalization. Digital and physical gift cards are another example of VAS as consumers can personalize the gift message and configure the amount. A VAS can be merchandised to an unlimited number of products. Use this service to list, add, and delete VAS.

- Search for a specific version of the object by ID and Snapshot ID. Searching by a filter other than **snapshotId** returns the most recent version.
- Filter field names are case-insensitive.
- One VAS is returned if searching by VAS ID.
- All endpoints are synchronous.

Note that the VAS services return a field named pid. Even though this field implies a one-to-one relationship between product and VAS, this field is a legacy ID used for reporting purposes in Prodigy. Products can have several Value-Added Service objects associated with them.

The following sections describe each endpoint of the Merchandised Value Added Services API in detail.

### Merch Value Added Services List

Use this endpoint to list VAS by type or by VAS ID. Listing by multiple IDs is supported.

If you want to search by VAS ID but do not know it, call the [Merch Product List](#merch-product-list) endpoint first. The value_added_service ID will be returned in the search results for each product that has one or more value-added service attributes.

The consumer does not have to be logged in to call this endpoint.

This endpoint requires no special headers so you can execute test calls in any browser.

|I Want to List VAS Details for|Sample Query|
|---|---|
|VAS type DIGITAL_GIFT_CARD|https://api.nike.com/merch/value_added_services/v1?filter=type(DIGITAL_GIFT_CARD)|
|VAS ID 47bc9091-2965-5231-b5f1-a7216e249894|https://api.nike.com/merch/value_added_services/v1?filter=id(47bc9091-2965-5231-b5f1-a7216e249894)|
|VAS ID 124ae4cb-0506-5b52-98c0-06eaf7b7ea67 and VAS ID 47bc9091-2965-5231-b5f1-a7216e249894|https://api.nike.com/merch/value_added_services/v1?filter=id(124ae4cb-0506-5b52-98c0-06eaf7b7ea67,47bc9091-2965-5231-b5f1-a7216e249894)|
|VAS ID 47bc9091-2965-5231-b5f1-a7216e249894 and Snapshot ID 52ca6f5b-fde9-4daf-af65-3993ef7eb428|https://api.nike.com/merch/value_added_services/v1?filter=id(afd90c5b-230f-5fd3-b3a4-af36c5dbd55d)&filter=snapshotId(e0861083-f3a3-4120-bc30-29888113e940)|
|all available VAS|https://api.nike.com/merch/value_added_services/v1|

### Merch Value Added Services by ID

Use this endpoint when you want to list the fields for one VAS ID. This endpoint returns almost identical results as the [Merchandised Value Added Services List](#merch-value-added-services-list) endpoint returns except that it does not return pagination information because it returns only one VAS object. This endpoint returns a quicker response than the Merchandised Value Added Services List endpoint because it does not filter or paginate the results.

If you do not know the VAS ID, call the [Merch Product List](#merch-product-list) endpoint first. The value_added_service ID will be returned in the search results for each product that has one or more VAS attributes.

The consumer does not have to be logged in to call this endpoint.

This endpoint requires no special headers so you can execute test calls in any browser.

|I Want to List VAS Details for|Sample Query|
|---|---|
|ID 56e48cf5-050f-51a7-b6ce-1ca5ab9d415b|https://api.nike.com/merch/value_added_services/v1?filter=id(47bc9091-2965-5231-b5f1-a7216e249894)|
|ID 56e48cf5-050f-51a7-b6ce-1ca5ab9d415b and Snapshot ID 52ca6f5b-fde9-4daf-af65-3993ef7eb428|https://api.nike.com/merch/value_added_services/v1/56e48cf5-050f-51a7-b6ce-1ca5ab9d415b?snapshotId=566ba45b-898b-4f19-a743-c12e8a753945|
|ID 56e48cf5-050f-51a7-b6ce-1ca5ab9d415b and only return pid and type fields|https://api.nike.com/merch/value_added_services/v1/56e48cf5-050f-51a7-b6ce-1ca5ab9d415b?fields=(status,pid,type)|

## Using Product Content

- [Product Content by Style Color](#product-content-by-style-color)
- [Product Content by Style Color List](#product-content-by-style-color-list)
- [Product Content  Item by Style Color](#product-content-item-by-style-color)
- [Product Content Field by Style Color List](#product-content-field-by-style-color-list)
- [Product Image Set by Style Color](#product-image-set-by-style-color)
- [Product Base Image URL by Style Color List](#product-base-image-url-by-style-color-list)
- [Product Base Image URL by Style Color](#product-base-image-url-by-style-color)
- [Product Image Set by Style Color List](#product-image-set-by-style-color-list)

### Product Content Overview

Use these services to list product content such as title, subtitle, description, and images by [country](/doc/commerce/product/merch-product-field-reference.html#using-merchandised-products) and locale.

There are two sets of Product Content services, internal and external.

External services go through the public router (api.nike.com and snkrs.prod.commerce.nikecloud.com) and return product information for products in the ACTIVE and CLOSEOUT status.

Internal services go through the frame router (frame.prod.commerce.nikecloud.com). These services return identical fields to the external services but they return all products regardless of status. When making service to service calls, use the internal Product Content endpoints.

All endpoints are synchronous.

### Product Content by Style Color

Use this endpoint to list localized product content for a style-color, [country](/doc/commerce/product/merch-product-field-reference.html#using-merchandised-products) and locale.

|I Want to List Product Content for|Sample Query|
|---|---|
|Style-color code 919704-006 in Spain for locale es_ES|https://api.nike.com/merch/contents/v1/919704-006/content?country=ES&locale=es_ES|

### Product Content by Style Color List

Use this endpoint to list localized product content for a list of style-colors, [country](/doc/commerce/product/merch-product-field-reference.html#using-merchandised-products) and locale. Only one country and locale is supported.

|I Want to List Product Content for|Sample Query|
|---|---|
|Style-color codes 852395-601 and 919704-006, country Spain and locale es_ES|https://api.nike.com/merch/contents/v1/content?stylecolors=852395-601,919704-006&country=ES&locale=es_ES|

### Product Content Item by Style Color

Use this endpoint to list one item (field) of product content for a style-color, [country](/doc/commerce/product/merch-product-field-reference.html#using-merchandised-products) and locale. Only one style-color, itemName, country and locale is supported. You can use any valid itemName in the path parameter.

|I Want to List Product Content for|Sample Query|
|---|---|
|Title information for style-color code 919704-006, country Spain and locale es_ES|https://api.nike.com/merch/contents/v1/919704-006/content/title?country=ES&locale=es_ES|

### Product Content Field by Style Color List

Use this endpoint to list one item (field) of product content for a list of style-colors, [country](/doc/commerce/product/merch-product-field-reference.html#using-merchandised-products) and locale. Only one itemName, country and locale is supported. You can use any valid itemName in the path parameter.

|I Want to List Product Content for|Sample Query|
|---|---|
|Title information for style-color codes 852395-601 and 919704-006, country Spain and locale es_ES|https://api.nike.com/merch/contents/v1/content/descriptionHeading?country=ES&locale=es_ES&stylecolors=852395-601,919704-006|

### Product Image Set by Style Color

Use this endpoint to list the images associated with a style-color and country.

Product images are stored in Scene 7. A Nike product often has multiple images associated with it, each displaying the product from a different angle. This group of images is called an image set in Scene 7.

|I Want to List Product Image Set for|Sample Query|
|---|---|
|Style-color code 919704-006 and country Spain|https://api.nike.com//merch/contents/v1/919704-006/images?country=ES|

### Product Base Image URL by Style Color

Use this endpoint to list the first image in the image set for a style-color. This is also known as the base image.

|I Want to List the Base Product Image for|Sample Query|
|---|---|
|Style-color code 919704-006 and country Spain|https://api.nike.com/merch/contents/v1/919704-006/images/base?country=ES|


### Product Image Set by Style Color List

Use this endpoint to list the image set for a list of style-color codes and country. Only one country is supported.

|I Want to List the Image Set for|Sample Query|
|---|---|
|Style-color codes 919704-006 and 852395-601 and country Spain|https://api.nike.com/merch/contents/v1/images%3Fcountry=ES&stylecolors=919704-006,852395-601|


### Product Base Image URL by Style Color List

Use this endpoint to list the base image for a list of style-color codes and country. Only one country is supported.

|I Want to List the Base Product Image URL for|Sample Query|
|---|---|
|Style-color codes 919704-006 and 852395-601 and country Spain|https://api.nike.com/merch/contents/v1/images/base?country=ES&stylecolors=919704-006,852395-601|

---

## Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### Tools

Use the general troubleshooting tips in the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#troubleshooting) guide.

Use a Splunk query (requires access) to check for issues with your request.

Contact the Merch team on the [#pdm-merch-catalog](https://nikedigital.slack.com/archives/CANEN2FH9){:target="new-tab"} Slack channel for assistance.

### Common Questions

**Why isn't the change I published in Prodigy returned in my call to Merch Product API?**

It takes approximately 30 seconds for an add/update/delete record to flow to the Merch Products Database once it is published in Prodigy. If a change does not appear after 30 seconds by Merch Products API, it may be in the Prodigy queue behind other jobs with higher priority. Republish the change in Prodigy to push it again. Note that Prodigy gives a higher queue priority to an individual project change than to a change made to several products at once in a bulk update.

**Why aren't some fields returned in my call to Merch Product API?**

There could be several reasons why the product data you expect is not listed.

1. You may not be calling the correct service.
Depending upon the product data you are looking for, you may need to chain together services to get the input to the service that returns the data you need. See the [Gathering a Product Data Set](#gathering-a-product-data-set) section for the chain of calls you need to make to get all details for a product.

2. The data you are looking for is not set up in the upstream system.
Check the product in Prodigy to verify that it is merchandised as you expect.

3. The product data may be queued or in transit from Prodigy to the Merch Products database.
Wait 30 seconds and call the API again.

If none of these scenarios apply, [contact the Merch Product team](#contacting-the-team) for help. Supply as much of the information below to the Team as possible to help them troubleshoot the issue:

* Date/time of request
* URI, headers and body (if POST request)
* Context in which your request was executed (service-to-service, app, web)
* Environment in which your request was executed (test, prod, performance)
* Splunk [TraceId](/doc/getting-started/using-nike-apis.html#troubleshooting)

## Contacting the Team

Need to contact the Merch Product team?

|---|---|
|Slack|[#pdm-merch-catalog](https://nikedigital.slack.com/archives/CANEN2FH9){:target="new-tab"}|
|Confluence Space|[PDM - Consumer Product Services](https://confluence.nike.com/display/PCPS/PDM+-+Consumer+Product+Services+Home){:target="new-tab"}|
|<i id="product-owner">Product Owner</i>|[Debbie Meier](mailto:debbie.meier@nike.com)|

## Document Change Log

|Summary|Date|
|---|---|
|Initial publish|12/01/2017|
|Added detail on internationalization and product flow|12/7/2017|
|Clarified **count** description|02/12/2018|
|Updated contact info, restructured sections, updated links|06/09/2020|

## Related Links

- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)
- [Merch Product Field Reference Guide](/doc/commerce/product/merch-product-field-reference.html#using-merchandised-products)
- [Product Feeds API](/doc/commerce/product/use-product-feeds.html)