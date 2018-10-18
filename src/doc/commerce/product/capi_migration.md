---
tags: pdf
category: use-case
position: 3
title: CAPI Migration
url: /commerce/product/capi_migration.html
toc:
  - h2: Overview
    url: /doc/commerce/product/capi_migration.html#overview
  - h2: CAPI vs. Cloud
    url: /doc/commerce/product/capi_migration.html#capi-vs-cloud-comparison
  - h2: Endpoint Mapping
    url: /doc/commerce/product/capi_migration.html#endpoint-mapping
  - h2: Migration Scenarios
    url: /doc/commerce/product/capi_migration.html#migration-scenarios
  - h2: Migration Contacts
    url: /doc/commerce/product/capi_migration.html#migration-contacts
  - h2: Field Mapping
    url: /doc/commerce/product/capi_migration.html#field-mapping
---

# Commerce API (CAPI) <i class="g72-swoosh"></i><br>Migration Guide

---

##### Last Updated: 10/11/2018


> The CAPI API is in KLO. No feature requests or enhancements are being accepted. If CAPI does not provide the data or functionality you require, migrate to the appropriate Cloud services.

If you are a current Commerce API (CAPI) client, use this guide to help with migration to the Nike Cloud APIs.

## <a name="overview"></a>Overview

CAPI is a legacy API that provides access to Nike product information, including inventory availability. CAPI has been replaced by Nike's Cloud-based APIs and will be deprecated after all clients have migrated to the newer APIs.

![](/images/commerce/capi/capi_to_cloud.png)

## <a name="capi-vs-cloud-comparison"></a>CAPI vs. Cloud: Comparison

Read on to learn more about the similarities and differences between CAPI and Cloud.

### Overall Considerations

- CAPI is largely replaced by the [Product Feeds v2 API](/doc/commerce/product/api_product_feeds.html). The two APIs are similar in that they aggregate multiple sources of data, thus reducing the number of calls required to gather product data and content. Product Feeds has the additional benefit of having fewer endpoints than CAPI, for example some implementations rely on calls to only two distinct endpoints.

- **Some of the search functionality of CAPI has not yet been replaced in the Cloud**. If you rely on CAPI for faceted search, you may need to continue to use CAPI for now. Contact the [Search Product Owner](mailto:david.wagner@nike.com) for more info about when this feature of Cloud Search will be available.

- CAPIs inventory capabilities are replaced by Cloud Inventory APIs, and in the case of Digital inventory availability, also by Product Feeds.

