---
id: use-carts
tags: pdf
category: b-use-case
position: 6
title: Carts
url: /doc/commerce/checkout/use-carts.html
toc:
  - h2: Introduction
    url: /doc/commerce/checkout/use-carts.html#introduction
  - h2: Carts
    url: /doc/commerce/checkout/use-carts.html#carts
  - h2: API Quick Reference
    url: /doc/commerce/checkout/use-carts.html#api-quick-reference
  - h2: Troubleshooting
    url: /doc/commerce/checkout/use-carts.html#troubleshooting
  - h2: Contacting the Team
    url: /doc/commerce/checkout/use-carts.html#contacting-the-team
  - h2: Next Steps
    url: /doc/commerce/checkout/use-carts.html#next-steps
---
{% include dev-header.html %}

---

##### Last Updated: 05/09/2022

Read this guide to learn how to add Carts to your experience.

>**TIPS**:
>- Before using this guide, read [Using Nike APIs](/doc/getting-started/using-nike-apis.html) and [Cart & Checkout Overview](/doc/commerce/checkout/overview-checkout.html).
>- Use this guide as a supplement to the API Reference for detailed use cases. See [API Quick Reference](#api-quick-reference) for links to all the API Reference docs discussed here.

## Introduction

### What is a Cart?

In e-commerce,
the shopping cart (also called a basket or bag)
allows consumers to collect and compare products that they are considering for purchase,
but without requiring membership or entering any shipping and billing information.

At Nike, a cart contains the following:

- Products and services with respective prices, discounts, and quantities
- Promotion codes
- Totals

See also [How Is a Wish List different From a Cart?](/doc/commerce/checkout/use-wishlists.html#how-is-a-wishlist-different-from-a-cart) and [What Is a Checkout?](/doc/commerce/checkout/use-checkout.html#what-is-a-checkout).

## Carts

<i class="g72-check"></i>&nbsp;&nbsp;**Manage a consumer's shopping cart and get product pricing**

<i class="g72-check"></i>&nbsp;&nbsp;**Check if a product can be purchased or not**

Now that you know what a cart is, let's explore how to add it to your experience.

### Step 1: Create the Cart

The first step
in managing a consumer's cart is to create the cart using the [Carts API](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="new-tab"}.
For example, this could be done when the consumer chooses to add their first product to the cart.

To create the cart,
execute a request to the [Create
or Update a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-cart-id-put){:target="new-tab"} or [Create or Update a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-filter-criteria-put){:target="new-tab"} endpoint.

>**TIP:** A cart is owned by one consumer (member, guest, or employee) who must be authenticated. If an attempt is made to manage a cart when no, or incorrect, authentication is provided, the Carts API returns an error response. See [Authorization](/doc/getting-started/using-nike-apis.html#authorization) for more information.

Sample [Create or Update a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-cart-id-put){:target="new-tab"} PUT request URI:
```
https://api.nike.com/buy/carts/v2/61bc115b-16e5-43b5-bcaf-dd6168c543f8
```

When you successfully create the cart, the response contains product pricing.
If the consumer is a member who has saved a shipping address,
the response contains their recipient (contact) information and default shipping address from their Nike profile.

### Step 2: Get a Cart

Now that the cart is created, you can display the cart to the consumer by calling the Cart Views API.
This allows the consumer to continue shopping and view the cart details again later.

>**NOTE**: Cart Views operates asynchronously. This means that after you execute the initial request, you call another endpoint to get the result. See [Using Nike APIs](/doc/getting-started/using-nike-apis.html#asynchronous-operation) for more details.

#### Step 2a: Send a PUT to Cart Views

Execute a PUT request to [Request Cart Views](https://developer.niketech.com/docs/projects/Cart%20Views?tab=api#cart-views-endpoints-put){:target="new-tab"}
to initiate a job to generate a view of a cart.

The request for cart views can be made in one of two ways:

**1. Request by Country, Brand, and Channel**

Sample Request Body:
```json
{
  "request": {
    "cart": {
      "country": "US",
      "brand": "NIKE",
      "channel": "NIKECOM"
    },
    "locale": "en_US"
  }
}
```

**2. Request by Cart ID**

Note that `fulfillmentDetails` are optional.

Sample Request Body:
```json
{
  "request": {
    "cart": {
      "id": "9af84d4b-6a1f-4899-af57-b4379f966913"
    },
    "locale": "en_US",
    "fulfillmentDetails": {
      "type": "SHIP",
      "location": {
        "type": "address/shipping",
        "postalAddress": {
          "postalCode": "97005",
          "country": "US"
        }
      }
    }
  }
}
```

>**TIP**: All Carts Views PUT requests must include a `locale`, e.g. "en_US"

#### Step 2b: Retrieve the Cart Views Job

Execute a GET request to the [Retrieve Cart Views Job](https://developer.niketech.com/docs/projects/Cart%20Views?tab=api#cart-views-endpoints-get){:target="new-tab"} endpoint
to get the actual cart details.
The job expires in 60 seconds.

### Step 3: Modify the Cart

To add or remove products, services, and promotion codes from a cart,
execute a request
to the [Modify a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-modify-a-cart-by-cart-id-patch){:target="new-tab"}
or [Modify a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-modify-a-cart-by-filter-criteria-patch){:target="new-tab"} endpoint.

>**TIP:** Prices and subtotals are recalculated and returned in the response to each request.

To delete **all** the products in the cart,
execute a request to [Delete All Items from a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-delete-all-items-from-a-cart-by-cart-id-delete){:target="new-tab"}
or [Delete All Items from a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-delete-all-items-from-a-cart-by-filter-criteria-delete){:target="new-tab"} endpoints.

The delete operation is optional, even if the cart is empty;
member's carts will automatically purge from storage after 90 days of inactivity,
while guest carts will purge at 30 days.

>**TIP:** For more info on how to use the `?filter` query parameter, see [Using Nike APIs](/doc/getting-started/using-nike-apis.html#query-parameters).

## API Quick Reference

**Carts V2**
- [Create or Update a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-cart-id-put){:target="new-tab"}
- [Modify a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-modify-a-cart-by-cart-id-patch){:target="new-tab"}
- [Delete All Items from a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-delete-all-items-from-a-cart-by-cart-id-delete){:target="new-tab"}
- [Create or Update a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-filter-criteria-put){:target="new-tab"}
- [Modify a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-modify-a-cart-by-filter-criteria-patch){:target="new-tab"}
- [Delete All Item from a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-delete-all-items-from-a-cart-by-filter-criteria-delete){:target="new-tab"}

**Cart Views**

- [Request Cart Views](https://developer.niketech.com/docs/projects/Cart%20Views?tab=api#cart-views-endpoints-put){:target="new-tab"}
- [Retrieve Cart Views Job](https://developer.niketech.com/docs/projects/Cart%20Views?tab=api#cart-views-endpoints-get){:target="new-tab"}

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
|Team Contacts|[Sree Krishna](mailto:sree.krishna@nike.com)|

## Document Change Log

| Summary                                                                                                                  | Date       |
|--------------------------------------------------------------------------------------------------------------------------|------------|
| Converted to stand alone guide, formerly in Cart & Checkout guide                                                        | 04/23/2020 |
| Changed cart 'get' operations to use Cart Views instead of Carts v2, moved Cart Reviews content to Cart & Checkout guide | 05/09/2022 |

## Next Steps

You've learned how to add Carts to your experience. Here are some related topics.

- [Wishlist](/doc/commerce/checkout/use-wishlists.html)
- [Checkout](/doc/commerce/checkout/use-checkout.html)
- [Fulfillment Offerings](/doc/commerce/checkout/use-fulfillment-offerings.html)
- [Payment](/doc/commerce/payment/use-payment.html)
- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)
- [Supported Countries](/doc/commerce/reference/global.html)