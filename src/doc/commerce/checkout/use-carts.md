---
id: use-carts
tags: pdf
#category: b-use-case
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
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn-secondary-grey guide-button"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING CARTS TO YOUR EXPERIENCE

---

##### Last Updated: 06/20/2019

Read this guide to learn how to add [Carts](#carts) to your experience.

>**TIPS**:
>- Before using this guide, read [Using Nike APIs](/doc/getting-started/using-nike-apis.html) and [Cart & Checkout Overview](/doc/commerce/checkout/overview-checkout.html).
>- Use this guide as a supplement to the API Reference for detailed use cases. See [API Quick Reference](#api-quick-reference) for links to all the API Reference docs discussed here.
>- The steps involving **Payment** are covered in [Adding Payment to Your Experience](/doc/commerce/payment/use-payment.html).

## Introduction

### What is a Cart?

In e-commerce, the shopping cart (also called basket or bag) allows consumers to collect and compare products that they are considering for purchase, but without requiring membership or entering any shipping and billing information.

At Nike, a cart contains the following:

- Products & services with respective prices, discounts, and quantities
- Promotion codes
- Totals

See also [How is a Wish List different from a Cart?](/doc/commerce/checkout/use-wishlists.html#how-is-a-wishlist-different-from-a-cart) and [What is a Checkout?](/doc/commerce/checkout/use-checkouts.html#what-is-a-checkout).

## Carts

<i class="g72-check"></i>&nbsp;&nbsp;**Manage a consumer's shopping cart and get product pricing**

<i class="g72-check"></i>&nbsp;&nbsp;**Check if a product can be purchased or not**

<i class="g72-check"></i>&nbsp;&nbsp;**Summarize a cart prior to checkout**

Now that you know what a cart is, let's explore how to add it to your experience.

### Step 1: Create the Cart

The first step in managing a consumer's cart is to create the cart using the [Carts API](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="new-tab"}. For example, this could be done when the consumer chooses to add their first product(s) to the cart.

To create the cart, execute a request to the [Create or Update a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-cart-id-put){:target="new-tab"} or [Create or Update a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-filter-criteria-put){:target="new-tab"} endpoint.

>**TIP:** A cart is owned by one consumer (member, guest, or employee) who must be authenticated. If an attempt is made to manage a cart when no, or incorrect, authentication is provided, an error will be returned by the Carts API.

Sample [Create or Update a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-cart-id-put){:target="new-tab"} request URI:
```
https://api.nike.com/buy/carts/v2/61bc115b-16e5-43b5-bcaf-dd6168c543f8
```

If you successfully create the cart, you will get product pricing and, if the consumer is a member who has saved a shipping address, you will get their default shipping address and recipient (i.e. contact) info from their Nike profile.

### Step 2: Get a Cart

Now that the cart has been created, you can display the cart to the consumer, for example if they continue shopping and then later want to see the cart details again.

To get a cart, you have a few options depending on what information you need:

1. Execute a request to the [Get a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-get-a-cart-by-cart-id-get){:target="new-tab"}, [Get a Cart by Filter Criteria (Query Param)](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-get-a-cart-by-filter-query-param-get-2){:target="new-tab"}, or [Get a Cart by Path Parameters](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-get-a-cart-by-path-parameters-get-1){:target="new-tab"} endpoint of the Carts API to get the full details of the cart.
2. Execute a request to the [Get a Cart Summary by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-get-a-cart-summary-by-cart-id-get-1){:target="new-tab"} endpoint, only if you support PayPal Express payment type and want to display promo codes on the order confirmation.

>**TIP:** For more info on how to use the `?filter` query parameter, see [Using Nike APIs](/doc/getting-started/using-nike-apis.html#query-parameters).

### Step 3: Modify the Cart

To add or remove products, services, and promotion codes from a cart, execute a request to the [Modify a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-modify-a-cart-by-cart-id-patch-1){:target="new-tab"} or [Modify a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-modify-a-cart-by-filter-criteria-patch-1){:target="new-tab"} endpoint.

>**TIP:** Prices and subtotals are recalculated and returned in the response to each request.

To delete **all** of the products in the cart, execute a request to [Delete All Items from a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-delete-all-items-from-a-cart-by-cart-id-delete-1){:target="new-tab"} or [Delete All Items from a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-delete-all-items-from-a-cart-by-filter-criteria-delete-1){:target="new-tab"} endpoints.

The delete operation is optional, even if the cart is empty; member's carts will automatically purge from storage after 90 days of inactivity, while guest carts will purge at 30 days.

### Step 4: Get a Cart Summary

The consumer has finished adding products to the cart, and you can use the [Cart Reviews API](https://developer.niketech.com/docs/projects/Cart%20Reviews?tab=api){:target="new-tab"} to show them a cart summary before they proceed to checkout.

Cart Reviews currently has two versions available:

|Version|Notes|
|---|---|
|v1|Limited to only basic shipping methods (e.g. Standard, Two-Day)|
|v2|Based on [Fulfillment Offerings](/doc/commerce/checkout/use-fulfillment-offerings.html), including Buy-Online-Pickup-In-Store (BOPIS)|

**Using Cart Reviews v2**

- Execute a request to the [Augment a Cart](https://developer.niketech.com/docs/projects/Cart%20Reviews?tab=api#cart-reviews-augment-a-cart-post){:target="new-tab"} endpoint with a complete cart.

    >**NOTE**: It is not required to create a cart with the Carts API prior to sending a request to the Cart Reviews API. Instead of using Cart ID in the request, send the **country**, **currency**, and **brand** associated with the consumer.

- Include any known fulfillment details in the request as per the [Fulfillment Offerings](/doc/commerce/checkout/use-fulfillment-offerings.html#what-are-fulfillment-offerings) schema.

Sample [Augment a Cart](https://developer.niketech.com/docs/projects/Cart%20Reviews?tab=api#cart-reviews-augment-a-cart-post){:target="new-tab"} request URI:
```
https://api.nike.com/buy/cart_reviews/v2/
```

**Using Cart Reviews v1 (Legacy)**

- Execute a request to the [Augment a Cart](https://developer.niketech.com/docs/projects/Cart%20Reviews?tab=api#cart-reviews-augment-a-cart-post){:target="new-tab"} endpoint with a complete cart.

- Optionally include additional info in the request to get additional info in the response, as follows:

    - To get sales tax and shipping tax, the request must include postal code.

    - To get estimated delivery date(s), the request must include the shipping method(s).

    - To get shipping group information, the request must include the shipping method and the shipping address associated with each product.

>**TIPS:**
>- Shipping group refers to the grouping of products into multiple shipments with potentially different delivery dates. This is done automatically for you based on Nike business rules.
>- For China consumers, you can capture and include [Fapiao invoice](https://www.sirva.com/docs/default-source/default-document-library/what-are-fapiaos-and-why-do-they-matter-.pdf) info in the request and it will be returned in the response.

Sample [Augment a Cart](https://developer.niketech.com/docs/projects/Cart%20Reviews?tab=api#cart-reviews-augment-a-cart-post){:target="new-tab"} request URI:
```
https://api.nike.com/buy/cart_reviews/v1/
```

## API Quick Reference

**Carts**
- [Create or Update a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="new-tab"}
- [Modify a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="new-tab"}
- [Delete All Items from a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="new-tab"}
- [Get a Cart by Cart ID](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="new-tab"}
- [Get a Cart by Filter Criteria (Query Param)](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api)
- [Create or Update a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="new-tab"}
- [Modify a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="new-tab"}
- [Get a Cart by Filter Criteria (Path Param)](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="new-tab"}
- [Delete All Item from a Cart by Filter Criteria](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api){:target="new-tab"}

**Cart Reviews**
- [Augment a Cart](https://developer.niketech.com/docs/projects/Cart%20Reviews?tab=api){:target="new-tab"}

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
|Initial draft|06/20/2019|Initial Draft|

## Next Steps

You've learned how to add Carts to your experience. Here are some next steps.

[Documentation Home](/index.html)

[Get Started](/doc/getting-started/get-started.html)

[Supported Countries & Currencies](/doc/commerce/checkout/checkout-country-currency.html)