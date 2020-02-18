---
id: use-channeled-products
tags: pdf
# category: b-use-case
position: 5
title: Channeled Products
url: /doc/commerce/product/use-channeled-products.html
toc:
 - h2: Introduction
   url: /doc/commerce/product/use-channeled-products.html#introduction
 - h2: Key Concepts & Terms
   url: /doc/commerce/product/use-channeled-products.html#key-concepts--terms
 - h2: Get Channeled Products by Product Code or GTIN
   url:  /doc/commerce/product/use-channeled-products.html#get-channeled-products-by-product-code-or-gtin
 - h2: Get a Channeled Product by its ID
   url:  /doc/commerce/product/use-channeled-products.html#get-a-channeled-product-by-its-id
 - h2: API Endpoint Quick Reference
   url:  /doc/commerce/product/use-channeled-products.html#api-endpoint-quick-reference
 - h2: Best Practices
   url:  /doc/commerce/product/use-channeled-products.html#best-practices
 - h2: Troubleshooting
   url:  /doc/commerce/product/use-channeled-products.html#troubleshooting
 - h2: Terms of Service
   url:  /doc/commerce/product/use-channeled-products.html#terms-of-service
 - h2: Contacting the Team
   url:  /doc/commerce/product/use-channeled-products.html#contacting-the-team
 - h2: Document Change Log
   url:  /doc/commerce/product/use-channeled-products.html#document-change-log
 - h2: Next Steps
   url:  /doc/commerce/product/use-channeled-products.html#next-steps
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="new-tab" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# Using Channeled Products <i class="g72-swoosh"></i><br>DRAFT

---

##### Last Updated: 01/31/2020

Use the Channeled Products API to **get product data that is segmented by channel, marketplace, and channel type** into your app.

>**TIP**: Migrating from Merch Products/SKUs? See also the [Channeled Products Migration Guide](link to that guide).

## Introduction

### What are Channeled Products?

