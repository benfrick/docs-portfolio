---
id: use-f-offs
tags: pdf
category: b-use-case
position: 9
title: Fulfillment Offerings
url: /doc/commerce/checkout/use-fulfillment-offerings.html
dev-guide: /doc/commerce/checkout/use-fulfillment-offerings.html
toc:
  - h2: Introduction
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#introduction
  - h2: Which Version Should I Use?
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#which-version-should-i-use
  - h2: Key Concepts and Terms
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#key-concepts-and-terms
  - h2: Quick Start
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#quick-start
  - h2: Fulfillment Offerings GET
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#fulfillment-offerings-get
  - h2: Fulfillment Offerings Jobs PUT
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#fulfillment-offerings-jobs-put
  - h2: Fulfillment Types
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#fulfillment-types
  - h2: API Quick Reference
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#api-quick-reference
  - h2: Troubleshooting
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#troubleshooting
  - h2: Caching
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#caching
  - h2: Contacting the Team
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#contacting-the-team
---
##### Last Updated: 01/04/2023

Use [Fulfillment Offerings](#fulfillment-offerings) in a checkout experience to show consumers the best options for getting their purchases, wherever they are.

>**TIPS:**
>- Before using this guide, read [Using Nike APIs](/doc/getting-started/using-nike-apis.html) and [Cart & Checkout Overview](/doc/commerce/checkout/overview-checkout.html).
>- Use this guide as a supplement to the API Reference for detailed use cases. See [API Quick Reference](#api-quick-reference) for links to all the API Reference docs discussed here.
>- The steps involving **Payment** are covered in [Adding Payment to Your Experience](/doc/commerce/payment/use-payment.html).

## Introduction

In a checkout experience, consumers are accustomed to selecting a shipping speed (for example, "Two Day") based on cost and estimated delivery dates.

But what if you want to show consumers additional options, like a list of nearby stores or other locations where they can pick up their order?

**Fulfillment Offerings** gives you all you need to drive an interactive 'Shipping/Pick Up' selection experience like the one shown here:

![Prototype of a Nike fulfillment offering experience](/images/commerce/buy/fo-pickup-ship.png)

## Which Version Should I Use?

We recommend that new experiences use Fulfillment Offerings V2.

Advantages of V2:
- Response has an improved schema that greatly reduces the length of the response
- Enforces authentication by not offering a separate GET endpoint that returns a cached version of get-by dates, fulfillment costs and offerings
- All V2 endpoints require either the `umpid` header for members or `x-nike-visitorid` and `x-nike-visitid` header for guests

## Key Concepts and Terms

Listed below are some Fulfillment Offerings key terms used in this guide.

###### Table 1.0 Fulfillment Offerings Key Terms

| Term                     | Definition                                                                                                       |
|--------------------------|------------------------------------------------------------------------------------------------------------------|
| **Expiration Date**      | Date/time after which a fulfillment offering expires                                                             |
| **(Fulfillment) Intent** | When a consumer indicates how they want to receive their item, for example, SHIP                                 |
| **Get By**               | Estimated date range (min/max) for an item to be fulfilled. Synonymous with legacy Estimated Delivery Date (EDD) |
| **Locations**            | Location of a fulfillment offering, e.g `address/shipping` and `location/search`                                 |
| **Pickup Location**      | Third-party location at which the consumer can pick up their order                                               |
| **Store**                | Nike store at which the consumer can pick up their order, in the case of BOPIS                                   |


### Fulfillment Offerings

Fulfillment Offerings are a set of price offers that a consumer has for receiving the items in their cart, as determined by the [Fulfillment Offerings API V1](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} and [Fulfillment Offerings API V2](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings%20V2){:target="new-tab"} APIs.

Offerings can vary at any moment in time based on:

- Consumer information
- Delivery destinations (i.e. shipping addresses, store IDs, pickup locations, email addresses, GPS coordinates)
- Items in cart
- Total item prices
- Available discounts/promotions

>**TIP:** You can also [Search for Offerings Using Consumer Location and Intents](#search-for-offerings-using-consumer-location-and-intents).

#### What's In an Offering?

Each offering has these attributes:

###### Table 1.1: Offering Attributes

|Attribute|Description|Example|
|---|---|---|
|`type`|Type of offering, present when the consumer has indicated [intent](#intent) for the offering|`"type": "SHIP"`,`"type": "PICKUP"`|
|`location`|Delivery destination|postal/email addresses, store IDs, pickup locations, GPS coordinates|
|`getBy`|Estimated date (min/max) for the item to be fulfilled|`"dateTime": "2019-02-09T23:59:59.000Z"`|
|`offerExpiration`|Date the offering expires|`"offerExpiration": "2019-02-07T00:00:00.000Z"`|
|`price`|Price of the offering|`"total": 8`|
|`priceOfferId`|ID of the price offer, present when the consumer has indicated [intent](#intent) for the offering|`727a92a6-3cb6-49ce-8d52-2f84728d17d2`|

Each location in an offering is one of these types:

###### Table 1.2 : Location Types

|Location Type|Fulfillment Type|
|---|---|---|
|`store/store_views`|Nike store location|
|`address/shipping`|Shipping address location|
|`location/search`|Search nearby Nike stores and third party pickup locations based on latitude and longitude or postal code|
|`address/digital`|Digital location, for example, an email address|
|`ship/pickup_points`|Third party pick up location|

If the consumer indicated [intent](#intent) for the offering, the offering has a fulfillment type. The valid types are listed below.

###### Table 1.3: Fulfillment Types

|Type|Description|Example Scenario|
|---|---|---|
|`SHIP`|Consumer receives the order at their postal address|Carrier delivers order to a home address|
|`PICKUP`|Consumer picks up the order at a Nike store or third-party pickup location|'Buy Online Pickup In Store' (BOPIS) or ships to a third party location.|
|`INSTORE`|Consumer completes self-checkout via mobile while in a retail store|Consumer uses Nike mobile app for Instant Checkout in store and leaves with their purchase|
|`DIGITAL`|Consumer receives the order at their digital address|Digital gift card is delivered by email|

>**TIP**: Get fulfillment types and their associated location types by country, by calling the [Fulfillment Types API](#fulfillment-types).  

### Fulfillment Groups

The [Fulfillment Offerings Jobs PUT V1](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-endpoint-put){:target="new-tab"} and [Fulfillment Offerings Jobs PUT V2](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings%20V2?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-put-get-put-4){:target="new-tab"} response includes an array of `fulfillmentGroups`. All items in a fulfillment group share the same:
- Fulfillment type, for example, PICKUP
- Location type, for example, store/store_views
- Location, for example, store ID 69b5fec5-e0a6-4dd2-b971-4f9b90d4f85b
- List of price offers

This means that all items in a fulfillment group share the same [intent](#intent).

#### What's In a Fulfillment Group?

Each group has the following attributes:

###### Table 1.4 Fulfillment Group Attributes

|Attribute|Description|Example|
|---|---|---|
|`id`|Unique ID in the format of UUID|845a92a6-3cb6-49ce-8d52-2f84728d17d4|
|`type`|Fulfillment type|`PICKUP`|
|`priceOffers`|Array of price offers for the group|See the next table for `priceOffer` object fields|

###### Table 1.5 Price Offer Attributes

|Attribute|Description|Example|
|---|---|---|
|`id`|Unique ID in the format of UUID|727a92a6-3cb6-49ce-8d52-2f84728d17d2|
|`offerExpiration`|Date price offer expires|2019-02-07T00:00:00.000Z|
|`price`|Object containing the base, discount, and total cost of the price offer|{"base": 0,"discount": 0,"total": 5}|
|`getBy`|Object containing combined min and max estimated delivery dates of all items in the fulfillment group|{minDate {"dateTime": "2019-02-09T23:59:59.000Z"}, maxDate {"dateTime": "2019-03-22T23:59:59.000Z"}}|
|`promotionDiscounts`|Optional, object containing the discount ID, discount code, and total of all discounts applied to this price offer|{"id": "US_CODE_20_OFF_TWO_DAY","code": "SUMMER20","amount": 20}|

What happens when items in the same fulfillment group have different `getBy` dates? For instance, a `SHIP` fulfillment group could contain a custom Nike By You shoe with a `getBy` date a month in the future, and a non-custom shoe with a `getBy` date 3 days in the future. To handle this, the fulfillment group has an aggregated `getBy` delivery range to cover the minimum and maximum individual item get by dates.

Fulfillment groups can be identified by the unique identifiers found in either `items.fulfillmentGroupId` or `fulfillmentGroups.id`.

>**TIP:** Use fulfillment groups as a display tool to show offerings of the same intent together in your experience. Displaying items by fulfillment group makes it easy for the consumer to quickly select how they want to get each item in their cart.

### Intent

Intent for an offering is the combination of location and fulfillment type. When consumers choose how and where they want to receive an item in their cart in your app or experience, they are indicating (fulfillment) intent for that offer. For example, a consumer is providing intent by choosing to pick up ('PICKUP' = fulfillment type) the item at the Santa Monica, CA store (store ID U30121909 = fulfillment location) for free.

### BOPIS

Fulfillment Offerings supports the 'Buy Online, Pickup In Store' (BOPIS) scenario. This is when the consumer completes a checkout in an experience and then travels to a nearby Nike store to pick up their order.

## Quick Start

Let's walk through how to make your first request to the Fulfillment Offerings API, and along the way, define and explain additional concepts.

### Send the Fulfillment Offerings Request

There are two ways to get a list of Fulfillment Offerings:

- [Option 1](#option-1-get-fulfillment-offerings-for-each-size-of-a-style-color): Send a request to the [Fulfillment Offerings GET V1](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-get-get-2){:target="new-tab"} endpoint to list the fulfillment offerings for each size of a style-color.
- [Option 2](#option-2-get-fulfillment-offerings-for-each-item-in-cart): Send a request to the [Fulfillment Offerings Jobs PUT V1](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-put-get-put-5){:target="new-tab"} or [Fulfillment Offerings Jobs PUT V2](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings%20V2?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-put-get-put){:target="new-tab"} endpoint to get the fulfillment offerings for each item in cart.

#### OPTION 1: Get Fulfillment Offerings for Each Size of a Style-Color

Call [Fulfillment Offerings GET (V1)](#fulfillment-offerings-get){:target="new-tab"} when consumer information is not necessary to calculate detailed fulfillment offerings for the sizes of a style-color, such as on a product display page.

This endpoint has a low response rate and may retrieve cached data.

###### Table 2.1 Fulfillment Offerings GET API Request Headers

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|`Accept`|Content type you will accept in response, application/json is only value allowed|X|X|X|
|`Content-Type`|Content type of the request, application/json is only value allowed|X|X|X|

>**TIP:** This endpoint uses an optional `userType` URL filter parameter instead of `upmid` or `x-nike-visitorid` authorization headers.

Send a GET request to `https://api.nike.com/buy/fulfillment_offerings/v1{?filter}`.

The `filter` query parameter must be included. See the [Fulfillment Offerings GET V1](#fulfillment-offerings-get){:target="new-tab"} section for more information on the supported filters.

The GET request below asks for all `SHIP` and `PICKUP` type fulfillment offerings for US zip code 97123 for productId 935f2623-6010-4da9-a218-571c8e33d7aa and currency in US dollars.

**Sample Fulfillment Offerings GET V1 Request URL**

```
https://api.nike.com/buy/fulfillment_offerings/v1/?filter=currency(USD)&filter=productId(935f2623-6010-4da9-a218-571c8e33d7aa)&filter=countryCode(US)&filter=offeringTypes(SHIP,PICKUP)&filter=postalCode(97123)
```

See [Fulfillment Offerings GET V1](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-get-get){:target="new-tab"} endpoint for a sample response body.

A successful Fulfillment Offerings GET response includes these important top-level properties:

###### Table 2.2 Top-level Properties of the Fulfillment Offerings GET API Response

|Property|Data Type|Description|
|---|---|---|
|`summary`|object|Contains a list of offerings by type in the embedded `fulfillmentOfferings` array|
|`items`|array|An array of style-color-sizes, each with an embedded array of `fulfillmentOfferings`|
|`locations`|array|An array of locations, linked by `id` to the `fulfillmentDetails` section of `items`|
 
The offerings for each size are calculated independently. If the service cannot calculate offerings for all sizes, this is a partial success. Sizes for which offerings cannot be calculated are included in a warning list with a code explaining why the offering could not be calculated for that size.

If the service cannot calculate offerings for any size, it returns an error code explaining why the call failed.

#### OPTION 2: Get Fulfillment Offerings for Each Item in Cart

Allow the consumer to indicate their fulfillment intent for each item in cart by displaying a list of fulfillment offerings. Get the available options by calling the **Fulfillment Offerings Jobs PUT** endpoint.

>**NOTE**: This endpoint operates asynchronously. This means that after you execute the initial request, you call another endpoint to get the result. See [Using Nike APIs](/doc/getting-started/using-nike-apis.html#asynchronous-operation) for more details.

##### Step 1: Make a Fulfillment Offerings Jobs PUT request

Send a request to the PUT endpoint with the following headers:

###### Table 2.3 Fulfillment Offerings Jobs API Request Headers

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|`Accept`|Content type you will accept in response, application/json is only value allowed|X|X|X|
|`Content-Type`|Content type of the request, application/json is only value allowed|X|X|X|
|`Authorization`|Your access token in the format of Bearer {token} indicating the consumer is logged in|X||X|
|`x-nike-visitid`|Identifier for the guest (i.e. not logged-in) consumer, validated by the Edge router and passed through to the service||X||
|`x-nike-visitorid`|Integer identifying the guest’s session||X||

>**TIP:** For the Authorization header, use the token for the consumer’s login session that you obtained from [accounts.nike.com](https://miniature-couscous-57c7acad.pages.github.io/){:target="new-tab"} or [Nike Unite/Identity](https://confluence.nike.com/display/USER/Unite+Platform+-+Product+Documentation){:target="new-tab"}, prefixed by **Bearer ** (note the single space after Bearer). This is necessary for Nike to verify that you are authorized to perform the requested operation on behalf of the consumer.

Send a request to one of the **Fulfillment Offerings PUT** URLs below. Note the UUID in the URL path, which you must generate. Make sure to send any consumer information you have such as shipping address, email address, or latitude and longitude of the consumer's physical location to get the most accurate list of offerings for each cart item.

V1:
`https://api.nike.com/buy/fulfillment_offerings_jobs/v1/2c1db6b9-7fd7-401c-acc9-73f926681cb9`

V2:
`https://api.nike.com/buy/fulfillment_offerings_jobs/v2/2c1db6b9-7fd7-401c-acc9-73f926681cb9`

>**TIP**: See the [Address Geocoding API](/doc/commerce/checkout/use-address.html#address-geocoding) section of the Address Tools guide for information on how to get coordinates from an address.

**Sample Fulfillment Offerings Jobs PUT Request Body**

```
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

Let's break down the sample **Fulfillment Offerings Jobs PUT** request body.

`skuId` 935f2623-6010-4da9-a218-571c8e33d7aa is a customizable style-color because the `type` is `customization/nike_id`. The consumer has not indicated an [intended method of fulfillment](#intent) because there is no `fulfillmentType`, but the shipping address in the `locations` object is used to calculate a `SHIP` fulfillment offering for the customizable style-color.

The consumer has indicated intent to ship skuId 15611769-e81b-45dd-b28c-ca0effb272de to the address in the `locations` object due to the SHIP `fulfillmentType`. The shipping address in the `locations` object is used to calculate `SHIP` and `PICKUP` type fulfillment offerings returned in the response.

The consumer has indicated intent to pickup `skuId` f1d26307-c6c6-4c3b-afcf-6fbfd3db00c7 due to the PICKUP `fulfillmentType`. The shipping address and location search data points (postal code and latitude/longitude) in the `locations` object are used to calculate `SHIP` and `PICKUP` type fulfillment offerings returned in the response.

The list of `offeringTypes` restricts the fulfillment offerings returned to the `SHIP` and `PICKUP` fulfillment types.

##### Step 2: Retrieve the Fulfillment Offerings Jobs Result

After calling either **Fulfillment Offerings Jobs PUT** V1 or V2 and receiving an HTTP 202 response, execute a request to [Fulfillment Offerings Jobs GET V1](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-put-get-get-3){:target="new-tab"} or [Fulfillment Offerings Jobs GET V2](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings%20V2?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-put-get-get-2){:target="new-tab"} using the same Fulfillment Offerings ID to check the status of your job.

V1:
```
https://api.nike.com/buy/fulfillment_offerings_jobs/v1/2c1db6b9-7fd7-401c-acc9-73f926681cb9
```

V2:
```
https://api.nike.com/buy/fulfillment_offerings_jobs/v2/2c1db6b9-7fd7-401c-acc9-73f926681cb9
```

To know if the job is done, check the value of the **status** field in the response body as follows:

- `"status": "PENDING"`: job processing has not started

- `"status": "IN_PROGRESS"`: job processing is in progress

- `"status": "COMPLETED"`: job has completed

Once you receive a 200 response with a job status of COMPLETED, get the results of your job by parsing the data in the **response** object.

See the **Fulfillment Offerings GET V1** or **Fulfillment Offerings GET V2** endpoints for a sample Jobs GET response body.

The **Fulfillment Offerings Jobs GET** response includes the following important top-level properties:

###### Table 2.4 Top-level Properties of the Fulfillment Offerings Jobs GET Response Body

|Property|Data Type| Description                                                                                                                                                              |
|---|---|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|`items`|array| Array of style-color-sizes, each with an embedded array of `fulfillmentOfferings`                                                                                        |
|`fulfillmentGroups`|array| Grouping of `priceOffers` by fulfillment type, linked by `id` to `fulfillmentGroupId` in `items`                                                                         |
|`promotionCodes`|array| Summary of the status of any applied promotion codes                                                                                                                     |
|`locations`|array| Array of locations, linked by `id` to the `fulfillmentDetails` section of `items`. Includes `itemAvailability` for each PICKUP location ("FULL", "PARTIAL", or "NONE" |

**Get By Date Ranges**

The response contains a `getBy` object for each item (`items[i].fulfillmentOfferings[i].getBy`) and each fulfillment group (`fulfillmentGroups[i].priceOffers[i].getBy`). The `getBy` values are defined in the table below.

###### Table 2.5 Item and Fulfillment Group getBy Date Ranges

|Field Name|Required|Item|Fulfillment Group|
|---|---|---|
|`getBy.minDate`|Optional|Earliest day/time the item will be fulfilled. If the item does not have a `getBy.minDate`, the item will be fulfilled any day/time between order placement and the item's `getBy.maxDate.`|Earliest *approximate* day/time any item in the fulfillment group will be fulfilled. |
|`getBy.maxDate`|**Required**|Latest day/time the item will be fulfilled.|No item in the fulfillment group will be fulfilled after the `maxDate`.|

For more information on `getBy` dates, see [Semantics of Get-By Data in Nike Experiences](https://confluence.nike.com/pages/viewpage.action?spaceKey=BUY&title=Semantics+of+Get-By+Data+in+Nike+Experiences){:target="new-tab"}.

##### Fulfillment Windows (Japan only)
If all items in the fulfillment group can be delivered on the same day at the same time, the `getBy` object may contain a `fulfillmentWindows` array. Each item in the array represents a window of time in which all items in the fulfillment group can be delivered. The range is defined by a `minDate` and `maxDate` object that contains the date and time of the delivery window, the timezone, and the (delivery) precision, as shown below.

```dtd
...
"getBy": {
  "minDate": {
    "dateTime": "2022-02-07T00:00:00.000Z",
    "timezone": "America/Los_Angeles",
    "precision": "DAY"
  },
  "maxDate": {
    "dateTime": "2022-03-22T23:59:59.000Z",
    "timezone": "America/Los_Angeles",
    "precision": "DAY"
   },
   "fulfillmentWindows": [
     {
       "minDate": {
         "dateTime": "2022-02-07T10:00:00.000Z",
         "timezone": "America/Los_Angeles",
         "precision": "MINUTE"
       },
        "maxDate": {
          "dateTime": "2022-02-07T12:00:00.000Z",
          "timezone": "America/Los_Angeles",
          "precision": "MINUTE"
        }
     },
     {
       "minDate": {
         "dateTime": "2022-02-07T12:00:00.000Z",
         "timezone": "America/Los_Angeles",
         "precision": "MINUTE"
        },
        "maxDate": {
          "dateTime": "2022-02-07T14:00:00.000Z",
          "timezone": "America/Los_Angeles",
          "precision": "MINUTE"
        }
     }
   ]
},
...
```

Japan experiences could use the data above to display available fulfillment windows to the consumer as "Arrives 2/7, 10:00AM - 12:00PM" and "Arrives 2/7, 12:00PM - 2:00PM."

If a price offer has one or more fulfillment windows:
- All fulfillment windows within a price offer have the same price
- Display of the fulfillment window to the consumer in an experience is optional
- Selection of the fulfillment window by the consumer in an experience is optional
- Selection of the fulfillment window by the consumer in an experience applies to all items in the fulfillment group

>**NOTES**: 
>- Mixed carts containing Nike By You customized products, pre-order products, or physical gift cards do not have fulfillment windows
>- Carts with products shipping from different inventory sources may limit the number of fulfillment windows available

## Fulfillment Offerings GET

<i class="g72-check"></i>&nbsp;&nbsp;**List the fulfillment offerings for each size of a product on a PDP**

Show the consumer a summary of fulfillment offerings and available offerings for each size of a style-color by calling the Fulfillment Offerings GET V1 endpoint.

### Step 1: Display a Preview of a Style-Color's Fulfillment Offerings on a PDP

Execute a Fulfillment Offerings GET V1 request to
```
https://api.nike.com/buy/fulfillment_offerings/v1/{filter}
```

The `filter` query parameter must be included. The field/value requirements are listed below.

|Filter|Required|Example|Description|
|---|---|---|
|`countryCode`|**Required**|`filter=countryCode(US)`|Two-letter country identifier|
|`currency`|**Required**|`filter=currency(USD)`|Three-letter currency identifier, ISO 4217 standard|
|`productId`|**Required**|`filter=productId(8e799c64-dd8e-4861-9d38-9592f35e7aa5)`|UUID of style-color|
|`offeringTypes`|**Required**|`filter=offeringTypes(SHIP,PICKUP,INSTORE)`|List of offering types to include in the response, `SHIP`,`PICKUP`,`INSTORE` are supported|
|`postalCode`|Optional|`filter=postalCode(97005)`|5-digit postal code number|
|`userType`|Optional|`filter=userType(nike:swoosh)`|Type of consumer. `nike:guest`, `nike:plus`, `nike:swoosh` are supported. Defaults to `nike:guest`. See [User Types](/doc/getting-started/using-nike-apis.html#data-reference) for more information.|
|`locationId`|Optional|`filter=locationId(339EF669C22F4B2EE05336680C0A6639)`|Location identifier, UUID storeId or locationId|
|`locationType`|Optional|`filter=locationType(ship/pickup_points)`|Type of location. Required if filtering by `locationId`. `store/store_views`, `ship/pickup_points` are supported.|
|`locale`|Optional|`filter=locale(en-US)`|Locale code for localized store views data, BCP 47 or POSIX standard|


Shown below is a sample [Fulfillment Offerings GET V1](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} request URI for a US style-color with productId 8e799c64-dd8e-4861-9d38-9592f35e7aa5, consumer postal code 97005 filtered by offering type `SHIP` and `PICKUP` and userType nike:swoosh (a Nike employee).
```
https://api.nike.com/buy/fulfillment_offerings/v1/?filter=countryCode(US)&filter=currency(US)&filter=productId(8e799c64-dd8e-4861-9d38-9592f35e7aa5)&filter=offeringTypes(SHIP,PICKUP)&filter=postalCode(97005)&filter=userType(nike:swoosh)
```

A successful 200 response includes a summary of available fulfillment offerings. It also includes fulfillment offerings for each size of the style-color including offer price, location, and estimated `getBy` dates.

## Fulfillment Offerings Jobs PUT

<i class="g72-check"></i>&nbsp;&nbsp;**List the fulfillment offerings for each item in a consumer's cart**

When you want to show available fulfillment offerings to the consumer for each item in their cart and capture each fulfillment offering they select, follow the iterative steps below.

### Step 1: Show a UI to Select Fulfillment Intent

In order for the consumer to decide how to receive their items, you need to capture some information about their [intent](#intent).

#### Search for Offerings Using Consumer Location and Intents

What if you want to get additional offerings to show the consumer, for example, based on their GPS coordinates? What if you already know the consumer's intended fulfillment type for some items, but not all items?

> **TIP**: See the [Address Geocoding API](/doc/commerce/checkout/use-address.html#address-geocoding) section of the Address Tools guide for information on how to get coordinates from an address.

In this case, you can *optionally* send any of the following to Fulfillment Offerings endpoint:

- **Location search data** (for example, GPS coordinates)
- **Known Addresses** (shipping, email or other known addresses for that consumer)
- **Promotion discount codes**
- **Allowed fulfillment types** (for example, return only 'SHIP' and 'PICKUP' types)

The Fulfillment Offerings API adjusts the results based on what you send, making for an efficient way to drive the experience. The API groups items of the same intent by fulfillment group. This grouping makes it easy for the app or experience to display items with the same intent.

Listed below are the allowed [location type and fulfillment type](#whats-in-an-offering) combinations you can send in the request. These two values express the consumer's chosen [intent](#intent) to receive that item. Invalid combinations result in an error because inventory cannot be fulfilled.

###### Table 4.1: Valid Location Type/Fulfillment Type Combinations

|Location Type|Fulfillment Type|
|---|---|---|
|`store/store_views`|`PICKUP`, `INSTORE`|
|`address/shipping`|`SHIP`|
|`location/search`|`PICKUP`, `INSTORE`|
|`address/digital`|`DIGITAL`|
|`ship/pickup_points`|`PICKUP`|

Shown below is a sample **Fulfillment Offerings Jobs PUT** request. The client supplies the Job ID, here 5e799c64-dd8e-4861-9d38-9592f35e7aa5. This endpoint is asynchronous, so you will call a different endpoint to check both the status of the job, and the job results when it is complete.

V1:
```
https://api.nike.com/buy/fulfillment_offerings_jobs/v1/5e799c64-dd8e-4861-9d38-9592f35e7aa5
```

V2:
```
https://api.nike.com/buy/fulfillment_offerings_jobs/v2/5e799c64-dd8e-4861-9d38-9592f35e7aa5
```

### Step 2: Check the Status of the Fulfillment Offerings Job

After calling **Fulfillment Offerings Jobs PUT** and receiving an HTTP 202 response, execute a request to **Fulfillment Offerings Jobs GET** using the same fulfillment offerings multi-item ID to check the status of your job.

V1:
```
https://api.nike.com/buy/fulfillment_offerings_jobs/v1/5e799c64-dd8e-4861-9d38-9592f35e7aa5
```

V2:
```
https://api.nike.com/buy/fulfillment_offerings_jobs/v2/5e799c64-dd8e-4861-9d38-9592f35e7aa5
```

Once the job status is `COMPLETED`, get the results of your job by parsing the data in the **response** object. Each cart item in the response is in a fulfillment group. Items with the same [intent](#intent) are in the same fulfillment group.

>**TIP:** Make sure you pass all cart items to **Fulfillment Offerings Jobs PUT** to group items properly and to get the most accurate fulfillment offers for each item.

### Step 3: Repeat **Step 1**

Each time the consumer indicates fulfillment intent for an item in their cart, call the **Fulfillment Offerings Jobs PUT** endpoint as described in **Step 1**, passing the consumer's selection. This will regroup items with the same intent and update the list of fulfillment offerings for each item in cart.

### Step 4: Proceed to Checkout

Once the consumer has chosen how they want all items in their cart fulfilled, and you have called **Fulfillment Offerings Jobs PUT** one last time to get an updated list of fulfillment offerings with price offers, you can proceed with the checkout process. This process includes the optional step of [Checkout Preview](/doc/commerce/checkout/use-checkout.html#checkout-preview), [Payment Preview](/doc/commerce/payment/use-payment.html), and [Submitting a Checkout](/doc/commerce/checkout/use-checkout.html#checkout-submit).

#### Step 4a: Call Checkout Preview (Optional)

If you choose to call **Checkout Preview** to increase the chances of successful checkout, pass the consumer-selected fulfillment information for each cart item in the `fulfillmentDetails` object from **Step 3**. The **Checkout Preview** response body includes a `totals` object that includes the fulfillment offerings totals to use in **Step 4c**.

#### Step 4b: Call Payment Preview

Call **Payment Preview** to gather the consumer's payment information.

####  Step 4c: Call Checkout Submit

Pass the consumer-selected fulfillment information for each cart item in the `fulfillmentDetails` object from **Step 3** to **Checkout Submit**. If you called **Checkout Preview**, pass the `totals` object returned in the response to validate that the prices, including fulfillment offerings prices, have not changed.

## Fulfillment Types

<i class="g72-check"></i>&nbsp;&nbsp;**List the Fulfillment Types and Location Types for a given shopping country**

The Fulfillment Types API tells you which fulfillment types, and associated location types, are supported for a particular shopping country. By optionally calling **Fulfillment Types** prior to calling **Fulfillment Offerings**, you can streamline your checkout UX in the following ways:

- Show or hide the UI for "Pickup" based on whether fulfillment type "PICKUP" is supported or not
- Ask Fulfillment Offerings for "PICKUP" options based on above
- When showing a UI for "Pickup", show or hide sections like "Nike Stores" or "Pickup Points" based on the supported "PICKUP" location types

### Step 1: Retrieve Fulfillment Types for a Shopping Country

Execute a **Fulfillment Types GET** request

```
https://api.nike.com/buy/fulfillment_types/v1?filter=countryCode(US)
```

>**NOTE**: The `filter` query parameter must include a two-letter `countryCode` identifier. In the above example, it is "US".

Sample **Fulfillment Types** response body:

```
{
    "country": "US",
    "fulfillmentTypes": [
        {
            "type": "SHIP",
            "locationTypes": [
                "address/shipping"
            ]
        },
        {
            "type": "PICKUP",
            "locationTypes": [
                "store/store_views"
            ]
        },
        {
            "type": "INSTORE",
            "locationTypes": [
                "store/store_views"
            ]
        },
        {
            "type": "DIGITAL",
            "locationTypes": [
                "address/digital"
            ]
        }
    ],
    "links": {
        "self": {
            "ref": "/buy/fulfillment_types/v1?filter=countryCode(US)"
        }
    },
    "resourceType": "buy/fulfillment_types"
}
```

### Step 2: Call Fulfillment Offerings

Call **Fulfillment Offerings** for the fulfillment types returned in the **Fulfillment Types** response. Use the `offeringTypes` array in the request body to restrict the returned offerings to only the supported types.

```
"offeringTypes": [
"SHIP",
"PICKUP"
]
```

Use the **Fulfillment Offerings** response in the next step.

### Step 3: Adjust Your UI for Selecting Fulfillment Offerings

Now that you have the list of supported fulfillment types, you can adjust your UI accordingly for selecting fulfillment offerings. The typical UI changes can be summarized as follows:

- Show or hide the UI for "Pickup", based on whether fulfillment type "PICKUP" is supported or not
- When showing a UI for "Pickup", show or hide sections like "Nike Stores" or "Pickup Points" based on the supported "PICKUP" location types

Here are two examples for how this might play out:

#### Example 1

UX calls **Fulfillment Types** for country "CZ", which returns the following fulfillment/location type combinations:

"PICKUP"
- "store/store_views" (Nike store locations)

"SHIP"
- "address/shipping" (postal address)

**UX takes the following actions:**
- Shows the UI for "Pickup" in the checkout flow
- Shows the section for "Nike Stores" pickup
- Hides the section for "Pickup Points" pickup
- Asks Fulfillment Offerings for available PICKUP and SHIP options
- Shows available PICKUP and SHIP options

#### Example 2

UX calls Fulfillment Types for country "BE", which returns the following fulfillment/location type combinations:

"PICKUP"
- Not supported

"SHIP"
- "address/shipping" (postal address)

**UX takes the following actions:**
- Hides the UX for "Pickup"
- Calls **Fulfillment Offerings** available for SHIP options only
- Shows available SHIP options

## API Quick Reference

**V1**
**Fulfillment Offerings Multi-Item**
- [Fulfillment Offerings Jobs PUT](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"}
- [Fulfillment Offerings Jobs GET](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"}

**Fulfillment Offerings (Single) Style-Color**
- [Fulfillment Offerings GET](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"}

**V2**
- [Fulfillment Offerings Jobs PUT](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings%20V2?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-put-get-put-4){:target="new-tab"}
- [Fulfillment Offerings Jobs GET](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings%20V2?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-put-get-get-4){:target="new-tab"}

**Fulfillment Types**
- [Fulfillment Types GET](https://developer.niketech.com/docs/projects/Fulfillment%20Types?tab=api){:target="new-tab"}

## Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### Use Troubleshooting Tools

- Use the general troubleshooting tips in the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) to check for issues with your request.

- Contact the Buy team on the [#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV){:target="new-tab"} Slack channel for assistance.

## Caching

Although the **Fulfillment Offerings Style-Color** endpoint may return cached results, the client should not cache results from any **Fulfillment Offerings** call. Several factors affect fulfillment offerings calculations, and they can change throughout the checkout process. It is highly recommended that the client call the **Fulfillment Offerings Jobs PUT** endpoint each time the consumer indicates [intent](#intent) for an item in cart to get the most accurate list of fulfillment offerings.

## Contacting the Team

Need to contact the Buy team?

|Slack|[#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV){:target="new-tab"}|
|Confluence Space|[CiC Order Capture](https://confluence.nike.com/pages/viewpage.action?pageId=163654070){:target="new-tab"}|
|Team Contacts|[Saket Shrivastava](mailto:saket.shrivastava@nike.com)|

## Document Change Log

| Summary                                       | Date       | 
|-----------------------------------------------|------------|
| Initial Publish                               | 03/03/2020 |
| Renamed endpoints, updated Next Steps section | 04/20/2020 |
| Added Fulfillment Types section               | 01/01/2021 |
| Added links to Address Geocoding guide        | 04/19/2021 |
| Added fulfillment windows for Japan           | 11/14/2022 |
| Added accounts.nike.com                       | 01/04/2023 |

## Next Steps

You've learned how to add Fulfillment Offerings to your experience. Here are some related topics.

- [Wishlist](/doc/commerce/checkout/use-wishlists.html)
- [Cart & Cart Review](/doc/commerce/checkout/use-carts.html)
- [Address Tools](/doc/commerce/checkout/use-address.html)
- [Checkout](/doc/commerce/checkout/use-checkout.html)
- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)
- [Supported Countries](/doc/commerce/reference/global.html)