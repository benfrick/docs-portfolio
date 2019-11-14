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
  - h2: Get Fulfillment Offerings
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#get-fulfillment-offerings
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

##### Last Updated: 10/22/2019

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

### What are Fulfillment Offerings?

Fulfillment Offerings are a **set of price offers that a consumer has for receiving the items in their cart**, as determined by the [Fulfillment Offerings API](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"}.

Offerings can vary at any moment in time based upon:

- Consumer information
- Delivery destinations (i.e. shipping addresses, store IDs, pickup locations, email addresses, GPS coordinates)
- Items in cart
- Total item prices
- Available discounts/promotions

Turn this into a diagram:
Send an API request to get the available offerings and then show them to the consumer. As the consumer selects an offer for each item, send additional API requests in order to dynamically refresh the offerings shown. That way, the consumer can make up their mind quickly and easily.

>**TIP:** You can also [Search for Offerings Using Consumer Location and Intents](#search-for-offerings-using-consumer-location-and-intents).

### What is BOPIS?

Fulfillment Offerings supports the 'Buy Online, Pickup In Store' (BOPIS) scenario. This is where the consumer completes a checkout in the app/web, then travels to a nearby store to pick up their order. See [BOPIS](#bopis) for further details.

## Key Terms

|Term|Definition|
|---|---|
|Fulfillment Offering|A set of price offers that a consumer has for fulfilling the items in their cart.|
|Items|The individual products and services to be fulfilled.|
|Expiration Date|The date/time after which an offering expires.|
|Get By|The estimated date (min/max) for the item to be fulfilled.|
|Fulfillment Group|A grouping of cart items that have the same Fulfillment Type.|
|Fulfillment Type|The type of offering, one of `SHIP`, `PICKUP`, `INSTORE`, `DIGITAL`|
|BOPIS|Acronym for 'Buy Online, Pickup In Store'|
|Locations|The types of locations to be considered for a particular offering, e.g. `address/shipping` or `location/search`|
|Store|A Nike store at which the consumer can pick up their order, in the case of BOPIS.|
|Pickup Location|The third-party location at which the consumer picks up their order.|
|Email|The email address to which the products/services are to be fulfilled, e.g. for digital gift cards.|
|Shipping Address|The postal address to which the products are to be shipped.|

## Making Your First Request

Let's walk through how to make your first request to the Fulfillment Offerings API, and along the way, define and explain some more concepts.

### What Data Do I Need To Provide?

At minimum, the following is required to be sent in the request body:

- `country` code (e.g. US)
- `currency` code (e.g. USD)
- List of `items`, each having:
    - Unique line item `id` (a UUID that you generate)
    - Item `quantity`
    - `locations` (one or more of `address/shipping`, `address/digital`, `location/search`, `store/store_views`, `location/pick_up_locations`)

Optionally, for each item you can send a `fulfillmentType` which describes the consumer's **intended method of fulfillment** for that item (if known).

**Possible values for Fulfillment Type**
|Type|Description|Example Scenario|
|---|---|---|
|`SHIP`|Consumer receives the order at their postal address.|Carrier delivers order to a home address|
|`PICKUP`|Consumer picks up the order at a Nike store or third-party pickup location|'Buy Online Pickup In Store' (BOPIS).|
|`INSTORE`|Consumer completes self-checkout via mobile while in a retail store|Instant Checkout in the Nike app|
|`DIGITAL`|Consumer receives the order at their digital address|Digital gift card is delivered by email.|

>**KEY CONCEPT**:
>Fulfillment Type, along with Location, describe the consumer's intent(s) for receiving the item. More on [intent](#step-1-show-a-ui-to-select-fulfillment-intent) later.

>**TIP**: Always check the [Fulfillment Offerings API Reference](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} for the most up-to-date requirements.

### Send the Request

Send a HTTP PUT request to https://api.nike.com/buy/fulfillment_offerings_jobs/v1/2c1db6b9-7fd7-401c-acc9-73f926681cb9. Note the UUID in the URL path, which you must generate.

**Sample Request Body**
```json
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

Query Params for GET request:

- Fulfillment Type (as `fulfillmentTypes`)
- Location as (`country` or `country` and `postalCode`)
- Product data (as `skuId` or `gtin`)

### Evaluate the Response

The API response includes a list of items. For each item, one or more offerings are included, along with a [Fulfillment Group](#fulfillment-groups) identifier.

#### What's in an Offering?

Each offering has the following attributes:

**Offering Attributes**
|Attribute|Description|Example|
|---|---|---|
|**Fulfillment Type**|The type of offering|`"type": "SHIP"`,`"type": "PICKUP"`|
|**Location**|Delivery destinations|postal/email addresses, store IDs, pickup locations, GPS coordinates|
|**'Get By' Date**|The estimated date (min/max) for the item to be fulfilled|`"dateTime": "2019-02-09T23:59:59.000Z"`|
|**Expiration Date**|The date on which the offering expires|`"offerExpiration": "2019-02-07T00:00:00.000Z"`|
|**Price**|The price of the offering|`"total": 8`|

#### Fulfillment Groups

The API response also includes an array of `fulfillmentGroups`, include one group for each applicable Fulfillment Type. For example, if there are multiple options for fulfillment type `SHIP`, they will belong to the same Fulfillment Group, while offerings of other types would be in separate groups.

Fulfillment Groups can be identified by the unique identifiers found in either `items.**fulfillmentGroupId**` or `fulfillmentGroups.**id**`.

>**TIP** Fulfillment Groups help you to show the offerings of same type together in the experience, making it easier for the consumer to make their selections.

## Get Fulfillment Offerings

<i class="g72-check"></i>&nbsp;&nbsp;**Get fulfillment offerings**

Let's walk through some use-cases for integrating Fulfillment Offerings into your experience.

### Step 1: Show a UI to Select Fulfillment Intent

For the consumer to finalize their decision about how to receive their items, first you need to capture some info about their **intent**.

Intent, in the context of Fulfillment Offerings, is the combination of the desired Fulfillment Type and Location.

Price offers are for fulfillment groups.

Intent vs non-intent offerings: intent will have a price offer reference (priceOfferId), while non-intent offerings do not.

Enter shipping address

Select from list?

#### Search for Offerings Using Consumer Location and Intents

What if you want to get additional offerings to show the consumer, for example, based on their GPS coordinates? What if you already know the consumer's intended fulfillment type for some items, but not all items?

For this you can *optionally* send any of the following to Fulfillment Offerings:

- **Location search data** (e.g. GPS coordinates, radius)
- **Known Addresses** (shipping, email or other known addresses for that consumer)
- **Promotion discount codes**
- **Allowed fulfillment types** (e.g. return only 'SHIP' and 'PICKUP' types)

Fulfillment Offerings adjusts the results based on what you send, making for an efficient way to drive the experience.

### Step 2: Show a UI to Select a Price Offer



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
|Initial draft|09/16/2019|Initial Draft|

## Next Steps

You've learned how to add Fulfillment Offerings to your experience. Here are some next steps.

- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)
- [Supported Countries & Currencies](/doc/commerce/checkout/checkout-country-currency.html)