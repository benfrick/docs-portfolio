---
tags: pdf
category: b-use-case
position: 6
title: Cart & Checkout
url: /doc/commerce/checkout/api_checkout.html
toc:
  - h2: API at a Glance
    url: /doc/commerce/checkout/api_checkout.html#api-at-a-glance
  - h2: Terms of Service
    url: /doc/commerce/checkout/api_checkout.html#terms-of-service
  - h2: Use Cases
    url: /doc/commerce/checkout/api_checkout.html#use-cases
  - h2: Endpoint Quick Reference
    url: /doc/commerce/checkout/api_checkout.html#api-endpoint-quick-reference
  - h2: Making Your First Request
    url: /doc/commerce/checkout/api_checkout.html#making-your-first-api-request
  - h2: Using Carts
    url: /doc/commerce/checkout/api_checkout.html#using-carts-v2
  - h2: Using Cart Reviews
    url: /doc/commerce/checkout/api_checkout.html#using-cart-reviews
  - h2: Using Wish Lists
    url: /doc/commerce/checkout/api_checkout.html#using-wish-lists
  - h2: Using Shipping Options
    url: /doc/commerce/checkout/api_checkout.html#using-shipping-options
  - h2: Using Checkouts
    url: /doc/commerce/checkout/api_checkout.html#using-checkouts
  - h2: Upgrading to the Latest Version
    url: /doc/commerce/checkout/api_checkout.html#upgrading-to-the-latest-version
  - h2: Best Practices
    url: /doc/commerce/checkout/api_checkout.html#best-practices
  - h2: Troubleshooting
    url: /doc/commerce/checkout/api_checkout.html#troubleshooting
  - h2: Glossary
    url: /doc/commerce/checkout/api_checkout.html#glossary
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn ncss-brand guide-button pt2-sm pr5-sm pb2-sm pl5-sm"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# BUY DOMAIN <i class="g72-swoosh"></i><br>DEVELOPER'S GUIDE

---

##### Last Updated: 10/01/2018

If you've read [Using NDe APIs](/doc/getting-started/using_nike_apis.html) and the [Cart & Checkout Overview](/doc/commerce/checkout/overview-checkout.html), this guide provides the additional details necessary to integrate with the Buy Domain APIs.

## API at a Glance

