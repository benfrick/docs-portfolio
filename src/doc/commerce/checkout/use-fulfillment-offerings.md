---
id: use-f-offs
tags: pdf
#category: b-use-case
position: 6
title: Fulfillment Offerings
url: /doc/commerce/checkout/use-fulfillment-offerings.html
toc:
  - h2: Introduction
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#introduction
  - h2: Quick Start
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#quick-start
  - h2: Get Fulfillment Offerings
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#get-fulfillment-offerings
  - h2: Get Detailed Fulfillment Offerings
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#get-detailed-fulfillment-offerings
  - h2: Refine Your Fulfillment Offerings
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#refine-your-fulfillment-offerings
  - h2: Get Shipping Options (Legacy)
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#get-shipping-options-legacy
  - h2: API Quick Reference
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#api-quick-reference
  - h2: Troubleshooting
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#troubleshooting
  - h2: Contacting the Team
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#contacting-the-team
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING FULFILLMENT OFFERINGS TO YOUR EXPERIENCE

---

##### Last Updated: 01/06/2020

Use [Fulfillment Offerings](#fulfillment-offerings) in a checkout experience to show consumers the best options for getting their purchases, wherever they are.

>**TIPS**:
>- Before using this guide, read [Using Nike APIs](/doc/getting-started/using-nike-apis.html) and [Cart & Checkout Overview](/doc/commerce/checkout/overview-checkout.html).
>- Use this guide as a supplement to the API Reference for detailed use cases. See [API Quick Reference](#api-quick-reference) for links to all the API Reference docs discussed here.
>- The steps involving **Payment** are covered in [Adding Payment to Your Experience](/doc/commerce/payment/use-payment.html).

## Introduction

In a checkout experience, consumers are accustomed to selecting a shipping method (e.g. "Two-Day") while being shown the associated costs and estimated delivery dates.

But what if you want to show them additional options, like a list of nearby stores or other locations where they can pick up their order?

[Fulfillment Offerings](#fulfillment-offerings) gives you all you need to drive an interactive 'Shipping' selection experience like the one shown here:

![Prototype of a Nike shipping selection experience](/images/commerce/buy/f-offs-select-options.png)

## Key Concepts and Terms

This section discusses topics important to understanding Fulfillment Offerings.

### Fulfillment Offerings

Fulfillment Offerings are a **set of price offers that a consumer has for receiving the items in their cart**, as determined by the [Fulfillment Offerings API](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"}.

Offerings can vary at any moment in time based on:

- Consumer information
- Delivery destinations (i.e. shipping addresses, store IDs, pickup locations, email addresses, GPS coordinates)
- Items in cart
- Total item prices
- Available discounts/promotions

<!--
[Turn this into a diagram (?):
Send an API request to get the available offerings and then show them to the consumer. As the consumer selects an offer for each item, send additional API requests in order to dynamically refresh the offerings shown. That way, the consumer can make up their mind quickly and easily.]todo
-->

>**TIP:** You can also [Search for Offerings Using Consumer Location and Intents](#search-for-offerings-using-consumer-location-and-intents).

#### What's in an Offering?

Each offering has the following attributes:

**Offering Attributes**

|Attribute|Description|Example|
|---|---|---|
|**Fulfillment Type**|The type of offering, if the consumer has indicated [intent](#intent) for the offering.|`"type": "SHIP"`,`"type": "PICKUP"`|
|**Location**|Delivery destinations|postal/email addresses, store IDs, pickup locations, GPS coordinates|
|**'Get By' Date**|The estimated date (min/max) for the item to be fulfilled|`"dateTime": "2019-02-09T23:59:59.000Z"`|
|**Expiration Date**|The date on which the offering expires|`"offerExpiration": "2019-02-07T00:00:00.000Z"`|
|**Price**|The price of the offering|`"total": 8`|
|`priceOfferId`|ID of the price offer. Returned in the response when the customer has indicated their [intent](#intent) for the offering.||

Each location in an offering is one of the types listed below.

**Location Types**

|Location Type|Fulfillment Type|
|---|---|---|
|`store/store_views`|Nike store location|
|`address/shipping`|Shipping address location|
|`location/search`|Search nearby Nike stores and third party pickup locations based on latitude and longitude or postal code|
|`address/digital`|Digital location, an email address|
|`location/pick_up_locations`|Third party pick up location|

If the consumer indicated [intent](#intent) for the offering, the offering has a Fulfillment type. The valid types are listed below.

**Fulfillment Types**

|Type|Description|Example Scenario|
|---|---|---|
|`SHIP`|Consumer receives the order at their postal address.|Carrier delivers order to a home address|
|`PICKUP`|Consumer picks up the order at a Nike store or third-party pickup location|'Buy Online Pickup In Store' (BOPIS) or ships to third party location.|
|`INSTORE`|Consumer completes self-checkout via mobile while in a retail store|Instant Checkout in the Nike app|
|`DIGITAL`|Consumer receives the order at their digital address|Digital gift card is delivered by email.|

### Fulfillment Groups

The [Fulfillment Offering PUT](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-endpoint-put) response includes an array of `fulfillmentGroups`. All items in a Fulfillment Group share the same:
- Fulfillment type e.g. PICKUP
- Location type e.g. store/store_views
- Location e.g. store ID 91
- List of price offers

This means that all items in a Fulfillment Group share the same [intent](#intent).

#### What's in a Fulfillment Group?

Each group has the following attributes:

**Fulfillment Group Attributes**

|Attribute|Description|Example|
|---|---|---|
|`id`|Unique ID in the format of UUID|845a92a6-3cb6-49ce-8d52-2f84728d17d4|
|`type`|Fulfillment Type|`PICKUP`|
|`priceOffers`|Array of price offers for the group.|See the next table for `priceOffer` object fields|

**Price Offer Attributes**

|Attribute|Description|Example|
|---|---|---|
|`id`|Unique ID in the format of UUID|727a92a6-3cb6-49ce-8d52-2f84728d17d2|
|`offerExpiration`|Date price offer expires|2019-02-07T00:00:00.000Z|
|`price`|Object containing the base, discount, and total cost of the price offer|{"base": 0,"discount": 0,"total": 5}|
|`getBy`|Object containing combined min and max estimated delivery dates of all items in the Fulfillment Group|{minDate {"dateTime": "2019-02-09T23:59:59.000Z"}, maxDate {"dateTime": "2019-03-22T23:59:59.000Z"}}|
|`promotionDiscounts`|Optional, object containing the discount ID, discount code, and total of all discounts applied to this price offer|{"id": "US_CODE_20_OFF_TWO_DAY","code": "SUMMER20","amount": 20}|

What happens when items in the same Fulfillment Group have different get by dates? For instance, a `SHIP` Fulfillment Group could contain a custom Nike By You shoe with a get by date a month in the future and a non-custom product with a get by date 3 days in the future. To handle this, the Fulfillment Group has an aggregated get by delivery range to cover the minimum and maximum individual item get by dates.

Fulfillment Groups can be identified by the unique identifiers found in either `items.**fulfillmentGroupId**` or `fulfillmentGroups.**id**`.

>**TIP** Use Fulfillment Groups as a display tool to show offerings of the same [intent](#intent) together in your experience. Displaying items by Fulfillment Group makes it easy for the consumer to make their selections.

### Intent

Intent for a offering is the combination of location and fulfillment type. When consumers choose how and where they want to receive an item in their cart in your app or experience, they are indicating Fulfillment intent for that offer. For example, a consumer is providing intent by choosing to pick up ('PICKUP' = fulfillment type) the item at the Santa Monica, CA store (store ID 90 = fulfillment location).

### BOPIS

Fulfillment Offerings supports the 'Buy Online, Pickup In Store' (BOPIS) scenario. This is when the consumer completes a checkout in the app/web and then travels to a nearby Nike store to pick up their order.

### KEY TERMS

Listed below are some additional Fulfillment Offerings key terms.

|Term|Definition|
|---|---|
|Email|The email address to which the products/services are to be sent, for digital gift cards.|
|Expiration Date|The date/time after which an offering expires.|
|Items|The individual products and services to be fulfilled.|
|Get By|The estimated date (min/max) for the item to be fulfilled. Synonymous with legacy Estimated Delivery Date (EDD)|
|Locations|The location of an offering, e.g `address/shipping` and `location/search`|
|Pickup Location|The third-party location at which the consumer can pick up their order.|
|Store|A Nike store at which the consumer can pick up their order, in the case of BOPIS.|
|Shipping Address|The postal address to which the products are to be shipped.|

## Quick Start

Let's walk through how to make your first request to the Fulfillment Offerings API, and along the way, define and explain some more concepts.

### What Data Do I Need To Provide?

At minimum, the following is required to be sent in the request body of the Fulfillment Offerings PUT endpoint:

- `country` code (e.g. US)
- `currency` code (e.g. USD)
- List of `items`, each having:
    - Unique line item `id` (a UUID that you generate)
    - Item `quantity`
    - `locations` (one or more of `address/shipping`, `address/digital`, `location/search`, `store/store_views`, `location/pick_up_locations`)

Optionally, for each item you can send a `fulfillmentType` which describes the consumer's [intended method of fulfillment](#intent) for that item (if known). The API puts items that have the same intention in a fulfillment group. This makes it easy for the app or experience to display items by fulfillment group.

### Send the Fulfillment Offerings Request

There are two ways to get the list of Fulfillment Offerings for each item in a consumer's Cart. You can make a PUT request to get the most comprehensive list when you have gathered certain consumer information. This is discussed in **Option 1** below. You can also make a GET request to get a cached version of Fulfillment Offerings without consumer information such as on the Product Display Page. This is discussed in **Option 2** below.

#### OPTION 1: Send a PUT request

>**NOTE**: The PUT Fulfillment Offerings endpoint operates asynchronously. This means that after you execute the initial request, you call another endpoint to get the result. See [Using Nike APIs](https://developer.niketech.com/nde-docs/doc/getting-started/using-nike-apis.html#asynchronous-operation) for more details.

##### Step 1: Make a Fulfillment Offerings request

If you have consumer information such as shipping address, email address, or latitude and longitude of the consumer's physical location, send a HTTP PUT request to https://api.nike.com/buy/fulfillment_offerings_jobs/v1/2c1db6b9-7fd7-401c-acc9-73f926681cb9. Note the UUID in the URL path, which you must generate.

The sample request body below contains a SHIP `fulfillmentType` for skuId 15611769-e81b-45dd-b28c-ca0effb272de and PICKUP `fulfillmentType` for skuId 15611769-e81b-45dd-b28c-ca0effb272de. This means that the consumer "intends" (has indicated through the experience) to receive those two items through those fulfillment methods.

The list of `offeringTypes` restricts the Fulfillment Offerings returned to only `SHIP` and `PICKUP` Fulfillment types.

**Sample Request Body**

```javascript
{
    "country": "US",
    "currency": "USD",
    "locale": "en_US",
    "items": [
      {
        "id": "2c1db6b9-7fd7-401c-acc9-73f926681cb9",
        "skuId": "935f2623-6010-4da9-a218-571c8e33d7aa",
        "quantity": 1,
        "valueAddedServices": [
          {
            "id": "88d0475d-30e5-4c2f-9a87-7a31938f8ace",
            "instruction": {
              "id": "2027261230",
              "type": "customization/nike_id"
            }
          }
        ],
        "locations": [
          {
            "type": "address/shipping",
            "postalAddress": {
              "country": "US",
              "address1": "1234 NW Test",
              "city": "Beaverton",
              "state": "OR",
              "postalCode": "97006"
            }
          }
        ]
      },
      {
        "id": "a05dcb8a-79e5-4f69-bc30-213dd93f429c",
        "skuId": "15611769-e81b-45dd-b28c-ca0effb272de",
        "quantity": 1,
        "locations": [
          {
            "type": "address/shipping",
            "postalAddress": {
              "country": "US",
              "address1": "1234 NW Test",
              "city": "Beaverton",
              "state": "OR",
              "postalCode": "97006"
            }
          }
        ],
        "fulfillmentType": "SHIP"
      },
      {
        "id": "64607a11-eaa8-4997-b2ff-b50b6b323b37",
        "skuId": "f1d26307-c6c6-4c3b-afcf-6fbfd3db00c7",
        "quantity": 1,
        "locations": [
          {
            "type": "address/shipping",
            "postalAddress": {
              "country": "US",
              "address1": "1234 NW Test",
              "city": "Beaverton",
              "state": "OR",
              "postalCode": "97006"
            }
          },
          {
            "type": "location/search",
            "coordinates": {
              "latitude": 2847475,
              "longitude": 7799846
            },
            "radius": {
              "distance": 20,
              "unitOfMeasure": "mi"
            }
          },
          {
            "type": "location/search",
            "postalCode": "90401",
            "radius": {
              "distance": 20,
              "unitOfMeasure": "mi"
            }
          }
        ],
        "fulfillmentType": "PICKUP"
      }
    ],
    "promotionCodes": [
      "SUMMER20"
    ],
    "offeringTypes": [
      "SHIP",
      "PICKUP"
    ]
}
```

##### Step 2: Retrieve the Fulfillment Offerings Job

After calling [Fulfillment Offerings](https://bitbucket.nike.com/projects/PHYLORD/repos/v2-order-api/browse/fulfillmentofferings/API.md){:target="new-tab"} and receiving a HTTP 202 response, execute a request to [Fulfillment Offerings Job](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api#checkout-preview-retrieve-checkout-preview-job-get-1){:target="new-tab"} using the same Fulfillment Offerings ID to check the status of your job.

To know if the job is done, check the value of the **status** field in the response body as follows:

- `"status": "PENDING"`: job processing has not started

- `"status": "IN_PROGRESS"`: job processing is in progress

- `"status": "COMPLETED"`: job has completed

Once you receive a job status of COMPLETED, get the results of your job by parsing the data in the **response** object.

Sample [Fulfillment Offerings Job](https://bitbucket.nike.com/projects/PHYLORD/repos/v2-order-api/browse/fulfillmentofferings/API.md){:target="new-tab"} request URI:
```
https://api.nike.com/buy/fulfillment_offerings_jobs/v1/61bc115b-16e5-43b5-bcaf-dd6168c543f8
```

#### OPTION 2: Send a GET request

In addition to the PUT endpoint mentioned in [Option 1](#option-1-send-a-put-request), a GET endpoint is also available that returns cached Fulfillment Offerings for all sizes of a product or a service in Cart. The GET endpoint is intended to be used in scenarios where consumer information isn't necessary to calculate detailed fulfillment offerings, e.g. in a PDP. Because this endpoint retrieves cached data, it has a very low response time.

Send a GET request to https://api.nike.com/buy/fulfillment_offerings/v1{?filter}.

The `filter` query parameter must be included, with the field/value requirements as follows:

|Filter|Required?|Example|Notes|
|---|---|---|
|Product|Required|`filter=skuId(935f2623-6010-4da9-a218-571c8e33d7aa,f1d26307-c6c6-4c3b-afcf-6fbfd3db00c7)`|Separate multiple skuIds with a comma
|Location|Required|`filter=country(US)` or `filter=country(US)&filter=postalCode(97123)`|Only one country and postal code are supported|
|Fulfillment Type|Optional|`filter=fulfillmentTypes(SHIP)`|`SHIP`,`PICKUP`,`INSTORE` are supported. Separate multiple fulfillment types with a comma.|

The GET request below asks for all `SHIP` type Fulfillment Offerings for the US zip code 97123 for skuIds 935f2623-6010-4da9-a218-571c8e33d7aa and f1d26307-c6c6-4c3b-afcf-6fbfd3db00c7.

```
https://api.nike.com//?filter=skuId(935f2623-6010-4da9-a218-571c8e33d7aa,f1d26307-c6c6-4c3b-afcf-6fbfd3db00c7)&filter=country(US)&filter=postalCode(97123)&ilter=fulfillmentTypes(SHIP)

```

### Evaluate the Response

The API response includes a list of items. For each item, one or more offerings are included, along with a [Fulfillment Group](#fulfillment-groups) identifier.

#### What Do I Do in Case of an Error?

In the case of a 404 NOT_FOUND response, you can fall back to calling the Shipping Options API covered in [Get Shipping Options (Legacy)](#get-shipping-options-legacy).

Listed below is a sample Fulfillment Offerings 404 response.

```
{"id":"a49322d6-25cc-4a83-bb9c-a35834572352","status":"COMPLETED","links":{"self":{"ref":"/buy/fulfillment_offerings_jobs/v1/a49322d6-25cc-4a83-bb9c-a35834572352"}},"country":"US","currency":"USD","locale":"en_US","error":{"message":"Not found","httpStatus":404,"code":"NOT_FOUND","errors":[{"field":"/items/0","message":"Fulfillment offerings not found","code":"FULFILLMENT_OFFERINGS_NOT_FOUND"}]},"resourceType":"fulfillmentOfferingsJob"}
```

## Get Cached Fulfillment Offerings

<i class="g72-check"></i>&nbsp;&nbsp;**Get cached fulfillment offerings for a product or service**

Show the consumer a summary of Fulfillment Offerings and available offerings for each size of a product or service before they add it to Cart by calling the Cacheable Fulfillment Offerings GET endpoint.

### Step 1: Display a Preview of a Product's Fulfillment Offerings on a PDP

To get a preview of Fulfillment Offerings for a product or service, execute a request to [Fulfillment Offerings (cacheable)](){:target="new-tab"} endpoint.

At a minimum, you need to pass:

- Consumer's country code
- Types of Fulfillment Offerings to return in the response, `SHIP`, `PICKUP`, or both
- Either product ID (UUID format) or style-color, e.g. 100450-100

You can optionally pass:
- Consumer's 5-digit postal code
- Location ID (unique store ID or pickup location ID) and location type, `store/store_views` or `location/pick_up_locations`.


Shown below is a sample Fulfillment Offerings (cacheable) GET request URI for a US product with style-color 100450-100, consumer postal code 97005 filtered by offering type `SHIP` and `PICKUP`:
```
https://api.nike.com/buy/fulfillment_offerings/v1/?filter=countryCode(US)&filter=styleColor(100450-100)&filter=offeringTypes(SHIP,PICKUP)&filter=postalCode(97005)
```

A successful 200 response includes a summary of available Fulfillment Offerings for the product or service. It also includes Fulfillment Offerings for each size of the product including offer price, location, and estimated `getBy` dates.

## Get Fulfillment Offerings

<i class="g72-check"></i>&nbsp;&nbsp;**Get fulfillment offerings**

When you want to show available Fulfillment Offerings to the consumer for each item in their Cart and then capture their choices, follow the iterative steps below.

### Step 1: Show a UI to Select Fulfillment Intent

In order for the consumer to decide how to receive their items, you need to capture some information about their [intent](#intent).

#### Search for Offerings Using Consumer Location and Intents

What if you want to get additional offerings to show the consumer, for example, based on their GPS coordinates? What if you already know the consumer's intended fulfillment type for some items, but not all items?

In this case, you can *optionally* send any of the following to Fulfillment Offerings:

- **Location search data** (e.g. GPS coordinates, radius)
- **Known Addresses** (shipping, email or other known addresses for that consumer)
- **Promotion discount codes**
- **Allowed fulfillment types** (e.g. return only 'SHIP' and 'PICKUP' types)

Fulfillment Offerings adjusts the results based on what you send, making for an efficient way to drive the experience.

Listed below are the allowed [location type and fulfillment type](#whats-in-an-offering) combinations you can send in the request. These two values express the customer's chosen [intent](#intent) to receive that item. Invalid combinations result in an error because inventory cannot be fulfilled.

**Valid Location Type/Fulfillment Type Combinations**

|Location Type|Fulfillment Type|
|---|---|---|
|`store/store_views`|`PICKUP`, `INSTORE`|
|`address/shipping`|`SHIP`|
|`location/search`|`PICKUP`, `INSTORE`|
|`address/digital`|`DIGITAL`|
|`location/pick_up_locations`|`PICKUP`|

Shown below is a sample [Request Fulfillment Offerings](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} PUT request. The client supplies the Job ID, here 5e799c64-dd8e-4861-9d38-9592f35e7aa5. This endpoint is asynchronous, so you will call a different endpoint to check both the status of the job and when the job is complete, the job results:
```
https://api.nike.com/buy/fulfillment_offerings_jobs/v1/5e799c64-dd8e-4861-9d38-9592f35e7aa5
```

### Step 2: Check the status of the Fulfillment Offerings job

After calling [Request Fulfillment Offerings](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} and receiving a HTTP 202 response, execute a request to [Retrieve Job Result](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-endpoint-get-1){:target="new-tab"} using the same Fulfillment Offerings Job ID to check the status of your job.

To know if the job is done, check the value of the **status** field in the response body as follows:

- `"status": "PENDING"`: job processing has not started

- `"status": "IN_PROGRESS"`: job processing is in progress

- `"status": "COMPLETED"`: job has completed

Once you receive a job status of `COMPLETED`, get the results of your job by parsing the data in the **response** object.

Sample [Retrieve Job Result](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-endpoint-get-1){:target="new-tab"} request URI:
```
https://api.nike.com/GET/buy/fulfillment_offerings_jobs/v1/5e799c64-dd8e-4861-9d38-9592f35e7aa5
```

A `"COMPLETED"` job response will put each item in a Fulfillment Group. Items with the same [intent](#intent) will be in the same Fulfillment group. This grouping allows you to easily display items in your experience by Fulfillment Group.

>TIP: Make sure you pass all Cart items to [Request Fulfillment Offerings](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} to group items properly and to get the most accurate Fulfillment Offers for each item.

### Step 3: Repeat **Step 1**

Each time the consumer indicates Fulfillment intent for an item in your experience, call the [Request Fulfillment Offerings](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} endpoint as described in **Step 1** to regroup items with the same intent and to get an updated list of Fulfillment Offerings for each item in Cart.

### Step 4: Proceed to Checkout

Once the consumer has chosen how they want all items in their Cart fulfilled and you have called Fulfillment Options one last time to get an updated list of Fulfillment Options with price offers, you can proceed with the Checkout process, which includes the optional step of [Previewing a Checkout](https://developer.niketech.com/commerce-docs/doc/commerce/checkout/use-checkout.html#previewing-a-checkout), gathering [Payment](https://developer.niketech.com/commerce-docs/doc/commerce/payment/use-payment.html) information and [Submitting a Checkout](https://developer.niketech.com/commerce-docs/doc/commerce/checkout/use-checkout.html#submitting-a-checkout).

You will pass the consumer-selected Fulfillment information in `fulfillmentDetails` to the optional step of [Checkout Preview](https://developer.niketech.com/docs/projects/Checkout%20Previews%20V3?tab=api-) and [Checkout Submit](https://developer.niketech.com/docs/projects/Checkouts%20V3?tab=api). Those APIs call Fulfillment Options for you to make sure the consumer's selections are still valid.



## Get Shipping Options (Legacy)

<i class="g72-check"></i>&nbsp;&nbsp;**Get shipping options (legacy)**

>**IMPORTANT**: The Shipping Options API will be deprecated. New integrators should use Fulfillment Offerings.

Use the [Shipping Options API](https://developer.niketech.com/docs/projects/Shipping%20Options?tab=api#shipping-options-post){:target="new-tab"} to retrieve the available shipping methods for a consumer's checkout, including any associated costs, estimated delivery dates, or discounts (such as free shipping for members).

To get the shipping options, execute a request to the *Shipping Options* endpoint.

Sample [Shipping Options API](https://developer.niketech.com/docs/projects/Shipping%20Options?tab=api#shipping-options-post){:target="new-tab"} request URI:

```
https://api.nike.com/buy/shipping_options/v2
```

>**TIPS:**
>- Although optional, including a `shippingAddress` is recommended whenever possible.
>- In China, shipping methods can vary based on the province, city, and district combination.
>- For certain countries (e.g. US), including the shipping address can get you an estimated delivery date versus an estimated delivery range.

## API Quick Reference

**Fulfillment Offerings**
- [Request Fulfillment Offerings](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"}
- [Retrieve Fulfillment Offerings Job](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"}
- [Get Fulfillment Offerings (Cacheable)](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"}

**Shipping Options**
- [Shipping Options](https://developer.niketech.com/docs/projects/Shipping%20Options?tab=api){:target="new-tab"}

## Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### Use Troubleshooting Tools

- Use the general troubleshooting tips in the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) to check for issues with your request.

- Contact the Buy team on the [#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV){:target="new-tab"} Slack channel for assistance.

## Contacting the Team

Need to contact the Cart & Checkout team?

|Slack|[#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV){:target="new-tab"}|
|Confluence Space|[CiC Order Capture](https://confluence.nike.com/pages/viewpage.action?pageId=163654070){:target="new-tab"}|
|Team Contacts|[Dan Robertson](mailto:dan.robertson@nike.com), [Saket Shrivastava](mailto:saket.shrivastava@nike.com)|

## Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|01/06/2020|Initial Draft|

## Next Steps

You've learned how to add Fulfillment Offerings to your experience. Here are some next steps.

- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)
- [Supported Countries & Currencies](/doc/commerce/checkout/checkout-country-currency.html)