>**TIP:** See the [Endpoint Mapping](#endpoint-mapping) section for the details of how each CAPI endpoint maps to Cloud.

### REST and JSON

Both CAPI and Cloud use the REST architectural style and feature JSON-formatted requests and responses.

>**TIP:** If you are using the XML version of CAPI, you will need to be able to send and receive JSON when you migrate to the Cloud.

### Country & Language Support

All of the countries and languages supported by CAPI are also supported by Cloud, and more. For the complete list of supported languages for Product Feeds v2 (Cloud), see <a href="https://confluence.nike.com/display/DEN/Product+Feeds+Supported+Languages+and+Locales" target="_blank">here</a>.

### Product Identifiers

Product information is available in the Cloud in the Product Feeds v2 API. This section includes some specific callouts in regards to product identifiers.

#### Product ID

CAPI can be called by **productId** (PID), e.g. '1074990' (which also can be sent in **id** field for certain CAPI endpoints), the legacy identifier that is unique to a *style-color*. In general, you cannot call Cloud APIs with this same **productId**, although you might see it in certain Cloud responses, for example with Product Feeds in the **pid** field.

The equivalent of **productId** in the Cloud is the **id**, e.g. '8e94a648-a232-5739-b4a6-c7d844a8bda0', a UUID generated from the [Merchandised Products API](/doc/commerce/product/api_merch_product.html). You will use this **id** when making calls directly to Merchandised Products and also in the responses from the Product Feeds API, which aggregates data from Merchandised Products and several other APIs.

#### SKU ID

Responses from several CAPI endpoints feature **skuID**, e.g. '1107974', the legacy identifier that is unique to a SKU or *style-color-size*. This value is still available in the cloud because several downstream systems rely on it, but it is renamed to **stockKeepingUnitId**. In addition, an **id** in the form of a UUID is generated per SKU by the [Merchandised Product SKU API](/doc/commerce/product/api_merch_product#using-merchandised-product-skus.html) when it flows into the system.

>**TIP:** For cloud, you can call the Merchandised Product SKU List endpoint with the filter query parameter, include the UUID of the parent product, and be returned a list of all the SKUs for that product. Example: https://api,nike.com/merch/skus/v2?filter=parentId(cf441ec7-53fd-5828-8f6d-d28a9cdcf1b1).

#### Style-Color Code

Style-color codes, e.g. '870790-420', are the same values and in the same format in both CAPI and Cloud.

#### GTIN

GTIN (Global Trade Identification Number), e.g. '00675911130902' values and format are the same in both CAPI and Cloud.

>**TIP:** For Cloud, be sure to always send a 14-digit GTIN value, including any leading zeroes as necessary.

#### Gender Codes

CAPI uses gender codes like '1' for Mens, '2' for Womens, etc. while cloud uses the gender name as the identifier (i.e. 'Mens'). Eventually these values will be replaced by UUIDs originating in the <a href="https://bitbucket.nike.com/projects/TAX/repos/taxonomy/browse/API-v2.md" target="_blank">Taxonomy service</a>.

### Prices

Product price information is available in Cloud in the Product Feeds v2 API. Like CAPI, prices are available in Cloud at the style-color level.

CAPI features **list** (suggested price), **currentRetail** (current price), **sale** (sale price), and the **currency** (currency code). CAPI also includes 'formatted' versions of each price in separate fields, i.e. the same price value but with the relevant currency symbol.

Cloud offers **msrp** (suggested price), **fullPrice** (full/regular price), **currentPrice** (current price), **employeePrice** (employee price), **discounted** (a Boolean indicating the product is on sale), and **currency** (currency code). Cloud does not offer 'formatted' prices.

>**TIP:** See the [Field Mapping](#field-mapping) section for detailed field-by-field mapping between CAPI and Cloud.

### Inventory

CAPI provides access to both Retail store on-hand inventory quantity and Digital inventory availability (true/false) by calling with a product ID, style-color code, or GTIN. Cloud offers Retail store on-hand inventory quantity by a combination of Store UUID and one or more GTINs in the <a href="https://bitbucket.nike.com/projects/PHYLINV/repos/v2-deliver-api/browse/inventory/API.md" target="_blank">Inventory API</a>. Cloud offers Digital inventory availability (true/false) by either Product ID or SKU ID in the <a href="https://bitbucket.nike.com/projects/PHYLINV/repos/v2-deliver-api/browse/availability/API.MD" target="_blank">Availability API</a> and also in the Product Feeds API.

>**TIP:** Both the Inventory API and the Product Feeds API offer Digital inventory availability as a boolean (TRUE or FALSE), but the Inventory API has one additional field for inventory **level** (HIGH, MEDIUM, or LOW).

### Dates

All dates returned by CAPI are in GMT in the format `yyyy-MM-dd'T'HH:mm:ss`, e.g. '2017-06-07T19:50:00.000'. For Cloud, dates are also in GMT in the format `yyyy-MM-dd'T'HH:mm:ss'Z'`, e.g. 2017-06-07T19:50:00.000Z.

### Images

CAPI clients may be accustomed to adjusting the image URL's returned by CAPI to suit their needs, e.g. by adding query parameters for format, width, height, or quality before calling to retrieve the image. With Product Feeds, you can still do the same.

One notable difference with Product Feeds is that it can return multiple image URL's by aspect ratio, namely the fields **squarishURL**, **portraitURL**, and **landscapeURL**.

### Caching/ETag/CORS Support

CAPI supports both ETag and CORS. Product Feeds supports CORS only.

Product Feeds caching is fixed at `cache-control:private, no-transform, max-age=30`.

## <a name="migration-scenarios"></a>Migration Scenarios

### Product Search Migration

**CAPI**

If your experience uses CAPI to drive free text search, it may call the CAPI Facets endpoint. For example, this CAPI URL finds all products including NIKEiD products with `vapor` in the name, sorted in ascending order.

https://commerce-api.nike.com/commerce/v1/US/en_US/facets/1j7.json?client=test-client&includeCustomizable=true&merchandisedResults=true&page=1&pageSize=10&query=vapor&rollup=product_group&sortDirection=asc

**Cloud**

One option is to use the Cloud <a href="https://bitbucket.nike.com/projects/PHYLCDSB/repos/searchtypeahead/browse/API.md" target="_blank">Type Ahead Service</a> and the <a href="https://bitbucket.nike.com/projects/PHYLCDSB/repos/visualsearchservice/browse/API.md" target="_blank">Visual Search Service</a>. This is a two-step process. The first step generates a list of suggested search terms based on customer input and the second step generates a list of suggested products with that search term in the name.

For example, when a customer types `vap` (enough to form a search term suggestion), call the search suggestion endpoint. The URL below requests search term suggestions with `vap` in the English name in the US. It returns `vaporfly` and `vapormax` searchTerms.

https://api.nike.com/search/suggestions/v1?language=en&country=us&count=4&text=vap&origin=3957856850

Then call the visual search endpoint passing one of the the search terms in the POST body to generate a list of suggested products. The URL below requests a list of suggested products and price data with `vapormax` in the name sold in the US marketplace in the English language.

https://api.nike.com/search/visual_searches/v1

POST Body:

```
{
	"marketplace": "us",
	"language": "en",
	"searchTerms": "vapormax"
}
```

### Faceted Navigation Migration

**CAPI**

If your experience uses CAPI to drive faceted navigation, it may call the CAPI Facet Discovery endpoint to derive a set of related facets. For example, this CAPI URL finds all the facets related to the Women, Shoes and Running facets using the hashed facet 7ptZ8yzZoi3.

https://commerce-api.nike.com/commerce/v1/US/en_US/facets/7ptZ8yzZoi3.json?client=test-client&fields=facets&merchandisedResults=false

**Cloud**

The equivalent Cloud API is TBD.

### Product Recommendations

**CAPI**

If your experience uses CAPI to drive the Product Display Page (PDP), it may call CAPI's Recommendations endpoint to list recommended products for a style-color. For example, this CAPI URL lists product recommendations for style-color 849557-202.

https://commerce-api.nike.com/commerce/v1/US/en_US/product/849557-202/recommendations.json?client=test-client

**Cloud**

The equivalent Cloud API is TBD.

### Product Gridwall Migration

**CAPI**

If your experience uses CAPI to drive the product gridwall, it may call CAPI's Faceted Hash search endpoint to list the products assigned to one or more facets. For example, this CAPI URL finds all products in the Women, Shoes and Running facets (including NIKEiD products) using merchandising rules and rolls them up by product group in ascending order.

https://commerce-api.nike.com/commerce/v1/US/en_US/facets/7ptZ8yzZoi3.json?client=test-client&includeCustomizable=true&merchandisedResults=true&page=1&pageSize=10&rollup=product_group&sortDirection=asc

**Cloud**

The equivalent Cloud API is TBD.

### Product Details Migration

**CAPI**

If your experience uses CAPI to get product details for the PDP, it probably calls CAPI's group details endpoint for a style-color. For example, this CAPI URL lists product details for style-color 849557-202. Because the includePreLaunch flag is set to false, the service applies visibility rules to determine if the product should be returned in the results.

https://commerce-api.nike.com/commerce/v1/US/en_US/products/details.json?client=test-client&ids=849557-202&includePreLaunch=false

**Cloud**

The comparable Cloud endpoint is the [Product Threads List endpoint](/doc/commerce/product/api_product_feeds.html#product-threads-list) in the Product Feeds API. For example, this URL calls the Product Threads List endpoint for the US marketplace and English language, filtering by style-color 8AH7282-081. It lists threads for style-color 8AH7282-081, applying Cloud visibility rules to determine which product data to return.

https://api.nike.com/product_feed/threads/v2/?filter=marketplace%28US%29&filter=language%28en%29&filter=channelId%28933182b3-5f66-4b70-b0b1-0513e235742c%29&filter=publishedContent.properties.products.styleColor%28AH7282-081%29

### Related Products Migration

**CAPI**

If your experience uses CAPI to display related colorways on the PDP, it may call CAPI's Family Product endpoint. For example, this CAPI URL lists all colorways with style code 849557.

https://commerce-api.nike.com/commerce/v1/US/en_US/product/849557-202/family.json?client=test-client

**Cloud**

The comparable Cloud endpoint is the [Product Threads List endpoint](/doc/commerce/product/api_product_feeds.html#product-threads-list) in the Product Feeds API. For example, this URL calls the Product Threads List endpoint for the US marketplace and the English language, filtering by style code AH7246. It returns thread data for any product with style code AH7246.

https://api.nike.com/product_feed/threads/v2/?filter=marketplace%28US%29&filter=language%28en%29&filter=channelId%28933182b3-5f66-4b70-b0b1-0513e235742c%29&filter=productInfo.merchProduct.styleCode%28AH7246%29

### Product Inventory Migration

**CAPI**

If your experience uses CAPI to determine which sizes of a product are in and out of stock, it may call CAPI's Inventory endpoint. For example, this CAPI URL lists whether or not each size is in stock for a list of style-colors.

https://commerce-api.nike.com/commerce/v1/US/en_US/products/inventory.json?client=test-client&ids=849557-202%2C849557-006%2C849557-041%2C849557-104%2C849557-004%2C849557-026%2C849557-100%2C849557-605%2C849557-007

**Cloud**

The comparable Cloud endpoint is the [Product Threads List endpoint](/doc/commerce/product/api_product_feeds.html#product-threads-list) in the Product Feeds API.  For example, this URL lists thread data for the list of style-colors including the SKU availablity of each size. The sample URL below calls the Product Threads List endpoint for the US marketplace and the English language, filtering by style-codes 847269-430 and AH7238-080.

https://api.nike.com/product_feed/threads/v2/?filter=marketplace%28US%29&filter=language%28en%29&filter=channelId%28933182b3-5f66-4b70-b0b1-0513e235742c%29&filter=publishedContent.properties.products.styleColor(847269-430,AH7238-080)

The response lists SKU data in the availableSkus array. The SKU is in stock if `available` is true, out of stock if false.

### Looking up style-color from GTIN

If you have a GTIN (UPC) and need to get the style-color, here are the steps you would follow in the Cloud.

1. Call the [Merchandised Product SKUs service](/doc/commerce/product/api_merch_product.html#using-merchandised-product-skus) filtering by GTIN.

https://api.nike.com/merch/skus/v2/?filter=gtin(00887225865153)

>**TIP:** It is recommended that you call the Merchandised Sku service rather than the Product Feed service if you only need SKU information, not product, inventory, product content or price information.

2. If you receive a 200 response from the Merchandised Sku service, get the parentId UUID from the response, pass it as the `id` parameter and call the [Merchandised Product service](/doc/commerce/product/api_merch_product.html#using-merchandised-products). A 200 response lists the styleCode, colorCode and styleColor.

https://api.nike.com/merch/products/v2?filter=merchgroup(US)&filter=id(2c4282cc-9fd1-5250-94a5-0c74735443dc)

>**TIP:** It is recommended that you call the Merchandised Product service rather than the Product Feeds service if you only need product information, not inventory, product content, price or SKU information.

3. If you do not receive a 200 response from the Merchandised Product Sku service, it could be because your GTIN is retail-only. Only digital SKUs are currently available in the Cloud. In this case, you will need to continue to call the CAPI Product Widths endpoint to get the style-color using the GTIN as a path parameter.

https://commerce-api.nike.com/commerce/v1/US/en_US/product/00887225865153/widths?client=test-client

## <a name="migration-contacts"></a>Migration Contacts

Have a question about migrating from CAPI services to Cloud services? See team contact information below.

|Service|Product Owner|Contact Information|Slack Channel|
|---|---|---|---|
|**CAPI**|None. These services are in KLO.|None.|#nde-capi|
|**Cloud Catalog Service**|Debbie Meier|debbie.meier@nike.com|#caps-info|
|**Cloud Inventory Service**|Lori Brown|lori.brown@nike.com|#cic-inventory|
|**Cloud Merchandised Product Service**<br>includes product, price, SKU, content, value-added service APIs|Arun KannanGeetha|arun.kannangeetha@nike.com|#pdm-merch-product|
|**Cloud Product Feed Service**<br>catalog, inventory, product, taxonomy service aggregator|Andy Sun|andy.sun@nike.com|#nde-product-feeds|
|**Cloud Search Service**|David Wagner|david.wagner@nike.com|#search-integration|
|**Cloud Taxonomy Service**|Don Lawson|don.lawson@nike.com|#cic-taxonomy|
|**Prodigy Tool**|Matt Salgado|matt.salgado@nike.com||

## <a name="endpoint-mapping"></a>Endpoint Mapping

The following table lists all of the CAPI endpoints and the equivalent Cloud endpoint.

>Note: Some of the CAPI endpoints have been deprecated and thus no equivalent exists in the Cloud. Those are marked as 'None/Deprecated'. For other CAPI endpoints, the Cloud solution is still to be determined and those are marked as 'TBD'.
>Note: Some of the CAPI endpoints have been deprecated and thus no equivalent exists in the Cloud. Those are marked as 'None/Deprecated'. For other CAPI endpoints, the Cloud solution is still to be determined and those are marked as 'TBD'.

|Use Case|CAPI Endpoint Name|Equivalent Cloud Endpoint Name|
|---|---|---|
|**Get general product info by keyword**|<a href="https://bitbucket.nike.com/projects/CA/repos/commerce-api/browse/README.md#search-free-text" target="_blank">Search: Free Text</a>|<a href="https://bitbucket.nike.com/projects/PHYLPROD/repos/productfeedv2/browse/API.md#Threads_get_product_feed_threads_v2" target="_blank">Product Feeds: Threads List</a>|
|**Get general product info by the hash of one or more facets**|<a href="https://bitbucket.nike.com/projects/CA/repos/commerce-api/browse/README.md#search-faceted-hash-search" target="_blank">Search: Faceted Hash</a>|TBD|
|**Get top-level facets available for product searches**|<a href="https://bitbucket.nike.com/projects/CA/repos/commerce-api/browse/README.md#search-facet-discovery" target="_blank">Search: Facet Discovery</a>|TBD|
|**Get general product info for one or more product identifiers**|<a href="https://bitbucket.nike.com/projects/CA/repos/commerce-api/browse/README.md#details-product" target="_blank">Details: Product/Multiple Products/Full Product/Family Product/Product Widths</a>|<a href="https://bitbucket.nike.com/projects/PHYLPROD/repos/productfeedv2/browse/API.md#Threads_get_product_feed_threads_v2" target="_blank">Product Feeds: Threads List</a>|
|**Get product reviews, ratings, recommendations**|<a href="https://bitbucket.nike.com/projects/CA/repos/commerce-api/browse/README.md#details-full-product" target="_blank">Details: Full Product</a>|TBD|
|**Get Nike-curated outfits**|<a href="https://bitbucket.nike.com/projects/CA/repos/commerce-api/browse/README.md#outfit-outfit-summary" target="_blank">Outfit: Summary/Details/Full/Reviews/Highest Rated/Most Commented/Recommendations</a>|None/Deprecated|
|**Get Digital product inventory availability for one or more product identifiers**|<a href="https://bitbucket.nike.com/projects/CA/repos/commerce-api/browse/README.m#inventory-product" target="_blank">Inventory: Product/Multiple Products</a>, <a href="https://bitbucket.nike.com/projects/CA/repos/commerce-api/browse/README.md#product-availability-availability" target="_blank">Product Availability</a>|<a href="https://bitbucket.nike.com/projects/PHYLINV/repos/v2-deliver-api/browse/availability/API.MD#sku-availability-get-sku-availability" target="_blank">Deliver: Product Availability List/Get SKU Availability</a>|
|**Get Retail product inventory quantities for one or more product identifiers**|<a href="https://bitbucket.nike.com/projects/CA/repos/commerce-api/browse/README.md#inventory-product" target="_blank">Inventory: Product/Multiple Products</a>|<a href="https://bitbucket.nike.com/projects/PHYLINV/repos/v2-deliver-api/browse/inventory/API.md" target="_blank">Inventory: Get Inventory Info</a>, <a href="https://bitbucket.nike.com/projects/PHYLINV/repos/v2-deliver-api/browse/availability/gtins/API.MD" target="_blank">Deliver: Get GTIN Availability</a>|

## <a name="field-mapping"></a>Field Mapping

### In this section:

[Search: Free Text](#search-free-text)

[Search: Facet Discovery](#search-facet-discovery)

[Search: Faceted Hash](#search-faceted-hash)

[Details: Product/Multiple Products/Full Product/Family Product/Product Widths](#details-productmultiple-productsfull-productfamily-productproduct-widths)

[Inventory: Product/Multiple Products](#inventory-productmultiple-products)

[Product Availability](#product-availability)

The following tables describe the mapping of *response body* fields between CAPI and the equivalent Cloud endpoint.

### <a name="search-free-text"></a>Search: Free Text

|CAPI Field Name|CAPI Example|Cloud Field Name|Cloud Example|Cloud Endpoint|
|---|---|---|---|---|
|**country**|us|objects.**marketplace**|US|Feeds: Threads List|
|**language**|en|objects.**language**|en|Feeds: Threads List|
|**searchTerm**|jordan shoes|**searchTerms** (query param)|Chuck Taylor|Feeds: Threads List|
|**searchFacets**|mens, shoes, customize|TBD|TBD|TBD|
|**totalResults**|9107|N/A|N/A|N/A|
|**pageNum**|1|pages.**prev**, pages.**next**|/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)<br>&filter=channelId(cd3c0153-cf35-4703-892c-f02ba990148b)&anchor=50|Feeds: Threads List|
|**resultsPerPage**|2|N/A|N/A|N/A|
|**totalPages**|4554|N/A|N/A|N/A|
|results.**id**|10074961|productInfo.merchProduct.**id**|7bea4f98-14df-5f3b-832f-eb7fc05983e2|Feeds: Threads List|
|results.**productGroupId**|N/A|productInfo.merchProduct.**productGroupId**|11836281|Feeds: Threads List|
|results.**type**|Shoes|productInfo.merchProduct.**styleType**|INLINE|Feeds: Threads List|
|results.**nikeType**|FOOTWEAR|productInfo.merchProduct.**productType**|FOOTWEAR|Feeds: Threads List|
|results.**name1**|Jordan Flight 45 Men's Shoe|productInfo.productContent.**title**|Converse Chuck Taylor All Star DC Comic Justice League High Top|Feeds: Threads List|
|results.**name2**|N/A|productInfo.productContent.subtitle|N/A|Feeds: Threads List|
|results.**nikeId**|false|productInfo.merchProduct.**styleType**|When "NIKEID" present here, product is Nike iD|Feeds: Threads List|
|results.**primarySport**|LifeStyle|productInfo.merchProduct.**sportTags**|Lifestyle|Feeds: Threads List|
|results.**nikeIdSlug**|free-id|productInfo.merchProduct.customization.**nikeIdSlug**|N/A|Feeds: Threads List|
|results.**builderType**|B16|N/A|N/A|N/A|
|results.**nikeIdPathName**|mogMid21403|N/A|N/A|N/A|
|results.**nikeIdSalesChannel**|688501|productInfo.merchProduct.channels|SNKRS|Feeds: Threads List|
|results.**readyBuiltPreBuild**|TEST_PREBUILD|TBD|TBD|TBD|
|results.**instantCustomization**|false|N/A|N/A|N/A|
|results.**pbid**|554071398|TBD|TBD|TBD|
|results.**piid**|36325|TBD|TBD|TBD|
|results.**tagline**|N/A|N/A|N/A|N/A|
|results.**nikeIdPremiumImage**|true|N/A|N/A|N/A|
|results.images.**path**|/images.nike.com/is/image/DotCom/NIKE_API<br>/Jordan-Flight-45-Mens-Shoe-644846_005.png|publishedContent.properties.nodes.nodes.properties**squareURL**|/c.static-nike.com/a/images/w_1920,c_limit<br>/cizvemmljfyngf1zxikt/tiempo-totti.jpg|Feeds: Threads List|
|results.images.**alt**|Jordan Flight 45 Men's Shoe|publishedContent.properties.nodes.nodes.properties.**altText**|Nike Tiempo Legend 6 Totti Gladiator|Feeds: Threads List|
|results.images.**type**|primary|publishedContent.properties.coverCard.**subType**|image|Feeds: Threads List|
|results.images.**sortOrder**|1|N/A|N/A|N/A|
|results.prices.**list**|120|productInfo.merchPrice.**msrp**|120|Feeds: Threads List|
|results.prices.**sale**|100|productInfo.merchPrice.**currentPrice** when **discounted**=true|100|Feeds: Threads List|
|results.prices.**nikeType**|APPAREL|productInfo.merchProduct.**productType**|APPAREL|Feeds: Threads List|
|results.prices.**currencyCode**|USD|productInfo.merchPrice.**currency**|USD|Feeds: Threads List|
|results.prices.**formattedList**|$120|N/A (Deprecated)|N/A|N/A|
|results.prices.**formattedSale**|$100|N/A|N/A (Deprecated)|N/A|
|results.**style**|644846|productInfo.merchProduct.**styleCode**|AA0612|Feeds: Threads List|
|results.**colorCode**|5|productInfo.merchProduct.**colorCode**|002|Feeds: Threads List|
|results.**colorDescription**|Black|productInfo.productContent.**colorDescription**|Gold|Feeds: Threads List|
|results.**swatchColor**|FFFFFF|productInfo.productContent.colors.**hex**|E9B137|Feeds: Threads List|
|results.**hardLaunch**|false|productInfo.merchPrice.**hardLaunch**|true|Feeds: Threads List|
|results.**preOrder**|false|productInfo.merchPrice.**preOrder**|true|Feeds: Threads List|
|results.**accessCode**|false|productInfo.merchProduct.**exclusiveAccess**|false|Feeds: Threads List|
|results.**startDate**|2014-04-01T12:00:00|productInfo.merchPrice.**commerceStartDate**|2017-04-26T14:00:00.000Z|Feeds: Threads List|
|results.**comingSoonDate**|2014-04-01T12:00:00|N/A|N/A|N/A|
|results.**quantityLimit**|10|productInfo.merchProduct.**quantityLimit**|10|Feeds: Threads List|
|results.**appleWatch**|false|N/A|N/A|N/A|
|results.**availableOnline**|true|N/A|N/A|N/A|
|results.**availableInStores**|false|N/A|N/A|N/A|
|results.urls.**inventoryUrl**|/commerce-api.nike.com/commerce/v1/us<br>/en_US/product/10074961/inventory|N/A|N/A|N/A|
|results.urls.**productUrl**|/commerce-api.nike.com/commerce/v1/us<br>/en_US/product/10074961/details|N/A|N/A|N/A|
|results.urls.**reviewsUrl**|/commerce-api.nike.com/commerce/v1/us<br>/en_US/product/10074961/reviews|N/A|N/A|N/A|
|results.urls.**recommendationsUrl**|/commerce-api.nike.com/commerce/v1/us<br>/en_US/product/10074961/recommendations|N/A|N/A|N/A|
|pageUrls.**prevUrl**|/commerce-api.nike.com/commerce/v1/us<br>/en_US/search?page=1&query=jordan+shoes|pages.**prev**|/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=<br>channelId(cd3c0153-cf35-4703-892c-f02ba990148b)&anchor=40|Feeds: Threads List|
|pageUrls.**nextUrl**|/commerce-api.nike.com/commerce/v1/us<br>/en_US/search?page=3&query=jordan+shoes|pages.**next**|/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)&filter=<br>channelId(cd3c0153-cf35-4703-892c-f02ba990148b)&anchor=50|Feeds: Threads List|
|pageUrls.**firstUrl**|/commerce-api.nike.com/commerce/v1/us<br>/en_US/search?page=1&query=jordan+shoes|N/A|N/A|N/A|
|pageUrls.**lastUrl**|/commerce-api.nike.com/commerce/v1/us<br>/en_US/search?page=4554&query=jordan+shoes|N/A|N/A|N/A|

### <a name="search-facet-discovery"></a>Search: Facet Discovery

|CAPI Field Name|CAPI Example|Cloud Field Name|Cloud Example|Cloud Endpoint|
|---|---|---|---|---|
|**country**|us|TBD|TBD|TBD|
|language|en|TBD|TBD|TBD|
|facets.**name**|Sport|TBD|TBD|TBD|
|facets.**group**|Sport|TBD|TBD|TBD|
|facets.**id**|10120|TBD|TBD|TBD|
|facets.**masterName**|Running|TBD|TBD|TBD|
|facets.facetValues.**name**|Running|TBD|TBD|TBD|
|facets.facetValues.**group**|Sport|TBD|TBD|TBD|
|facets.facetValues.**hash**|8yz|TBD|TBD|TBD|
|facets.facetValues.**masterName**|Running|TBD|TBD|TBD|
|facets.facetValues.**links**|N/A|TBD|TBD|TBD|
|facets.facetValues.links.**rel**|search|TBD|TBD|TBD|
|facets.facetValues.links.**href**|/domain:port/commerce/v1/us/en_US/facets/8yz|TBD|TBD|TBD|

### <a name="search-faceted-hash"></a>Search: Faceted Hash

|CAPI Field Name|CAPI Example|Cloud Field Name|Cloud Example|Cloud Endpoint|
|---|---|---|---|---|
|**country**|us|objects.**marketplace**|US|Feeds: Threads List|
|**language**|en|objects.**language**|en|Feeds: Threads List|
|**currentFacetName**|Nike+ Accessories|TBD|TBD|TBD|
|**currentFacetSlug**|nike-accessories|TBD|TBD|TBD|
|**searchHash**|1js|TBD|TBD|TBD|
|**searchTerm**|N/A|**searchTerms** (query param)|Chuck Taylor|Feeds: Threads List|
|**sortBy**|N/A|TBD|TBD|TBD|
|**sortDirection**|N/A|TBD|TBD|TBD|
|**totalResults**|13|N/A|N/A|N/A|
|**pageNum**|1|pages.**prev**, pages.**next**|/product_feed/threads/v2?filter=marketplace(US)&filter=language(en)<br>&filter=channelId(cd3c0153-cf35-4703-892c-f02ba990148b)&anchor=50|Feeds: Threads List|
|**resultsPerPage**|10|N/A|N/A|N/A|
|**totalPages**|1|N/A|N/A|N/A|
|analytics.**id**|10120|TBD|TBD|TBD|
|analytics.**masterName**|Sport|TBD|TBD|TBD|
|analytics.**gated**|false|TBD|TBD|TBD|
|analytics.**rollup**|false|TBD|TBD|TBD|
|analytics.**dimensionGroup**|N/A|TBD|TBD|TBD|
|analytics.**selected**|false|TBD|TBD|TBD|
|analytics.analyticsValues.**id**|12296|TBD|TBD|TBD|
|analytics.analyticsValues.**masterName**|Training|TBD|TBD|TBD|
|analytics.analyticsValues.**dimensionGroup**|N/A|TBD|TBD|TBD|
|analytics.analyticsValues.**selected**|true|TBD|TBD|TBD|
|results.**pgid**|10292379|TBD|TBD|TBD|
|results.**totalProducts**|1|TBD|TBD|TBD|
|results.products.**id**|10266756|productInfo.merchProduct.**id**|7bea4f98-14df-5f3b-832f-eb7fc05983e2|Feeds: Threads List|
|results.products.**productGroupId**|10292379|productInfo.merchProduct.**productGroupId**|11836281|Feeds: Threads List|
|results.products.**type**|Footwear|productInfo.merchProduct.**styleType**|INLINE|Feeds: Threads List|
|results.products.**nikeType**|FOOTWEAR|productInfo.merchProduct.**productType**|FOOTWEAR|Feeds: Threads List|
|results.products.**name1**|Nike Zoom Hypercross TR|productInfo.productContent.**title**|Converse Chuck Taylor All Star DC Comic Justice League High Top|Feeds: Threads List|
|results.products.**name2**|Men's Training Shoe|productInfo.productContent.subtitle|N/A|Feeds: Threads List|
|results.products.**nikeId**|false|productInfo.merchProduct.**styleType**|When "NIKEID" present here, product is Nike iD|Feeds: Threads List|
|results.products.**primarySport**|Lifestyle|productInfo.merchProduct.**sportTags**|Lifestyle|Feeds: Threads List|
|results.products.**nikeIdSlug**|free-id|productInfo.merchProduct.customization.**nikeIdSlug**|N/A|Feeds: Threads List|
|results.products.**builderType**|B13|N/A|N/A|N/A|
|results.products.**nikeIdPathName**|mogMid21403|N/A|N/A|N/A|
|results.products.**nikeIdSalesChannel**|688501|productInfo.merchProduct.channels|SNKRS|Feeds: Threads List|
|results.products.**readyBuiltPreBuild**|TEST_PREBUILD|TBD|TBD|TBD|
|results.products.**instantCustomization**|false|N/A|N/A|N/A|
|results.products.**slug**|zoom-hypercross-tr-training-shoe|productInfo.productContent.**slug**|tiempo-legend-vi-se-firm-ground-soccer-cleat|Feeds: Threads List|
|results.products.**pbid**|554071398|TBD|TBD|TBD|
|results.products.**piid**|36325|TBD|TBD|TBD|
|results.products.**nikeIdPremiumImage**|true|N/A|N/A|N/A|
|results.products.images.**path**|/images.nike.com/is/image/DotCom/NIKE_API<br>/Nike-Zoom-Hypercross-TR-616192_300.png|publishedContent.properties.nodes.nodes.properties**squareURL**|/c.static-nike.com/a/images/w_1920,c_limit<br>/cizvemmljfyngf1zxikt/tiempo-totti.jpg|Feeds: Threads List|
|results.products.images.**alt**|Nike Zoom Hypercross TR Men's Training Shoe|publishedContent.properties.nodes.nodes.properties.**altText**|Nike Tiempo Legend 6 Totti Gladiator|Feeds: Threads List|
|results.products.images.**type**|primary|publishedContent.properties.coverCard.**subType**|image|Feeds: Threads List|
|results.products.images.**sortOrder**|1|N/A|N/A|N/A|
|results.products.prices.**msrp**|150|productInfo.merchPrice.**msrp**|150|Feeds: Threads List|
|results.products.prices.**list**|150|productInfo.merchPrice.**msrp**|150|Feeds: Threads List|
|results.products.prices.**currentRetail**|120|productInfo.merchPrice.**currentPrice**|120|Feeds: Threads List|
|results.products.prices.**sale**|100|productInfo.merchPrice.**currentPrice** when **discounted**=true|100|Feeds: Threads List|
|results.products.prices.**currencyCode**|USD|productInfo.merchPrice.**currency**|USD|Feeds: Threads List|
|results.products.prices.**formattedMsrp**|$150|N/A|N/A|N/A|
|results.products.prices.**formattedList**|$150|N/A|N/A|N/A|
|results.products.prices.**formattedCurrentRetail**|$150|N/A|N/A|N/A|
|results.products.prices.**formattedCurrentSale**|$150|N/A|N/A|N/A|
|results.products.**style**|684635|productInfo.merchProduct.**styleCode**|AA0612|Feeds: Threads List|
|results.products.**colorCode**|30|productInfo.merchProduct.**colorCode**|002|Feeds: Threads List|
|results.products.**colorDescription**|Black|productInfo.productContent.**colorDescription**|Gold|Feeds: Threads List|
|results.products.**swatchColor**|FFFFFF|productInfo.productContent.colors.**hex**|E9B137|Feeds: Threads List|
|results.products.**hardLaunch**|true|productInfo.merchPrice.**hardLaunch**|true|Feeds: Threads List|
|results.products.**preOrder**|false|productInfo.merchPrice.**preOrder**|true|Feeds: Threads List|
|results.products.**accessCode**|N/A|productInfo.merchProduct.**exclusiveAccess**|false|Feeds: Threads List|
|results.products.**startDate**|2014-04-01|productInfo.merchPrice.**commerceStartDate**|2017-04-26T14:00:00.000Z|Feeds: Threads List|
|results.products.**comingSoonDate**|2014-04-01|N/A|N/A|N/A|
|results.products.**publishDate**|2014-04-01|TBD|TBD|TBD|
|results.products.**overallRating**|N/A|TBD|TBD|TBD|
|results.products.**numRatings**|120|TBD|TBD|TBD|
|results.products.**quantityLimit**|10|productInfo.merchProduct.**quantityLimit**|10|Feeds: Threads List|
|results.products.**appleWatch**|N/A|N/A|N/A|N/A|
|results.products.**availableOnline**|true|N/A|N/A|N/A|
|results.products.**availableInStores**|true|N/A|N/A|N/A|
|results.products.urls.**inventoryUrl**|/domain:port/commerce/v1/us<br>/en_US/product/10266756/inventory|N/A|N/A|N/A|
|results.products.urls.**productUrl**|/domain:port/commerce/v1/us<br>/en_US/product/10266756/details|N/A|N/A|N/A|
|results.products.urls.**reviewsUrl**|/domain:port/commerce/v1/us<br>/en_US/product/10266756/reviews|N/A|N/A|N/A|
|results.products.urls.**recommendationsUrl**|/domain:port/commerce/v1/us<br>/en_US/product/10266756/recommendations|N/A|N/A|N/A|
|facets.**name**|Collections|TBD|TBD|TBD|
|facets.**group**|Collections|TBD|TBD|TBD|
|facets.**id**|10042|TBD|TBD|TBD|
|facets.**masterName**|Collections|TBD|TBD|TBD|
|facets.facetValues.**name**|Nike Pro|TBD|TBD|TBD|
|facets.facetValues.**group**|Brand|TBD|TBD|TBD|
|facets.facetValues.**hash**|7u9Z9hkZbqj|TBD|TBD|TBD|
|facets.facetValues.**masterName**|Nike Pro|TBD|TBD|TBD|
|facets.facetValues.**links**|N/A|TBD|TBD|TBD|
|facets.facetValues.links.**rel**|search|TBD|TBD|TBD|
|facets.facetValues.links.**href**|/domain:port/commerce/v1/us<br>/en_US/facets/7u9Z9hkZbqj|TBD|TBD|TBD|
|selectedFacetValues.**name**|Nike Pro|TBD|TBD|TBD|
|selectedFacetValues.**group**|Brand|TBD|TBD|TBD|
|selectedFacetValues.**hash**|7u9Z9hkZbqj|TBD|TBD|TBD|
|selectedFacetValues.**links**|N/A|TBD|TBD|TBD|
|selectedFacetValues.links.**rel**|search|TBD|TBD|TBD|
|selectedFacetValues.links.**href**|/domain:port/commerce/v1/us<br>/en_US/facets/7u9Z9hkZbqj|TBD|TBD|TBD|
|pageUrls.**firstUrl**|/domain:port/commerce/v1/us<br>/en_US/facets/9hkZbqj?page=1&pageSize=10|N/A|N/A|N/A|
|pageUrls.**lastUrl**|/domain:port/commerce/v1/us<br>/en_US/facets/9hkZbqj?page=1&pageSize=10|N/A|N/A|N/A|

### <a name="details-productmultiple-productsfull-productfamily-productproduct-widths"></a>Details: Product/Multiple Products/Full Product/Family Product/Product Widths

|CAPI Field Name|CAPI Example|Cloud Field Name|Cloud Example|Cloud Endpoint|
|---|---|---|---|---|
|**country**|us|objects.**marketplace**|US|Feeds: Threads List|
|**locale**|en_US|objects.**language**|en|Feeds: Threads List|
|results.**requestedProduct**|1505636|productInfo.merchProduct.**pid**|1505636|Feeds: Threads List|
|results.product.**id**|1505636|productInfo.merchProduct.**id**|7bea4f98-14df-5f3b-832f-eb7fc05983e2|Feeds: Threads List|
|results.product.**productGroupId**|1538982|objects.productInfo.merchProduct.**productGroupId**|11820113|Feeds: Threads List|
|results.product.**type**|Shoes|productInfo.merchProduct.**productType**|FOOTWEAR|Feeds: Threads List|
|results.product.**nikeType**|Shoes|productInfo.merchProduct.**productType**|FOOTWEAR|Feeds: Threads List|
|results.product.**name1**|Nike Air Mogan Mid 2 iD|publishedContent.properties.**title**|Converse Chuck Taylor All Star DC Comic Justice League High Top|Feeds: Threads List|
|results.product.**name2**|Men's Skateboarding Shoe|N/A|N/A|N/A|
|results.product.**nikeId**|true|productInfo.merchProduct.**styleType**|When "NIKEID" present here, product is Nike iD|Feeds: Threads List|
|results.product.**primarySport**|Lifestyle|productInfo.merchProduct.**sportTags**|Lifestyle|Feeds: Threads List|
|results.product.**instantCustomization**|false|N/A|N/A|N/A|
|results.product.**nikeIdPathName**|mogMid21403|N/A|N/A|N/A|
|results.product.**nikeIdMatchStyle**|688501|productInfo.merchProduct.customization.nikeIdStyleCode|688501|Feeds: Threads List|
|results.product.**slug**|air-mogan-mid-2-id|productInfo.productContent.**slug**|tiempo-legend-vi-se-firm-ground-soccer-cleat|Feeds: Threads List|
|results.product.**nikeIdSlug**|athletic-id-shoulder-bag|productInfo.merchProduct.customization.nikeIdSlug|athletic-id-shoulder-bag|Feeds: Threads List|
|results.product.**builderType**|B16|N/A|N/A|N/A|
|results.product.**nikeIdSalesChannel**|stuff|productInfo.merchProduct.channels|SNKRS|Feeds: Threads List|
|results.product.**readyBuiltPreBuild**|things|N/A|N/A|N/A|
|results.product.**athletes**|Kobe Bryant|productInfo.productContent.athletes.**value**, *.**localizedValue**|Carmelo Anthony|Feeds: Threads List|
|results.product.**tagline**|N/A|N/A|N/A|N/A|
|results.product.**benefitsBullets**|N/A|N/A|N/A|N/A|
|results.product.**benefits**|Benefits / long description|productInfo.productContent.**description**|<p><b>Benefits</b></p>Leather, synthetic leather or textile upper depending on color|Feeds: Threads List|
|results.product.**sizeAndFit**|mens-shoe-sizing-chart|productInfo.productContent.**sizeChart**|mens-shoe-sizing-chart|Feeds: Threads List|
|results.product.**techSpec**|N/A|productInfo.productContent.**techSpec**|N/A|Feeds: Threads List|
|results.product.**shoeTechnologies**|Lunarlon|productInfo.merchProduct.**sportTags**|Lunarlon|Feeds: Threads List|
|results.product.**runningSurfaces**|Road|productInfo.productContent.bestFor.**value**, *.**localizedValue**|Grass|Feeds: Threads List|
|results.product.**bestFor**|Stability|productInfo.productContent.bestFor.**value**|Grass|Feeds: Threads List|
|results.product.**badges**|N/A|N/A|N/A|N/A|
|results.product.images.**path**|/images.nike.com/is/image/DotCom/NIKE_API_THN<br>/Nike-Air-Zoom-Structure-18-Womens-Running-Shoe-683737_100_A_PREM.png|publishedContent.properties.coverCard.properties.**portraitURL**|/c.static-nike.com/a/images/w_1920,c_limit<br>/cizvemmljfyngf1zxikt/tiempo-totti.jpg|Feeds: Threads List|
|results.product.images.**alt**|Nike Air Zoom Structure 18 Women's Running Shoe|publishedContent.properties.coverCard.properties.**altText**|Nike Tiempo Legend 6 Totti Gladiator|Feeds: Threads List|
|results.product.images.**type**|thumb|publishedContent.properties.coverCard.**subType**|image|Feeds: Threads List|
|results.product.images.**sortOrder**|1|N/A|N/A|N/A|
|results.product.prices.**list**|115|productInfo.merchPrice.**msrp**|235|Feeds: Threads List|
|results.product.prices.**currentRetail**|115|productInfo.merchPrice.**currentPrice**|235|Feeds: Threads List|
|results.product.prices.**sale**|115|productInfo.merchPrice.**currentPrice** when **discounted**=true|115|Feeds: Threads List|
|results.product.prices.**currencyCode**|USD|productInfo.merchPrice.**currency**|USD|Feeds: Threads List|
|results.product.prices.**formattedList**|$115.00|N/A|N/A|N/A|
|results.product.prices.**formattedCurrentRetail**|$115.00|N/A|N/A|N/A|
|results.product.prices.**formattedSale**|$115.00|N/A|N/A|N/A|
|results.product.**primaryColor**|White|productInfo.productContent.colors.**name**|White|Feeds: Threads List|
|results.product.**style**|653710|productInfo.merchProduct.**styleCode**|AA0612|Feeds: Threads List|
|results.product.**colorCode**|991|productInfo.merchProduct.**colorCode**|706|Feeds: Threads List|
|results.product.**colorDescription**|White/Black/Volt/Reflect Silver|productContent.colors.**name**|Gold|Feeds: Threads List|
|results.product.**colorwayGeneralMessage**|N/A|N/A|N/A|N/A|
|results.product.**accessCode**|false|productInfo.merchProduct.**exclusiveAccess**|false|Feeds: Threads List|
|results.product.**swatchColor**|0|productInfo.productContent.colors.**hex**|E9B137|Feeds: Threads List|
|results.product.**swatchColorDescription**|Black Heather|productInfo.productContent.colors.**name**|Gold|Feeds: Threads List|
|results.product.**hardLaunch**|false|productInfo.merchProduct.**hardLaunch**|true|Feeds: Threads List|
|results.product.**preOrder**|false|productInfo.merchProduct.**preOrder**|true|Feeds: Threads List|
|results.product.**startDate**|2014-02-01T00:00:00|productInfo.merchProduct.**commerceStartDate**|2017-04-26T14:00:00.000Z|Feeds: Threads List|
|results.product.**comingSoonDate**|2014-02-01T00:00:00|N/A|N/A|N/A|
|results.product.**comingSoonMessage**|N/A|N/A|N/A|N/A|
|results.product.**publishDate**|2014-02-04T00:00:00|publishedContent.**publishStartDate**|2017-11-09T20:30:21.000Z|Feeds: Threads List|
|results.product.**endDate**|2014-02-04T00:00:00|publishedContent.**publishEndDate**|3000-01-01T19:00:00.000Z|Feeds: Threads List|
|results.product.**preOrderAvailDate**|2014-02-04T00:00:00|productInfo.merchProduct.**preorderAvailabilityDate**|2017-11-13T08:00:00.000Z|Feeds: Threads List|
|results.product.**preOrderByDate**|2014-02-04T00:00:00|productInfo.merchProduct.**preorderByDate**|2017-11-13T08:00:00.000Z|Feeds: Threads List|
|results.product.**launchHeat**|N/A|N/A|N/A|N/A|
|results.product.**stockType**|N/A|N/A|N/A|N/A|
|results.product.**quantityLimit**|10|productInfo.merchProduct.**quantityLimit**|10|Feeds: Threads List|
|results.product.**appleWatch**|N/A|N/A|N/A|N/A|
|results.product.**taxCode**|N/A|productInfo.skus.countrySpecifications.taxInfo.**commodityCode**|531119.100|Feeds: Threads List|
|results.product.**notifyMeMessage**|N/A|N/A|N/A|N/A|
|results.product.catalogs.**merchGroup**|N/A|productInfo.merchProduct.**merchGroup**|US|Feeds: Threads List|
|results.product.catalogs.**catalogId**|N/A|productInfo.merchProduct.**catalogId**|f48ce476-9347-3550-b33c-1acf7c182854|Feeds: Threads List|
|results.product.instances.**piid**|36062|TBD|TBD|TBD|
|results.product.instances.**masterProductId**|1505636|TBD|TBD|TBD|
|results.product.instances.**prebuilds**|N/A|TBD|TBD|TBD|
|results.product.instances.prebuilds.**pbid**|141998474|TBD|TBD|TBD|
|results.product.instances.prebuilds.**legacyPid**|1527591|TBD|TBD|TBD|
|results.product.instances.**defaultPrebuilds**|683895122|TBD|TBD|TBD|
|results.product.prebuilds.**pbid**|141998474|TBD|TBD|TBD|
|results.product.prebuilds.**pdpPath**|/v2/products/mogMid21403/pdp/default_en.xml|TBD|TBD|TBD|
|results.product.prebuilds.**simpleColor**|Blue|TBD|TBD|TBD|
|results.product.prebuilds.**images**|N/A|TBD|TBD|TBD|
|results.product.prebuilds.images.**path**|/ugc.nikeid.com/is/image/nike/ugc/NIKE_PWP_FTWR<br>/Nike-Air-Mogan-Mid-2-iD-_-141998474.tif?fmt=png|TBD|TBD|TBD|
|results.product.prebuilds.images.**alt**|Nike Air Mogan Mid 2 iD|TBD|TBD|TBD|
|results.product.prebuilds.images.**type**|primary|TBD|TBD|TBD|
|results.product.prebuilds.images.**sortOrder**|1|TBD|TBD|TBD|
|results.product.prebuilds.**instances**|36062|TBD|TBD|TBD|
|results.product.prebuilds.**defaultPrebuildForInstances**|36062|TBD|TBD|TBD|
|results.product.**otherWidths**|true|N/A|N/A|N/A|
|results.product.widths.**pid**|1538981|N/A|N/A|N/A|
|results.product.widths.**pgid**|1538982|N/A|N/A|N/A|
|results.product.widths.**widthName**|Regular|productInfo.productContent.widths.**value**, *.**localizedValue**|REGULAR, Regular|Feeds: Threads List|
|results.product.**genders**|1|productInfo.merchProduct.**genders**|MEN|Feeds: Threads List|
|results.product.skus.**skuId**|3777803|productInfo.skus.**stockKeepingUnitId**|3777803|Feeds: Threads List|
|results.product.skus.**nikeSize**|42MM|productInfo.skus.**nikeSize**|42MM|Feeds: Threads List|
|results.product.skus.**inStockOnline**|true|productInfo.availableSkus.**available**|true|Feeds: Threads List|
|results.product.skus.**purchaseInCountry**|true|N/A|N/A|N/A|
|results.product.skus.**upc**|00883418129569|productInfo.skus.**gtin**|00883419546983|Feeds: Threads List|
|results.product.skus.**commodityCode**|531119.1|productInfo.skus.countrySpecifications.taxInfo.**commodityCode**|531119.100|Feeds: Threads List|
|results.product.skus.sizeDescription.**sizeText**|6|productInfo.skus.**nikeSize**, *.**localizedSize**|7|Feeds: Threads List|
|results.product.skus.sizeDescription.**unitText**|N/A|N/A|N/A|N/A|
|results.product.urls.**inventoryUrl**|/commerce-api.nike.com/commerce/v1/us<br>/en_US/product/1505636/inventory|N/A|N/A|N/A|
|results.product.urls.**productUrl**|/commerce-api.nike.com/commerce/v1/us<br>/en_US/product/1505636/details|productInfo.merchProduct.links.self.**ref**|/merch/products/v2/75d4ae01-f913-50a5-ac9c-03670f302ac1|Feeds: Threads List|
|results.product.urls.**reviewsUrl**|/commerce-api.nike.com/commerce/v1/us<br>/en_US/product/1505636/reviews|N/A|N/A|N/A|
|results.product.urls.**recommendationsUrl**|/commerce-api.nike.com/commerce/v1/us<br>/en_US/product/1505636/recommendations|N/A|N/A|N/A|
|reviews.**rating**|4.4|N/A|N/A|N/A|
|reviews.**maxRating**|5|N/A|N/A|N/A|
|reviews.**numReviews**|5|N/A|N/A|N/A|

### <a name="inventory-productmultiple-products"></a>Inventory: Product/Multiple Products

**Digital**

|CAPI Field Name|CAPI Example|Cloud Field Name|Cloud Example|Cloud Endpoint|
|---|---|---|---|---|
|**country**|us|N/A|N/A|N/A|
|**language**|en|N/A|N/A|N/A|
|**requestProduct**|403298|N/A|N/A|N/A|
|**productId**|1057886|N/A|N/A|N/A|
|**styleColor**|WM0114-006|N/A|N/A|N/A|
|skuInventories.**skuId**|3613064|**skuId**|b307d7c0-0d71-11e6-b19d-df64d28a4129|Inventory: Get Inventory Info|
|skuInventories.**nikeSize**|S|N/A|N/A|N/A|
|skuInventories.**inStockOnline**|true|**available**|true|Inventory: Get Inventory Info|
|skuInventories.**inStockOnline**|true|productInfo.availableSkus.**available** (Note: another option for same)|true|Feeds: Threads List|
|skuInventories.**upc**|885176172030|N/A|N/A|N/A|
|skuInventories.**sizeDescription**|N/A|N/A|N/A|N/A|
|skuInventories.sizeDescription.**sizeText**|S|N/A|N/A|N/A|
|skuInventories.**storeInventories**|N/A|N/A|N/A|N/A|
|skuInventories.storeInventories.**numberInStock**|1|N/A|N/A|N/A|
|skuInventories.storeInventories.**storeId**|368|N/A|N/A|N/A|
|**pageUrls**|N/A|N/A|N/A|N/A|

**Retail Store**

|CAPI Field Name|CAPI Example|Cloud Field Name|Cloud Example|Cloud Endpoint|
|---|---|---|---|---|
|**country**|us|N/A|N/A|N/A|
|**language**|en|N/A|N/A|N/A|
|**requestProduct**|403298|N/A|N/A|N/A|
|**productId**|1057886|N/A|N/A|N/A|
|**styleColor**|WM0114-006|N/A|N/A|N/A|
|skuInventories.**skuId**|3613064|N/A|N/A|N/A|
|skuInventories.**nikeSize**|S|N/A|N/A|N/A|
|skuInventories.**inStockOnline**|true|N/A|N/A|N/A|
|skuInventories.**upc**|885176172030|**gtin**|1234567895678|Inventory: Get Inventory Info|
|skuInventories.sizeDescription.**sizeText**|S|N/A|N/A|N/A|
|skuInventories.storeInventories.**numberInStock**|1|**quantity**|1|Inventory: Get Inventory Info|
|skuInventories.storeInventories.**storeId**|368|**storeId**|9C659645-36E8-4B8D-AF29-573B48C75E38|Inventory: Get Inventory Info|
|**pageUrls**|N/A|N/A|N/A|N/A|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>With CAPI, Digital inventory availability could be requested by product ID (PID), style-color code, or GTIN (i.e. size). With Cloud, the same can be requested by Product ID (i.e. style-color) or SKU ID (i.e. size).
>
><i class="mr2-sm g72-check"></i>The **storeId** from the Cloud endpoint *Get Inventory Info* is a UUID from the <a href="https://developer.niketech.com/docs/projects/Stores" target="_blank">Stores API</a>.

### <a name="product-availability"></a>Product Availability

|CAPI Field Name|CAPI Example|Cloud Field Name|Cloud Example|Cloud Endpoint|
|---|---|---|---|---|
|**productId**|1057886|**productId**|a212ccc0-0d73-11e6-b19d-df64d28a4129|Deliver: Product Availability List|
|**productGroupId**|1074990|N/A|N/A|N/A|
|**style**|WM0114|N/A|N/A|N/A|
|**colorCode**|101|N/A|N/A|N/A|
|**gtin**|00887223392798|N/A|N/A|N/A|
|**viewable**|true|**available**|true|Deliver: Product Availability List/Get SKU Availability|
|**sellable**|true|**available**|true|Deliver: Product Availability List/Get SKU Availability|
|**viewableDate**|2017-04-03T12:00:00|N/A|N/A|N/A|
|**startDate**|2017-04-03T12:00:00|N/A|N/A|N/A|
|**reasons**|N/A|N/A|N/A|N/A|

>Notes:

> * With Cloud, there is no distinction between 'viewable' and 'sellable' and there is no longer a corresponding date value for both. The product is either 'available' or not based on the boolean value returned in the response.

<!--
## <a name="document-change-log"></a>Document Change Log

|Summary |Date |Description|
|---|---|---|
|||
-->

## <a name="related-links"></a>Related Links

[NDe Docs Home](/index.html)

[Get Started](/doc/getting-started/get-started.html)