|Topic|Details|
|---|---|
|Use these APIs to|Add Nike products or gift cards to a shopping cart or Wish List and get pricing<br>Get available shipping options with pricing><br>Preview & validate a checkout<br>Submit a checkout for fulfillment<br>More...|
|Who calls this API|SNKRS app (Web/iOS/Android), Nike+ app (iOS/Android), Nike.com|
|Version|v1, v2|
|SLA|Carts - Response Time: 1000ms, Requests Per Second: 300<br>Cart Reviews - Response Time: 150 ms, Requests Per Second: 200<br>Wish Lists - Response Time: 160 ms, Requests Per Second: 80<br>Shipping Options - Response Time: 100 ms, Requests Per Second: 1000<br>Checkouts - Response Time: 300 ms, Requests Per Second: 600|
|Domain|Commerce|
|Prerequisites|[API Registration](/doc/getting-started/using_nike_apis.html#registration)<br>JWT for *Launch Checkout Submit* only|
|Contact Info|Slack: [#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV){:target="blank"}<br>Confluence: [CiC Order Capture](https://confluence.nike.com/pages/viewpage.action?pageId=163654070){:target="blank"}<br>Product Owners: Dan Robertson, Saket Shrivastava, Sree Krishna (Carts v1/v2)|

>**TIP:** SLAs vary per endpoint for many of the Buy APIs. In the figures listed above, the highest response time and lowest requests per second *for the API overall* were shown. Ask the Product Owner to get specific SLA info for each endpoint.

## Terms of Service

It is recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#registration) guide on how to create and register your caller ID.

### Authentication

#### Access Tokens

Most calls through the Nike API gateway (api.nike.com) require an access token be sent in the request header. This allows Nike to verify that your app is authorized to perform the action on behalf of the user. Access tokens are obtained by calling Nike Unite services prior to calling the API which you ultimately want to reach.

See [Using NDe APIs](/doc/getting-started/using_nike_apis.html#authorization) guide for more on how to call Unite services.

#### JSON Web Token

Only one endpoint in the Buy APIs, *Launch Checkout Submit*, requires the additional authorization of a JSON Web Token (JWT). For more, see the JWT section of [Using NDe APIs](/doc/getting-started/using_nike_apis.html#jwt-json-web-token).

## Use Cases

|I want to...|API(s) to use|
|---|---|
|Manage a user's shopping cart, get product pricing|Carts API|
|Check the 'buyability' of a product|Carts API|
|Augment a cart with estimated taxes and delivery dates|Cart Reviews API|
|Manage a user's Wish Lists (member/employee only), get product pricing|Wish Lists API|
|Get available shipping methods, estimated delivery dates|Shipping Options API|
|Validate product and shipping info. Get product, tax, and shipping prices|Checkouts API|
|Submit a checkout for fulfillment|Checkouts API|

### Example Implementation Diagram

Here is an example of a sequence of API calls to execute an entire checkout:

![](/images/commerce/buy/checkout_seq_dgm.png){:class="border"}

### Sample Requests

The sample requests included throughout this guide often contain unique IDs and access tokens that are spent/expired in the Production environment, so you will not be able to copy and use them as-is for testing purposes. However, since other values in the request may still be valid and thus reusable, it may be convenient for you to copy the samples and change only the spent/expired values.

### User Types

The Nike Checkout APIs support 3 distinct user types:

- Member: user has logged in with their Nike+ account credentials

- Guest: user has not logged in (anonymous user)

- Employee: user is an employee of Nike or a subsidiary and has logged in with swoosh.com credentials (also known as Swoosh user type)

Depending on user type, certain aspects of the calls that you make to the Checkout APIs might need to be modified. This will be called out whenever applicable in the detailed endpoint sections which follow in this guide. Also, consider that not all user types might apply to your app (e.g. you might only support Members).

See the User Types section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#user-types) guide for more information.

### Request Headers

The following request headers are common to all of the Checkout APIs:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|X|X|X|
|**Content-Type**|Content type of the request, application/json is only value allowed|X|X|X|
|**Authorization**|Your access token in the format of `Bearer {token}` indicating the customer is logged in|X||X|
|**x-nike-visitorid**|Identifier for the guest (i.e. not logged-in) user, validated by the Edge router and passed through to the service||X||

>**TIP:** For the Authorization header, use the token for the user's login session that you obtained from Nike Unite/Identity, prefixed by **Bearer ** (note the single space after Bearer). This is necessary for Nike to verify that you are authorized to perform the requested operation on behalf of the user.

### Idempotence

[Idempotence](http://restcookbook.com/HTTP%20Methods/idempotency/){:target="blank"} means that the result of a successful request is independent of the number of times it is executed. What does that mean for the Checkouts API? Each PUT request to *Request Checkout Preview* and *Request a Checkout Submit* includes 1) a client-generated UUID (checkout ID) in the URL and 2) an Entity in the request body. There are 4 possible scenarios:

|Scenario|Result|
|---|---|
|UUID and Entity are new to the system (base use case)|Client receives HTTP 202 response, request processed as new job|
|UUID and Entity match a prior request|Client receives the exact same HTTP 202 response from the prior request (no new job processed)|
|UUID used previously, Entity is new|Client receives HTTP 409 error response (no new job processed)|
|UUID is new, Entity previously submitted under another UUID|Client receives HTTP 202 response, request processed as new job|

>**TIP:** For more, see the Idempotence Guarantee section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#idempotence-guarantee) guide.

## API Endpoint Quick Reference

**Carts**
- [Create or Update a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="blank"}
- [Modify a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="blank"}
- [Delete All Items from a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="blank"}
- [Get a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="blank"}
- [Get a Cart by Filter Criteria (Query Param)](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api)
- [Create or Update a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="blank"}
- [Modify a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="blank"}
- [Get a Cart by Filter Criteria (Path Param)](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="blank"}
- [Delete All Item from a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="blank"}

**Cart Reviews**
- [Augment a Cart](https://developer.niketech.com/docs/projects/Cart%20Reviews?tab=api){:target="blank"}

**Payment Options**
- [Get Payment Options for an Order](https://developer.niketech.com/docs/projects/Payment%20Options?tab=api){:target="blank"}
- [Allowable Billing Countries for a Shipping Country](https://developer.niketech.com/docs/projects/Payment%20Options?tab=api){:target="blank"}
- [Validate Payments](https://developer.niketech.com/docs/projects/Payment%20Options?tab=api){:target="blank"}

**Wish Lists**
- [Create or Update a List](https://bitbucket.nike.com/projects/PHYLPAY/repos/wishlist/browse/API.md){:target="blank"}
- [Delete a List](https://bitbucket.nike.com/projects/PHYLPAY/repos/wishlist/browse/API.md){:target="blank"}
- [Retrieve a List by ID](https://bitbucket.nike.com/projects/PHYLPAY/repos/wishlist/browse/API.md){:target="blank"}
- [Retrieve Lists for Authenticated User](https://bitbucket.nike.com/projects/PHYLPAY/repos/wishlist/browse/API.md){:target="blank"}
- [Add Item to List](https://bitbucket.nike.com/projects/PHYLPAY/repos/wishlist/browse/API.md){:target="blank"}
- [Remove Item from List](https://bitbucket.nike.com/projects/PHYLPAY/repos/wishlist/browse/API.md){:target="blank"}
- [Retrieve Items by List](https://bitbucket.nike.com/projects/PHYLPAY/repos/wishlist/browse/API.md){:target="blank"}
- [Retrieve Item by ID](https://bitbucket.nike.com/projects/PHYLPAY/repos/wishlist/browse/API.md){:target="blank"}

**Shipping Options**
- [Shipping Options](https://developer.niketech.com/docs/projects/Shipping%20Options?tab=api){:target="blank"}

**Checkouts**
- [Request Checkout Preview](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api){:target="blank"}
- [Retrieve Checkout Preview Job](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api){:target="blank"}
- [Retrieve Checkout Preview Results](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api){:target="blank"}
- [Request Checkout Submit](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api){:target="blank"}
- [Retrieve Checkout Submit Job](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api){:target="blank"}
- [Retrieve Checkout Results](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api){:target="blank"}
- [Request Checkout Submit (Launch)](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api){:target="blank"}

## Making Your First API Request

For your first API request, send a request to the *Create or Update a Cart by Cart ID* endpoint of the Carts v2 API and create your first cart.

##### 1. Gather Data Needed For The Request

Our example endpoint, *Create or Update a Cart by Cart ID*, only supports the HTTP PUT method. To create a cart, send a PUT request with (at minimum) the required request headers and the required parts of the request body.

First, read the [Using Carts](#using-carts-v2) section of this document to learn more about the required parts of this request.

Assume that user for whom you are creating the cart is a Nike+ member who has logged in with their Nike+ credentials. This indicates which request headers are required.

For the request headers, the following considerations apply (at minimum):

- Always send `application/json` in both the **Accept** and **Content-Type** headers.

- Send the user's access token as obtained from Unite services in the **Authorization** header.

```
Accept: application/json
Content-Type: application/json
Authorization: Bearer {your access token}
```

For the request body, the following considerations apply (at miniumum):

1. Send a UUID **that you have created** in the **id** field, in this case `61bc115b-16e5-43b5-bcaf-dd6168c543f8`. This is the cart ID.

2. Send the country code of the country where the user is shopping in the **country** field, in this case, `US`. Send `NIKE` in the **brand** field.

3. Send a UUID **that you have created, different from above** in the items.**id** field. This is the identifier for the line item in the cart. If you include multiple line items, each must have a unique identifier.

4. Send a valid SKU identifier obtained from the Merchandised Products SKU service in the items.**skuId** field.

```
{
  "id": "61bc115b-16e5-43b5-bcaf-dd6168c543f8",
  "country": "US",
  "brand": "NIKE",
  "items": [
    {
      "id": "9992b8cb-e4ac-42af-a8bb-3454d8509d32",
      "skuId": "1f6b36bd-61c0-5eb5-b9f0-8643e1ebae37",
      "quantity": 1
    }
  ]
}
```

**2. Create the URL**

The [API Reference](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="blank"} states that the required URL format is `/buy/carts/v2/{id}`.

To build the full URL, prepend `https://api.nike.com` to the above path, then append  **id** after "v2". The **id** is the cart identifier you passed in the request body.

The complete URL is then https://api.nike.com/buy/carts/v2/61bc115b-16e5-43b5-bcaf-dd6168c543f8.

**3. Execute the request**

Execute the request with a cURL command. Using the values gathered in steps 1 and 2, the final cURL command is:

```
curl -X PUT \
  https://api.nike.com/buy/carts/v2/61bc115b-16e5-43b5-bcaf-dd6168c543f8 \
  -H 'Accept: application/json' \
  -H 'Authorization: Bearer {your access token}' \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{
     "id": "61bc115b-16e5-43b5-bcaf-dd6168c543f8",
     "country": "US",
     "brand": "NIKE",
     "items": [
       {
         "id": "9992b8cb-e4ac-42af-a8bb-3454d8509d32",
         "skuId": "1f6b36bd-61c0-5eb5-b9f0-8643e1ebae37",
         "quantity": 1
       }
     ]
}'
```

**4. Parse the Response**

Assuming no errors, you will receive a response body similar to the following:

```
{
    "id": "61bc115b-16e5-43b5-bcaf-dd6168c543f8",
    "country": "US",
    "currency": "USD",
    "brand": "NIKE",
    "totals": {
        "subtotal": 130,
        "discountTotal": 0,
        "valueAddedServicesTotal": 0,
        "total": 130,
        "quantity": 1
    },
    "items": [
        {
            "id": "9992b8cb-e4ac-42af-a8bb-3454d8509d32",
            "skuId": "1f6b36bd-61c0-5eb5-b9f0-8643e1ebae37",
            "quantity": 1,
            "priceInfo": {
                "price": 130,
                "subtotal": 130,
                "discount": 0,
                "valueAddedServices": 0,
                "total": 130,
                "priceSnapshotId": "d5d8dbed-afba-4677-9904-e9712fa3ecb9",
                "msrp": 130,
                "fullPrice": 130
            }
        }
    ],
    "links": {
        "self": {
            "ref": "/buy/carts/v2/61bc115b-16e5-43b5-bcaf-dd6168c543f8"
        }
    },
    "resourceType": "cart"
}
```

Some values in the response are exactly what you sent in the request, but the values in the **totals** section provide a cart pricing summary and the values in items.**priceInfo** section provide the current item pricing details.

#### Another Example

For your next request, send a GET request to the *Get a Cart for a Cart ID* endpoint of the Carts v2 API, using the cart **id** that you created in the previous step.

Refer to the [Using Carts v2](#using-carts-v2) section of this document to find the required parts of this request.

For the request headers, use the same headers you used in the previous step.

>**NOTE**: There is no request body needed for a GET request.

The complete URL is https://api.nike.com/buy/carts/v2/61bc115b-16e5-43b5-bcaf-dd6168c543f8. Note that the same cart **id** that you created for the previous PUT request is at the end of the URL.

The final cURL is:

```
curl -X GET \
  https://api.nike.com/buy/carts/v2/61bc115b-16e5-43b5-bcaf-dd6168c543f8 \
  -H 'accept: application/json' \
  -H 'authorization: Bearer {your access token}' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json'
```

The response body from the *Get a Cart for a Cart ID* endpoint is the same as *Create or Update a Cart by Cart ID*, so the process of parsing it is also the same.

## Using Carts v1

**NOTE: Carts v1 has been replaced with Carts v2 and will be deprecated. Use Carts v2 for any new integrations. For more info, see the [Using Carts v2](#using-carts-v2) section of this document.**

- [Carts v1 Overview](#carts-v1-overview)

- [Create or Update a Cart](#create-or-update-a-cart)

- [Retrieve Carts by ID](#retrieve-carts-by-id)

- [Retrieve Carts by Filter](#retrieve-carts-by-filter)

- [Delete All Items from a Cart](#delete-all-items-from-a-cart)

- [Carts v1 Error Handling](#carts-v1-error-handling)

### Carts v1 Overview

In e-commerce, the cart (also called basket or bag) allows customers to collect and compare items that they are considering for purchase before starting the checkout process. At Nike, a cart contains items, quantities, and associated value-added services (if any).

The Carts API helps you manage carts. It provides storage, validation, and pricing augmentation for up to 100 Nike products or value-added services in each cart.

#### More Facts About Carts

- Cart item count and/or cart item quantity totals can be calculated by executing a GET request and then summing the values.

- Cart pricing summary can be obtained by executing a PUT or GET request and will include totals only for "buyable" cart items.

- Carts can be stored long-term but not indefinitely; if unmodified for over 180 days, a cart will be automatically removed from storage.

- To check the buyability of cart items, execute either a PUT cart or GET cart request and interrogate the response body’s errors object. Item errors will be linked by cart item ID.

- Item pricing can be obtained by a PUT cart or GET cart request wherever available (for example, a non-buyable product will still have a price, while an invalid item skuId will not).

- PUT cart requests fail when cart items are invalid, non-buyable, or if more quantity was requested than available and/or allowed.

- All filter values are case-sensitive.

- Adding an item to a cart does not reserve the inventory for purchase.

- When using the optional channel filter in GET cart requests, carts for which no channel value was included in the preceding PUT request will not be returned.

>**TIP:** It is a best practice to send all of the optional request headers and request body fields, if the data is available, to avoid unexpected responses.

The following sections describe each endpoint of the Carts API in detail:

### Create or Update a Cart

Create a cart by executing an HTTP PUT request with a cart ID in [UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier){:target="blank"} format **that you have generated**. Update a cart with PUT request using an existing cart ID.

>**Note**: HTTP PATCH is not supported; for each 'update cart' operation, send the entire cart contents again.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PUT**|`/buy/carts/v1/{id}{?fields}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique identifier for the cart|string|**Required**|
|**fields**|Query|Fields to be included in the response (all fields included by default)|string|Optional|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

#### Request Body

|Element Name|Required?|Description|
|---|---|---|
|**id**|Required|Unique client-generated cart identifier as [UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier){:target="blank"}|
|**country**|Required|ISO 3166 country code, e.g. US. This is typically the same as the country of the user's shipping address.|
|**currency**|Required|ISO 4217 currency code, e.g. USD|
|**brand**|Required|Nike brand name associated with the cart, only NIKE is supported|
|**items**|Required|Array containing list of item objects, with the following required fields:|
|items.**quantity**|Required|Unit quantity (integer) of the SKU.|
|items.**id**|Required|Unique identifier of the line item in the request. **You create this value**. If the response contains errors, it will include a reference to the identifier of the line item having the error.|
|items.**skuId**|Required|Stock Keeping Unit (SKU) unique identifier of the product, as obtained from Nike Product services.|
|**channel**|Optional|Sales channel of the shopping cart, only NIKECOM is supported.|
|**valueAddedServices**|Optional|List of value-added service (VAS) line items. One or more VAS line items can be associated with a Nike product (i.e. **skuId**). Examples of VAS are a customization service for a shoe or a gift-wrapping service.|
|valueAddedServices.**id**|Optional|Unique identifier for the VAS.
|valueAddedServices.Instruction.**id**|Optional|Instruction unique identifier for the value-added service, related to the various service domains, e.g. design id for Nike iD customization.|
|valueAddedServices.Instruction.**type**|Optional|Instruction Type, e.g. customization/nike_id (only one currently available), customization/my_print, customization/gift_card, buy/gift_wrap, buy/gift_message.|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>For the list of supported country code and currency code combinations, see [here](/doc/commerce/checkout/checkout_country_currency.html).
>
><i class="mr2-sm g72-check"></i>Use the same brand value for all calls for a particular cart, else you will get a 409 Conflict error when the value varies from the initial PUT.
>
><i class="mr2-sm g72-check"></i>Use the same channel value for all calls for a particular cart, else you will get a 409 Conflict error when the value varies from the initial PUT.
>
><i class="mr2-sm g72-check"></i>To retrieve VAS data to include in your checkout request, call the Merchandised Value Added Services endpoints of the Merchandised Products API. See the [Merchandised Products API Developer's Guide](/doc/commerce/product/api_merch_product.html) for more information.

Sample *Create or Update Cart* Request Body:

```
{
     "id": "9af84d4b-6a1f-4899-af57-b4379f966913",
     "country": "US",
     "currency": "USD",
     "brand": "NIKE",
     "channel": "NIKECOM",
     "items": [
       {
         "id": "9892b8cb-e4ac-42af-a8bb-3454d8509d32",
         "skuId": "d3d15345-63e6-4cf9-9135-c2beacbbe352",
         "quantity": 2,
         "valueAddedServices": [
           {
             "id": "88d0475d-30e5-4c2f-9a87-7a31938f8ace",
             "instruction": {
               "id": "2027261230",
               "type": "customization/nike_id"
             }
           },
           {
             "id": "ac9fd9d3-3815-44ce-8b1f-18cce7abd488",
             "instruction": {
               "id": "1027551960",
               "type": "customization/nike_id"
             }
           }
         ]
       },
       {
         "id": "e945e0fd-cdcf-4005-9fe4-9302b9d6235c",
         "skuId": "f030bb22-4859-404e-82c9-aa9a23582e4f",
         "quantity": 1
       }
     ]
   }
```

#### Response Body

Sample *Create or Update Cart* response body without errors:
```
{
    "id": "3dee558b-82e7-49aa-a9f3-46ee294ca7a0",
    "country": "US",
    "currency": "USD",
    "brand": "NIKE",
    "channel": "NIKECOM",
    "totals": {
        "subtotal": 190,
        "discountTotal": 0,
        "valueAddedServicesTotal": 0,
        "total": 190,
        "quantity": 1
    },
    "items": [
        {
            "id": "9892b8cb-e4ac-42af-a8bb-3454d8509d32",
            "skuId": "2f127fe4-78d4-5042-a944-b8a4938aff10",
            "quantity": 1,
            "valueAddedServices": [],
            "priceInfo": {
                "price": 190,
                "subtotal": 190,
                "discount": 0,
                "valueAddedServices": 0,
                "total": 190,
                "priceSnapshotId": "a1f2f7ec-4faf-41d3-a144-d2da48c07bbe"
            }
        }
    ],
    "links": {
        "self": {
            "ref": "/buy/carts/v1/3dee558b-82e7-49aa-a9f3-46ee294ca7a0"
        }
    },
    "resourceType": "cart"
}
```

Some of the values in the response are exactly as sent in the request, but the values in the **totals** section provides a cart pricing summary and the **priceInfo** section provides the latest item pricing details.

### Retrieve Carts by ID

Get the details of a cart using the ID (in [UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier){:target="blank"} format) that **you previously created**. The default HTTP 200 response includes a list of items in a cart with prices, quantities, discounts, value-added services, and totals. You can also choose which fields you want to receive in the response, using the fields query parameter in the URL.

>**TIP:** Reads against this endpoint are [eventually consistent](https://en.wikipedia.org/wiki/Eventual_consistency){:target="blank"}. Since the PUT endpoint responds with the same body as this endpoint, consume the response body from the PUT for best performance to avoid polling.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/buy/carts/v1/{id}/{?fields}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique client-generated identifier for the cart|string|**Required**|
|**fields**|Query|Fields to be included in the response (all fields included by default)|string|Optional|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

#### Request Body

There is no body on a GET request.

#### Response Body

See the response body from the *Create or Update Cart* endpoint as it is the same as this endpoint.

### Retrieve Carts by Filter

Retrieve a user's cart(s) by country, brand, and (optionally) channel. The default format of each cart in the HTTP 200 response is the same as doing a GET by ID.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/buy/carts/v1/{?filter,fields}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**filter**|Query|Values by which to limit the cart results: **country**: ISO 3166-1 [two-letter code](/doc/commerce/checkout/checkout_country_currency.html) **Required**<br>**brand**: NIKE brand name, only NIKE is supported **Required**<br>channel: sales channel, only NIKECOM is supported, optional|string|**Required**|
|**fields**|Query|Fields to be included in the response (all fields included by default)|string|Optional|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

#### Request Body

There is no body on a GET request.

#### Response Body

See the response body from the *Create or Update Cart* endpoint as it is the same as this endpoint.

### Delete All Items From A Cart

Delete all items in a cart by its ID and receive a HTTP 204 response if successful. Subsequent calls to GET that same cart ID will return a HTTP 404 status ('Not Found').

>**NOTE**: The delete operation is optional; carts will automatically purge from storage after 180 days of inactivity.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**DELETE**|`/buy/carts/v1/{id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique client-generated identifier for the cart|string|**Required**|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

#### Request Body

There is no body on a DELETE request.

#### Response Body

The HTTP 204 response (successful delete) returns an empty response body.

### Carts v1 Error Handling

Following is a summary of the errors and warnings that can come back in responses from the Carts API:

|HTTP Response Code|Relevant HTTP Method(s)|Error Code|Error Description|Action to Take|
|----|----|----|----|---|
|400|GET, PUT|REQUEST_INVALID|Request was structurally invalid, such as malformed JSON.|Check the URL, syntax of the request body, or item quantity for validity.|
|400|PUT|MISSING_REQUIRED|Required field(s) missing in the request (e.g. cart ID, country, brand, etc.|Retry the request while supplying the missing field/value|
|400|PUT|FIELD_INVALID|Value of field(s) in the request not valid (e.g. >100 items, unsupported country code and/or brand, etc.).|Check the indicated field/value. Correct and retry|
|400|PUT|INVALID_SKU|Item SKU not found or not valid for the country.|Check the skuId. Correct and retry.|
|400|GET, PUT|PRODUCT_NOT_BUYABLE|Item sku not 'buyable', either due to being inactive, being outside sell dates, or launch product purchase being attempted outside of launch.|Notify user as necessary|
|400|PUT|ITEM_QUANTITY_LIMIT|Quantity limit (for single cart) exceeded for the item sku.|Notify the user as necessary|
|500|GET, PUT, DELETE|SYSTEM_ERROR|Error occurred processing the request.||
|401|GET, PUT, DELETE|35|The operation was requested by an unauthorized user.|Check that your access token was sent in **Authorization** request header in format `Bearer {token}` or that the token has not expired.|
|404|GET|n/a, no request body|The operation was not requested by the cart owner or ownership was not provided.|Check that the access token sent in the request header was for the correct user.|
|404|GET|n/a, no request body|Cart just created or cart has expired|If cart was just created, try GET again later or do a PUT. If cart was created > 180 days ago, create a new cart.|
|409|PUT|n/a, no request body|Cart ID already exists and is associated with a different user ID, country or brand.|Choose a unique cartId and retry.|
|200|GET, PUT|PRICE_CHANGED|This is a *warning* only that the price of an item or value added service has changed since the item was added to the cart.|Notify the user as necessary|

#### Example error response bodies:

1. Response for a request that was missing the required field 'id':
```
{
    "errors": [
        {
            "code": "MISSING_REQUIRED",
            "message": "Required field",
            "field": "id"
        }
    ]
}
```

2. Response for a request that included an invalid country code:
```
{
    "errors": [
        {
            "code": "FIELD_INVALID",
            "message": "Invalid field",
            "field": "country"
        }
    ]
}
```

3. Response for a request where the item quantity value exceeded the allowed limit:
```
{
    "errors": [
        {
            "code": "ITEM_QUANTITY_LIMIT",
            "message": "Product item quantity limit exceeded. skuId=2f127fe4-78d4-5042-a944-b8a4938aff10, productId=636ae3f2-3d44-5751-9200-f6edfc5f0264, itemQuantity=101, accumulatedQuantity=101, quantityLimit=1",
            "field": "$.items[?(@.id == '9892b8cb-e4ac-42af-a8bb-3454d8509d32')]"
        }
    ]
}
```

4. Response for a request that included an invalid skuId:
```
{
    "errors": [
        {
            "code": "INVALID_SKU",
            "message": "Invalid skuId",
            "field": "sku.id"
        }
    ]
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLORD/repos/v2-order-api/browse/carts/API.md?raw#!/Cart_Operations/get_buy_carts_v1" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

## Using Carts v2

- [Carts v2 Overview](#carts-v2-overview)

- [Create or Update a Cart by Cart ID](#create-or-update-a-cart-by-cart-id)

- [Modify a Cart by Cart ID](#modify-a-cart-by-cart-id)

- [Delete All Items from a Cart by Cart ID](#delete-all-items-from-a-cart-by-cart-id)

- [Get a Cart for a Cart ID](#get-a-cart-by-cart-id)

- [Get a Cart by Filter Criteria (Query Param)](#get-a-cart-by-filter-criteria-query-param)

- [Create or Update a Cart by Filter Criteria](#create-or-update-a-cart-by-filter-criteria)

- [Modify a Cart by Filter Criteria](#modify-a-cart-by-filter-criteria)

- [Get a Cart by Filter Criteria (Path Param)](#get-a-cart-by-filter-criteria-path-param)

- [Delete All Items from a Cart by Filter Criteria](#delete-all-items-from-a-cart-by-filter-criteria)

- [Carts v2 Error Handling](#carts-v2-error-handling)

### Carts v2 Overview

Manage a user's shopping cart by either the cart ID or by a set of filter criteria.

### Create or Update a Cart by Cart ID

Create a cart by executing an HTTP PUT request with a cart ID that you have generated. Update a cart with a PUT request using an existing cart ID.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PUT**|`/buy/carts/v2/{id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique identifier for the cart|string|**Required**|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

Other required request headers for this API are:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**x-nike-visitid**|Count of visits by the guest user||X||
|**appId**|Unique application identifier of the calling app||X||


#### Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|Shopping cart unique identifier (UUID), created by client|Required|
|**country**|string|ISO 3166-1 two letter country code, e.g. 'US'|Required|
|**brand**|string|Brand name associated with the cart|Required|
|**items**|array|List of items|Required|
|items.**id**|string|Shopping cart line item unique identifier, created by client. If the response contains errors, it will reference the identifier of the line item with the error|Required|
|items.**skuId**|string |Product SKU (Stock Keeping Unit) unique identifier|Required|
|items.**quantity**|integer|Unit quantity of the SKU|Required|
|items.**giftCard**|object|The gift card to be added to cart|Optional|
|items.giftCard.**amount**|number|Amount to be added to the purchased gift card|Required|
|items.**offer**|string|Item offer identifier|Optional|
|items.**priceInfo**|object|Object containing product pricing information|Optional|
|items.priceInfo.**price**|number|Retail cost|Required|
|items.priceInfo.**total**|number|The total price: retail price times quantity, less any discounts|Required|
|items.priceInfo.**currency**|string|Currency code following the ISO 4217 standard. Ex: US currency code is 'USD'|Optional|
|items.**recipient**|object|The person to which items are to be shipped. **Applies to physical gift cards**|Optional|
|items.recipient.**firstName**|string|First name of the person receiving the items. The name must be at least one character and non-whitespaces (e.g. " " is invalid)|Required|
|items.recipient.**lastName**|string|Last name of the person receiving the items. The name must be at least one character and non-whitespaces (e.g. " " is invalid).|Required|
|items.recipient.**altFirstName**|string|Alternate first name of the person receiving the items. This will typically be used in locales such as Japan where we support two versions of names.|Optional|
|items.recipient.**altLastName**|string|Alternate last name of the person receiving the items. This will typically be used in locales such as Japan where we support two versions of names.|Optional|
|items.recipient.**givenName**|string|Given name of the person receiving the items.|Optional|
|items.recipient.**middleInitial**|string|Middle initial of the person receiving the items.|Optional|
|items.recipient.**middleName**|string|Middle name of the person receiving the items.|Optional|
|items.**shippingAddress**|object|The address to which items are to be shipped. **Applies to physical gift cards**|Optional|
|items.shippingAddress.**country**|string|Shipping address country. 2-alpha character ISO 3166 country code.|Required|
|items.shippingAddress.**address1**|string|Shipping address line one.|Optional|
|items.shippingAddress.**address2**|string|Shipping address line two.|Optional|
|items.shippingAddress.**address3**|string|Shipping address line three.|Optional|
|items.shippingAddress.**city**|string|Shipping address city.|Optional|
|items.shippingAddress.**county**|string|Shipping address county.  This will typically be used for non-US addresses to hold specific regional data.|Optional|
|items.shippingAddress.**email**|string|Email address.|Optional|
|items.shippingAddress.**postalCode**|string|Shipping address postal code. In the US, this is the 5 digit or the 5 plus 4 digit zip code.|Optional|
|items.shippingAddress.**state**|string|Shipping address state. This should be the ISO 3166-2 subdivision code. For the US, this is the 2-alpha state code as defined in ISO 3166-2:US.|Optional|
|items.**valueAddedServices**|array|List of value-added services (VAS). Examples of VAS are a customization service for a shoe or a gift-wrapping service|Optional|
|items.valueAddedServices.**id**|string|VAS unique identifier.|Optional|
|**channel**|string|Sales channel of the shopping cart|Optional|
|links.**self**|object|Object containing self-link|Optional|
|links.self.**ref**|string|Link to this resource, itself|Required|
|**resourceType**|string|The type of resource the document is modeling|Optional|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>For the list of supported country code and currency code combinations, see [here](/doc/commerce/checkout/checkout_country_currency.html).
>
><i class="mr2-sm g72-check"></i>Use the same brand and channel values for all calls for a particular cart, else you will get a 409 Conflict error when the value varies from the initial PUT.
>
><i class="mr2-sm g72-check"></i>To retrieve VAS data to include in your checkout request, call the Merchandised Value Added Services endpoints of the Merchandised Products API. See the [Merchandised Products API Developer's Guide](/doc/commerce/product/api_merch_product.html) for more information.

Sample *Create or Update Cart by Cart ID* Request Body:

```
{
     "id": "61bc115b-16e5-43b5-bcaf-dd6168c543f8",
     "country": "US",
     "brand": "NIKE",
     "items": [
       {
         "id": "05398886-5d3d-548d-937d-953d239d3221",
         "skuId": "87849a71-8d0a-5d62-9dbe-c2662c049088",
         "quantity": 1
       }
     ]
}
```

#### Response Body

Some of the values in the response are exactly as sent in the request, but the values in the **totals** section provides a cart pricing summary and the **priceInfo** section provides the latest item pricing details.

Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|Shopping cart unique identifier|Required|
|**country**|string|2-alpha character ISO 3166 country code|Required|
|**currency**|string|Currency code following the ISO 4217 standard, e.g. US currency code is 'USD'|Required|
|**brand**|string|NIKE brand|Required|
|**promotionCodes**|array\<string\>||Optional|
|**channel**|string|Sales channel of the shopping cart|Optional|
|totals.**subtotal**|number|Subtotal of the item costs for all items|Required|
|totals.**valueAddedServicesTotal**|number|Total of value added services on the items|Required|
|totals.**discountTotal**|number|Total of all discounts applied to the cart|Required|
|totals.**total**|number|Total price of the entire item or cart, item costs less any discounts|Required|
|totals.**quantity**|integer|Cart quantity|Required|
|**items**|array|List of items|Required|
|items.**id**|string|Shopping cart item unique identifier|Required|
|items.**skuId**|string|Product Stock Keeping Unit (SKU) unique identifier|Required|
|items.**quantity**|integer|Line item quantity|Required|
|items.**giftCard**|object|The gift card to be added to cart|Optional|
|items.giftCard.**amount**|number|Amount to be added to the purchased gift card|Required|
|items.**offer**|string|The unique id (offer id) of the exclusive access offer|Optional|
|items.**priceInfo**|object||Optional|
|items.priceInfo.**price**|number|Price of the cart item|Required|
|items.priceInfo.**subtotal**|number|Item subtotal, the sku price multiplied by quantity|Required|
|items.priceInfo.**discount**|number|Item discount|Required|
|items.priceInfo.**valueAddedServices**|number|The total cost of the value added services for the item|Required|
|items.priceInfo.**total**|number|Total price of the item and value added services, less any discounts|Required|
|items.priceInfo.**priceSnapshotId**|string|The price's snapshot in time unique identifier|Required|
|items.priceInfo.**fullPrice**|number|fullPrice from merch price service v2|Optional|
|items.priceInfo.**msrp**|number|msrp price from merch price service v2|Optional|
|items.**recipient**|object|The person to which items are to be shipped. **Applies to physical gift cards**|Optional|
|items.recipient.**firstName**|string|First name of the person receiving the items. The name must be at least one character and non-whitespaces (e.g. " " is invalid)|Required|
|items.recipient.**lastName**|string|Last name of the person receiving the items. The name must be at least one character and non-whitespaces (e.g. " " is invalid).|Required|
|items.recipient.**altFirstName**|string|Alternate first name of the person receiving the items. This will typically be used in locales such as Japan where we support two versions of names.|Optional|
|items.recipient.**altLastName**|string|Alternate last name of the person receiving the items. This will typically be used in locales such as Japan where we support two versions of names.|Optional|
|items.recipient.**givenName**|string|Given name of the person receiving the items.|Optional|
|items.recipient.**middleInitial**|string|Middle initial of the person receiving the items.|Optional|
|items.recipient.**middleName**|string|Middle name of the person receiving the items.|Optional|
|items.**shippingAddress**|object|The address to which items are to be shipped. **Applies to physical gift cards**|Optional|
|items.shippingAddress.**country**|string|Shipping address country. 2-alpha character ISO 3166 country code.|Required|
|items.shippingAddress.**address1**|string|Shipping address line one.|Optional|
|items.shippingAddress.**address2**|string|Shipping address line two.|Optional|
|items.shippingAddress.**address3**|string|Shipping address line three.|Optional|
|items.shippingAddress.**city**|string|Shipping address city.|Optional|
|items.shippingAddress.**county**|string|Shipping address county.  This will typically be used for non-US addresses to hold specific regional data.|Optional|
|items.shippingAddress.**email**|string|Email address.|Optional|
|items.shippingAddress.**postalCode**|string|Shipping address postal code. In the US, this is the 5 digit or the 5 plus 4 digit zip code.|Optional|
|items.shippingAddress.**state**|string|Shipping address state. This should be the ISO 3166-2 subdivision code. For the US, this is the 2-alpha state code as defined in ISO 3166-2:US.|Optional|
|items.**valueAddedServices**|array|List of value added services|Optional|
|items.valueAddedServices.**id**|string|Value added service unique identifier|Required|
|items.valueAddedServices.instruction.**id**|string|Instruction unique identifier for the value added service, related to the various service domains.  Example would be a design id for Nike iD customization|Required|
|items.valueAddedServices.instruction.**type**|string|Instruction Type, e.g. customization/nike_id (only one currently available), customization/my_print, customization/gift_card, buy/gift_wrap, buy/gift_message|Required|
|items.valueAddedServices**priceInfo**|object|Object containing pricing information|Optional|
|items.valueAddedServices.priceInfo.**price**|number|Price of the value added service|Required|
|items.valueAddedServices.priceInfo.**discount**|number|Value added service discount|Required|
|items.valueAddedServices.priceInfo.**total**|number|Total price of the value added service, less any discounts|Required|
|items.valueAddedServices.priceInfo.**priceSnapshotId**|string|The price's snapshot in time unique identifier|Required|
|**errors**|array|List of errors in the cart|Optional|
|errors.**code**|string|Code for the error, text based, 'screaming snake-case', e.g. 'FIELD_INVALID'|Required|
|errors.**message**|string|Plain text description of the error|Required|
|errors.**field**|string|The field that has an error|Optional|
|**warnings**|array|List of warnings in the cart|Optional|
|warnings.**code**|string|Code for the warning, text based, 'screaming snake-case', e.g. 'PRICE_CHANGED'|Required|
|warnings.**message**|string|Plain text description of the warning|Required|
|warnings.**field**|string|The field that has an error|Optional|
|links.**self**|object|Object containing self-link|Optional|
|links.self.**ref**|string|Link to this resource, itself|Required|
|**resourceType**|string|The type of resource the document is modeling, e.g. 'cart'|Optional|

Sample *Create or Update Cart by Cart ID* response body without errors:

```
{
    "id": "61bc115b-16e5-43b5-bcaf-dd6168c543f8",
    "country": "US",
    "currency": "USD",
    "brand": "NIKE",
    "totals": {
        "subtotal": 200,
        "discountTotal": 0,
        "valueAddedServicesTotal": 0,
        "total": 200,
        "quantity": 1
    },
    "items": [
        {
            "id": "05398886-5d3d-548d-937d-953d239d3221",
            "skuId": "87849a71-8d0a-5d62-9dbe-c2662c049088",
            "quantity": 1,
            "priceInfo": {
                "price": 200,
                "subtotal": 200,
                "discount": 0,
                "valueAddedServices": 0,
                "total": 200,
                "priceSnapshotId": "04604d61-d5fc-4749-8380-8f720a93def0",
                "msrp": 200,
                "fullPrice": 200
            }
        }
    ],
    "links": {
        "self": {
            "ref": "/buy/carts/v2/61bc115b-16e5-43b5-bcaf-dd6168c543f8"
        }
    },
    "resourceType": "cart"
}
```

>**TIP:** Prices and subtotals are recalculated and returned in the response to each call.

### Modify a Cart by Cart ID

Create or update a cart by executing a HTTP PATCH request with a Cart ID. Add or remove a line item or promotion code from a user's cart, or to create or replace the entire cart contents.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PATCH**|`/buy/carts/v2/{id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique identifier for the cart|string|**Required**|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

Other required request headers for this API are:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**x-nike-visitid**|Count of visits by the guest user||X||
|**appId**|Unique application identifier of the calling app||X||

#### Request Body

The request must contain at least **ONE OF** the following schemas:

Element Name|Type|Description|Required?|
|---|---|---|---|
|**op**| string |Operation to perform, either 'add' or 'replace' is allowed|Required|
|**path**|string|JSON Pointer path, only ‘/items’ is allowed|Required|
|value.**id**|string|Shopping cart item unique identifier|Required|
|value.**skuId**|string|Product SKU unique identifier|Required|
|value.**quantity**|integer|Number of units to be purchased|Required|
|value.**offer**|string|Item offer identifier|Optional|
|value.**valueAddedServices**|array|List of value added services|Optional|
|value.valueAddedServices.**id** |string|Value added service unique identifier|Required|
|value.valueAddedServices.**instruction**|object|Line item to add, update or remove.|Optional|
|value.valueAddedServices.instruction.**id**|string|Instruction Id, (e.g. Metric Id, VAS UUID, Jersey Id, etc.)|Required|
|value.valueAddedServices.instruction.**type**|string|Instruction type|Required|

**OR**

Element Name|Type|Description|Required?|
|---|---|---|---|
|**op**|string |Operation to perform, only 'remove' is allowed|Required|
|**path**|string|JSON Pointer path, only ‘/items’ is allowed|Required|
|value.**id**|string|Shopping cart item unique identifier|Required|

**OR**

Element Name|Type|Description|Required?|
|---|---|---|---|
|**op**|string |Operation to perform, either 'add' or 'remove' is allowed|Required|
|**path**|string|JSON Pointer path, only '/promotionCodes' is allowed|Required|
|**value**|string|Promotion Code to add or remove|Required|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>You can include more than one patch operation in a request.
>
><i class="mr2-sm g72-check"></i>Sending "op": "remove" for a line item will delete the entire quantity previously added under that line item.

Sample *Modify a Cart by Cart ID* Request Body:

```
[
    {
      "op": "add",
      "path": "/items",
      "value": {
        "id": "e945e0fd-cdcf-4005-9fe4-9302b9d6235c",
        "skuId": "55b42896-dfc9-5e85-9d92-abd73c05cee5",
        "quantity": 1
    	}
    }
]
```

#### Response Body

Some of the values in the response are exactly as sent in the request, but the values in the **totals** section provides a cart pricing summary and the **priceInfo** section provides the latest item pricing details.

Sample *Modify a Cart by Cart ID* response body without errors:

```
{
    "id": "61bc115b-16e5-43b5-bcaf-dd6168c543f8",
    "country": "US",
    "currency": "USD",
    "brand": "NIKE",
    "totals": {
        "subtotal": 220,
        "discountTotal": 0,
        "valueAddedServicesTotal": 0,
        "total": 220,
        "quantity": 2
    },
    "items": [
        {
            "id": "e945e0fd-cdcf-4005-9fe4-9302b9d6235c",
            "skuId": "55b42896-dfc9-5e85-9d92-abd73c05cee5",
            "quantity": 1,
            "priceInfo": {
                "price": 110,
                "subtotal": 110,
                "discount": 0,
                "valueAddedServices": 0,
                "total": 110,
                "priceSnapshotId": "0e4b0318-c3b0-4cf8-a84f-4cae821c9a09",
                "msrp": 110,
                "fullPrice": 110
            }
        },
        {
            "id": "9992b8cb-e4ac-42af-a8bb-3454d8509d32",
            "skuId": "55b42896-dfc9-5e85-9d92-abd73c05cee5",
            "quantity": 1,
            "priceInfo": {
                "price": 110,
                "subtotal": 110,
                "discount": 0,
                "valueAddedServices": 0,
                "total": 110,
                "priceSnapshotId": "0e4b0318-c3b0-4cf8-a84f-4cae821c9a09",
                "msrp": 110,
                "fullPrice": 110
            }
        }
    ],
    "links": {
        "self": {
            "ref": "/buy/carts/v2/61bc115b-16e5-43b5-bcaf-dd6168c543f8"
        }
    },
    "resourceType": "cart"
}
```

### Delete All Items from a Cart by Cart ID

Delete all items in a cart by its ID and receive a HTTP 204 response if successful. Subsequent calls to GET that same cart ID will return a HTTP 404 status ('Not Found').

>**NOTE**: The delete operation is optional; carts will automatically purge from storage after 90 days of inactivity.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**DELETE**|`/buy/carts/v2/{id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique client-generated identifier for the cart|string|**Required**|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

Other required request headers for this API are:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**x-nike-visitid**|Count of visits by the guest user||X||
|**appId**|Unique application identifier of the calling app||X||

#### Request Body

There is no body on a DELETE request.

#### Response Body

The HTTP 204 response (successful delete) returns an empty response body.

### Get a Cart by Cart ID

Get the details of a cart using the Cart ID. The default HTTP 200 response includes a list of items in a cart with prices, quantities, discounts, value-added services, and totals.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/buy/carts/v2/{id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique client-generated identifier for the cart|string|**Required**|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

Other required request headers for this API are:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**x-nike-visitid**|Count of visits by the guest user||X||
|**appId**|Unique application identifier of the calling app||X||

#### Request Body

There is no body on a GET request.

#### Response Body

See the response body from the [*Create or Update Cart by Cart ID* endpoint](#cart-put-v2-response-body) as it is the same for this endpoint.

### Get a Cart by Filter Criteria (Query Param)

Retrieve a user's cart by **country**, **brand**, and (optionally) **channel** values sent as `?filter` query parameters. The default format of each cart in the HTTP 200 response is the same as doing a GET by ID.

>**TIP:** For more info on how to use `?filter`, see the query parameters section of [Using NDe APIs](/doc/getting-started/using_nike_apis.html#query-parameters).

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/buy/carts/v2?filter`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**filter**|Query|Values by which to limit the cart results * **country**: ISO 3166-1 [two-letter code](/doc/commerce/checkout/checkout_country_currency.html) **Required** * **brand**: Brand name, e.g. 'NIKE' **Required** * channel: Sales channel, optional|string|**Required**|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

Other required request headers for this API are:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**x-nike-visitid**|Count of visits by the guest user||X||
|**appId**|Unique application identifier of the calling app||X||

#### Request Body

There is no body on a GET request.

#### Response Body

See the response body from the [*Create or Update Cart by Cart ID*](#cart-put-v2-response-body) endpoint as it is the same for this endpoint.

### Create or Update a Cart by Filter Criteria

Create or update a cart by executing an HTTP PUT request with country, brand, and (optionally) channel path parameters included. The format of each cart in the HTTP 200 response is the same as doing a PUT by Cart ID.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PUT**|`/buy/carts/v2/{country}/{brand}/{channel}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**country**|Path|2-alpha character ISO 3166 country code|string|**Required**|
|**brand**|Path|Brand name of the shopping cart|string|**Required**|
|**channel**|Path|Sales channel of the shopping cart|string|**Required**|

#### Request Headers

See the required request headers of the [*Create or Update a Cart by Cart ID*](#cart-put-v2-request-headers) endpoint as it is the same for this endpoint.

#### Request Body

See the request body format and sample request of the [*Create or Update a Cart by Cart ID*](#cart-put-v2-request-body) endpoint as it is the same for this endpoint.

#### Response Body

See the response body format and sample response of the [*Create or Update a Cart by Cart ID*](#cart-put-v2-response-body) endpoint as it is the same for this endpoint.

### Modify a Cart by Filter Criteria

Create or update a cart by executing an HTTP PUT request with country, brand, and (optionally) channel path parameters included. The format of each cart in the HTTP 200 response is the same as doing a PUT by Cart ID.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PATCH**|`/buy/carts/v2/{country}/{brand}/{channel}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**country**|Path|2-alpha character ISO 3166 country code|string|**Required**|
|**brand**|Path|Brand name of the shopping cart|string|**Required**|
|**channel**|Path|Sales channel of the shopping cart|string|**Required**|

#### Request Headers

See the required request headers of the [*Modify a Cart by Cart ID*](#cart-patch-v2-request-headers) endpoint as it is the same for this endpoint.

#### Request Body

See the request body format and sample request of the [*Modify a Cart by Cart ID*](#cart-patch-v2-request-body) endpoint as it is the same for this endpoint.

#### Response Body

See the response body format and sample response of the [*Modify a Cart by Cart ID*](#cart-patch-v2-response-body) endpoint as it is the same for this endpoint.

### Get a Cart by Filter Criteria (Path Param)

Retrieve a user's cart by **country**, **brand**, and (optionally) **channel** values sent as path parameters. The default format of each cart in the HTTP 200 response is the same as doing a GET by ID.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/buy/carts/v2?filter`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**country**|Path|ISO 3166-1 [two-letter code](/doc/commerce/checkout/checkout_country_currency.html)|string|Required|
|**brand**|Path|Brand name, e.g. 'NIKE'|string|Required|
|**channel**|Path|Sales channel|string|Optional|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

Other required request headers for this API are:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**x-nike-visitid**|Count of visits by the guest user||X||
|**appId**|Unique application identifier of the calling app||X||

#### Request Body

There is no body on a GET request.

#### Response Body

See the response body from the [*Create or Update Cart by Cart ID*](#cart-put-v2-response-body) endpoint as it is the same for this endpoint.

### Delete All Items from a Cart by Filter Criteria

Delete all items in a cart by **country**, **brand**, and (optionally) **channel** values sent as path parameters and receive a HTTP 204 response if successful. Subsequent calls to GET that same cart ID will return a HTTP 404 status ('Not Found').

>**NOTE**: The delete operation is optional; carts will automatically purge from storage after 90 days of inactivity.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**DELETE**|`/buy/carts/v2/{id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique client-generated identifier for the cart|string|**Required**|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

Other required request headers for this API are:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**x-nike-visitid**|Count of visits by the guest user||X||
|**appId**|Unique application identifier of the calling app||X||

#### Request Body

There is no body on a DELETE request.

#### Response Body

The HTTP 204 response (successful delete) returns an empty response body.

### Carts v2 Error Handling

Following is a summary of the errors and warnings that can come back in responses from the Carts v2 API:

|HTTP Response Code|Relevant HTTP Method(s)|Error Code|Error Description|Action to Take|
|----|----|----|----|---|
|400|GET, PUT, PATCH|REQUEST_INVALID|Request was structurally invalid, such as malformed JSON.|Check the URL, syntax of the request body, or item quantity for validity.|
|400|PUT, PATCH|MISSING_REQUIRED|Required field(s) missing in the request (e.g. cart ID, country, brand, etc.|Retry the request while supplying the missing field/value|
|400|PUT, PATCH|INVALID_VALUE|Value of field(s) in the request not valid (e.g. >100 items, unsupported country code and/or brand, etc.).|Check the indicated field/value. Correct and retry|
|400|GET, PUT, PATCH|PRODUCT_NOT_BUYABLE|Item sku not 'buyable', either due to being inactive, being outside sell dates, or launch product purchase being attempted outside of launch.|Notify user as necessary|
|400|PUT, PATCH|ITEM_QUANTITY_LIMIT|Quantity limit (for single cart) exceeded for the item sku.|Notify the user as necessary|
|400|PUT, PATCH|INVALID_QUANTITY|The item total requested quantity was too high.||
|500|GET, PUT, PATCH, DELETE|SYSTEM_ERROR|Error occurred processing the request.||
|503|GET, PUT, PATCH, DELETE|N/A|Service unavailable||
|401|GET, PUT, PATCH, DELETE|35|The operation was requested by an unauthorized user.|Check that your access token was sent in **Authorization** request header in format `Bearer {token}` or that the token has not expired.|
|404|GET|N/A|The operation was not requested by the cart owner or ownership was not provided.|Check that the access token sent in the request header was for the correct user.|
|404|GET|N/A|Cart just created or cart has expired|If cart was just created, try GET again later or do a PUT. If cart was created > 180 days ago, create a new cart.|
|409|PUT, PATCH|N/A|Cart ID already exists and is associated with a different user ID, country or brand.|Choose a unique cartId and retry.|
|200|PUT, PATCH|VALUE_ADDED_SERVICE_INVALID|VAS associated with the item is invalid.||
|200|PUT, PATCH|VALUE_ADDED_SERVICE_SKU_COMBINATION_INVALID|The items on the cart is not a VAS item.||
|200|PUT, PATCH|EXCLUSIVE_OFFER_INVALID|OfferId used on the item is not valid.||
|200|PUT, PATCH|EXCLUSIVE_OFFER_PRODUCT_COMBINATION_INVALID|OfferId applied on on-exclusive access product.||
|200|PUT, PATCH|INTERNAL_ERROR|Error occurred while calling the exclusive access service for validating the offer.||
|200|PUT, PATCH|OUT_OF_STOCK|Item does not have available inventory.|Notify the user as necessary|
|200|PUT, PATCH|INVALID_GIFT_CARD_AMOUNT|Gift Card does not have a valid price amount.|Notify the user as necessary|
|200|GET, PUT, PATCH|PRICE_CHANGED|This is a *warning* only that the price of an item or value-added service has changed since the item was added to the cart.|Notify the user as necessary|

#### Example error response bodies:

1. Response for a request where the values in items.**id** (cart line item number) were not unique:
```
{
    "code": "REQUEST_INVALID",
    "message": "Bad Request",
    "errors": [
        {
            "code": "REQUEST_INVALID",
            "field": "/item/id",
            "message": "Item ids are not unique"
        }
    ]
}
```

2. Response for a request that included an invalid **country** value:
```
{
    "code": "CART_COUNTRY_INVALID",
    "message": "Bad Request"
}
```

3. Response for a request where the items.**quantity** value exceeded the allowed limit:
```
{
    "code": "ITEM_QUANTITY_LIMIT",
    "message": "Product item quantity limit exceeded. skuId=ef3222c4-5571-591f-b450-9f87a09df9e3, productId=2bff389a-59b9-5b86-9cbb-30b82f932b6e, itemQuantity=1,000, accumulatedQuantity=1,000, quantityLimit=10",
    "field": "/items/0/quantity"
}
```

4. Response for a request that included an invalid value (not a UUID) in items.**skuId**:
```
{
    "message": "Request validation failed",
    "errors": [
        {
            "field": "items..skuId",
            "code": "INVALID_VALUE",
            "message": "The field value is invalid"
        }
    ]
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/carts/browse/API.md?raw" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

## Using Cart Reviews

- [Cart Reviews Overview](#cart-reviews-overview)

- [Augment a Cart](#augment-a-cart)

- [Cart Reviews Error Handling](#cart-reviews-error-handling)

### Cart Reviews Overview

After the customer has provided a shipping address and chosen a shipping method, use this service to retrieve an enhanced cart summary before the customer proceeds to the checkout process. Use the Cart Reviews API in conjunction with the Carts API to achieve this.

Cart Reviews returns sales and shipping taxes, estimated delivery date(s), and shipping group information (when applicable), as well as item and subtotal information for a customer's cart.

>**TIP:** Shipping group refers to the grouping of items into multiple shipments with potentially different delivery dates. This is done automatically for you based on Nike business rules.

#### More Facts About Cart Reviews:

- To get sales tax and shipping tax, the request must include postal code.

- To get estimated delivery date(s), the request must include the shipping method(s) the shopper had selected.

- To get shipping group information, the request must include the shipping method and the shipping address associated with each item.

- Items with the same shipping address and same shipping method will be in the same shipping group. If two items have either a different shipping address or different shipping method, the two items will be in different shipping groups in the response.

- This API is ‘ephemeral’ in that it does not create a resource for later retrieval.

- Subsequent calls for a given cart may result in different responses if underlying tax or delivery estimate details have changed.

- Requests not having a fields parameter will return the complete cart reviews response content.

- The Cache-Control response header indicates that responses must not be cached and thus not used across multiple requests.

>**TIP:** It is a best practice to send all of the optional request headers and request body fields, if the data is available, to avoid unexpected responses.

The following section describes the endpoint of the Cart Reviews API in detail:

### Augment a Cart

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**POST**|`/buy/cart_reviews/v1`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|fields|Query|Fields to be included in the response (all fields included by default)|string|Optional|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

#### Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**country**|string|ISO 3166 country code, e.g. US|Required|
|**currency**|string|ISO 4217 currency code, e.g. USD|Required|
|**brand**|string|Nike brand name associated with the cart, only NIKE is supported|Required|
|**items**|array|Array containing list of item objects, with the following required fields:|Required|
|items.**id**|string|Unique identifier of the line item in the request. You create this value.|Required|
|items.**skuId**|string|Stock Keeping Unit (SKU) unique identifier of the product, as obtained from Nike Product services.|Required|
|items.**quantity**|integer|Unit quantity of the SKU.|Required|
|items.**shippingAddress**|object|Address to which items are to be shipped. Only the following field is required:|Required|
|items.shippingAddress.**country**|string|Shipping address country. 2-alpha character ISO 3166 country code.|Required|
|**channel**|string|Sales channel of the shopping cart, only 'NIKECOM' is supported. Located at top level of request.|Optional|
|**shippingMethod**|object|The method by which the item will be shipped. Located under **items** array. Only the following field is required:|Optional|
|shippingMethod.**id**|string|The identifier for the shipping method, e.g. 'STANDARD' for standard ground shipping in the US.|Optional|
|**valueAddedServices**|array|List of value-added service (VAS) line items. One or more VAS line items can be associated with a Nike product (i.e. **skuId**). Examples of VAS are a customization service for a shoe or a gift-wrapping service.|Optional|
|valueAddedServices.**id**|string|Unique identifier for the VAS. In nested **Instruction** object, the following are required:|Optional|
|valueAddedServices.Instruction.**id**|string|Instruction unique identifier for the value-added service, related to the various service domains, e.g. design id for Nike iD customization.|Optional|
|valueAddedServices.Instruction.**type**|string|Instruction Type, e.g. customization/nike_id (only one currently available), customization/my_print, customization/gift_card, buy/gift_wrap, buy/gift_message.|Optional|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>For the list of supported country code and currency code combinations, see [here](/doc/commerce/checkout/checkout_country_currency.html).
>
><i class="mr2-sm g72-check"></i>Use the same brand and channel values for all calls for a particular cart, else you will get a 409 Conflict error when the value varies from the initial PUT.
>
><i class="mr2-sm g72-check"></i>Although optional, send the postalCode in the shippingAddress in addition to the required country code. If so, the sales tax will be returned in items.priceInfo.tax and shipping tax will be returned in items.shippingCosts.priceInfo.tax.
>
><i class="mr2-sm g72-check"></i>Although optional, if you send a valid shippingMethod in the request, the net shipping cost for the item will be returned in shippingCosts.priceInfo.total. If you also send a valid postalCode in the shippingAddress, the shipping tax for the item will be returned in shippingCosts.priceInfo.tax and also in shippingCosts.taxes.total.
>
><i class="mr2-sm g72-check"></i>To retrieve VAS data to include in your checkout request, call the Merchandised Value Added Services endpoints of the Merchandised Products API. See the [Merchandised Products API Developer's Guide](/doc/commerce/product/api_merch_product.html) for more information.

Sample *Cart Reviews* request body:

```
{
  "country": "US",
  "currency": "USD",
  "brand": "NIKE",
  "channel": "NIKECOM",
  "items": [
    {
      "id": "9892b8cb-e4ac-42af-a8bb-3454d8509d32",
      "skuId": "d3d15345-63e6-4cf9-9135-c2beacbbe352",
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
      "shippingMethod": {
        "id": "STANDARD"
      },
      "shippingAddress": {
        "city": "Beaverton",
        "state": "OR",
        "postalCode": "97006",
        "country": "US",
        "county": "Washington"
      }
    },
    {
      "id": "e945e0fd-cdcf-4005-9fe4-9302b9d6235c",
      "skuId": "f030bb22-4859-404e-82c9-aa9a23582e4f",
      "quantity": 1,
      "shippingMethod": {
        "id": "STANDARD"
      },
      "shippingAddress": {
        "city": "Beaverton",
        "state": "OR",
        "postalCode": "97006",
        "country": "US",
        "county": "Washington"
      }
    }
  ]
}
```

#### Response Body

Sample *Cart Reviews* response body:

```
{
  "resourceType": "buy/cart_reviews",
  "country": "US",
  "currency": "USD",
  "brand": "NIKE",
  "channel": "NIKECOM",
  "shippingGroups": [
    {
      "items": [
        {
          "id": "9892b8cb-e4ac-42af-a8bb-3454d8509d32",
          "skuId": "d3d15345-63e6-4cf9-9135-c2beacbbe352",
          "quantity": 1,
          "priceInfo": {
            "price": 200,
            "subtotal": 200,
            "discount": 0,
            "valueAddedServices": 0,
            "total": 200
          },
          "valueAddedServices": [
            {
              "id": "88d0475d-30e5-4c2f-9a87-7a31938f8ace",
              "instruction": {
                "id": "2027261230",
                "type": "customization/nike_id"
              },
              "priceInfo": {
                "price": 0,
                "subtotal": 0,
                "discount": 0,
                "valueAddedServices": 0,
                "total": 0
              }
            }
          ],
          "taxes": [
            {
              "type": "SALESTAX",
              "rate": 10,
              "total": 20
            }
          ]
        },
        {
          "id": "e945e0fd-cdcf-4005-9fe4-9302b9d6235c",
          "skuId": "f030bb22-4859-404e-82c9-aa9a23582e4f",
          "quantity": 1,
          "priceInfo": {
            "price": 75,
            "subtotal": 75,
            "discount": 0,
            "valueAddedServices": 0,
            "total": 75
          },
          "taxes": [
            {
              "type": "SALESTAX",
              "rate": 10,
              "total": 7.5
            }
          ]
        }
      ],
      "shippingMethod": {
        "id": "STANDARD",
        "estimatedDelivery": "2016-02-09T00:00:00.000-08:00"
      },
      "shippingAddress": {
        "city": "Beaverton",
        "state": "OR",
        "postalCode": "97006",
        "country": "US",
        "county": "Washington"
      },
      "shippingCosts": {
        "priceInfo": {
          "price": 8,
          "discount": 8,
          "total": 0,
          "taxTotal": 0
        },
        "taxes": [
          {
            "type": "SHIPPINGTAX",
            "rate": 10,
            "total": 0
          }
        ]
      }
    }
  ],
  "totals": {
    "subtotal": 275,
    "valueAddedServicesTotal": 0,
    "shippingTotal": 0,
    "discountTotal": 0,
    "total": 275
  }
}
```

### Cart Reviews Error Handling

Following is a summary of the errors and warnings that can come back in responses from the Cart Reviews API:

|HTTP Response Code|Relevant HTTP Method(s)|Error Code|Error Description|Action to Take|
|----|----|----|----|---|
|400|POST|MISSING_REQUIRED|A required field or fields in the request was missing. Examples include not providing cart ID, country, brand etc.|Retry the request while supplying the missing field/value|
|400|POST|INVALID_FIELD|The value of a field or fields in the request was not valid. Examples include providing too many items, country code and/or brand not supported, etc.|Check the indicated field/value. Correct and retry|
|400|POST|INVALID_SKU|Item SKU not found or not valid for the country.|Check the skuId. Correct and retry.|
|401|POST|35|The operation was requested by an unauthorized user.|Check that your access token was sent in **Authorization** request header in format `Bearer {token}` or that the token has not expired.|
|404|POST|310|The resource you requested does not exist.|Check the URL. Adjust as necessary and retry|
|500|POST|n/a|Request was structurally invalid, such as malformed JSON.|Check the syntax of the request body, or item quantity for validity.|
|500|POST|Server error|Error occurred processing the request.|Bad shipping method? skuId isn't in UUID format? Line item id not in UUID format?|

#### Example error response bodies:

1. Response for a request that included an invalid skuId:
```
{
    "httpStatus": 400,
    "timestamp": 1500926608289,
    "message": "Bad Request",
    "errors": [
        {
            "code": "INVALID_SKU",
            "field": "sku.id",
            "message": "Invalid skuId"
        }
    ]
}
```

2. Response for a request that included a skuId which was not in UUID format:
```
{
    "httpStatus": 500,
    "timestamp": 1500926568225,
    "service": "cartreviews",
    "message": "Server error"
}
```

3. Response for a request that included an id (line item identifier) which was not in UUID format:
```
{
    "httpStatus": 500,
    "timestamp": 1500924543763,
    "service": "cartreviews",
    "message": "Server error"
}
```

4. Response for a request sent to an incorrect URL
```
{
    "error_id": "fa494ed5-7144-4771-9e11-dc7a86500ab5",
    "errors": [
        {
            "code": 310,
            "message": "The resource you requested does not exist."
        }
    ]
}
```

5. Response for a request that included a line item ID which was not unique:
```
{
    "httpStatus": 400,
    "timestamp": 1500925852389,
    "message": "Bad Request",
    "errors": [
        {
            "code": "INVALID_REQUEST",
            "field": "/item/id",
            "message": "Item ids are not unique"
        }
    ]
}
```

6. Response for a request that was missing the required field 'country':
```
{
    "httpStatus": 400,
    "timestamp": 1500924336435,
    "message": "Bad Request",
    "errors": [
        {
            "code": "MISSING_REQUIRED",
            "field": "country",
            "message": "Required field"
        }
    ]
```

7. Response for a request that included an invalid country code:
```
{
    "httpStatus": 400,
    "timestamp": 1500924180370,
    "message": "Bad Request",
    "errors": [
        {
            "code": "INVALID_FIELD",
            "field": "country",
            "message": "Invalid field"
        }
    ]
```

8. Response for a request that had multiple errors:
```
{
    "httpStatus": 400,
    "timestamp": 1500928588847,
    "message": "Bad Request",
    "errors": [
        {
            "code": "INVALID_REQUEST",
            "field": "brand",
            "message": "Invalid value for the field"
        },
        {
            "code": "INVALID_REQUEST",
            "field": "/item/id",
            "message": "Item ids are not unique"
        }
    ]
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLORD/repos/v2-order-api/browse/cartreviews/API.md?raw#!/Cart_Reviews/post_buy_cart_reviews_v1" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

## Using Wish Lists

Manage a Nike member/employee's Wish Lists using the Wish Lists API.

- [Wish Lists Overview](#wish-lists-overview)

- [Create or Update a List](#create-or-update-a-list)

- [Delete a List](#delete-a-list)

- [Retrieve a List by ID](#retrieve-a-list-by-id)

- [Retrieve Lists for Authenticated User](#retrieve-lists-for-authenticated-user)

- [Add Item to List](#add-item-to-list)

- [Remove Item from List](#remove-item-from-list)

- [Retrieve Items by List](#retrieve-items-by-list)

- [Retrieve Item by ID](#retrieve-item-by-id)

### Wish Lists Overview

The Wish Lists API allows Nike members and employees to save lists of products to consider for purchase.

Features:

- Store unlimited Wish Lists per user
- Get product pricing and availability for items added to the list
- Create, read, update and delete support
- Pagination support
- Member and employee support only. **Guest users may not save Wish Lists**

#### Life Cycle of Wish List

![](/images/commerce/buy/wishlists_flow.png){:width="70%"}

### Create or Update a List

Create or update header-level information for a Wish List using this endpoint.

- Only **header-level** info, such as the list identifier and name, can be created with this endpoint. Use the other endpoints to add or remove items from a list.
- List name must be unique within a user's lists for a given country.
- Updating lists is currently limited to changing the list name only.

>TIP: You generate the unique list and list item identifiers and send them in the request in UUID format. See individual endpoint sections for details.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PUT**|`/buy/lists/v1/{id}{?fields}`|No|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|List identifier, **client-generated UUID**|String|**Required**|
|**fields**|Query|Filter the fields returned in the response. When not provided, the response will include all list contents.|String|Optional|

#### Request Headers

|Header Name|Description|
|---|---|
|**Content-Type**|Content type of the request, application/json is only value allowed|
|**Authorization**|Your access token in the format of `Bearer {token}` indicating the customer is logged in|

#### Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|List UUID assigned by the client|Required|
|**country**|string|2-alpha character ISO 3166 country code, e.g. 'US'|Required|
|**name**|string|Name of the list|Required|
|**brand**|string|Brand associated with the list, only 'NIKE' is allowed|Required|
|**channel**|string|Sales channel of the list, only 'NIKECOM' is allowed|Optional|
|**isPublic**|boolean|Specifies if the list is viewable by guests|Optional|
|**isPublished**|boolean|Specifies if the list is viewable|Optional|

Sample *Create or Update a List* request URI:
```
https://www.api.nike.com/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057
```

Sample *Create or Update a List* request body:
```
{
    "id": "93a333a2-907b-46f1-b9ac-469489909057",
    "country": "US",
    "name": "Winter Running",
    "brand": "NIKE"
}

```

#### Response Body

Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|List UUID assigned by the client|Required|
|**country**|string|2-alpha character ISO 3166 country code, e.g. 'US'|Required|
|**name**|string|Name of the list|Required|
|**brand**|string|Brand associated with the list, only 'NIKE' is allowed|Required|
|**channel**|string|Sales channel of the list, only 'NIKECOM' is allowed|Optional|
|**isPublic**|boolean|Specifies if the list is viewable by guests|Optional|
|**isPublished**|boolean|Specifies if the list is viewable|Optional|
|**modificationDate**|string|ISO 8601 of the date when the resource was last updated, added or removed from|Optional|
|links.**self**|object|Object containing self-link|Optional|
|links.self.**ref**|string|Link to this resource, itself|Required|

Sample *Create or Update a List* 200 response:
```
{
    "id": "93a333a2-907b-46f1-b9ac-469489909057",
    "country": "US",
    "name": "Winter Running",
    "brand": "NIKE",
    "modificationDate": "2016-11-29T22:52:12.132Z",
    "links": {
      "self": {
        "ref": "/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057"
      }
    }
}
```

Sample *Create or Update a List* 400 response:
```
{
    "message": "Validation Failed",
    "errors": [
      {
        "field":"/country",
        "code":"FIELD_INVALID",
        "message": "Invalid country"
      }
    ]
}
```

### Delete a List

Delete a Wish List using this endpoint. Note that **all** of the items on the list will be removed.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**DELETE**|`/buy/lists/v1/{id}`|No|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|List identifier, **client-generated UUID**|String|**Required**|

#### Request Headers

|Header Name|Description|
|---|---|
|**Content-Type**|Content type of the request, application/json is only value allowed|
|**Authorization**|Your access token in the format of `Bearer {token}` indicating the customer is logged in|

#### Request Body

There is no request body for a DELETE request.

Sample *Delete a List* request URI:
```
https://www.api.nike.com/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057
```

#### Response Body

There is no response body for a successful HTTP response to a DELETE request.

### Retrieve a List by ID

Call this endpoint to retrieve header info for a single list using the list identifier that you previously created. The list items are **not** included in the response. To get the list items, separately call the *Retrieve Items by List* endpoint with the appropriate list identifier.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/buy/lists/v1/{id}{?fields}`|No|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|List identifier, **client-generated UUID**|String|**Required**|
|**fields**|Query|Filter the fields returned in the response. When not provided, the response will include all list contents.|String|Optional|

#### Request Headers

|Header Name|Description|
|---|---|
|**Content-Type**|Content type of the request, application/json is only value allowed|
|**Authorization**|Your access token in the format of `Bearer {token}` indicating the customer is logged in|

#### Request Body

There is no request body on a GET request.

Sample *Retrieve a List by ID* request URI:
```
https://www.api.nike.com/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057
```

#### Response Body

Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|List UUID assigned by the client|Required|
|**country**|string|2-alpha character ISO 3166 country code, e.g. 'US'|Required|
|**name**|string|Name of the list|Required|
|**brand**|string|Brand associated with the list, only 'NIKE' is allowed|Required|
|**channel**|string|Sales channel of the list, only 'NIKECOM' is allowed|Optional|
|**isPublic**|boolean|Specifies if the list is viewable by guests|Optional|
|**isPublished**|boolean|Specifies if the list is viewable|Optional|
|**modificationDate**|string|ISO 8601 of the date when the resource was last updated, added or removed from|Optional|
|links.**self**|object|Object containing self-link|Optional|
|links.self.**ref**|string|Link to this resource, itself|Required|

Sample *Retrieve a List by ID* 200 response:
```
{
    "id": "93a333a2-907b-46f1-b9ac-469489909057",
    "country": "US",
    "name": "Winter Running",
    "brand": "NIKE",
    "modificationDate": "2016-11-29T22:52:12.132Z",
    "links": {
      "self": {
        "ref": "/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057"
      }
    }
}
```

### Retrieve Lists for Authenticated User

Retrieve header info for all lists for a single authenticated user with this endpoint. The list items are **not** included in the response. To get the list items, separately call the *Retrieve Items by List* endpoint with the appropriate list identifier.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/buy/lists/v1{?filter,fields}`|No|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**filter**|Query|Limit the results to those matching the specified filters: **country** (string, required) - ISO 3166 country code(s)<br>name (string, optional) - List name|String|**Required**|
|**fields**|Query|Filter the fields returned in the response. When not provided, the response will include all list contents.|String|Optional|

#### Request Headers

|Header Name|Description|
|---|---|
|**Content-Type**|Content type of the request, application/json is only value allowed|
|**Authorization**|Your access token in the format of `Bearer {token}` indicating the customer is logged in|

#### Request Body

There is no request body on a GET request.

Sample *Retrieve Lists for Authenticated User* request URI:
```
https://www.api.nike.com/buy/lists/v1?filter=country(US)
```

#### Response Body

Element Name|Type|Description|Required?|
|---|---|---|---|
|**objects**|object|List resources|Required|
|objects.**id**|string|List UUID assigned by the client|Required|
|objects.**country**|string|2-alpha character ISO 3166 country code, e.g. 'US'|Required|
|objects.**name**|string|Name of the list|Required|
|objects.**brand**|string|Brand associated with the list, only 'NIKE' is allowed|Required|
|objects.**channel**|string|Sales channel of the list, only 'NIKECOM' is allowed|Optional|
|objects.**isPublic**|boolean|Specifies if the list is viewable by guests|Optional|
|objects.**isPublished**|boolean|Specifies if the list is viewable|Optional|
|objects.**modificationDate**|string|ISO 8601 of the date when the resource was last updated, added or removed from|Optional|
|objects.links.**self**|object|Object containing self-link|Optional|
|objects.links.self.**ref**|string|Link to this resource, itself|Required|

Sample *Retrieve Lists for Authenticated User* 200 response:
```
{
    "objects": [
      {
        "id": "93a333a2-907b-46f1-b9ac-469489909057",
        "country": "US",
        "name": "Winter Running",
        "brand": "NIKE",
        "modificationDate": "2016-11-29T22:52:12.132Z",
        "links": {
          "self": {
            "ref": "/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057"
          }
        }
      },
      {
        "id": "7b1d5327-58e6-054f-8492-60150b8caafb",
        "country": "US",
        "name": "Summer Basketball",
        "brand": "NIKE",
        "modificationDate": "2016-11-29T22:52:12.132Z",
        "links": {
          "self": {
            "ref": "/buy/lists/v1/7b1d5327-58e6-054f-8492-60150b8caafb"
          }
        }
      }
    ]
}
```

Sample *Retrieve Lists for Authenticated User* 400 response:
```
{
        "message": "Validation Failed",
        "errors": [
          {
            "field": "filter",
            "code": "QUERY_PARAMETER_INVALID",
            "message": "Invalid filter"
          }
        ]
      }
```

### Add Item to List

Add an item to an existing list using the list identifier and get current product pricing in the response.

- If you add an item that is already on the list, the item will be replaced.
- Only the item being added are included in the response, not all items in the list.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PUT**|`/buy/list_items/v1/{id}{?fields}`|No|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|List identifier, **client-generated UUID**|String|**Required**|
|**fields**|Query|Filter the fields returned in the response. When not provided, the response will include all list contents.|String|Optional|

#### Request Headers

|Header Name|Description|
|---|---|
|**Content-Type**|Content type of the request, application/json is only value allowed|
|**Authorization**|Your access token in the format of `Bearer {token}` indicating the customer is logged in|

#### Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|List item UUID assigned by the client|Required|
|**wishlistId**|string|List UUID assigned by the client|Required|
|**skuId**|string|SKU UUID from the merchandising services|Optional|
|**productId**|string|Product UUID from the merchandising services|Optional|
|**country**|string|Country code to use when looking up price for the item. Overrides the country of the parent list|Optional|
|**valueAddedServices**|array|The value-added services to apply to the purchased SKU. Examples are gift wrap, personalization and customization|Optional|
|valueAddedServices.**id**|string|UUID of the value-added service|Optional|
|valueAddedServices.**instruction**|string|Further information about the value-added service. Systems can derive instructions, bill of materials, etc from the referenced resource|Optional|
|valueAddedServices.instruction.**id**|string|Instruction identifier|Optional|
|valueAddedServices.instruction.**type**|string|Instruction type, e.g. NIKEiD (only one currently available), Gift Wrap|Optional|

Sample *Add Item to List* request URI:
```
https://www.api.nike.com/buy/list_items/v1/93a333a2-907b-46f1-b9ac-469489909057
```

Sample *Add Item to List* request body:
```
{
    "id": "bf69a7c9-55c5-f643-ffb1-c6f1eaadde21",
    "wishlistId": "93a333a2-907b-46f1-b9ac-469489909057",
    "productId": "82ec699b-7855-7a29-1a94-6a1eaf2807d1",
    "valueAddedServices": [
      {
        "id": "1905b205-0908-4f8e-a716-7b1695c38995",
        "instruction": {
          "id": "0123456789",
          "type": "NIKEID"
        }
      }
    ]
}
```

#### Response Body

Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|List item UUID assigned by the client|Required|
|**wishlistId**|string|List UUID assigned by the client|Required|
|**skuId**|string|SKU UUID from the merchandising services|Optional|
|**productId**|string|Product UUID from the merchandising services|Optional|
|**country**|string|Country code to use when looking up price for the item. Overrides the country of the parent list|Optional|
|**valueAddedServices**|array|The value-added services to apply to the purchased SKU. Examples are gift wrap, personalization and customization|Optional|
|valueAddedServices.**id**|string|UUID of the value-added service|Optional|
|valueAddedServices.**instruction**|string|Further information about the value-added service. Systems can derive instructions, bill of materials, etc from the referenced resource|Optional|
|valueAddedServices.instruction.**id**|string|Instruction identifier|Optional|
|valueAddedServices.instruction.**type**|string|Instruction type, e.g. NIKEiD (only one currently available), Gift Wrap|Optional|
|**msrp**|string|Suggested retail price of the product|Optional|
|**currentPrice**|string|Current price of the product|Optional|
|**fullPrice**|string|Full price of the product|Optional|
|**employeePrice**|string|Employee price of the product|Optional|
|**currency**|string|Currency of the product prices|Optional|
|**creationDate**|string|ISO 8601 of the date when the resource was created|Optional|
|links.**self**|object|Object containing self-link|Optional|
|links.self.**ref**|string|Link to this resource, itself|Required|
|**error**|object|Error information|Optional|
|error.**field**|string|JSON Pointer to the erroneous field|Required|
|error.**code**|string|Error code for the error, text-based, 'screaming snake-case', one of "INVALID_FIELD", "UNAVAILABLE", "NOT_FOUND"|Required|

Sample *Add Item to List* 200 response:
```
{
    "id": "bf69a7c9-55c5-f643-ffb1-c6f1eaadde21",
    "wishlistId": "93a333a2-907b-46f1-b9ac-469489909057",
    "productId": "a05846b0-fef4-e113-94dc-7bad08547709",
    "country": "US",
    "msrp": 34.22,
    "currentPrice": 34.22,
    "fullPrice": 34.22,
    "employeePrice": 34.22,
    "currency": "USD",
    "creationDate": "2016-11-29T22:52:12.132Z",
    "links": {
      "self": {
        "ref": "/buy/list_items/v1/bf69a7c9-55c5-f643-ffb1-c6f1eaadde21"
      }
    },
    "error": {
      "field": "/productId",
      "code": "UNAVAILABLE"
    }
}
```

Sample *Add Item to List* 400 response:
```
{
    "message": "Validation Failed",
    "errors": [
      {
        "field":"/country",
        "code":"FIELD_INVALID",
        "message": "Invalid country"
      }
    ]
}
```

### Remove Item from List

Delete a single item from a list using the list **item** identifier that you previously created, and get a HTTP 200 response if successful.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**DELETE**|`/buy/list_items/v1/{id}`|No|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|List item identifier, **client-generated UUID**|String|**Required**|

#### Request Headers

|Header Name|Description|
|---|---|
|**Content-Type**|Content type of the request, application/json is only value allowed|
|**Authorization**|Your access token in the format of `Bearer {token}` indicating the customer is logged in|

#### Request Body

There is no request body on a DELETE request.

Sample *Remove Item from List* request URI:

```
https://www.api.nike.com/buy/list_items/v1/93a333a2-907b-46f1-b9ac-469489909057
```

#### Response Body

There is no response body for a successful HTTP response to a DELETE request.

### Retrieve Items by List

Retrieve all items in a list by its list identifier, which you previously created. Add optional filter, sort, count, or anchor criteria query parameters to further manipulate the data in the response.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/buy/list_items/v1{?filter, anchor, count, fields, sort}`|No|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**filter**|Query|Limit the results to those matching the specified filters: **wishlistId** (required), List identifier, e.g. `93a333a2-907b-46f1-b9ac-469489909057`|String|Required|
|**anchor**|Query|Return elements after this anchor|String|Optional|
|**count**|Query|Number of items to return per response|String|Optional|
|**fields**|Query|Filter the fields returned in the response. When not provided, the response will include all list item contents.|String|Optional|
|**sort**|Query|To sort the items in the list, indicate the field to be sorted on along with the sort order(field+order)|String|Optional|

#### Request Headers

|Header Name|Description|
|---|---|
|**Content-Type**|Content type of the request, application/json is only value allowed|
|**Authorization**|Your access token in the format of `Bearer {token}` indicating the customer is logged in|

#### Request Body

There is no request body for a GET request.

Sample *Retrieve Items by List* request URI:
```
https://www.api.nike.com/buy/list_items/v1?filter=wishlistId(3ebf8798-2c86-4e29-a67b-7435ebad62af)
```

#### Response Body

Element Name|Type|Description|Required?|
|---|---|---|---|
|**pages**|object|Pagination links|Optional|
|pages.**prev**|string|Link to previous set of results|Optional|
|pages.**next**|string|Link to next set of results|Optional|
|**objects**|array|List item resources|Required|
|objects.**id**|string|List item UUID assigned by the client|Required|
|objects.**wishlistId**|string|List UUID assigned by the client|Required|
|objects.**skuId**|string|SKU UUID from the merchandising services|Optional|
|objects.**productId**|string|Product UUID from the merchandising services|Optional|
|objects.**country**|string|Country code to use when looking up price for the item. Overrides the country of the parent list|Optional|
|objects.**valueAddedServices**|array|The value-added services to apply to the purchased SKU. Examples are gift wrap, personalization and customization|Optional|
|objects.valueAddedServices.**id**|string|UUID of the value-added service|Optional|
|objects.valueAddedServices.**instruction**|string|Further information about the value-added service. Systems can derive instructions, bill of materials, etc from the referenced resource|Optional|
|objects.valueAddedServices.instruction.**id**|string|Instruction identifier|Optional|
|objects.valueAddedServices.instruction.**type**|string|Instruction type, e.g. NIKEiD (only one currently available), Gift Wrap|Optional|
|objects.**msrp**|string|Suggested retail price of the product|Optional|
|objects.**currentPrice**|string|Current price of the product|Optional|
|objects.**fullPrice**|string|Full price of the product|Optional|
|objects.**employeePrice**|string|Employee price of the product|Optional|
|objects.**currency**|string|Currency of the product prices|Optional|
|objects.**isAvailable**|boolean|Indicates if the product is available|Optional|
|objects.**creationDate**|string|ISO 8601 of the date when the resource was created|Optional|
|objects.**isCurrentPriceChanged**|boolean|Indicates if currentPrice has changed since the item was saved|Optional|
|objects.links.**self**|object|Object containing self-link|Required|
|objects.links.self.**ref**|string|Link to this resource, itself|Required|
|objects.**error**|object|Error information|Optional|
|objects.error.**field**|string|JSON Pointer to the erroneous field|Required|
|objects.error.**code**|string|Error code for the error, text-based, 'screaming snake-case', one of "INVALID_FIELD", "UNAVAILABLE", "NOT_FOUND"|Required|

Sample *Retrieve Items by List* 200 response:
```
{
    "pages": {
      "prev": "/buy/list_items/v1?filter=wishlistId(93a333a2-907b-46f1-b9ac-469489909057)&anchor=0&count=25",
      "next": "/buy/list_items/v1?filter=wishlistId(93a333a2-907b-46f1-b9ac-469489909057)&anchor=2&count=25"
    },
    "objects": [
      {
        "id": "bf69a7c9-55c5-f643-ffb1-c6f1eaadde21",
        "wishlistId": "93a333a2-907b-46f1-b9ac-469489909057",
        "productId": "a05846b0-fef4-e113-94dc-7bad08547709",
        "country": "US",
        "msrp": 34.22,
        "currentPrice": 34.22,
        "fullPrice": 34.22,
        "employeePrice": 34.22,
        "currency": "USD",
        "creationDate": "2016-11-29T22:52:12.132Z",
        "links": {
          "self": {
            "ref": "/buy/list_items/v1/bf69a7c9-55c5-f643-ffb1-c6f1eaadde21"
          }
        },
        "error": {
          "field": "/productId",
          "code": "UNAVAILABLE"
        }
      },
      {
        "id": "189d2970-3d3b-854e-03c2-843c55789f48",
        "wishlistId": "93a333a2-907b-46f1-b9ac-469489909057",
        "productId": "82ec699b-7855-7a29-1a94-6a1eaf2807d1",
        "country": "US",
        "valueAddedServices": [
          {
            "id": "1905b205-0908-4f8e-a716-7b1695c38995",
            "instruction": {
              "id": "0123456789",
              "type": "NIKEID"
            }
          }
        ],
        "msrp": 99.49,
        "currentPrice": 99.49,
        "fullPrice": 99.49,
        "employeePrice": 99.49,
        "currency": "USD",
        "creationDate": "2016-11-29T22:52:12.132Z",
        "links": {
          "self": {
            "ref": "/buy/list_items/v1/189d2970-3d3b-854e-03c2-843c55789f48"
          }
        },
        "error": {
          "field": "/valueAddedServices/0/id",
          "code": "UNAVAILABLE"
        }
      }
    ]
}
```

Sample *Retrieve Items from List* 400 response:
```
{
    "message": "Validation Failed",
    "errors": [
      {
        "field": "filter",
        "code": "QUERY_PARAMETER_INVALID",
        "message": "Invalid filter"
      }
    ]
}
```

### Retrieve Item by ID

Retrieve a list item by the list item identifier that you previously created.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/buy/list_items/v1/{id}{?fields}`|No|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|List identifier, **client-generated UUID**|String|**Required**|
|**fields**|Query|Filter the fields returned in the response. When not provided, the response will include all list contents.|String|Optional|

#### Request Headers

|Header Name|Description|
|---|---|
|**Content-Type**|Content type of the request, application/json is only value allowed|
|**Authorization**|Your access token in the format of `Bearer {token}` indicating the customer is logged in|

#### Request Body

There is no request body for a GET request.

Sample *Retrieve Item by ID* request URI:
```
https://www.api.nike.com/buy/list_items/v1/93a333a2-907b-46f1-b9ac-469489909057
```

#### Response Body

Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|List item UUID assigned by the client|Required|
|**wishlistId**|string|List UUID assigned by the client|Required|
|**skuId**|string|SKU UUID from the merchandising services|Optional|
|**productId**|string|Product UUID from the merchandising services|Optional|
|**country**|string|Country code to use when looking up price for the item. Overrides the country of the parent list|Optional|
|**valueAddedServices**|array|The value-added services to apply to the purchased SKU. Examples are gift wrap, personalization and customization|Optional|
|valueAddedServices.**id**|string|UUID of the value-added service|Optional|
|valueAddedServices.**instruction**|string|Further information about the value-added service. Systems can derive instructions, bill of materials, etc from the referenced resource|Optional|
|valueAddedServices.instruction.**id**|string|Instruction identifier|Optional|
|valueAddedServices.instruction.**type**|string|Instruction type, e.g. NIKEiD (only one currently available), Gift Wrap|Optional|
|**msrp**|string|Suggested retail price of the product|Optional|
|**currentPrice**|string|Current price of the product|Optional|
|**fullPrice**|string|Full price of the product|Optional|
|**employeePrice**|string|Employee price of the product|Optional|
|**currency**|string|Currency of the product prices|Optional|
|**isAvailable**|boolean|Indicates if the product is available|Optional|
|**creationDate**|string|ISO 8601 of the date when the resource was created|Optional|
|**isCurrentPriceChanged**|boolean|Indicates if currentPrice has changed since the item was saved|Optional|
|links.**self**|object|Object containing self-link|Optional|
|links.self.**ref**|string|Link to this resource, itself|Required|
|**error**|object|Error information|Optional|
|error.**field**|string|JSON Pointer to the erroneous field|Required|
|error.**code**|string|Error code for the error, text-based, 'screaming snake-case', one of "INVALID_FIELD", "UNAVAILABLE", "NOT_FOUND"|Required|

Sample *Retrieve Item by ID* 200 response:
```
{
    "id": "bf69a7c9-55c5-f643-ffb1-c6f1eaadde21",
    "wishlistId": "93a333a2-907b-46f1-b9ac-469489909057",
    "productId": "a05846b0-fef4-e113-94dc-7bad08547709",
    "country": "US",
    "msrp": 34.22,
    "currentPrice": 34.22,
    "fullPrice": 34.22,
    "employeePrice": 34.22,
    "currency": "USD",
    "creationDate": "2016-11-29T22:52:12.132Z",
    "links": {
      "self": {
        "ref": "/buy/list_items/v1/bf69a7c9-55c5-f643-ffb1-c6f1eaadde21"
      }
    },
    "error": {
      "field": "/productId",
      "code": "UNAVAILABLE"
    }
}
```
---

## Using Shipping Options

- [Shipping Options Overview](#shipping-options-overview)

- [Shipping Options](#shipping-options)

- [Shipping Options Error Handling](#shipping-options-error-handling)

### Shipping Options Overview

Shoppers are accustomed to selecting a shipping method (e.g. Standard, Two-Day, Next-Day) during the checkout process. But how do you know which methods to present to them, based on their shopping context?

Use the Shipping Options v2 API to retrieve the customer's available shipping methods for a checkout, including associated costs and estimated delivery dates/ranges.

>**TIP:** It is a best practice to send all of the optional request headers and request body fields, if the data is available, to avoid unexpected responses.

### Shipping Options

Send a request with a country code, currency code, item information and (optionally) shipping address information to this endpoint to get the list of available shipping methods, along with associated costs/taxes and estimated delivery date(s). This endpoint calculates shipping discounts such as free shipping for members.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**POST**|`/buy/shipping_options/v2`|no|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

#### Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**country**|string|ISO 3166 country code, e.g. US|Required|
|**currency**|string|ISO 4217 currency code, e.g. USD|Required|
|**items**|array|Array containing list of item objects, with the following required fields:|Required|
|items.**id**|string|Unique identifier of the line item in the request. You create this value.|Required|
|items.**skuId**|string|Stock Keeping Unit (SKU) unique identifier of the product, as obtained from Nike Product services.|Required|
|**valueAddedServices**|array|List of value-added service (VAS) line items. One or more VAS line items can be associated with a Nike product (i.e. **skuId**). Examples of VAS are a customization service for a shoe or a gift-wrapping service.|Optional|
|valueAddedServices.**id**|string|Unique identifier for the VAS. In nested **Instruction** object, the following are required:|Optional|
|valueAddedServices.Instruction.**id**|string|Instruction unique identifier for the value-added service, related to the various service domains, e.g. design id for Nike iD customization.|Optional|
|valueAddedServices.Instruction.**type**|string|Instruction Type, e.g. customization/nike_id (only one currently available), customization/my_print, customization/gift_card, buy/gift_wrap, buy/gift_message.|Optional|
|**shippingAddress**|object|The address to which items are to be shipped. Required fields are **postalCode** and **country**. Complete list of fields here:|Optional|
|shippingAddress.**address1**|string|Shipping address line one.|Optional|
|shippingAddress.**address2**|string|Shipping address line two.|Optional|
|shippingAddress.**address3**|string|Shipping address line three.|Optional|
|shippingAddress.**city**|string|Shipping address city.|Optional|
|shippingAddress.**state**|string|Shipping address state. This should be the ISO 3166-2 subdivision code. For the US, this is the 2-alpha state code as defined in ISO 3166-2:US.|Optional|
|shippingAddress.**postalCode**|string|Shipping address postal code. In the US, this is the 5-digit or the 5-plus-4-digit zip code.|Optional|
|shippingAddress.**country**|string|Shipping address country. 2-alpha character ISO 3166 country code.|Optional|
|shippingAddress.**county**|string|Shipping address county. This will typically be used for non-US addresses to hold specific regional data.|Optional|
|**promotionCodes**|array|Array containing promotion codes that the user has attempted to apply|Optional|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>For the list of supported country code and currency code combinations, see [here](/doc/commerce/checkout/checkout_country_currency.html).
>
><i class="mr2-sm g72-check"></i>To retrieve VAS data to include in your checkout request, call the Merchandised Value Added Services endpoints of the Merchandised Products API. See the [Merchandised Products API Developer's Guide](/doc/commerce/product/api_merch_product.html) for more information.
>
><i class="mr2-sm g72-check"></i>Although optional, including a shippingAddress is recommended whenever possible. In China, shipping methods can vary based on the province, city, and district combination. Also, for certain countries (e.g. US), including the shipping address can get you an estimated delivery date versus an estimated delivery range.

Sample *Shipping Options* request body:

```
{
  "country": "US",
  "currency": "USD",
  "items": [
    {
      "id": "a05dcb8a-79e5-4f69-bc30-213dd93f429c",
      "skuId": "15611769-e81b-45dd-b28c-ca0effb272de",
      "valueAddedServices": [
        {
          "id": "88d0475d-30e5-4c2f-9a87-7a31938f8ace",
          "instruction": {
            "id": "2027261230",
            "type": "customization/nike_id"
          }
        }
      ],
      "shippingAddress": {
        "address1": "1234 NW Test",
        "city": "Beaverton",
        "state": "OR",
        "postalCode": "97006",
        "country": "US"
      }
    }
  ]
}
```

#### Response Body

The HTTP 200 success response from *Shipping Options* reflects back many elements from the request body and also includes the following new information to the client:

|Element Name|Type|Description|
|---|---|---|
|**shippingMethods**|array|Array under **items** containing information about the shipping methods available to your shopper based on the data sent in the request|
|shippingMethods.**id**|string|Shipping method name|
|shippingMethods.**daysToArrive**|n/a|DEPRECATED - do not use|
|shippingMethods.**estimatedDelivery**|object|Estimated delivery date (in nested **date** field) or date range (in nested range.**min** and range.**max** for the shipping method. You will get either a date or a date range, not both.|
|shippingMethods.estimateDelivery.**id**|string|Identifier for the delivery estimate|
|shippingMethods.estimateDelivery.**date**|string|Estimated delivery date|
|shippingMethods.estimateDelivery.**range**|object|Estimated delivery range (see min/max nested)|
|shippingMethods.estimateDelivery.range.**minDate**|string|Earliest date within range that the delivery can be completed|
|shippingMethods.estimateDelivery.range.**maxDate**|string|Latest date within range that the delivery can be completed|
|shippingMethods.**priceInfo**|string|Price information for shipping method. Contains the following:|
|shippingMethods.priceInfo.**cost**|number|Base price of shipping method|
|shippingMethods.priceInfo.**discount**|number|Discount amount applied (if any)|
|shippingMethods.priceInfo.**total**|number|Net price of shipping method (cost - discount)|
|shippingMethods.**promotionDiscounts**|array|Array of applied promotion codes and their discount amounts|
|shippingMethods.promotionDiscounts.**code**|string|Promotion code associated with the discount (entered by user)|
|shippingMethods.promotionDiscounts.**amount**|number|Promotion discount amount|
|shippingMethods.promotionDiscounts.**id**|string|Promotion unique identifier|

>**TIP:** The date value(s) in estimatedDelivery object are in the [ISO-8601](https://en.wikipedia.org/wiki/ISO_8601){:target="blank"} format of `yyyy-mm-ddThh:mm:ss.mssZ` and in UTC with zero offset, e.g. `2017-07-18T18:25:45.237Z`. Convert to the local date (or date/time) of the shopper as necessary.

Sample *Shipping Options* response body:

```
{
    "resourceType": "shippingOptions",
    "country": "US",
    "currency": "USD",
    "items": [
        {
            "id": "7e909b64-fbb1-5dc7-bf39-a67fcfefb7b8",
            "skuId": "d76dfbd7-13fb-5675-9365-2a8859750c15",
            "shippingMethods": [
                {
                    "id": "STANDARD",
                    "daysToArrive": 5,
                    "estimatedDelivery": {
                        "range": {
                            "minDate": "2017-06-28T23:19:50.33Z",
                            "maxDate": "2017-07-01T23:19:50.33Z"
                        }
                    },
                    "priceInfo": {
                        "cost": 8,
                        "discount": 8,
                        "total": 0
                    }
                },
                {
                    "id": "TWO_DAY",
                    "daysToArrive": 4,
                    "estimatedDelivery": {
                        "range": {
                            "minDate": "2017-06-28T23:19:50.443Z",
                            "maxDate": "2017-06-29T23:19:50.443Z"
                        }
                    },
                    "priceInfo": {
                        "cost": 15,
                        "discount": 0,
                        "total": 15
                    }
                },
                {
                    "id": "NEXT_DAY",
                    "daysToArrive": 2,
                    "estimatedDelivery": {
                        "range": {
                            "minDate": "2017-06-27T23:19:50.544Z",
                            "maxDate": "2017-06-29T23:19:50.544Z"
                        }
                    },
                    "priceInfo": {
                        "cost": 25,
                        "discount": 0,
                        "total": 25
                    }
                }
            ]
        }
    ]
}
```

### Shipping Options Error Handling

Following is a summary of the errors and warnings that can come back in responses from the Shipping Options API:

|HTTP Response Code|Relevant HTTP Method(s)|Error Code|Error Description|Action to Take|
|----|----|----|----|---|
|400|POST|MISSING_REQUIRED|"Request body contained invalid JSON"|Check the syntax of the request body, or item quantity for validity.|
|400|POST|MISSING_REQUIRED|A required field or fields in the request was missing. Examples include not providing cart ID, country, brand etc.|Retry the request while supplying the missing field/value|
|400|POST|FIELD_INVALID|The value of a field or fields in the request was not valid. Examples include providing too many items, country code and/or brand not supported, etc.|Check the indicated field/value. Correct and retry|
|401|POST|35|The operation was requested by an unauthorized user.|Check that your access token was sent in **Authorization** request header in format `Bearer {token}` or that the token has not expired.|
|404|POST|310|The resource you requested does not exist.|Check the URL. Adjust as necessary and retry|
|500|POST|Server error|Error occurred processing the request.|skuId invalid or isn't in UUID format? Line item id not in UUID format?|

#### Example error response bodies:

1. Response for a request containing an invalid country code:
```
{
    "code": "INPUT_VALIDATION_FAILED",
    "message": "Validation Failed",
    "errors": [
        {
            "field": "/country",
            "code": "FIELD_INVALID",
            "message": "ECMA 262 regex \"^[A-Z]{2}$\" does not match input string \"\""
        }
    ]
}
```

2. Response for a request sent to an unrecognized URL:
```
{
    "error_id": "40b05032-bd51-46b3-bd05-19eb261055e9",
    "errors": [
        {
            "code": 310,
            "message": "The resource you requested does not exist."
        }
    ]
}
```

3. Response for a request that was missing a required field:
```
{
    "code": "INPUT_VALIDATION_FAILED",
    "message": "Validation Failed",
    "errors": [
        {
            "field": "country",
            "code": "MISSING_REQUIRED",
            "message": "object has missing required properties ([\"country\"])"
        }
    ]
}
```

4. Response for a request with malformed JSON:
```
{
    "code": "MISSING_REQUIRED",
    "message": "Request body contained invalid JSON",
    "errors": []
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLORD/repos/v2-order-api/browse/shippingoptions/API.md?raw#!/default/post_buy_shipping_options_v2" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

## Using Checkouts

- [Checkouts Overview](#checkouts-overview)

- [Request Checkout Preview](#request-checkout-preview)

- [Retrieve Checkout Preview Job](#retrieve-checkout-preview-job)

- [Retrieve Checkout Preview Results](#retrieve-checkout-preview-results)

- [Request Checkout Submit](#request-checkout-submit)

- [Retrieve Checkout Submit Job](#retrieve-checkout-submit-job)

- [Retrieve Checkout Results](#retrieve-checkout-results)

- [Request Checkout Submit (Launch)](#request-checkout-submit-launch)

- [Checkouts Error Handling](#checkouts-error-handling)

### Checkouts Overview

The Checkouts v2 API allows you to create, validate, and submit a checkout to Nike for fulfillment. What exactly is a checkout? (Hint: it's like an order).

A checkout consists of all data necessary for defining the following:

- Consumer’s product choices (items, quantities, value-added services)

- Consumer’s payment method(s) and billing address(es)

- Consumer’s shipping method(s) and shipping address(es)

- Pricing

- Taxes

- Discounts

Through calls to Checkout and other Nike APIs, you can maintain the state of the shopper's checkout in your client application and then submit the checkout to Nike for approval and fulfillment.

>**TIP:** It is a best practice to send all of the optional request headers and request body fields, if the data is available, to avoid unexpected responses.

### Request Checkout Preview

The *Request a Checkout Preview* endpoint allows you to check that the items, shipping method(s), and shipping address(es) included in a checkout are valid based on Nike pricing and address rules. Additionally, you'll get item pricing and tax, shipping fee and tax, and checkout subtotals in the response.

#### Checkout Preview Is Optional, But Recommended

Is it not required to call *Request Checkout Preview* in order for your shopper to complete their purchase. However, it is recommended.

In a typical Nike digital experience, a successful checkout preview means that the checkout details are accurate, including shipping fees and taxes, and that the checkout process can proceed to the payment steps.

Use the response to display the final payment amount to the customer. Once the customer confirms the payment method details and clicks or taps 'Place Order', there will be a greater chance of success.

>**TIP:** For more context, see a step-by-step example of all the calls in a checkout in the diagram in the [Use Cases](#use-cases) section of this document. For more info about Payment, see the [Payment Domain Developer's Guide](/doc/commerce/payment/api_payment.html).

####  Checkout Preview Operates Asynchronously

This endpoint operates **asynchronously** which means that there are extra steps to retrieve the results of your request. Read the Asynchronous Operation section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#asynchronous-operation) guide to learn more.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PUT**|`/buy/checkout_previews/v2/{id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique client-generated identifier ([UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier){:target="blank"}) for the checkout|string|**Required**|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

Other required request headers for this API are:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**appId**|Your application identifier||X||

#### Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**request**|object|Top-level object in request schema|Required|
|**email**|string|Email address for the shopper|Required|
|**country**|string|2-alpha character ISO 3166 country code, e.g US|Required|
|**currency**|string|ISO 4217 currency code for the shopper, e.g. USD|Required|
|**locale**|string|Posix-formatted locale code, e.g. en_US|Required|
|**channel**|string|Selling channel name associated with the checkout, e.g. 'SNKRS'|Required|
|**items**|array|Array containing list of products and value-added services to be previewed. The minimum values that need to be sent in this section are:|Required|
|items.**id**|string|Unique identifier of the line item in the array. You create this value|Required|
|items.**skuId**|string|Stock Keeping Unit (SKU) unique identifier of the product, as obtained from Nike Product services|Required|
|items.**quantity**|integer|Unit quantity (integer) of the line item, as chosen by the shopper|Required|
|items.**recipient**|object|Person to which the items are to be shipped, as entered by the shopper:|Required|
|items.recipient.**firstName**|string|First name of the person receiving the items|Required|
|items.recipient.**lastName**|string|Last name of the person receiving the items|Required|
|items.**shippingAddress**|object|Address to which items are to be shipped, as entered by the shopper:|Required|
|items.shippingAddress.**address1**|string|Shipping address line one|Required|
|items.shippingAddress.**city**|string|Shipping address city|Required|
|items.shippingAddress.**country**|string|Shipping address country|Required|
|items.**shippingMethod**|string|Identifier for the shipping method, as obtained from the Nike Shipping Options API and selected by the shopper, e.g. 'STANDARD' for standard ground shipping in the US|Required|
|**clientInfo**|object|Information about the client system making the request to the API|Optional|
|clientInfo.**deviceId**|string|'Fingerprint' of the device making the request|Optional|
|clientInfo.**client**|string|Name of client making the request, e.g. 'com.nike.commerce.snkrs.web'|Optional|
|**valueAddedServices**|array|List of value-added service (VAS) line items. One or more VAS line items can be associated with a Nike product (i.e. **skuId**). Examples of VAS: a customization service for a shoe or a gift-wrapping service|Optional|
|valueAddedServices.**id**|string|Unique identifier for the VAS. In nested **Instruction** object, the following are required:|Optional|
|valueAddedServices.Instruction.**id**|string|Instruction unique identifier for the value-added service, related to the various service domains, e.g. design id for Nike iD customization|Optional|
|valueAddedServices.Instruction.**type**|string|Instruction Type, e.g. customization/nike_id (only one currently available), customization/my_print, customization/gift_card, buy/gift_wrap, buy/gift_message|Optional|
|**promotionCodes**|array|Array containing list of promotion codes being applied to the checkout|Optional|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>For the list of supported country code and currency code combinations, see [here](/doc/commerce/checkout/checkout_country_currency.html).
>
><i class="mr2-sm g72-check"></i>To retrieve VAS data to include in your checkout request, call the Merchandised Value Added Services endpoints of the Merchandised Products API. See the [Merchandised Products API Developer's Guide](/doc/commerce/product/api_merch_product.html) for more information.

Sample *Request a Checkout Preview* request body:
```
{
     "request": {
       "email": "null@null.com",
       "country": "US",
       "currency": "USD",
       "locale": "en_US",
       "channel": "SNKRS",
       "clientInfo": {
         "deviceId": "iPhone"
       },
       "items": [
         {
           "id": "a05dcb8a-79e5-4f69-bc30-213dd93f429c",
           "skuId": "15611769-e81b-45dd-b28c-ca0effb272de",
           "quantity": 1,
           "valueAddedServices": [
             {
               "id": "88d0475d-30e5-4c2f-9a87-7a31938f8ace",
               "instruction": {
                 "id": "2027261230",
                 "type": "customization/nike_id"
               }
             },
             {
               "id": "ac9fd9d3-3815-44ce-8b1f-18cce7abd488",
               "instruction": {
                 "id": "1027551960",
                 "type": "customization/nike_id"
               },
               "priceInfo": {
                 "price": 12,
                 "discount": 0,
                 "total": 12,
                 "priceSnapshotId": "12319076-f81c-4fdb-8beb-2510ba74e9ff"
               }
             }
           ],
           "recipient": {
             "firstName": "John",
             "altFirstName": "J",
             "lastName": "Doe",
             "altLastName": "Deer",
             "middleName": "Henry",
             "middleInitial": "H",
             "givenName": "John H. Deer"
           },
           "shippingAddress": {
             "address1": "1234 NW Test",
             "address2": "Suite 22",
             "address3": "Door 1",
             "city": "Beaverton",
             "state": "OR",
             "postalCode": "97006",
             "country": "US",
             "county": "Washington"
           },
           "contactInfo": {
             "phoneNumber": "555-555-5555",
             "email": "null@null.com"
           },
           "shippingMethod": "STANDARD"
         }
       ]
     }
   }
```

#### Response Body

The HTTP 202 response from *Request Checkout Preview* contains information about how to retrieve the results of your job via the 'Retrieve Checkout Preview Job' endpoint. Following are the descriptions of the important fields in the response body:

|Element Name|Description|
|---|---|
|**id**|Checkout id you sent in the request, also your job ID|
|**status**|Status of the job|
|**eta**|Estimated wait time before polling the jobs endpoint to get your results|
|**links**|Relative URL path you can use to poll the jobs endpoint (see nested "ref" field)|

```
{
    "id": "a05dcb8a-79e5-4f69-bc30-213dd93f429c",
    "status": "PENDING",
    "eta": 200,
    "resourceType": "job",
    "links": {
        "self": {
            "ref": "/buy/checkout_previews/v2/jobs/a05dcb8a-79e5-4f69-bc30-213dd93f429c"
        }
    }
}
```

### Retrieve Checkout Preview Job

After calling *Request Checkout Preview* and receiving a HTTP 202 response, call *Retrieve Checkout Preview Job* using the same checkout ID to check the status of your job.

To know if the job is done, check the value of the **status** field in the response body as follows:

- `"status": "PENDING"`: job processing has not started

- `"status": "IN_PROGRESS"`: job processing in progress

- `"status": "COMPLETED"`: job has completed

Once you receive a job status of COMPLETED, get the results of your job by parsing the data in the **response** object from this endpoint. Alternatively, follow the link to the *Retrieve Checkout Preview Results* endpoint which is provided in the response body (see **links** object).

>**TIP:** Parsing the 'Completed' job result directly is a best practice because it eliminates doing another service call.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/buy/checkout_previews/v2/jobs/{id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique client-generated identifier ([UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier){:target="blank"}) for the checkout|string|**Required**|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

Other required request headers for this API are:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**appId**|Your application identifier||X||

#### Request Body

There is no body for a GET request.

#### Response Body

For a job that is in either "PENDING" or "IN_PROGRESS" status, the response is abbreviated and only contains the following:

|Element Name|Type|Description|
|---|---|---|
|**id**|string|Checkout id you sent in the request, also your job ID|
|**status**|string|Status of the job|
|**eta**|integer|Estimated wait time before polling the jobs endpoint to get your results|
|**links**|object|Relative URL path you can use to poll the jobs endpoint (see nested **ref** field)|

Sample *Retrieve Checkout Preview Job* response body with "IN_PROGRESS" status:

```
{
  "id": "7a37290b-c724-4f87-aeef-821265853546",
  "status": "IN_PROGRESS",
  "eta": 250,
  "resourceType": "job",
  "links": {
    "self": {
      "ref": "/buy/checkout_previews/v2/jobs/7a37290b-c724-4f87-aeef-821265853546"
    }
  }
}
```
For a job that is in "COMPLETED" status and had no errors, the response also contains a **response** object that has the details of your checkout preview result.

The structure of the **response** object is similar in structure to the request body, with the following notable additions:

|Element Name|Type|Description|
|---|---|---|
|**shippingGroups**|array|Array found under **response** object containing items and corresponding VAS, taxes, shipping address/method/cost. Grouped based on Nike business rules|
|**priceInfo**|object|Object containing price details. Found under the **items**, **valueAddedServices**, and **shippingCosts** objects|
|priceInfo.**employeePrice**|number|Employee price of the cart item. Only present if an employee price is used when pricing the checkout|
|**taxes**|array|Array of tax details. Found under **items** and **shippingCosts** objects|
|taxes.**type**|enum|Type of tax (e.g. SALESTAX, SHIPPINGTAX, VALUEADDEDTAX)|
|taxes.**rate**|number|Tax rate|
|taxes.**total**|number|Total tax amount|
|**promotionDiscounts**|array|Array found under **items** and **shippingGroups** containing a list of promotions and their discount amounts|
|promotionDiscounts.**code**|string|Promotion code entered by the user|
|promotionDiscounts.**amount**|number|Promotion discount amount|
|promotionDiscounts.**id**|string|Promotion identifier|
|promotionDiscounts.**displayName**|string|Promotion display name|
|**shippingMethod**|object|Object found under **shippingGroups** containing cost of shipping method and estimated delivery date(s)|
|shippingMethod.**id**|string|Identifier for the shipping method, e.g. STANDARD for standard ground shipping in the US|
|shippingMethod.**cost**|number|Retail cost of shipping via the shipping method|
|shippingMethod.**daysToArrive**|n/a|DEPRECATED - do not use|
|shippingMethod.**estimatedDelivery**|string|Estimated delivery date for the items|
|shippingMethod.estimatedDelivery.**estimatedDeliveryDetails**|object|Object containing unique identifier of the delivery estimate|
|shippingMethod.estimatedDelivery.estimatedDeliveryDetails.**id**|string|Unique identifier (UUID) of the delivery estimate|
|shippingMethod.estimatedDelivery.estimatedDeliveryDetails.**date**|string|Estimated delivery date for the items|
|shippingMethod.estimatedDelivery.estimatedDeliveryDetails.**message**|string|Message describing the delivery estimate|
|**shippingCosts**|object|Object found under **shippingGroups** containing total shipping costs, discounts, taxes, totals|
|shippingCosts.**price**|number|Price of the shipping costs|
|shippingCosts.**discount**|number|Shipping costs discount|
|shippingCosts.**total**|number|Total price of the shipping costs, not including tax, less any discounts|
|shippingCosts.**taxTotal**|number|Total tax amount based on the total|
|**promotionCodes**|array|Array found under **response** containing distinct summary of status for the provided promotion codes|
|promotionCodes.**code**|string|Provided promotion code|
|promotionCodes.**status**|string|Status of whether the promotion code was applied, e.g. PROMOTION_APPLIED, PROMOTION_NOT_APPLIED, PROMOTION_INVALID|
|**totals**|object|Object under **response** containing price subtotals for the entire checkout by items, VAS, taxes, discounts, shipping. Total checkout price also included|
|totals.**subtotal**|number|Subtotal of the item costs for all items|
|totals.**valueAddedServicesTotal**|number|Total of value-added services on the items|
|totals.**taxTotal**|number|Total of all taxes applied to the checkout, including VALUEADDEDTAX|
|totals.**discountTotal**|number|Total of all discounts (excluding shipping discounts) applied to the checkout|
|totals.**shippingTotal**|number|Total of all shipping costs, less any shipping discounts, on the checkout|
|totals.**total**|number|Total prices of the entire checkout (item costs + shipping costs + taxes (including VALUEADDEDTAX) less any discounts|
|**priceChecksum**|string|Found under **response**, provides checksum for price details. Optionally, you can send it in the request body to *Request Checkout Submit* (see related section in this guide)|

Sample *Retrieve Checkout Preview Job* response body with "COMPLETED" status:

```
{
    "id": "87b5430e-48ed-4507-a38f-7faa7f63ecb2",
    "status": "COMPLETED",
    "links": {
        "self": {
            "ref": "/buy/checkout_previews/v2/jobs/87b5430e-48ed-4507-a38f-7faa7f63ecb2"
        },
        "result": {
            "ref": "/buy/checkout_preview_results/v2/87b5430e-48ed-4507-a38f-7faa7f63ecb2"
        }
    },
    "response": {
        "id": "87b5430e-48ed-4507-a38f-7faa7f63ecb2",
        "country": "US",
        "currency": "USD",
        "locale": "en_US",
        "shippingGroups": [
            {
                "items": [
                    {
                        "id": "87b5430e-48ed-4507-a38f-7faa7f63ecb2",
                        "skuId": "2f127fe4-78d4-5042-a944-b8a4938aff10",
                        "quantity": 1,
                        "valueAddedServices": [],
                        "priceInfo": {
                            "price": 190,
                            "valueAddedServices": 0,
                            "taxTotal": 0,
                            "discount": 0,
                            "total": 190
                        },
                        "taxes": [
                            {
                                "type": "SALESTAX",
                                "rate": 0,
                                "total": 0
                            }
                        ]
                    }
                ],
                "recipient": {
                    "firstName": "John",
                    "lastName": "Doe",
                    "altFirstName": "J",
                    "altLastName": "",
                    "middleName": ""
                },
                "shippingAddress": {
                    "address1": "1234 NW Test",
                    "address2": "Suite 22",
                    "address3": "Door 1",
                    "city": "Beaverton",
                    "state": "OR",
                    "postalCode": "97006",
                    "country": "US",
                    "county": "Washington"
                },
                "shippingMethod": {
                    "id": "STANDARD",
                    "cost": 8,
                    "daysToArrive": 5,
                    "estimatedDelivery": "2017-07-12T16:42:26.821Z"
                },
                "shippingCosts": {
                    "priceInfo": {
                        "price": 8,
                        "valueAddedServices": 0,
                        "taxTotal": 0,
                        "discount": 8,
                        "total": 0
                    },
                    "taxes": [
                        {
                            "type": "SHIPPINGTAX",
                            "rate": 0,
                            "total": 0
                        }
                    ]
                },
                "contactInfo": {
                    "phoneNumber": "5555555555",
                    "email": "null@null.com"
                }
            }
        ],
        "totals": {
            "shippingTotal": 0,
            "subtotal": 190,
            "valueAddedServicesTotal": 0,
            "taxTotal": 0,
            "discountTotal": 8,
            "total": 190
        },
        "priceChecksum": "f9b70f748aeb23af6255b3767f0c5595",
        "email": "null@null.com",
        "resourceType": "checkoutPreviewResult",
        "links": {
            "self": {
                "ref": "/buy/checkout_preview_results/v2/87b5430e-48ed-4507-a38f-7faa7f63ecb2"
            }
        }
    },
    "resourceType": "job"
}
```

### Retrieve Checkout Preview Results

After calling both the *Request Checkout Preview* and *Retrieve Checkout Preview Job* endpoints, you can call this endpoint to retrieve the result of your Checkout Preview request. This step is optional, as the same result is already available in the response from the *Retrieve Checkout Submit Job* endpoint.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PUT**|`/buy/checkout_preview_results/v2/{id}`|no|

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique client-generated identifier ([UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier){:target="blank"}) for the checkout|string|**Required**|

### Request Checkout Submit

Call the *Request Checkout Submit* endpoint when your user is ready to complete their purchase.

*Request Checkout Submit* performs the final validations of the user's information, requests payment authorization, and if everything succeeds, submits a checkout to Nike for fulfillment.

#### Considerations

- Before calling *Request Checkout Submit*, you must have previously called the Payment Preview API to collect the required payment information, most notably the mandatory Payment Preview **id**. See the [Payment Domain Developer's Guide](/doc/commerce/payment/api_payment.html) for more info.

- Calling *Request Checkout Preview* is not required before calling *Request Checkout Submit*, but it is recommended in most cases.

- When calling both the Preview and Submit endpoints in succession for a particular checkout, it is **not** required for you to use the same ID in the URL path (i.e. the checkout identifier) for both calls. However, any ID that you use must not have been used previously, else you will receive an idempotent response for the previously-used ID.

#### Checkout Submit Operates Asynchronously

This endpoint operates **asynchronously** which means that there are extra steps to retrieve the results of your request. Read the Asynchronous Operation section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#asynchronous-operation)
guide to learn more.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PUT**|`/buy/checkouts/v2/{id}`|no|

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique client-generated identifier ([UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier){:target="blank"}) for the checkout|string|**Required**|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

Other required request headers for this API are:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**appId**|Your application identifier||X||
|**True-Client-IP**|IP address of the client, required if **X-Forwarded-For** is null|X|X|X
|**X-Forwarded-For**|Used to derive the IP address of the client, required if **True-Client-IP** is null|X|X|X|
|**User-Agent**|Browser and operating system of the client calling this endpoint|X|X|X

Optional request headers:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**usertype**|nike:swoosh for Nike Employees, nike:plus for Nike+ Customers, otherwise do not send|X||X|
|**Origin-Order-ID**|During v1 to v2 cutover, represents the legacy order id associated to the checkout and is used by downstream systems|X|X|X|

#### Request Body

Required parts of the request body:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**request**|object|Top-level object in request schema|Required|
|**email**|string|Email address|Required|
|**country**|string|2-alpha character ISO 3166 country code, e.g US|Required|
|**currency**|string|ISO 4217 currency code, e.g. USD|Required|
|**locale**|string|BCP 47 locale code, e.g. en_US|Required|
|**channel**|string|Selling channel name associated with the checkout, e.g. 'SNKRS'|Required|
|**items**|array|Array containing list of item objects|Required|
|**paymentToken**|string|Unique identifier of the payment details, as obtained from the [Payment Preview API](/doc/commerce/payment/api_payment.html#using-payment-preview) in the **id** field at the top level|Required|
|**valueAddedServices**|array|List of value-added service (VAS) line items. One or more VAS line items can be associated with a Nike product (i.e. **skuId**). Examples of VAS are a customization service for a shoe or a gift-wrapping service|Optional|
|valueAddedServices.**id**|string|Unique identifier for the VAS. In nested **Instruction** object, the following are required:|Optional|
|valueAddedServices.Instruction.**id**|string|Instruction unique identifier for the value-added service, related to the various service domains, e.g. design id for Nike iD customization|Optional|
|valueAddedServices.Instruction.**type**|string|Instruction Type, e.g. customization/nike_id (only one currently available), customization/my_print, customization/gift_card, buy/gift_wrap, buy/gift_message|Optional|
|**promotionCodes**|array|Array containing list of promotion codes being applied to the checkout|Optional|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>For the list of supported country code and currency code combinations, see [here](/doc/commerce/checkout/checkout_country_currency.html).
>
><i class="mr2-sm g72-check"></i>To retrieve VAS data to include in your checkout request, call the Merchandised Value Added Services endpoints of the Merchandised Products API. See the [Merchandised Products API Developer's Guide](/doc/commerce/product/api_merch_product.html) for more information.
>
><i class="mr2-sm g72-check"></i>Optionally you can send the priceChecksum value you got from the *Request Checkout Preview* endpoint in the **priceChecksum** field in the request body. It is used to compare and validate the pricing calculated on a previous request against the pricing at the time of Checkout Submit.
>
><i class="mr2-sm g72-check"></i>For China only, you can offer shoppers the option to generate a Fapiao, which is a special tax invoice. If the shopper indicates a preference for Fapiao, they can enter a personal message to be used as a title for the invoice. Just send an **invoiceInfo** array in the request body, similar to the below example (see the request schema for this endpoint for more details):

```
"invoiceInfo": {
    "type": "ELECTRONIC_FAPIAO",
    "detail": "The shopper's personal title for the invoice"
}
```

Sample *Request Checkout Submit* request body:
```
{
     "request": {
       "email": "null@null.com",
       "country": "US",
       "currency": "USD",
       "locale": "en_US",
       "channel": "SNKRS",
       "clientInfo": {
         "deviceId": "iPhone"
       },
       "items": [
         {
           "id": "a05dcb8a-79e5-4f69-bc30-213dd93f429c",
           "skuId": "15611769-e81b-45dd-b28c-ca0effb272de",
           "quantity": 1,
           "recipient": {
             "firstName": "John",
             "altFirstName": "J",
             "lastName": "Doe",
             "altLastName": "Deer",
             "middleName": "Henry",
             "middleInitial": "H",
             "givenName": "John H. Deer"
           },
           "shippingAddress": {
             "address1": "1234 NW Test",
             "address2": "Suite 22",
             "address3": "Door 1",
             "city": "Beaverton",
             "state": "OR",
             "postalCode": "97006",
             "country": "US",
             "county": "Washington"
           },
           "contactInfo": {
             "phoneNumber": "555-555-5555",
             "email": "null@null.com"
           },
           "shippingMethod": "STANDARD"
         }
       ],
       "paymentToken": "fe2cc7d6-9b40-4b64-81bf-afa11c8b43e4",
       "priceChecksum": "987490576237"
     }
   }
```

#### Response Body

The HTTP 202 response from *Request Checkout Submit* contains information about how to retrieve the results of your job from the *Retrieve Checkout Submit Job* endpoint. Following are descriptions of the important fields in the response body:

|Element Name|Description|
|---|---|
|**id**|Checkout id you sent in the request, also your job ID|
|**status**|Status of the job|
|**eta**|Estimated wait time before polling the jobs endpoint to get your results|
|**links**|Relative URL path you can use to poll the jobs endpoint (see nested "ref" field)|

```
{
  "id": "7a37290b-c724-4f87-aeef-821265853546",
  "status": "IN_PROGRESS",
  "eta": 250,
  "resourceType": "job",
  "links": {
    "self": {
      "ref": "/buy/checkouts/v2/jobs/7a37290b-c724-4f87-aeef-821265853546"
    }
  }
}
```

### Retrieve Checkout Submit Job

After calling the Request Checkout Submit endpoint and receiving a HTTP 202 response, you can call this endpoint using the same checkout ID to check the status of your job.

To know if the job is done, check the value of the **status** field in the response body as follows:

- `"status": "PENDING"`: job processing has not started

- `"status": "IN_PROGRESS"`: job processing in progress

- `"status": "COMPLETED"`: job has completed

Once you observe a job status of COMPLETED, get the results of your job by parsing the data in the **response** object from this endpoint. Alternatively, follow the link to the *Retrieve Checkout Results* endpoint which is provided in the response body (see **links** object).

>**TIP:** Parsing the 'Completed' job result directly is a best practice because it eliminates doing another service call.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/buy/checkouts/v2/jobs/{id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique client-generated identifier ([UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier){:target="blank"}) for the checkout|string|**Required**|

#### Request Headers

Go to [Request Headers](#request-headers) to see the required, common headers for all Checkout APIs.

Other required request headers for this API are:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**appId**|Your application identifier||X||

#### Request Body

There is no body for a GET request.

#### Response Body

For a job that is in either "PENDING" or "IN_PROGRESS" status, the response is abbreviated and only contains the following:

|Element Name|Type|Description|
|---|---|---|
|**id**|string|Checkout id you sent in the request, also your job ID|
|**status**|string|Status of the job|
|**eta**|integer|Estimated wait time before polling the jobs endpoint to get your results|
|**links**|object|Relative URL path you can use to poll the jobs endpoint (see nested **ref** field)|

Sample *Retrieve Checkout Submit Job* response body with "IN_PROGRESS" status:
```
{
  "id": "7a37290b-c724-4f87-aeef-821265853546",
  "status": "IN_PROGRESS",
  "eta": 250,
  "resourceType": "job",
  "links": {
    "self": {
      "ref": "/buy/checkouts/v2/jobs/7a37290b-c724-4f87-aeef-821265853546"
    }
  }
}
```

For a job that is in "COMPLETED" status and had no errors, the response also contains a **response** object that has the details of your successfully-submitted checkout. The structure of the **response** object is similar in structure to the request body, with the following notable additions:

|Element Name|Type|Description|
|---|---|---|
|**shippingGroups**|array|Array found under **response** object containing items and corresponding VAS, taxes, shipping address/method/cost. Grouped based on Nike business rules|
|**priceInfo**|object|Object containing price details. Found under the **items**, **valueAddedServices**, and **shippingCosts** objects|
|priceInfo.**employeePrice**|number|Employee price of the cart item. Only present if an employee price is used when pricing the checkout|
|**taxes**|array|Array of tax details. Found under **items** and **shippingCosts** objects|
|taxes.**type**|enum|Type of tax (e.g. SALESTAX, SHIPPINGTAX, VALUEADDEDTAX)|
|taxes.**rate**|number|Tax rate|
|taxes.**total**|number|Total tax amount|
|**promotionDiscounts**|array|Array found under **items** and **shippingGroups** containing a list of promotions and their discount amounts|
|promotionDiscounts.**code**|string|Promotion code entered by the user|
|promotionDiscounts.**amount**|number|Promotion discount amount|
|promotionDiscounts.**id**|string|Promotion identifier|
|promotionDiscounts.**displayName**|string|Promotion display name|
|**shippingMethod**|object|Object found under **shippingGroups** containing cost of shipping method and estimated delivery date(s)|
|shippingMethod.**id**|string|Identifier for the shipping method, e.g. STANDARD for standard ground shipping in the US|
|shippingMethod.**cost**|number|Retail cost of shipping via the shipping method|
|shippingMethod.**daysToArrive**|n/a|DEPRECATED - do not use|
|shippingMethod.**estimatedDelivery**|string|Estimated delivery date for the items|
|shippingMethod.estimatedDelivery.**estimatedDeliveryDetails**|object|Object containing unique identifier of the delivery estimate|
|shippingMethod.estimatedDelivery.estimatedDeliveryDetails.**id**|string|Unique identifier (UUID) of the delivery estimate|
|shippingMethod.estimatedDelivery.estimatedDeliveryDetails.**date**|string|Estimated delivery date for the items|
|shippingMethod.estimatedDelivery.estimatedDeliveryDetails.**message**|string|Message describing the delivery estimate|
|**shippingCosts**|object|Object found under **shippingGroups** containing total shipping costs, discounts, taxes, totals|
|shippingCosts.**price**|number|Price of the shipping costs|
|shippingCosts.**discount**|number|Shipping costs discount|
|shippingCosts.**total**|number|Total price of the shipping costs, not including tax, less any discounts|
|shippingCosts.**taxTotal**|number|Total tax amount based on the total|
|**promotionCodes**|array|Array found under **response** containing distinct summary of status for the provided promotion codes|
|promotionCodes.**code**|string|Provided promotion code|
|promotionCodes.**status**|string|Status of whether the promotion code was applied, e.g. PROMOTION_APPLIED, PROMOTION_NOT_APPLIED, PROMOTION_INVALID|
|**totals**|object|Object under **response** containing price subtotals for the entire checkout by items, VAS, taxes, discounts, shipping. Total checkout price also included|
|totals.**subtotal**|number|Subtotal of the item costs for all items|
|totals.**valueAddedServicesTotal**|number|Total of value-added services on the items|
|totals.**taxTotal**|number|Total of all taxes applied to the checkout, including VALUEADDEDTAX|
|totals.**discountTotal**|number|Total of all discounts (excluding shipping discounts) applied to the checkout|
|totals.**shippingTotal**|number|Total of all shipping costs, less any shipping discounts, on the checkout|
|totals.**total**|number|Total prices of the entire checkout (item costs + shipping costs + taxes (including VALUEADDEDTAX) less any discounts|
|**paymentToken**|string|Found under **resource**, the unique identifier of the payment details in the payment domain|
|**paymentApprovalId**|string|Found under **resource**, the unique identifier of the payment approval|
|**paymentStatus**|string|Found under **resource**, the status of payment approval ("ACCEPT", "PENDING_PAYMENT", "REJECT")|
|**invoiceInfo**|array|Found under **resource**, an array with special instructions for invoicing. Optional and applies to China only|
|invoiceInfo.**type**|string|Type of instruction, e.g. ELECTRONIC_FAPIAO to indicate a Chinese Fapiao tax receipt|
|invoiceInfo.**detail**|string|Supporting details for the instruction, e.g. the title to be used with a Fapiao tax receipt|
|invoiceInfo.**taxId**|string|Tax Id to be used with a Fapiao tax receipt if the order was placed on behalf of a company|

Sample *Retrieve Checkout Submit Job* response body with "COMPLETED" status:
```
{
  "id": "7a37290b-c724-4f87-aeef-821265853546",
  "status": "COMPLETED",
  "resourceType": "job",
  "links": {
    "self": {
      "ref": "/buy/checkouts/v2/jobs/7a37290b-c724-4f87-aeef-821265853546"
    },
    "result": {
      "ref": "/buy/checkout_results/v2/7a37290b-c724-4f87-aeef-821265853546"
    }
  },
  "response": {
    "id": "7a37290b-c724-4f87-aeef-821265853546",
    "resourceType": "checkoutResult",
    "links": {
      "self": {
        "ref": "/buy/checkout_results/v2/7a37290b-c724-4f87-aeef-821265853546"
      }
    },
    "email": "null@null.com",
    "country": "US",
    "currency": "USD",
    "locale": "en_US",
    "orderId": "C00000000001",
    "shippingGroups": [
      {
        "items": [
          {
            "id": "a05dcb8a-79e5-4f69-bc30-213dd93f429c",
            "skuId": "15611769-e81b-45dd-b28c-ca0effb272de",
            "quantity": 1,
            "valueAddedServices": [
              {
                "id": "88d0475d-30e5-4c2f-9a87-7a31938f8ace",
                "instruction": {
                  "id": "2027261230",
                  "type": "customization/nike_id"
                },
                "priceInfo": {
                  "price": 10,
                  "discount": 0,
                  "total": 10,
                  "priceSnapshotId": "12319076-f81c-4fdb-8beb-2510ba74e9fe"
                }
              },
              {
                "id": "ac9fd9d3-3815-44ce-8b1f-18cce7abd488",
                "instruction": {
                  "id": "1027551960",
                  "type": "customization/nike_id"
                },
                "priceInfo": {
                  "price": 12,
                  "discount": 0,
                  "total": 12,
                  "priceSnapshotId": "12319076-f81c-4fdb-8beb-2510ba74e9ff"
                }
              }
            ],
            "priceInfo": {
              "price": 200,
              "valueAddedServices": 22,
              "discount": 0,
              "total": 222,
              "taxTotal": 20
            },
            "taxes": [
              {
                "type": "SALESTAX",
                "rate": 10,
                "total": 20
              }
            ]
          }
        ],
        "recipient": {
          "firstName": "John",
          "altFirstName": "J",
          "lastName": "Doe",
          "altLastName": "Deer",
          "middleName": "Henry"
        },
        "shippingAddress": {
          "address1": "1234 NW Test",
          "address2": "Suite 22",
          "address3": "Door 1",
          "city": "Beaverton",
          "state": "OR",
          "postalCode": "97006",
          "country": "US",
          "county": "Washington"
        },
        "contactInfo": {
          "phoneNumber": "555-555-5555",
          "email": "null@null.com"
        },
        "shippingMethod": {
          "id": "STANDARD",
          "cost": 8,
          "daysToArrive": 5,
          "estimatedDelivery": "2016-02-09T00:00:00.000Z"
        },
        "shippingCosts": {
          "priceInfo": {
            "price": 8,
            "discount": 0,
            "total": 8,
            "taxTotal": 0.8
          },
          "taxes": [
            {
              "type": "SHIPPINGTAX",
              "rate": 10,
              "total": 0.8
            }
          ]
        }
      }
    ],
    "paymentToken": "fe2cc7d6-9b40-4b64-81bf-afa11c8b43e4",
    "totals": {
      "subtotal": 200,
      "valueAddedServicesTotal": 22,
      "taxTotal": 20.8,
      "discountTotal": 0,
      "shippingTotal": 8,
      "total": 230.8
    }
  }
}
```

### Retrieve Checkout Results

After calling both the Request Checkout Submit and Retrieve Checkout Submit Job endpoints, you can call this endpoint to retrieve the result of your request. This step is optional, as the same result is already available in the response from the Retrieve Checkout Submit Job endpoint.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/buy/checkout_results/v2/{id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique client-generated identifier ([UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier){:target="blank"}) for the checkout|string|**Required**|

### Request Checkout Submit (Launch)

The Request Checkout Submit (Launch) endpoint is used exclusively for Nike Launch experiences and features [JWT](https://jwt.io/introduction/){:target="blank"} authentication to enforce that. All other types of checkouts need to be sent to the regular Request Checkout Submit endpoint.

The Launch endpoint has the same contract as the Request Checkout Submit endpoint so for additional details see that section.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PUT**|`/buy/launch_checkouts/v2/{id}`|Yes|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique client-generated identifier ([UUID](https://en.wikipedia.org/wiki/Universally_unique_identifier){:target="blank"} for the checkout|string|**Required**|

### Checkouts Error Handling

Following is a summary of the errors and warnings that can come back in responses from the Checkouts API:

#### Error Responses

|HTTP Response Code|Relevant HTTP Method(s)|Error Code|Error Description|Action to Take|
|----|----|----|----|---|
|200|GET|INVALID_PAYMENT_TYPE|The selected payment type is invalid for the checkout|
|200|GET|INVALID_SHIPPING_BILLING_COMBINATION|The shipping and billing country combination is not supported|
|200|GET|ITEM_QUANTITY_LIMIT|Shopper has exceeded the per-user quantity limit for the product (total purchase quantity over multiple checkouts).|Notify the user as necessary|
|200|GET|NO_INVENTORY|Unable to reserve inventory for the SKU|Notify user as necessary|
|200|GET|OFFER_INVALID|The exclusive access offer is not valid (Launch only)|Notify user as necessary|
|200|GET|PAYMENT_INSUFFICIENT|Unable to allocate order total across all payment types. Need more payment|Prompt user to select another payment method|
|200|GET|PAYMENT_INVALID|"Payment failed"|Check the paymentToken. Correct and retry|
|200|GET|PAYPAL_AUTH_FAILURE_10411|Express Checkout transaction has expired|Notify the user as necessary|
|200|GET|PAYPAL_AUTH_FAILURE_10417|Retry using alternative method from PayPal wallet|Notify the user as necessary|
|200|GET|PAYPAL_AUTH_FAILURE_10422|Retry using alternative method|Notify the user as necessary|
|200|GET|PAYPAL_AUTH_FAILURE_10445|Error occurred, retry the transaction|Notify the user as necessary|
|200|GET|PAYPAL_AUTH_FAILURE_10486|Retry using alternative method|Notify the user as necessary|
|200|GET|PAYPAL_AUTH_FAILURE_11084|PayPal transaction declined|Notify the user as necessary|
|200|GET|PAYPAL_AUTH_FAILURE_13113|PayPal payment failed|Notify the user as necessary|
|200|GET|PRODUCT_NOT_BUYABLE|"Non buyable product(s)"|Notify the user as necessary|
|200|GET|PRODUCT_NOT_FOUND|Item sku not found or not valid for the country.|Check the skuId. Correct and retry|
|200|GET|PROMOTION_CODE_INVALID|Promotion code is invalid|Notify the user as necessary|
|200|GET|QUANTITY_INVALID|"Product(s) exceeded quantity limit". This is on a per-checkout basis.|Check the item quantity. Reduce and retry|
|200|GET|REJECTED|Request was rejected|
|200|GET|REQUEST_INVALID|"Unable to obtain checkout request"|skuID invalid? Correct and retry|
|200|GET|SHIPPING_METHOD_INVALID|"Invalid shipping method(s)"|Check the shipping method(s). Correct and retry|
|200|GET|SYSTEM_ERROR|General system error occurred. Typically, due to a timeout in the job|Submit checkout again|
|200|GET|UNSUPPORTED_CREDIT_CARD_ISSUER_COUNTRY|The credit card number is from a country that is not supported|
|200|GET|UNSUPPORTED_PAYMENT_FOR_COUNTRY|The selected payment type is not supported in the selected billing country|
|400|PUT|FIELD_INVALID|The value of a field or fields in the request was not valid. Examples include providing too many items, country code and/or brand not supported, etc.|Check the indicated field/value. Correct and retry|
|400|PUT|MISSING_REQUIRED|A required field or fields in the request was missing. Examples include not providing country, currency etc.|Retry the request while supplying the missing field/value|
|400|PUT|REQUEST_INVALID|"Invalid request body"|Check for malformed JSON in the request and retry|
|401|PUT, GET|35|The operation was requested by an unauthorized user.|Check that your auth token was sent in **Authorization** request header in format `Bearer {token}` or that the token has not expired|
|404|PUT, GET|310|The resource you requested does not exist.|Check the URL. Adjust as necessary and retry|
|409|PUT|REQUEST_INVALID|"Request conflicts with previous request for same checkout"|Same checkout ID was used previously with different request body. Generate new checkout ID and retry|
|500|PUT|Server error|Error occurred processing the request.|Checkout ID not in UUID format? Bad shipping method? skuId isn't in UUID format? Line item id not in UUID format?|
|500|PUT|n/a|Request was structurally invalid, such as malformed JSON.|Check the syntax of the request body, or item quantity for validity|

#### Example error response bodies:

1. Response for a request containing an invalid skuId (Checkout Preview only):
```
{
    "id": "0be43157-32e6-45ea-ad94-6832419a714e",
    "status": "COMPLETED",
    "links": {
        "self": {
            "ref": "/buy/checkout_previews/v2/jobs/0be43157-32e6-45ea-ad94-6832419a714e"
        },
        "result": {
            "ref": "/buy/checkout_preview_results/v2/0be43157-32e6-45ea-ad94-6832419a714e"
        }
    },
    "error": {
        "message": "Product data not found",
        "httpStatus": 400,
        "code": "PRODUCT_NOT_FOUND",
        "errors": []
    },
    "resourceType": "job"
}
```

2. HTTP 401 response for a request containing an invalid access token in Authorization header (all Checkouts endpoints):

```
{
    "error_id": "132ef514-5c28-40d8-8c52-8e2a60cd3182",
    "errors": [
        {
            "code": 35,
            "message": "Unauthorized user access"
        }
    ]
}
```

3. HTTP 404 response for request sent to an unrecognized URL (all Checkouts endpoints):
```
{
    "error_id": "0c4a083e-b86d-471e-9d95-a2d14e7c001c",
    "errors": [
        {
            "code": 310,
            "message": "The resource you requested does not exist."
        }
    ]
}
```

4. HTTP 500 response for a request where the checkout id in the URL was not in UUID format (Checkout Preview only):
```
{
    "httpStatus": 500,
    "code": "5005",
    "timestamp": 1501001555623,
    "service": "checkoutpreviewscmd",
    "message": "Internal Server Error: type: class com.sun.jersey.api.ParamException$PathParamExceptionmessage: java.lang.IllegalArgumentException: Invalid UUID string: footrace: "
}
```

5. HTTP 500 response for a request where the checkout id in the URL was not in UUID format (Checkout Submit only):
```
{
    "httpStatus": 500,
    "timestamp": 1501003356822,
    "service": "checkoutscmd",
    "message": "An unhandled error has occurred."
}
```

6. Response for a request where a required field was missing (Checkout Preview and Checkout Submit only):
```
{
    "message": "Validation Failed",
    "errors": [
        {
            "field": "request.country",
            "message": "Required field",
            "code": "MISSING_REQUIRED"
        }
    ]
}
```

7. Response for a request containing an invalid field value (Checkout Preview and Checkout Submit only):
```
{
    "message": "Validation Failed",
    "errors": [
        {
            "field": "request.country",
            "message": "Invalid field",
            "code": "FIELD_INVALID"
        }
    ]
}
```

8. Response for a request containing a line item id that was not in UUID format (Checkout Preview and Checkout Submit only):
```
{
    "message": "Validation Failed",
    "errors": [
        {
            "field": "request.items[0].id",
            "message": "Invalid field",
            "code": "FIELD_INVALID"
        }
    ]
}
```

9. Response for a request where the item quantity limit was exceeded (Checkout Preview and Checkout Submit only):
```
{
    "id": "9b0a2af0-cdb5-423f-864f-1a9f8e0a8110",
    "status": "COMPLETED",
    "links": {
        "self": {
            "ref": "/buy/checkout_previews/v2/jobs/9b0a2af0-cdb5-423f-864f-1a9f8e0a8110"
        },
        "result": {
            "ref": "/buy/checkout_preview_results/v2/9b0a2af0-cdb5-423f-864f-1a9f8e0a8110"
        }
    },
    "error": {
        "message": "Product(s) exceeded quantity limit",
        "httpStatus": 400,
        "errors": [
            {
                "field": "request.items[0].quantity",
                "message": "skuId=2f127fe4-78d4-5042-a944-b8a4938aff10, quantity=1000000, quantityLimit=1",
                "code": "QUANTITY_INVALID"
            }
        ]
    },
    "resourceType": "job"
}
```

10. Response for a request where the field length limit was exceeded (Checkout Preview and Checkout Submit only):
```
{
    "id": "7a200850-dd7a-4def-9851-e55846db1334",
    "status": "COMPLETED",
    "links": {
        "self": {
            "ref": "/buy/checkout_previews/v2/jobs/7a200850-dd7a-4def-9851-e55846db1334"
        },
        "result": {
            "ref": "/buy/checkout_preview_results/v2/7a200850-dd7a-4def-9851-e55846db1334"
        }
    },
    "error": {
        "message": "Validation Failed",
        "httpStatus": 400,
        "errors": [
            {
                "field": "request.items[0].recipient.firstName",
                "message": "Value is invalid length",
                "code": "FIELD_INVALID"
            }
        ]
    },
    "resourceType": "job"
}
```

11. Response for a request where the shipping address country did not match the checkout (i.e. top-level) country (Checkout Preview and Checkout Submit only):
```
{
    "id": "1589b213-2083-4d9d-83ac-79f4c54abbe9",
    "status": "COMPLETED",
    "links": {
        "self": {
            "ref": "/buy/checkout_previews/v2/jobs/1589b213-2083-4d9d-83ac-79f4c54abbe9"
        },
        "result": {
            "ref": "/buy/checkout_preview_results/v2/1589b213-2083-4d9d-83ac-79f4c54abbe9"
        }
    },
    "error": {
        "message": "Validation Failed",
        "httpStatus": 400,
        "errors": [
            {
                "field": "request.items[0].shippingAddress.country",
                "message": "The shipping address country does not match the checkout country",
                "code": "FIELD_INVALID"
            }
        ]
    },
    "resourceType": "job"
}
```

12. Response for a request with an invalid shipping method (Checkout Preview only):
```
{
    "id": "827913ea-bad5-4561-8281-d7fd0667856a",
    "status": "COMPLETED",
    "links": {
        "self": {
            "ref": "/buy/checkout_previews/v2/jobs/827913ea-bad5-4561-8281-d7fd0667856a"
        },
        "result": {
            "ref": "/buy/checkout_preview_results/v2/827913ea-bad5-4561-8281-d7fd0667856a"
        }
    },
    "error": {
        "message": "Invalid shipping method(s)",
        "httpStatus": 400,
        "errors": [
            {
                "field": "request.items[0].shippingMethod",
                "message": "shippingMethod=null, styleType=INLINE, country=US, postalCode=47403",
                "code": "SHIPPING_METHOD_INVALID"
            }
        ]
    },
    "resourceType": "job"
}
```

13. Response for a request where the contact phone number included invalid character, e.g. hyphens (Checkout Preview and Checkout Submit only):
```
{
    "id": "9278e33a-19c5-4c71-9b2b-164e19b71291",
    "status": "COMPLETED",
    "links": {
        "self": {
            "ref": "/buy/checkout_previews/v2/jobs/9278e33a-19c5-4c71-9b2b-164e19b71291"
        },
        "result": {
            "ref": "/buy/checkout_preview_results/v2/9278e33a-19c5-4c71-9b2b-164e19b71291"
        }
    },
    "error": {
        "message": "Validation Failed",
        "httpStatus": 400,
        "errors": [
            {
                "field": "request.items[0].contactInfo.phoneNumber",
                "message": "Value includes invalid characters",
                "code": "FIELD_INVALID"
            }
        ]
    },
    "resourceType": "job"
}
```

14. Response for a request containing an invalid skuId (Checkout Submit only):
```
{
    "id": "5eaca359-12d2-49ee-a6b4-69619d29a2e6",
    "status": "COMPLETED",
    "error": {
        "message": "Unable to obtain checkout request",
        "httpStatus": 400,
        "code": "REQUEST_INVALID",
        "errors": []
    },
    "links": {
        "self": {
            "ref": "/buy/checkouts/v2/jobs/5eaca359-12d2-49ee-a6b4-69619d29a2e6"
        }
    },
    "resourceType": "job"
}
```

15. Response for a request containing an invalid paymentToken (Checkout Submit only):
```
{
    "id": "745ec668-ff96-40cf-afe4-24080b9cd8c7",
    "status": "COMPLETED",
    "error": {
        "message": "Validation Failed",
        "httpStatus": 400,
        "code": "PAYMENT_INVALID",
        "errors": [
            {
                "field": "paymentPreviewId",
                "message": "Payment failed",
                "code": "PAYMENT_INVALID"
            }
        ]
    },
    "links": {
        "self": {
            "ref": "/buy/checkouts/v2/jobs/745ec668-ff96-40cf-afe4-24080b9cd8c7"
        }
    },
    "resourceType": "job"
}
```

16. Response for a request containing an invalid shipping method (Checkout Submit only):
```
{
        "id": "4329122c-740f-4fc0-83cf-d8f0b4bdd1c2",
        "status": "COMPLETED",
        "error": {
            "message": "Internal Server Error",
            "httpStatus": 500,
            "code": "INTERNAL_ERROR",
            "errors": []
        },
        "links": {
            "self": {
                "ref": "/buy/checkouts/v2/jobs/4329122c-740f-4fc0-83cf-d8f0b4bdd1c2"
            }
        },
        "resourceType": "job"
    }
```

17. HTTP 409 response for a request with a previously-used checkout ID but a new entity in request body (Checkout Submit only):
```
{
    "message": "Request conflicts with previous request for same checkout",
    "code": "REQUEST_INVALID"
}
```

18. Response for a request with a skuID that is not 'buyable', e.g. due to upcoming launch (Checkout Preview only):
```
{
    "id": "9278e33a-19c5-4c71-9b2b-164e19b71291",
    "status": "COMPLETED",
    "links": {
        "self": {
            "ref": "/buy/checkout_previews/v2/jobs/9278e33a-19c5-4c71-9b2b-164e19b71291"
        },
        "result": {
            "ref": "/buy/checkout_preview_results/v2/9278e33a-19c5-4c71-9b2b-164e19b71291"
        }
    },
    "error": {
        "message": "Non buyable product(s)",
        "httpStatus": 400,
        "errors": [
            {
                "field": "request.items[0].skuId",
                "message": "skuId=386375f9-4908-52fb-bcd7-d43e42a5f5d3, productId=352ce8c0-e04a-58ba-8d3c-7398d0084958, status=HOLD, startDate=2017-02-23T15:00Z[UTC], endDate=null, availability=true, publishType=LAUNCH",
                "code": "PRODUCT_NOT_BUYABLE"
            }
        ]
    },
    "resourceType": "job"
}
```

19. Response for a request with a skuId that is not 'buyable', e.g. due to upcoming launch (Checkout Submit only):
```
{
    "id": "c6e266c6-a892-4833-b1df-c98145c66ee7",
    "status": "COMPLETED",
    "error": {
        "message": "Invalid launch request",
        "httpStatus": 401,
        "code": "REQUEST_INVALID",
        "errors": [
            {
                "field": "request.items[0].skuId",
                "message": "productPublishType=LAUNCH not compatible with launch request source=",
                "code": "INVALID_LAUNCH_PRODUCT"
            }
        ]
    },
    "links": {
        "self": {
            "ref": "/buy/checkouts/v2/jobs/c6e266c6-a892-4833-b1df-c98145c66ee7"
        }
    },
    "resourceType": "job"
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLORD/repos/v2-order-api/browse/checkouts/API.md?raw#!/Checkout/get_buy_checkout_results_v2_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

## Upgrading to the Latest Version

Here is the version status of each of the APIs described in this document, along with notes about upgrade paths:

### Checkouts

The latest version of the Checkouts endpoints is v2. All Nike experiences are currently using v2. If a v3 of any of these endpoints becomes available, then the process of upgrading will be documented here.

### Carts

The latest version of the Carts is v2. Information for upgrading from v1 to v2 is provided below:

#### Carts v1-to-v2 Endpoint Mapping

Use the following table to understand which v2 endpoint has replaced a corresponding v1 endpoint, and also which endpoints are new with v2:

|V1 Endpoint Name|Equivalent V2 Endpoint Name|
|---|---|
|Create or Update a Cart|Create or Update a Cart by Cart ID|
|Retrieve Carts by ID|Get a Cart by Cart ID|
|Retrieve Carts by Filter|Get a Cart by Filter Criteria (Query Param)|
|Delete All Items from a Cart|Delete All Items from a Cart by Cart ID|
|None|Modify a Cart by Cart ID|
|None|Create or Update a Cart by Filter Criteria|
|None|Modify a Cart by Filter Criteria|
|None|Get a Cart by Filter Criteria (Path Param)|
|None|Delete all Items from a Cart by Filter Criteria|

#### Carts v1-to-v2 Other Changes

##### Request Headers

For all v2 endpoints, the following additional request headers are required for guest (i.e. non-logged-in) users:

|Header Name|Description|
|---|---|
|**appId**|Unique application identifier of the calling app|
|**x-nike-visitid**|Count of visits by the guest user|

##### Query Parameters

For all v2 GET endpoints where query parameters are used, the **fields** query parameter is no longer supported.

##### Request Body

The following changes apply to all v2 endpoints with a request body:

|Field Name|Description of Change|
|---|---|
|**currency**|Not required at top level as with v1, instead is optional in items.**priceInfo** object|
|items.giftCard.**amount**|New field added in v2|
|items.**recipient**|New field added in v2|
|items.recipient.**firstName**|New field added in v2|
|items.recipient.**lastName**|New field added in v2|
|items.recipient.**altFirstName**|New field added in v2|
|items.recipient.**altLastName**|New field added in v2|
|items.recipient.**givenName**|New field added in v2|
|items.recipient.**middleInitial**|New field added in v2|
|items.recipient.**middleName**|New field added in v2|
|items.**shippingAddress**|New field added in v2|
|items.shippingAddress.**country**|New field added in v2|
|items.shippingAddress.**address1**|New field added in v2|
|items.shippingAddress.**address2**|New field added in v2|
|items.shippingAddress.**address3**|New field added in v2|
|items.shippingAddress.**city**|New field added in v2|
|items.shippingAddress.**county**|New field added in v2|
|items.shippingAddress.**email**|New field added in v2|
|items.shippingAddress.**postalCode**|New field added in v2|
|items.shippingAddress.**state**|New field added in v2|

##### Response Body

The following changes apply to all v2 endpoints with a response body:

|Field Name|Description of Change|
|---|---|
|items.priceInfo.**fullPrice**|New field added in v2|
|items.priceInfo.**msrp**|New field added in v2|

##### Error Messages

|Error Code|Description of Change|
|---|---|
|OUT_OF_STOCK|New code added in v2|
|INVALID_GIFT_CARD_AMOUNT|New code added in v2|

### Cart Reviews

The Cart Reviews endpoint are in v1 due to being released more recently. If a v2 of any of these endpoints becomes available, then the process of upgrading will be documented here.

### Shipping Options

The Shipping Options endpoint is in v2. If a v3 of this endpoint becomes available, then the process of upgrading will be documented here.

## Best Practices

### Conditions for Retries

For retry information by Checkout endpoint, visit [Retry Patterns for Checkout Clients](https://confluence.nike.com/display/DAHP/DRAFT+-+Retry+Pattern+for+Checkout+Service+Clients){:target="blank"} in Confluence.

For all Checkout APIs, the general rule is that HTTP 4XX error codes (except for 429) should not be retried but HTTP 5XX errors can be retried. For general information on Nike error retry practices, see [API Error Patterns](https://confluence.nike.com/pages/viewpage.action?spaceKey=DAHP&title=API+-+Error+Patterns#API-ErrorPatterns-RetrylogicbasedonHTTPstatuscode){:target="blank"} on Confluence.

### Honor the ETAs for Best Performance

For async endpoints that return an ETA, i.e. the estimated time for the job to be completed, it is important for your app to honor the ETA for best performance. For example, if the ETA is 2000ms, your app should wait 2000ms to start polling the /jobs endpoint to avoid consuming network and other resources unnecessarily.

### Test Scenarios

Here is an example list of test scenarios for a user experience that is integrating with the Checkout APIs. Note: in this context, inline refers to a regular Nike product as opposed to a customized Nike iD product.

- Single Item (Inline) - Single Payment (Credit Card)

- Single Item (Inline) - Single Payment (Gift Card)

- Single Item (Inline) - Single Payment (PayPal)

- Single Item (NikeID) - Single Payment (Credit Card)

- Single Item (NikeID) - Single Payment (PayPal)

- Single Item (Inline) - Multiple Payment (Credit Card & Gift Card)

- Single Item (NikeID) - Multiple Payment (Credit Card & Gift Card)

- Mixed Items (Inline & NikeID) - Single Payment (Credit Card)

- Mixed Items (Inline & NikeID) - Single Payment (PayPal)

- Mixed Items (Inline & NikeID) - Multiple Payment (Credit Card & Gift Card)

Additionally, it's useful to add scenarios for multi-quantity (i.e. quantity > 1) for Inline items, as well as scenarios with multiple Nike iD items in same checkout.

>**TIP:** While inspecting browser activity on www.nike.com/launch, you can change your shopping country with the flag icon at the upper right of the homepage. Also, as necessary you can place an order to observe all the checkout calls. Orders can be cancelled via self-service within 30 minutes of submission, otherwise contact Nike Customer Service.

### Test Environment

It is recommended to test all Checkout endpoints in the production environment as opposed to the test environment. Using the test environment can have unpredictable results due to the many downstream services which these endpoints are reliant upon in order to provide typical 'production-like' responses.

There are boundaries for testing in production:

- Performance tests at high volumes should never be done in production.

- Calling 'Request a Checkout Submit' in production can result in actual Nike orders being sent for fulfillment, and actual payment methods being authorized and/or charged. Proceed with caution.

### Caching Data

None of the endpoints described in this document support caching.

### Error Handling: Which JSON Field Had The Error?

In error responses from APIs, Nike uses the [JSON Pointer](https://tools.ietf.org/html/rfc6901){:target="blank"} standard to indicate which field of the request JSON had the error.

However, not all Checkout APIs are the same in this regard. This is due to some APIs having been built before Nike decided to use JSON Pointer standard.

For example, error responses from the Checkouts v2 API will vary from error responses from the Carts API.

Examples of both:

Checkouts (built before adopting JSON Pointer standard):

```
{
    "message": "Validation Failed",
    "errors": [{
        "field": "request.items[0].contactInfo.email",
        "code": "INVALID_EMAIL",
        "message": "Invalid email"
    }]
}
```

Carts (built after adopting JSON Pointer standard):
```
{
    "message": "Validation Failed",
    "errors": [{
        "field": "/request/items/0/contactInfo/email",
        "code": "INVALID_EMAIL",
        "message": "Invalid email"
    }]
}
```

If you are a client of both of the above APIs, you will need to parse error responses in two different ways.

## Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### Use Troubleshooting Tools

- Use the general troubleshooting tips in the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) to check for issues with your request.

- Contact the Buy team on the [#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV){:target="blank"} Slack channel for assistance.

### Common Questions

**Is it okay to call Checkout APIs if my app is hosted in an Amazon Web Services VPC?**

Yes. The APIs are exposed publicly so it shouldn't matter where you are calling from. If you are calling repeatedly from a small set of IP addresses, it might be possible that Nike's bot-mitigation tools could interfere with your ability to make calls. If you are having issues, reach out to us for help.

**My Checkout Submit job is taking a long time to complete. What gives?**

Checkout Submits initiate a lot of behind-the-scenes API calls, the duration of which is somewhat unpredictable. Depending on the total volume of requests happening at the time your request was submitted, combined with the payment method and shipping country selected by the user, it may take several seconds to get a completed job. Best case is about 5 seconds, worst case can be well over a minute. If the job times out, you will get a 'completed with error' job status.

## Glossary

See the [Glossary](/doc/commerce/reference/glossary.html)

## Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|10/02/2018|Initial Draft|
|Added Carts v2|03/16/2018|Updates based on Carts v2 API being released|
|Updated links|03/20/2018|Updated links to point to new dev portal|
|Updated external links|04/02/2018|Updated external links to open in new browser window, commented out 'Try It Now' buttons|
|Added Wish Lists API|04/30/2018|Added new Wish Lists API content|
|Added 'Required?' to tables|06/26/2018|Added required column to tables that were missing it|
|Updated TOC|10/01/2018|Removed 'In this guide', replaced with sidebar TOC|

## Related Links

[NDe Docs Home](/index.html)

[Get Started](/doc/getting-started/get-started.html)