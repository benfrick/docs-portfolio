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
  - h2: Key Concepts and Terms
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#key-concepts-and-terms
  - h2: Quick Start
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#quick-start
  - h2: Fulfillment Offerings GET
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#fulfillment-offerings-get
  - h2: Fulfillment Offerings Jobs PUT
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#fulfillment-offerings-put
  - h2: API Quick Reference
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#api-quick-reference
  - h2: Troubleshooting
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#troubleshooting
  - h2: Caching
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#caching
  - h2: Contacting the Team
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#contacting-the-team
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING FULFILLMENT OFFERINGS TO YOUR EXPERIENCE

---

##### Last Updated: 04/20/2020

Use [Fulfillment Offerings](#fulfillment-offerings) in a checkout experience to show consumers the best options for getting their purchases, wherever they are.

>**TIPS:**
>- Before using this guide, read [Using Nike APIs](/doc/getting-started/using-nike-apis.html) and [Cart & Checkout Overview](/doc/commerce/checkout/overview-checkout.html).
>- Use this guide as a supplement to the API Reference for detailed use cases. See [API Quick Reference](#api-quick-reference) for links to all the API Reference docs discussed here.
>- The steps involving **Payment** are covered in [Adding Payment to Your Experience](/doc/commerce/payment/use-payment.html).

## Introduction

In a checkout experience, consumers are accustomed to selecting a shipping speed (e.g. "Two Day") based on cost and estimated delivery dates.

But what if you want to show consumers additional options, like a list of nearby stores or other locations where they can pick up their order?

[Fulfillment Offerings](#fulfillment-offerings) gives you all you need to drive an interactive 'Shipping/Pick Up' selection experience like the one shown here:

![Prototype of a Nike fulfillment offering experience](/images/commerce/buy/fo-pickup-ship.png)

## Key Concepts and Terms

This section discusses topics important to understanding fulfillment offerings.

### Fulfillment Offerings

Fulfillment Offerings are a **set of price offers that a consumer has for receiving the items in their Cart**, as determined by the [Fulfillment Offerings API](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"}.

Offerings can vary at any moment in time based on:

- Consumer information
- Delivery destinations (i.e. shipping addresses, store IDs, pickup locations, email addresses, GPS coordinates)
- Items in Cart
- Total item prices
- Available discounts/promotions

>**TIP:** You can also [Search for Offerings Using Consumer Location and Intents](#search-for-offerings-using-consumer-location-and-intents).

#### What's in an Offering?

Each offering has these attributes.

###### Table 1.1: Offering Attributes

|Attribute|Description|Example|
|---|---|---|
|`type`|Type of offering, present when the consumer has indicated [intent](#intent) for the offering|`"type": "SHIP"`,`"type": "PICKUP"`|
|`location`|Delivery destination|postal/email addresses, store IDs, pickup locations, GPS coordinates|
|`getBy`|Estimated date (min/max) for the item to be fulfilled|`"dateTime": "2019-02-09T23:59:59.000Z"`|
|`offerExpiration`|Date the offering expires|`"offerExpiration": "2019-02-07T00:00:00.000Z"`|
|`price`|Price of the offering|`"total": 8`|
|`priceOfferId`|ID of the price offer, present when the consumer has indicated [intent](#intent) for the offering|`727a92a6-3cb6-49ce-8d52-2f84728d17d2`|

Each location in an offering is one of these types.

###### Table 1.2 : Location Types

|Location Type|Fulfillment Type|
|---|---|---|
|`store/store_views`|Nike store location|
|`address/shipping`|Shipping address location|
|`location/search`|Search nearby Nike stores and third party pickup locations based on latitude and longitude or postal code|
|`address/digital`|Digital location e.g. an email address|
|`ship/pickup_points`|Third party pick up location|

If the consumer indicated [intent](#intent) for the offering, the offering has a fulfillment type. The valid types are listed below.

###### Table 1.3: Fulfillment Types

|Type|Description|Example Scenario|
|---|---|---|
|`SHIP`|Consumer receives the order at their postal address|Carrier delivers order to a home address|
|`PICKUP`|Consumer picks up the order at a Nike store or third-party pickup location|'Buy Online Pickup In Store' (BOPIS) or ships to a third party location.|
|`INSTORE`|Consumer completes self-checkout via mobile while in a retail store|Consumer uses Nike mobile app for Instant Checkout in store and leaves with their purchase|
|`DIGITAL`|Consumer receives the order at their digital address|Digital gift card is delivered by email|

### Fulfillment Groups

The [Fulfillment Offerings Jobs PUT](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-endpoint-put){:target="new-tab"} response includes an array of `fulfillmentGroups`. All items in a Fulfillment Group share the same:
- Fulfillment type e.g. PICKUP
- Location type e.g. store/store_views
- Location e.g. store ID 69b5fec5-e0a6-4dd2-b971-4f9b90d4f85b
- List of price offers

This means that all items in a Fulfillment Group share the same [intent](#intent).

#### What's in a Fulfillment Group?

Each group has the following attributes.

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
|`getBy`|Object containing combined min and max estimated delivery dates of all items in the Fulfillment Group|{minDate {"dateTime": "2019-02-09T23:59:59.000Z"}, maxDate {"dateTime": "2019-03-22T23:59:59.000Z"}}|
|`promotionDiscounts`|Optional, object containing the discount ID, discount code, and total of all discounts applied to this price offer|{"id": "US_CODE_20_OFF_TWO_DAY","code": "SUMMER20","amount": 20}|

What happens when items in the same Fulfillment Group have different `getBy` dates? For instance, a `SHIP` Fulfillment Group could contain a custom Nike By You shoe with a `getBy` date a month in the future and a non-custom shoe with a `getBy` date 3 days in the future. To handle this, the Fulfillment Group has an aggregated get by delivery range to cover the minimum and maximum individual item get by dates.

Fulfillment Groups can be identified by the unique identifiers found in either `items.**fulfillmentGroupId**` or `fulfillmentGroups.**id**`.

>**TIP:** Use Fulfillment Groups as a display tool to show offerings of the same [intent](#intent) together in your experience. Displaying items by Fulfillment Group makes it easy for the consumer to quickly select how they want to get each item in their Cart.

### Intent

Intent for an offering is the combination of location and fulfillment type. When consumers choose how and where they want to receive an item in their Cart in your app or experience, they are indicating fulfillment intent for that offer. For example, a consumer is providing fulfillment intent by choosing to pick up ('PICKUP' = fulfillment type) the item at the Santa Monica, CA store (store ID U30121909 = fulfillment location) for free.

### BOPIS

Fulfillment Offerings supports the 'Buy Online, Pickup In Store' (BOPIS) scenario. This is when the consumer completes a checkout in the app/web and then travels to a nearby Nike store to pick up their order.

### Key Terms

Listed below are some additional Fulfillment Offerings key terms.

###### Table 1.6 Fulfillment Offerings Key Terms

|Term|Definition|
|---|---|
|**Email**|Email address to which the items are to be sent, for digital gift cards|
|**Expiration Date**|Date/time after which a fulfillment offering expires|
|**Item**|Style-color-size in Cart to be fulfilled|
|**Get By**|Estimated date range (min/max) for an item to be fulfilled. Synonymous with legacy Estimated Delivery Date (EDD)|
|**Locations**|Location of a fulfillment offering, e.g `address/shipping` and `location/search`|
|**Pickup Location**|Third-party location at which the consumer can pick up their order|
|**Store**|Nike store at which the consumer can pick up their order, in the case of BOPIS|
|**Shipping Address**|Postal address to which the items are to be shipped|
|**Style-Color**|Product that has one or more sizes|

## Quick Start

Let's walk through how to make your first request to the Fulfillment Offerings API, and along the way, define and explain some more concepts.

### Send the Fulfillment Offerings Request

There are two ways to get a list of Fulfillment Offerings. You can send a request to the [Fulfillment Offerings GET](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} endpoint to list the fulfillment offerings for each size of a style-color. This is discussed in [Option 1](#option-1-send-a-get-request) below. You can also send a request to the [Fulfillment Offerings Jobs PUT](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} endpoint to get the fulfillment offerings for each item in Cart. This is discussed in [Option 2](#option-2-send-a-put-request) below.

#### OPTION 1: Get fulfillment offerings for each size of a style-color

Call [Fulfillment Offerings GET](#fulfillment-offerings-get) when consumer information is not necessary to calculate detailed fulfillment offerings for the sizes of a style-color, such as on a product display page.

This endpoint has a low response rate and  may retrieve cached data.

Table 2.1 Fulfillment Offerings GET API Request Headers

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|`Accept`|Content type you will accept in response, application/json is only value allowed|X|X|X|
|`Content-Type`|Content type of the request, application/json is only value allowed|X|X|X|

>**TIP:** This endpoint uses an optional `userType` URL filter parameter instead of `upmid` or `x-nike-visitorid` authorization headers.

Send a GET request to `https://api.nike.com/buy/fulfillment_offerings/v1{?filter}`.

The `filter` query parameter must be included. See the [Fulfillment Offerings GET](#fulfillment-offerings-get) section for more information on the supported filters.

The GET request below asks for all `SHIP` and `PICKUP` type fulfillment offerings for US zip code 97123 for productId 935f2623-6010-4da9-a218-571c8e33d7aa and currency in US dollars.

**Sample Fulfillment Offerings GET Request Body**

```
https://api.nike.com/buy/fulfillment_offerings/v1/?filter=currency(USD)&filter=productId(935f2623-6010-4da9-a218-571c8e33d7aa)&filter=countryCode(US)&filter=offeringTypes(SHIP,PICKUP)&filter=postalCode(97123)
```

**Sample Fulfillment Offerings GET Response Body**

```
{
  "country": "US",
  "currency": "USD",
  "locale": "en_US",
  "summary": {
    "fulfillmentOfferings": [
      {
        "type": "SHIP",
        "location": {
          "type": "address/shipping",
          "postalAddress": {
            "postalCode": "97006",
            "country": "US"
          }
        },
        "offerExpiration": "2019-02-07T23:59:59.000Z",
        "fulfillmentAttributes": ["FASTEST"],
        "getBy": {
          "minDate": {
            "dateTime": "2019-02-07T00:00:00.000Z",
            "timezone": "America/Los_Angeles",
            "precision": "DAY"
          },
          "maxDate": {
            "dateTime": "2019-02-07T23:59:59.000Z",
            "timezone": "America/Los_Angeles",
            "precision": "DAY"
          }
        },
        "price": {
          "base": 25,
          "discount": 0,
          "total": 8
        }
      },
      {
        "type": "PICKUP",
        "location": {
          "type": "store/store_views",
          "id": "339EF669C22F4B2EE05336680C0A6639",
          "postalAddress": {
            "address1": "3485 SW Knowlton Rd",
            "city": "Beaverton",
            "state": "OR",
            "postalCode": "972005",
            "country": "US"
          },
          "name": "Nike Company Store",
          "timezone": "America/Los_Angeles",
          "distance": "0.1037204811454481",
          "operationalDetails": {
            "hoursOfOperation": {
              "regularHours": {
                "monday": [
                  {
                    "startTime": "10:00",
                    "duration": "PT11H"
                  }
                ],
                "tuesday": [
                  {
                    "startTime": "10:00",
                    "duration": "PT11H"
                  }
                ],
                "wednesday": [
                  {
                    "startTime": "10:00",
                    "duration": "PT11H"
                  }
                ],
                "thursday": [
                  {
                    "startTime": "10:00",
                    "duration": "PT11H"
                  }
                ],
                "friday": [
                  {
                    "startTime": "10:00",
                    "duration": "PT11H"
                  }
                ],
                "saturday": [
                  {
                    "startTime": "10:00",
                    "duration": "PT11H"
                  }
                ],
                "sunday": [
                  {
                    "startTime": "10:00",
                    "duration": "PT10H"
                  }
                ]
              },
              "specialHours": []
            }
          }
        },
        "offerExpiration": "2019-02-07T23:59:59.000Z",
        "fulfillmentAttributes": ["CHEAPEST"],
        "getBy": {
          "minDate": {
            "dateTime": "2019-02-07T00:00:00.000Z",
            "timezone": "America/Los_Angeles",
            "precision": "DAY"
          },
          "maxDate": {
            "dateTime": "2019-02-07T23:59:59.000Z",
            "timezone": "America/Los_Angeles",
            "precision": "DAY"
          }
        },
        "price": {
          "base": 0,
          "discount": 0,
          "total": 0
        }
      }
    ]
  },
  "items": [
    {
      "id": "2c1db6b9-7fd7-401c-acc9-73f926681cb9",
      "skuId": "935f2623-6010-4da9-a218-571c8e33d7aa",
      "fulfillmentOfferings": [
        {
          "type": "SHIP",
          "location": {
            "type": "address/shipping",
            "postalAddress": {
              "postalCode": "97006",
              "country": "US"
            }
          },
          "offerExpiration": "2019-02-07T23:59:59.000Z",
          "fulfillmentAttributes": ["FASTEST"],
          "getBy": {
            "minDate": {
              "dateTime": "2019-02-07T00:00:00.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            },
            "maxDate": {
              "dateTime": "2019-02-07T23:59:59.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            }
          },
          "price": {
            "base": 8,
            "discount": 0,
            "total": 8
          }
        }
      ]
    },
    {
      "id": "a05dcb8a-79e5-4f69-bc30-213dd93f429c",
      "skuId": "15611769-e81b-45dd-b28c-ca0effb272de",
      "fulfillmentOfferings": [
        {
          "type": "SHIP",
          "location": {
            "type": "address/shipping",
            "postalAddress": {
              "postalCode": "97006",
              "country": "US"
            }
          },
          "offerExpiration": "2019-02-07T23:59:59.000Z",
          "getBy": {
            "minDate": {
              "dateTime": "2019-02-07T00:00:00.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            },
            "maxDate": {
              "dateTime": "2019-02-08T23:59:59.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            }
          },
          "price": {
            "base": 8,
            "discount": 0,
            "total": 8
          }
        }
      ]
    },
    {
      "id": "64607a11-eaa8-4997-b2ff-b50b6b323b37",
      "skuId": "f1d26307-c6c6-4c3b-afcf-6fbfd3db00c7",
      "fulfillmentOfferings": [
        {
          "type": "SHIP",
          "location": {
            "type": "address/shipping",
            "postalAddress": {
              "postalCode": "97006",
              "country": "US"
            }
          },
          "offerExpiration": "2016-02-07T23:59:59.000Z",
          "getBy": {
            "minDate": {
              "dateTime": "2019-02-07T00:00:00.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            },
            "maxDate": {
              "dateTime": "2019-02-07T23:59:59.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            }
          },
          "price": {
            "base": 8,
            "discount": 0,
            "total": 8
          }
        },
        {
          "type": "PICKUP",
          "location": {
            "type": "store/store_views",
            "id": "339EF669C22F4B2EE05336680C0A6639",
            "postalAddress": {
              "address1": "3485 SW Knowlton Rd",
              "city": "Beaverton",
              "state": "OR",
              "postalCode": "972005",
              "country": "US"
            },
            "name": "Nike Company Store",
            "timezone": "America/Los_Angeles",
            "distance": "0.1037204811454481",
            "operationalDetails": {
              "hoursOfOperation": {
                "regularHours": {
                  "monday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT11H"
                    }
                  ],
                  "tuesday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT11H"
                    }
                  ],
                  "wednesday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT11H"
                    }
                  ],
                  "thursday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT11H"
                    }
                  ],
                  "friday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT11H"
                    }
                  ],
                  "saturday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT11H"
                    }
                  ],
                  "sunday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT10H"
                    }
                  ]
                },
                "specialHours": []
              }
            }
          },
          "offerExpiration": "2019-02-07T23:59:59.000Z",
          "fulfillmentAttributes": ["CHEAPEST"],
          "getBy": {
            "minDate": {
              "dateTime": "2019-02-07T00:00:00.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            },
            "maxDate": {
              "dateTime": "2019-02-07T23:59:59.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            }
          },
          "price": {
            "base": 0,
            "discount": 0,
            "total": 0
          }
        }
      ]
    }
  ],
  "warnings": [
    {
      "skuId": "c9176a0b-0664-4c92-8530-a46fe22f8a33",
      "code": "NOT_FOUND"
    },
    {
      "skuId": "60238fb7-fdfc-4015-a2af-feb9aed51fcd",
      "code": "VALIDATION_ERROR"
    }
  ]
}

```

A successful Fulfillment Offerings GET response includes a summary of offerings and offering details for each size of a style-color.

The offerings for each size are calculated independently. If the service cannot calculate offerings for all sizes, this is a partial success. Sizes for which offerings cannot be calculated are included in a warning list with a code explaining why the offering could not be calculated for that size.

If the service cannot calculate offerings for any size, it returns an error code explaining why the call failed.

#### OPTION 2: Get fulfillment offerings for each item in Cart

Allow the consumer to indicate their fulfillment intent for each item in Cart by displaying a list of fulfillment offerings. Get the available options by calling the **Fulfillment Offerings Jobs PUT** endpoint.

>**NOTE**: This endpoint operates asynchronously. This means that after you execute the initial request, you call another endpoint to get the result. See [Using Nike APIs](/doc/getting-started/using-nike-apis.html#asynchronous-operation) for more details.

##### Step 1: Make a Fulfillment Offerings Jobs PUT request

###### Table 2.2 Fulfillment Offerings Jobs API Request Headers

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|`Accept`|Content type you will accept in response, application/json is only value allowed|X|X|X|
|`Content-Type`|Content type of the request, application/json is only value allowed|X|X|X|
|`Authorization`|Your access token in the format of Bearer {token} indicating the consumer is logged in|X||X|
|`x-nike-visitid`|Identifier for the guest (i.e. not logged-in) consumer, validated by the Edge router and passed through to the service||X||
|`x-nike-visitorid`|Integer identifying the guest’s session||X||

>**TIP:** For the Authorization header, use the token for the consumer’s login session that you obtained from Nike Unite/Identity, prefixed by **Bearer ** (note the single space after Bearer). This is necessary for Nike to verify that you are authorized to perform the requested operation on behalf of the consumer.

Send a HTTP PUT request to `https://api.nike.com/buy/fulfillment_offerings_jobs/v1/2c1db6b9-7fd7-401c-acc9-73f926681cb9`. Note the UUID in the URL path, which you must generate. Make sure to send any consumer information you have such as shipping address, email address, or latitude and longitude of the consumer's physical location to get the most accurate list of offerings for each Cart item.

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

Let's break down the sample Fulfillment Offerings Jobs PUT request body.

skuId 935f2623-6010-4da9-a218-571c8e33d7aa is a customizable style-color because the `type` is `customization/nike_id`. The consumer has not indicated an [intended method of fulfillment](#intent) because there is no `fulfillmentType`, but the shipping address in the `locations` object is used to calculate a `SHIP` fulfillment offering for the customizable style-color.

The consumer has indicated intent to ship skuId 15611769-e81b-45dd-b28c-ca0effb272de to the address in the `locations` object due to the SHIP `fulfillmentType`. The shipping address in the `locations` object is used to calculate `SHIP` and `PICKUP` type fulfillment offerings returned in the response.

The consumer has indicated intent to pickup skuId f1d26307-c6c6-4c3b-afcf-6fbfd3db00c7 due to the PICKUP `fulfillmentType`. The shipping address and location search data points (postal code and latitude/longitude) in the `locations` object are used to calculate `SHIP` and `PICKUP` type fulfillment offerings returned in the response.

The list of `offeringTypes` restricts the fulfillment offerings returned to the `SHIP` and `PICKUP` fulfillment types.

##### Step 2: Retrieve the Fulfillment Offerings Jobs result

After calling [Fulfillment Offerings Jobs PUT](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} and receiving a HTTP 202 response, execute a request to [Fulfillment Offerings Jobs GET](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} using the same Fulfillment Offerings ID to check the status of your job.

To know if the job is done, check the value of the **status** field in the response body as follows:

- `"status": "PENDING"`: job processing has not started

- `"status": "IN_PROGRESS"`: job processing is in progress

- `"status": "COMPLETED"`: job has completed

Sample [Fulfillment Offerings Jobs GET](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} GET request URI:
```
https://api.nike.com/buy/fulfillment_offerings_jobs/v1/2c1db6b9-7fd7-401c-acc9-73f926681cb9
```

Once you receive a 200 response with a job status of COMPLETED, get the results of your job by parsing the data in the **response** object.

**Sample Fulfillment Offerings Jobs GET Response Body**

```
{
  "resourceType": "fulfillmentOfferingsJob",
  "id": "5e799c64-dd8e-4861-9d38-9592f35e7aa5",
  "status": "COMPLETED",
  "links": {
    "self": {
      "ref": "/buy/fulfillment_offerings_jobs/v1/5e799c64-dd8e-4861-9d38-9592f35e7aa5"
    }
  },
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
      "fulfillmentGroupId": "68993f5c-0d03-4046-a531-c4489f88c145",
      "fulfillmentOfferings": [
        {
          "type": "SHIP",
          "location": {
            "type": "address/shipping",
            "postalAddress": {
              "address1": "1234 NW Test",
              "city": "Beaverton",
              "state": "OR",
              "postalCode": "97006",
              "country": "US"
            }
          },
          "offerExpiration": "2016-02-07T23:59:59.000Z",
          "getBy": {
            "minDate": {
              "dateTime": "2019-02-07T00:00:00.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            },
            "maxDate": {
              "dateTime": "2019-03-22T23:59:59.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            }
          },
          "priceOfferId": "727a92a6-3cb6-49ce-8d52-2f84728d17d2",
          "price": {
            "base": 8,
            "discount": 0,
            "total": 8
          }
        }
      ]
    },
    {
      "id": "a05dcb8a-79e5-4f69-bc30-213dd93f429c",
      "skuId": "15611769-e81b-45dd-b28c-ca0effb272de",
      "quantity": 1,
      "fulfillmentGroupId": "68993f5c-0d03-4046-a531-c4489f88c145",
      "fulfillmentOfferings": [
        {
          "type": "SHIP",
          "location": {
            "type": "address/shipping",
            "postalAddress": {
              "address1": "1234 NW Test",
              "city": "Beaverton",
              "state": "OR",
              "postalCode": "97006",
              "country": "US"
            }
          },
          "offerExpiration": "2016-02-07T23:59:59.000Z",
          "getBy": {
            "minDate": {
              "dateTime": "2019-02-07T00:00:00.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            },
            "maxDate": {
              "dateTime": "2019-02-09T23:59:59.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            }
          },
          "priceOfferId": "6113bd90-406d-4d6a-b58e-70ae725efc60",
          "price": {
            "base": 25,
            "discount": 20,
            "total": 5
          },
          "promotionDiscounts": [
            {
              "id": "US_CODE_20_OFF_TWO_DAY",
              "code": "SUMMER20",
              "amount": 20
            }
          ]
        },
        {
          "type": "PICKUP",
          "location": {
            "type": "location/pick_up_locations",
            "postalAddress": {
              "address1": "123 Main St",
              "city": "Portland",
              "state": "OR",
              "postalCode": "97035",
              "country": "US"
            },
            "consumerPickupPoint": {
              "storeId": "U30121909",
              "storeType": "DEMO",
              "companyName": "SHOES R US"
            }
          },
          "offerExpiration": "2019-02-07T00:00:00.000Z",
          "getBy": {
            "minDate": {
              "dateTime": "2019-02-07T00:00:00.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            },
            "maxDate": {
              "dateTime": "2019-02-09T23:59:59.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            }
          },
          "price": {
            "base": 8,
            "discount": 0,
            "total": 8
          }
        }
      ]
    },
    {
      "id": "64607a11-eaa8-4997-b2ff-b50b6b323b37",
      "skuId": "f1d26307-c6c6-4c3b-afcf-6fbfd3db00c7",
      "quantity": 1,
      "fulfillmentGroupId": "1f5f6ff8-4469-4a42-9942-612a864705c5",
      "fulfillmentOfferings": [
        {
          "type": "SHIP",
          "location": {
            "type": "address/shipping",
            "postalAddress": {
              "address1": "1234 NW Test",
              "city": "Beaverton",
              "state": "OR",
              "postalCode": "97006",
              "country": "US"
            }
          },
          "offerExpiration": "2016-02-07T23:59:59.000Z",
          "getBy": {
            "minDate": {
              "dateTime": "2019-02-07T00:00:00.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            },
            "maxDate": {
              "dateTime": "2019-02-15T23:59:59.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            }
          },
          "price": {
            "base": 8,
            "discount": 0,
            "total": 8
          }
        },
        {
          "type": "PICKUP",
          "location": {
            "type": "store/store_views",
            "id": "339EF669C22F4B2EE05336680C0A6639",
            "postalAddress": {
              "address1": "395 Santa Monica Pl.",
              "city": "Santa Monica",
              "state": "CA",
              "postalCode": "90401",
              "country": "US"
            },
            "name": "Nike Santa Monica",
            "timezone": "America/Los_Angeles",
            "distance": "0.1037204811454481",
            "operationalDetails": {
              "hoursOfOperation": {
                "regularHours": {
                  "monday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT11H"
                    }
                  ],
                  "tuesday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT11H"
                    }
                  ],
                  "wednesday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT11H"
                    }
                  ],
                  "thursday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT11H"
                    }
                  ],
                  "friday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT11H"
                    }
                  ],
                  "saturday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT11H"
                    }
                  ],
                  "sunday": [
                    {
                      "startTime": "10:00",
                      "duration": "PT10H"
                    }
                  ]
                },
                "specialHours": []
              }
            }
          },
          "offerExpiration": "2016-02-07T23:59:59.000Z",
          "getBy": {
            "minDate": {
              "dateTime": "2019-02-07T00:00:00.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            },
            "maxDate": {
              "dateTime": "2019-02-07T23:59:59.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            }
          },
          "priceOfferId": "ba975ce4-867a-412c-b286-bf7549028692",
          "price": {
            "base": 0,
            "discount": 0,
            "total": 0
          }
        }
      ]
    }
  ],
  "fulfillmentGroups": [
    {
      "id": "68993f5c-0d03-4046-a531-c4489f88c145",
      "type": "SHIP",
      "priceOffers": [
        {
          "id": "727a92a6-3cb6-49ce-8d52-2f84728d17d2",
          "price": {
            "base": 0,
            "discount": 0,
            "total": 8
          },
          "offerExpiration": "2019-02-07T00:00:00.000Z",
          "getBy": {
            "minDate": {
              "dateTime": "2019-02-07T00:00:00.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            },
            "maxDate": {
              "dateTime": "2019-03-22T23:59:59.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            }
          },
          "promotionDiscounts": [
            {
              "id": "US_CODE_20_OFF_TWO_DAY",
              "code": "SUMMER20",
              "amount": 20
            }
          ]
        },
        {
          "id": "6113bd90-406d-4d6a-b58e-70ae725efc60",
          "price": {
            "base": 0,
            "discount": 0,
            "total": 5
          },
          "offerExpiration": "2019-02-07T00:00:00.000Z",
          "getBy": {
            "minDate": {
              "dateTime": "2019-02-07T00:00:00.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            },
            "maxDate": {
              "dateTime": "2019-02-09T23:59:59.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            },
            "promotionDiscounts": [
              {
                "id": "US_CODE_20_OFF_TWO_DAY",
                "code": "SUMMER20",
                "amount": 20
              }
            ]
          }
        }
      ]
    },
    {
      "id": "1f5f6ff8-4469-4a42-9942-612a864705c5",
      "type": "PICKUP",
      "priceOffers": [
        {
          "id": "ba975ce4-867a-412c-b286-bf7549028692",
          "price": {
            "base": 0,
            "discount": 0,
            "total": 0
          },
          "offerExpiration": "2019-02-07T00:00:00.000Z",
          "getBy": {
            "minDate": {
              "dateTime": "2019-02-07T00:00:00.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            },
            "maxDate": {
              "dateTime": "2019-02-07T23:59:59.000Z",
              "timezone": "America/Los_Angeles",
              "precision": "DAY"
            }
          }
        }
      ]
    }
  ]
}
```

The Fulfillment Offerings Jobs GET response includes the list of Cart items and a list of fulfillmentGroups. For each item, it lists the [fulfillment group](#fulfillment-groups) ID and fulfillment offerings.

**Get By Date Ranges**

The response contains a `getBy` object for each item (`items[i].fulfillmentOfferings[i].getBy`) and each fulfillment group (`fulfillmentGroups[i].priceOffers[i].getBy`). The `getBy` values are compared in the table below.

###### Table 2.3 Item and Fulfillment Group getBy Date Ranges

|Field Name|Required|Item|Fulfillment Group|
|---|---|---|
|`getBy.minDate`|Optional|Earliest day/time the item will be fulfilled. If the item does not have a `getBy.minDate`, the item will be fulfilled any day/time between order placement and the item's `getBy.maxDate.`|Earliest *approximate* day/time any item in the fulfillment group will be fulfilled. |
|`getBy.maxDate`|**Required**|Latest day/time the item will be fulfilled.|No item in the fulfillment group will be fulfilled after the `maxDate`.|

For more information on `getBy` dates, see [Semantics of Get-By Data in Nike Experiences](https://confluence.nike.com/pages/viewpage.action?spaceKey=BUY&title=Semantics+of+Get-By+Data+in+Nike+Experiences){:target="new-tab"}.

Listed below is a sample Fulfillment Offerings Jobs PUT 404 response.

```
{"id":"a49322d6-25cc-4a83-bb9c-a35834572352","status":"COMPLETED","links":{"self":{"ref":"/buy/fulfillment_offerings_jobs/v1/a49322d6-25cc-4a83-bb9c-a35834572352"}},"country":"US","currency":"USD","locale":"en_US","error":{"message":"Not found","httpStatus":404,"code":"NOT_FOUND","errors":[{"field":"/items/0","message":"Fulfillment offerings not found","code":"FULFILLMENT_OFFERINGS_NOT_FOUND"}]},"resourceType":"fulfillmentOfferingsJob"}
```

## Fulfillment Offerings GET

<i class="g72-check"></i>&nbsp;&nbsp;**Get fulfillment offerings for all sizes of a style-color**

Show the consumer a summary of fulfillment offerings and available offerings for each size of a style-color by calling the [Fulfillment Offerings GET](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} endpoint.

### Step 1: Display a Preview of a Style-Color's Fulfillment Offerings on a PDP

Execute a Fulfillment Offerings GET request to
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


Shown below is a sample [Fulfillment Offerings GET](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} request URI for a US style-color with productId 8e799c64-dd8e-4861-9d38-9592f35e7aa5, consumer postal code 97005 filtered by offering type `SHIP` and `PICKUP` and userType nike:swoosh (a Nike employee).
```
https://api.nike.com/buy/fulfillment_offerings/v1/?filter=countryCode(US)&filter=currency(US)&filter=productId(8e799c64-dd8e-4861-9d38-9592f35e7aa5)&filter=offeringTypes(SHIP,PICKUP)&filter=postalCode(97005)&filter=userType(nike:swoosh)
```

A successful 200 response includes a summary of available fulfillment offerings. It also includes fulfillment offerings for each size of the style-color including offer price, location, and estimated `getBy` dates.

## Fulfillment Offerings Jobs PUT

<i class="g72-check"></i>&nbsp;&nbsp;**Get fulfillment offerings for each item in Cart**

When you want to show available fulfillment offerings to the consumer for each item in their Cart and capture each fulfillment offering they select, follow the iterative steps below.

### Step 1: Show a UI to Select Fulfillment Intent

In order for the consumer to decide how to receive their items, you need to capture some information about their [intent](#intent).

#### Search for Offerings Using Consumer Location and Intents

What if you want to get additional offerings to show the consumer, for example, based on their GPS coordinates? What if you already know the consumer's intended fulfillment type for some items, but not all items?

In this case, you can *optionally* send any of the following to Fulfillment Offerings endpoint:

- **Location search data** (e.g. GPS coordinates, radius)
- **Known Addresses** (shipping, email or other known addresses for that consumer)
- **Promotion discount codes**
- **Allowed fulfillment types** (e.g. return only 'SHIP' and 'PICKUP' types)

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

Shown below is a sample [Fulfillment Offerings Jobs PUT](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} PUT request. The client supplies the Job ID, here 5e799c64-dd8e-4861-9d38-9592f35e7aa5. This endpoint is asynchronous, so you will call a different endpoint to check both the status of the job and the job results when it is complete.
```
https://api.nike.com/buy/fulfillment_offerings_jobs/v1/5e799c64-dd8e-4861-9d38-9592f35e7aa5
```

### Step 2: Check the status of the Fulfillment Offerings Job

After calling [Fulfillment Offerings Jobs PUT](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} and receiving a HTTP 202 response, execute a request to [Fulfillment Offerings Jobs GET](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-endpoint-get-1){:target="new-tab"} using the same Fulfillment Offerings Multi-Item ID to check the status of your job.

Sample [Fulfillment Offerings Job](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api#fulfillment-offerings-endpoints-fulfillment-offerings-jobs-endpoint-get-1){:target="new-tab"} request URI:
```
https://api.nike.com/buy/fulfillment_offerings_jobs/v1/5e799c64-dd8e-4861-9d38-9592f35e7aa5
```

Once the job status is `COMPLETED`, get the results of your job by parsing the data in the **response** object. Each Cart item in the response is in a Fulfillment Group. Items with the same [intent](#intent) are in the same Fulfillment Group.

>**TIP:** Make sure you pass all Cart items to [Fulfillment Offerings Jobs PUT](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} to group items properly and to get the most accurate fulfillment offers for each item.

### Step 3: Repeat **Step 1**

Each time the consumer indicates fulfillment intent for an item in their Cart, call the [Fulfillment Offerings Jobs PUT](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} endpoint as described in **Step 1**, passing the consumer's selection. This will regroup items with the same intent and update the list of fulfillment offerings for each item in Cart.

### Step 4: Proceed to Checkout

Once the consumer has chosen how they want all items in their Cart fulfilled and you have called Fulfillment Offerings Jobs PUT one last time to get an updated list of fulfillment offerings with price offers, you can proceed with the Checkout process. This process includes the optional step of [Checkout Preview](/doc/commerce/checkout/use-checkout.html#previewing-a-checkout), [Payment Preview](/doc/commerce/payment/use-payment.html), and [Submitting a Checkout](doc/commerce/checkout/use-checkout.html#submitting-a-checkout).

**Step 4a: Call Checkout Preview (Optional)**

If you choose to call [Checkout Preview](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api){:target="new-tab"} to increase the chances of a successful checkout, pass the consumer-selected fulfillment information for each Cart item in the `fulfillmentDetails` object from **Step 3**. The Checkout Preview response body includes a `totals` object that includes the fulfillment offerings totals to use in **Step 4c**.

**Step 4b: Call Payment Preview**

Call [Payment Preview](/doc/commerce/payment/use-payment.html) to gather the consumer's payment information.

**Step 4c: Call Checkout Submit**

Pass the consumer-selected fulfillment information for each Cart item in the `fulfillmentDetails` object from **Step 3** to [Checkout Submit](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api){:target="new-tab"}. If you called [Checkout Preview](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api){:target="new-tab"}, pass the `totals` object returned in the response to validate that the prices, including fulfillment offerings prices, have not changed.

## API Quick Reference

**Fulfillment Offerings Multi-Item**
- [Fulfillment Offerings Jobs PUT](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"}
- [Fulfillment Offerings Jobs GET](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"}
- [Fulfillment Offerings GET](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"}

## Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### Use Troubleshooting Tools

- Use the general troubleshooting tips in the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) to check for issues with your request.

- Contact the Buy team on the [#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV){:target="new-tab"} Slack channel for assistance.

## Caching

Although the Fulfillment Offerings Style-Color endpoint may return cached results, the client should not cache results from any Fulfillment Offerings call. There are several factors that affect calculating fulfillment offerings and these factors can change throughout the Checkout process. It is highly recommended that the client call the Fulfillment Offerings Jobs PUT endpoint each time the consumer indicates [intent](#intent) for an item in Cart to get the most accurate list of offerings.

## Contacting the Team

Need to contact the Cart & Checkout team?

|Slack|[#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV){:target="new-tab"}|
|Confluence Space|[CiC Order Capture](https://confluence.nike.com/pages/viewpage.action?pageId=163654070){:target="new-tab"}|
|Team Contacts|[Dan Robertson](mailto:dan.robertson@nike.com), [Saket Shrivastava](mailto:saket.shrivastava@nike.com)|

## Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|03/03/2020|Initial Publish|
|Renamed endpoints|04/20/2020|Renamed endpoints, updated Next Steps section|

## Next Steps

You've learned how to add Fulfillment Offerings to your experience. Here are some related topics.

- [Wishlist](/doc/commerce/checkout/use-wishlists.html)
- [Cart & Cart Review](/doc/commerce/checkout/use-carts.html)
- [Fulfillment Offerings](/doc/commerce/checkout/use-fulfillment-offerings.html)
- [Checkout](/doc/commerce/checkout/use-checkout.html)
- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)
- [Supported Countries & Currencies](/doc/commerce/checkout/checkout-country-currency.html)