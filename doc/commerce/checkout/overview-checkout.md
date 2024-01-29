---
id: overview-checkout
tags: pdf
category: a-overview
position: 6
title: Cart & Checkout
url: /doc/commerce/checkout/overview-checkout.html
h1: Cart & Checkout Overview
dev-guide: /doc/commerce/checkout/use-checkout.html
---

Learn how to use Nike Cart, Checkout, and Payment to enable the purchase of Nike products and services in your app.

### Consumers Purchase Quickly and Easily Using Cart, Checkout, and Payment

Nike builds digital experiences that showcase its premium products and tell amazing stories.
Powering those experiences are **Nike's Cart, Checkout, and Payment APIs**,
built to handle the massive scale of global e-commerce.

#### Adding Cart, Checkout, and Payment To Your App or Experience

The consumer finds a Nike product that they love in your app.
What happens next?
Step through the checklist below to incorporate Cart, Checkout, and Payment capabilities into your experience.

- [Manage a consumer's shopping cart and get product pricing](/doc/commerce/checkout/use-carts.html#carts)
- [Manage a consumer's wishlist (member/employee only) of products and services](/doc/commerce/checkout/use-wishlists.html)
- [Review a consumer's cart for checkout](/doc/commerce/checkout/use-carts.html#step-2-get-a-cart)
- [Get available fulfillment offerings](/doc/commerce/checkout/use-fulfillment-offerings.html)
- [Validate a shipping address](/doc/commerce/checkout/use-checkout.html#shipping-address-validation)
- [Validate a checkout for fulfillment](/doc/commerce/checkout/use-checkout.html#checkout-preview)
- [Get available payment methods](/doc/commerce/payment/use-payment.html#listing-and-validating-payment-options)
- [Validate payment](/doc/commerce/payment/use-payment.html#payment-preview)
- [Submit a checkout for fulfillment](/doc/commerce/checkout/use-checkout.html#checkout-submit)

#### Which API Version Should I Use?

To implement a Nike shopping experience,
your app or experience implements one of two fulfillment flows, legacy or omnichannel.

The **legacy** flow allows consumers to choose how quickly all products should be delivered to a shipping address.

The **omnichannel** flow expands the fulfillment options to include ship, digital delivery,
and pickup for each item based on consumer location.
This gives consumers much more flexibility in how, when, and where they can receive Nike products.

The APIs required for the two fulfillment flows are listed below.

###### Table 1: Legacy vs. Omnichannel Required APIs

| Legacy                   | Omnichannel              |
|--------------------------|--------------------------|
| Carts V2                 | Carts V2 & Cart Views    |
| Fulfillment Offerings V1 | Fulfillment Offerings V2 |
| Cart Reviews V2          | Cart Reviews V2          |
| Payment Options V2       | Payment Options V3       |
| Checkout Previews V3     | Checkout Previews V3     |
| Payment Preview V2       | Payment Preview V3       |
| Checkouts V3             | Checkouts V3             |

<h4>Related Information</h4>
<aside class="note">
<h5 style="text-align:center;">APIs</h5>
<ul>
    <li>
        <a href="https://console.platforms.nike.com/developer/docs/projects/Carts%20V2?tab=api" >Carts</a> <span class="guide-details-li-text"></span>
    </li>
    <li>
        <a href="https://console.platforms.nike.com/developer/docs/projects/Cart%20Views?tab=api" >Cart Views</a> <span class="guide-details-li-text"></span>
    </li>
    <li>
        <a href="https://console.platforms.nike.com/developer/docs/projects/Cart%20Reviews%20V2?tab=api" >Cart Reviews V2</a><span class="guide-details-li-text"></span>
    </li>
    <li>
        <a href="https://console.platforms.nike.com/developer/docs/projects/Fulfillment%20Offerings?tab=api" >Fulfillment Offerings</a> <span class="guide-details-li-text"></span>
    </li>
    <li>
        <a href="https://console.platforms.nike.com/developer/docs/projects/AddressValidator?tab=api" >Address Validation</a> <span class="guide-details-li-text"></span>
    </li>
    <li>
        Payment Options <a href="https://console.platforms.nike.com/developer/docs/projects/Payment%20Options?tab=api" >V2</a> and <a href="https://console.platforms.nike.com/developer/docs/projects/Payment%20Options%20v3%20(Source%20Aware)?tab=api" >V3</a><span class="guide-details-li-text"></span>
    </li>
    <li>
        Payment Preview <a href="https://console.platforms.nike.com/developer/docs/projects/Payment%20Preview?tab=api" >V2</a> and <a href="https://console.platforms.nike.com/developer/docs/projects/Payment%20Preview%20V3%20(Source%20aware)?tab=api" >V3</a><span class="guide-details-li-text"></span>
    </li>
    <li>
        <a href="https://console.platforms.nike.com/developer/docs/projects/Checkout%20Previews%20V3?tab=api" >Checkout Previews V3</a> <span class="guide-details-li-text"></span>
    </li>
    <li>
        <a href="https://console.platforms.nike.com/developer/docs/projects/Checkouts%20V3?tab=api" >Checkouts V3</a> <span class="guide-details-li-text"></span>
    </li>
</ul>
</aside>

- [Supported Countries](/doc/commerce/reference/global.html): Refer to this guide for the list of supported country
  code, language, and currency code combinations.
- [Wishlist](/doc/commerce/checkout/use-wishlists.html): Learn how to add Wishlist to your shopping experience.
- [Carts](/doc/commerce/checkout/use-carts.html): Learn how to manage a Cart as part of your checkout flow.
- [Fulfillment Offerings](/doc/commerce/checkout/use-fulfillment-offerings.html): Enable your consumers to choose how
  and when to get Nike product.
- [Checkout](/doc/commerce/checkout/use-checkout.html): Learn how to manage a Checkout as part of your shopping flow.
- [Payment](/doc/commerce/payment/use-payment.html): Learn how to collect payment as part of your checkout flow.
- [Working with Circuit Breakers](/doc/commerce/reference/caller-best-practices.html): Learn how to be a good client by
  following these best practices.
- [Glossary](/doc/commerce/reference/glossary.html): Common terms explained.
- [Product Life Cycle](/doc/commerce/reference/product-lifecycle.html): Discover how Nike products become available for
  purchase in an experience.

#### Connect to the Docs Team

We're here to help.&nbsp;&nbsp;&nbsp;<i class="g72-chat"></i> [Slack](slack://channel?team=T0G3T5X2B&id=C6A18NT7W)
&nbsp;&nbsp;&nbsp;<i class="g72-email"></i> [Email](mailto:Lst-nde.docs@nike.com)