The Channeled Products API provides Nike product data that is segmented by channel, marketplace, and channel type (see [Key Concepts & Terms](#key-concepts--terms for definitions). This helps you get the right set of product data delivered to the app, experience or store where they are to be sold.

`(Insert diagram showing channel, marketplace, channel type intersecting, along with an example of what a combination of those would look like IRL)`

>**NOTE**: Product pricing and content data are *NOT* available from Channeled Products. See [some other thing](link to that thing) for more.

### What Product Data is Available?

The Channeled Products API response contains one or more Nike products, each having attributes like:

Product Code
Style Code
Color Code
Product Type
Colors
Sizes
Consumer Taxonomy Attributes
Lifecycle Management
Marketplace
Channel Type
Consumer Channel Id

`(Replace above list with a picture showing the types of data and how they can be used. Group as necessary to simplify diagram.)`

## Key Concepts & Terms

### Channel, Marketplace, and Channel Type

- **Channel**: a specific intersection of product, services and environment, whether digital or physical retail. Identified uniquely by a UUID. Example: Nike.com, Nike App, SNKRS.

- **Marketplace**: a universally-defined location where goods are bought and sold, e.g. geo-political countries. Example: "US".

- **Channel Type**: types of retailers based on the target consumer, retail format and business model. Example: "Digital".

`(Give an example of what an intersection of these three things looks like)`

### Building a Product Data Set Requires Calling Other APIs

`(Enumerate here, or link to below, the additional APIs that can be called to build out the product data set further)`

### Terms

Here are other key terms used in this document.

###### Table 1: Key Terms

|Term|Definition|
|---|---|
|Product Code|The combination of Nike style code and color code. Example: 654321-001|
|Style Code|The Nike style code. Example: 654321|
|Color Code|The Nike color code. Example: 001|
|Product Type||
|Consumer Taxonomy Attribute||
|Lifecycle Management||
|GTIN|The global trade identifier number, unique to a style, color, and size combination. Example: 00867350300861|

## Get Channeled Products by Product Code or GTIN

<i class="g72-check"></i>&nbsp;&nbsp;**Get a list of Channeled Products**

Legacy use cases:

<i class="g72-check"></i>&nbsp;&nbsp;**List merchandised product information such as product state, gender, merchandising tags, product type, and launch dates for a list of style-colors**

<i class="g72-check"></i>&nbsp;&nbsp;**List the sizes and SKU detail such as Nike size, localized size description, value-added tax (VAT) and Commodity Code for a style-color**

### Step 1: Execute the Request

To get a list of Channeled Products, execute a GET request like:

```
curl --location --request GET 'https://api.nike.com/product_catalog/channeled_products/v1/?filter=productCodes%28654321-001%29'
```

#### Customizing Your Results

Customize your results by including URL query parameters in the request, as follows:

- The required `filter` query parameter must contain either a list of `productCodes()` or `gtins()` with comma-separated values, like `?filter=productCodes(654321-001,123456-701,...)`
- The optional `fields` query parameter allows you to specify by name which fields that you want in the response, like `?fields=productCode,styleCode,...`

### Step 2: Enrich Product Data Set via Other APIs

Optionally, you can build out your product data set even further. Use the data from the Channeled Products response to execute additional API requests, as follows:

###### Table 2: Usage of Fields in API Response

|Field|Data Type|Example|Description|Usage|
|---|---|---|---|---|
|id|string|8f413333-0be7-4f09-a378-f85c8cf7d080|Identifier for a given record||
|marketplace|string|US|A specific marketplace/country.||
|channelType|string|Digital|Nike channel type||
|consumerChannelId|string|89ddb38a-fd6e-4053-a2ba-1ad7ffec802e|Consumer channel experience identifier||
|globalProductId|string|63455a28-7a07-45d6-a430-af56b6132c0f|UUID of Global product||
|productCode|string|654321-001|Nike style-color code||
|styleCode|string|654321|Nike style code||
|colorCode|string|001|Nike color code||
|productType|string|InlineProduct|Nike product type||
|lifecycleManagement.consumerStartDate|string|2019-07-01T08:00:00.000Z|ISO formatted timestamp||
|lifecycleManagement.comingSoonEndDate|string|2019-07-14T08:00:00.000Z|ISO formatted timestamp||
|lifecycleManagement.evergreenStartDate|string|2020-09-01T15:14:00.000Z|ISO formatted timestamp||
|lifecycleManagement.disabledStartDate|string|null|ISO formatted timestamp||
|lifecycleManagement.isPreOrderable|boolean|true|If true, product can be pre-ordered||
|lifecycleManagement.isProductAttributionComplete|boolean|false|If true, product attribution has completed||
|colors.simpleColorId|string||UUID of simple color|Call taxonomy service to get details|
|colors.primaryColorId|string||UUID of primary color|Call taxonomy service to get details|
|colors.secondaryColorId|string||UUID of secondary color|Call taxonomy service to get details|
|colors.tertiaryColorId|string||UUID of tertiary color|Call taxonomy service to get details|
|colors.logoColorId|string||UUID of logo color|Call taxonomy service to get details|
|consumerTaxonomyAttributeIds|string|||Call taxonomy service to get details|
|sizes.id|string|e1045a42-2241-5893-a161-8a2e83983b7b||Call /catalog/sizes/v1?filter=ids(<uuid>,<uuid>) to get details|
|sizes.gtin|string|00867350300861|Global trade item number|Call /catalog/sizes/v1?filter=ids(<uuid>,<uuid>) to get details|
|sizes.sizeConversionId|string|0f4d7354-c33b-4e4d-b436-29ea727c14ce|UUID of size conversion|Call /catalog/sizes/v1?filter=ids(<uuid>,<uuid>) to get details|
|sizeChartId|string||UUID of size chart|Call size service to get details????????|

## API Endpoint Quick Reference

- [Channeled Product](https://developer.niketech.com/docs/projects/Channeled%20Products%20V1?tab=api){:target="new-tab"}
- [Channeled Products](https://developer.niketech.com/docs/projects/Channeled%20Products%20V1?tab=api){:target="new-tab"}

## Best Practices

Listed below are some best practices for working with {}.

### Conditions for Retries

For all Nike Cloud APIs, the general rule is that HTTP 4XX error codes (except for 429) should not be retried but HTTP 5XX errors can be retried. For general information on Nike error retry practices, see [API Error Patterns](https://confluence.nike.com/display/NEA/API+Standards#APIStandards-Errors){:target="new-tab"} on Confluence.

### Test Environment

It is recommended to test all endpoints in the production environment as opposed to the test environment. Using the test environment can have unpredictable results due to the many downstream services which these endpoints are reliant upon in order to provide typical 'production-like' responses.

There are boundaries for testing in production:

- Performance tests at high volumes should never be done in production. All performance tests should be done in test.

### Caching Data

Describe what is cached and for how long, or if caching is not supported.

## Troubleshooting

- Use the general troubleshooting tips in the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) to check for issues with your request.

- Contact the {} team on the [#slack-channel]({url for slack channel}){:target="new-tab"} Slack channel for assistance.

## Terms of Service
<!--
It is recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#registration) guide on how to create and register your caller ID.
-->
### Authorization

#### Access Tokens

Most calls through the Nike API gateway (api.nike.com) require an access token be sent in the request header. This allows Nike to verify that your app is authorized to perform the action on behalf of the user.

Access tokens are obtained by calling Nike Unite services prior to calling the API which you ultimately want to reach.

To find out more on how to call Unite services to obtain access tokens, see the Authorization section of the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#authorization) guide.

#### JSON Web Token

{Does this thing require JWT?}

For more, see the JWT section of [Using Nike APIs](/doc/getting-started/using-nike-apis.html#jwt-json-web-token).

### Sample Requests

Sample requests included throughout this guide contain unique IDs and access tokens that are spent/expired in the Production environment, so you will not be able use them as-is for testing purposes. Reuse what you can and replace with valid IDs/access tokens when necessary.

#### Required Request Headers

Listed below are the required request headers. Since most requests come through the Nike Edge router, these header values will be set automatically, provided your app experience calls the Unite services first to get an access token and passes that token in the request.

|Header Name|Description|
|---|---|
|**Header1**||

>**TIP:** For the Authorization header, use the token for the consumer's login session that you obtained from Nike Unite/Identity, prefixed by **Bearer ** (note the single space after Bearer). This is necessary for Nike to verify that your app is authorized to perform the requested operation on behalf of the consumer.

### Common Questions

**Question 1**

Answer 1

## Contacting the Team

Need to contact the {} team?

|---|---|
|Slack|[](){:target="new-tab"}|
|Confluence Space|[](){:target="new-tab"}|
|Team Contacts|Person1 (Person1 email)|

## Document Change Log

|Summary |Date |
|---|---|---|
|Initial publish|01/22/2020|

## Next Steps

You've learned how to add {} to your experience. Here are some next steps.

[{Doc Title}]({URL})

- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)
