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
##### Last Updated: 04/23/2020

Read this guide to learn how to add Carts and Cart Reviews to your experience.

>**TIPS**:
>- Before using this guide, read [Using Nike APIs](/doc/getting-started/using-nike-apis.html) and [Cart & Checkout Overview](/doc/commerce/checkout/overview-checkout.html).
>- Use this guide as a supplement to the API Reference for detailed use cases. See [API Quick Reference](#api-quick-reference) for links to all the API Reference docs discussed here.

## Introduction

### What is a Cart?

In e-commerce, the shopping cart (also called basket or bag) allows consumers to collect and compare products that they are considering for purchase, but without requiring membership or entering any shipping and billing information.

At Nike, a cart contains the following:

- Products and services with respective prices, discounts, and quantities
- Promotion codes
- Totals

See also [How Is a Wish List different From a Cart?](/doc/commerce/checkout/use-wishlists.html#how-is-a-wishlist-different-from-a-cart) and [What Is a Checkout?](/doc/commerce/checkout/use-checkout.html#what-is-a-checkout).

## Carts

<i class="g72-check"></i>&nbsp;&nbsp;**Manage a consumer's shopping cart and get product pricing**

<i class="g72-check"></i>&nbsp;&nbsp;**Check if a product can be purchased or not**

<i class="g72-check"></i>&nbsp;&nbsp;**Summarize a cart prior to checkout**

Now that you know what a cart is, let's explore how to add it to your experience.

### Step 1: Create the Cart

The first step in managing a consumer's cart is to create the cart using the [Carts API](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="new-tab"}. For example, this could be done when the consumer chooses to add their first product to the cart.

To create the cart, execute a request to the [Create or Update a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-cart-id-put){:target="new-tab"} or [Create or Update a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-filter-criteria-put){:target="new-tab"} endpoint.

>**TIP:** A cart is owned by one consumer (member, guest, or employee) who must be authenticated. If an attempt is made to manage a cart when no, or incorrect, authentication is provided, the Carts API returns an error response. See [Authorization](/doc/getting-started/using-nike-apis.html#authorization) for more information.

Sample [Create or Update a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-cart-id-put){:target="new-tab"} PUT request URI:
```
https://api.nike.com/buy/carts/v2/61bc115b-16e5-43b5-bcaf-dd6168c543f8
```

When you successfully create the cart, the response contains product pricing. If the consumer is a member who has saved a shipping address, the response contains their recipient (contact) information and default shipping address from their Nike profile.

### Step 2: Get a Cart

Now that the cart is created, you can display the cart to the consumer. This allows the consumer to continue shopping and view the cart details again later.

To get a cart, you have a few options depending on what information you need:

1. Execute a request to the [Get a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-get-a-cart-by-cart-id-get){:target="new-tab"}, [Get a Cart by Filter Criteria (Query Param)](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-get-a-cart-by-filter-query-param-get){:target="new-tab"}, or [Get a Cart by Path Parameters](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-get-a-cart-by-path-parameters-get){:target="new-tab"} endpoint of the Carts API to get the full details of the cart.
2. Execute a request to the [Get a Cart Summary by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-get-a-cart-summary-by-cart-id-get){:target="new-tab"} endpoint, only if you support PayPal Express payment type and want to display promo codes on the order confirmation.

>**TIP:** For more info on how to use the `?filter` query parameter, see [Using Nike APIs](/doc/getting-started/using-nike-apis.html#query-parameters).

### Step 3: Modify the Cart

To add or remove products, services, and promotion codes from a cart, execute a request to the [Modify a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-modify-a-cart-by-cart-id-patch){:target="new-tab"} or [Modify a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-modify-a-cart-by-filter-criteria-patch){:target="new-tab"} endpoint.

>**TIP:** Prices and subtotals are recalculated and returned in the response to each request.

To delete **all** of the products in the cart, execute a request to [Delete All Items from a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-delete-all-items-from-a-cart-by-cart-id-delete){:target="new-tab"} or [Delete All Items from a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-delete-all-items-from-a-cart-by-filter-criteria-delete){:target="new-tab"} endpoints.

The delete operation is optional, even if the cart is empty; member's carts will automatically purge from storage after 90 days of inactivity, while guest carts will purge at 30 days.

### Step 4: Get a Cart Summary

After the consumer has finished adding products to their cart, you can use the Cart Reviews API to show them a summary of their cart before they proceed to checkout. The summary includes updated subtotals of all cart items, taxes, estimated delivery/pick up dates and costs.

Details on the available Cart Reviews versions are listed below.

###### Table 1: Cart Reviews API Versions

|Version|Description|
|---|---|
|**V2**|Used in [omni-channel](/doc/commerce/checkout/overview-checkout.html#which-api-version-should-i-use) shopping flow<br>Supports [fulfillment offerings](/doc/commerce/checkout/use-fulfillment-offerings.html), including Buy-Online-Pickup-In-Store (BOPIS)<br>For registered consumers, guest consumers, and employees<br>Asynchronous endpoint|
|**V1**|Used in [legacy](/doc/commerce/checkout/overview-checkout.html#which-api-version-should-i-use) shopping flow<br>Limited to basic [shipping options](/doc/commerce/checkout/use-checkout.html#shipping-options), for example Standard<br>For registered consumers and employees only<br>Synchronous endpoint|


#### Cart Reviews V2

Execute a PUT request to the [Create a Job](https://developer.niketech.com/docs/projects/Cart%20Reviews%20V2?tab=api#cart-reviews-v2-endpoints-cart-reviews-v2-jobs-endpoint-put){:target="new-tab"} endpoint with a complete cart, passing the **country**, **currency**, and **fulfillmentDetails** for each item returned from [fulfillment offerings](/doc/commerce/checkout/use-fulfillment-offerings.html) associated with the consumer. The `id` path parameter is a client-generated UUID.

>**NOTE**: Cart Reviews V2 operates asynchronously. This means that after you execute the initial request, you call another endpoint to get the result. See [Using Nike APIs](/doc/getting-started/using-nike-apis.html#asynchronous-operation) for more details.

Sample [Create a Job](https://developer.niketech.com/docs/projects/Cart%20Reviews%20V2?tab=api#cart-reviews-v2-endpoints-cart-reviews-v2-jobs-endpoint-put){:target="new-tab"} PUT request URI:
```
https://api.nike.com/buy/cart_reviews/v2/52bc115b-16e5-43b5-bcaf-dd6168c543g9
```

After calling [Create a Job](https://developer.niketech.com/docs/projects/Cart%20Reviews%20V2?tab=api#cart-reviews-v2-endpoints-cart-reviews-v2-jobs-endpoint-put){:target="new-tab"} and receiving a HTTP 202 response, execute a GET request to [Retrieve a Job Result](https://developer.niketech.com/docs/projects/Cart%20Reviews%20V2?tab=api#cart-reviews-v2-endpoints-cart-reviews-v2-jobs-endpoint-get){:target="new-tab"} using the same Cart Reviews ID to check the status of your job.

To know if the job is done, check the value of the status field in the response body as follows:

- `"status"`: `"PENDING"`: job processing has not started

- `"status"`: `"IN_PROGRESS"`: job processing is in progress

- `"status": "COMPLETED"`: job has completed

Once you receive a job status of `COMPLETED`, get the results of your job by parsing the data in the response object.

Sample [Retrieve a Job Result](https://developer.niketech.com/docs/projects/Cart%20Reviews%20V2?tab=api#cart-reviews-v2-endpoints-cart-reviews-v2-jobs-endpoint-get){:target="new-tab"} GET request:

```
https://api.nike.com/buy/cart_reviews/v2/52bc115b-16e5-43b5-bcaf-dd6168c543g9
```

A successful 200 response in the `COMPLETED` state contains `currency`, `locale` and `fulfillmentGroups` information.

#### Cart Reviews V1 (Legacy)

To get a cart summary, execute a request to the [Augment a Cart](https://developer.niketech.com/docs/projects/Cart%20Reviews?tab=api#cart-reviews-augment-a-cart-post){:target="new-tab"} endpoint with a complete cart.

>**NOTE**: It is not required to create a cart with the Carts V2 API prior to sending a request to the Cart Reviews V1 API. Instead of using Cart ID in the request, send the **country**, **currency**, and **brand** associated with the consumer.

Cart Reviews V1 does not support guest consumers. The consumer must be logged in.

You can get additional info in the response by including the following in the request:

- To get sales tax and shipping tax, include postal code.

- To get estimated delivery date(s), include the shipping method(s).

- To get shipping group information, include the shipping method and the shipping address associated with each product.

Sample [Augment a Cart](https://developer.niketech.com/docs/projects/Cart%20Reviews?tab=api#cart-reviews-augment-a-cart-post){:target="new-tab"} POST request URI:

```
https://api.nike.com/buy/cart_reviews/v1/
```

A successful 200 `COMPLETED` response contains `country`, `currency`, `locale`, `brand`, `channel`, and `shippingGroups` information.

>**TIPS:**
>- Shipping group refers to the grouping of products into multiple shipments with potentially different delivery dates. This is done automatically for you based on Nike business rules.
>- For China consumers, you can capture and include [Fapiao invoice](https://www.sirva.com/docs/default-source/resources-docs/reports/2012/what-are-fapiaos-and-why-do-they-matter-.pdf){:target="new-tab"} info in the request and it will be returned in the response.

## API Quick Reference

**Carts V2**
- [Create or Update a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-cart-id-put){:target="new-tab"}
- [Modify a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-modify-a-cart-by-cart-id-patch){:target="new-tab"}
- [Delete All Items from a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-delete-all-items-from-a-cart-by-cart-id-delete){:target="new-tab"}
- [Get a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-get-a-cart-by-cart-id-get){:target="new-tab"}
- [Get a Cart by Filter Criteria (Query Param)](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-get-a-cart-by-filter-query-param-get){:target="new-tab"}
- [Create or Update a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-filter-criteria-put){:target="new-tab"}
- [Modify a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-modify-a-cart-by-filter-criteria-patch){:target="new-tab"}
- [Get a Cart by Filter Criteria (Path Param)](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-get-a-cart-by-path-parameters-get){:target="new-tab"}
- [Delete All Item from a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-delete-all-items-from-a-cart-by-filter-criteria-delete){:target="new-tab"}

**Cart Reviews**

V1:
- [Augment a Cart](https://developer.niketech.com/docs/projects/Cart%20Reviews?tab=api#cart-reviews-augment-a-cart-post){:target="new-tab"}

V2:
- [Create a Job](https://developer.niketech.com/docs/projects/Cart%20Reviews%20V2?tab=api#cart-reviews-v2-endpoints-cart-reviews-v2-jobs-endpoint-put){:target="new-tab"}
- [Retrieve a Job Result](https://developer.niketech.com/docs/projects/Cart%20Reviews%20V2?tab=api#cart-reviews-v2-endpoints-cart-reviews-v2-jobs-endpoint-get){:target="new-tab"}

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

|Summary |Date |Description|
|---|---|---|
|Converted to stand alone guide|04/23/2020|Content moved from Cart & Checkout use-case guide|

## Next Steps

You've learned how to add Carts to your experience. Here are some related topics.

- [Wishlist](/doc/commerce/checkout/use-wishlists.html)
- [Checkout](/doc/commerce/checkout/use-checkout.html)
- [Fulfillment Offerings](/doc/commerce/checkout/use-fulfillment-offerings.html)
- [Payment](/doc/commerce/payment/use-payment.html)
- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)
- [Supported Countries](/doc/commerce/reference/global.html)