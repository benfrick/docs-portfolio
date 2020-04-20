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
{% include overview-header.html %}

---

Learn how to use Cart, Checkout, and Payment to enable the purchase of Nike products and services in your app.

### Consumers purchase quickly and easily using Nike Cart, Checkout, and Payment

Nike builds digital experiences that showcase its premium products and tell amazing stories. Powering those experiences is <font class="u-bold">Nike Cart, Checkout, and Payment</font>, built to handle the massive scale of global e-commerce.

![SNKRS app payment flow](/images/commerce/payment/snkrs_payment-md.png){:style="float:right;"}

#### Adding Cart, Checkout, and Payment To Your App or Experience

The consumer finds a Nike product that they love in your app. What happens next? Step through the check list below to incorporate Cart, Checkout, and Payment capabilities into your experience.

|---|
|<i class="numberCircle gray">1</i>&nbsp;&nbsp;[Manage a consumer's shopping cart and get product pricing](/doc/commerce/checkout/use-carts.html)|
|<i class="numberCircle gray">2</i>&nbsp;&nbsp;[Manage a consumer's wishlist (member/employee only) of products and services](/doc/commerce/checkout/use-wishlist.html)|
|<i class="numberCircle gray">3</i>&nbsp;&nbsp;[Check the 'buyability' of a product](/doc/commerce/checkout/use-carts.html)|
|<i class="numberCircle gray">4</i>&nbsp;&nbsp;[Review a consumer's cart for checkout](/doc/commerce/checkout/use-carts.html)|
|<i class="numberCircle gray">5</i>&nbsp;&nbsp;[Get available shipping options](/doc/commerce/checkout/use-checkout.html#shipping-options) or [get available fulfillment offerings](/doc/commerce/checkout/use-fulfillment-offerings.html) <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;See [Which API Version Should I Use](#which-api-version-should-i-use) for more details.|
|<i class="numberCircle gray">6</i>&nbsp;&nbsp;[Validate a shipping address](/doc/commerce/checkout/use-checkout.html#shipping-address-validation)|
|<i class="numberCircle gray">7</i>&nbsp;&nbsp;[Validate a checkout for fulfillment](/doc/commerce/checkout/use-checkout.html#previewing-a-checkout)|
|<i class="numberCircle gray">8</i>&nbsp;&nbsp;[Get available payment methods](/doc/commerce/payment/use-payment.html)|
|<i class="numberCircle gray">9</i>&nbsp;&nbsp;[Validate payment](/doc/commerce/payment/use-payment.html#payment-preview)|
|<i class="numberCircle gray">10</i>&nbsp;&nbsp;[Submit a checkout for fulfillment](/doc/commerce/checkout/use-checkout.html#submitting-a-checkout)|

#### Which API Version Should I Use?

The Nike shopping experience involves several APIs. Your app or experience implements one of two fulfillment flows, legacy or Omnichannel. The main difference between the two flows is that the Omnichannel flow gives consumers much more flexibility in how, when, and where to receive Nike products. The legacy flow allows consumers to choose how quickly they want all products delivered to a shipping address. The Omnichannel flow expands the fulfillment options to include ship, digital delivery, and pick up for each item based on consumer location.

The APIs required for the two fulfillment flows are listed below.

###### Table 1: Legacy vs. Omnichannel Required APIs

|Legacy|Omni-channel|
|---|---|
|Carts V2<br>Shipping Options V1<br>Cart Reviews V1<br>Payment Options V1<br>Checkout Previews V2<br>Payment Preview V1<br>Checkouts V2|Carts V2<br>Fulfillment Offerings V1<br>Cart Reviews V2<br>Payment Options V2<br>Checkout Previews V3<br>Payment Preview V2<br>Checkouts V3|

<h4>Related Information</h4>
<aside class="note">
<h5 style="text-align:center;">APIs</h5>
<ul>
    <li>
        <a href="https://developer.niketech.com/docs/projects/Carts%20V2?tab=api" target="new-tab">Carts</a> <span class="guide-details-li-text"></span>
    </li>
    <li>
        Cart Reviews <a href="https://developer.niketech.com/docs/projects/Cart%20Reviews?tab=api" target="new-tab">V1</a> and <a href="https://developer.niketech.com/docs/projects/Cart%20Reviews%20V2?tab=api" target="new-tab">V2</a><span class="guide-details-li-text"></span>
    </li>
    <li>
        <a href="https://developer.niketech.com/docs/projects/Shipping%20Options?tab=api" target="new-tab">Shipping Options</a> <span class="guide-details-li-text"></span>
    </li>
    <li>
        <a href="https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api" target="new-tab">Fulfillment Offerings</a> <span class="guide-details-li-text"></span>
    </li>
    <li>
        <a href="https://developer.niketech.com/docs/projects/AddressValidator?tab=api" target="new-tab">Address Validation</a> <span class="guide-details-li-text"></span>
    </li>
    <li>
        Payment Options <a href="https://developer.niketech.com/docs/projects/Payment%20Options?tab=api" target="new-tab">V1</a> and <a href="#" target="new-tab">V2</a><span class="guide-details-li-text"></span>
    </li>
    <li>
        Payment Preview <a href="https://developer.niketech.com/docs/projects/Payment%20Preview?tab=api" target="new-tab">V1</a> and <a href="#" target="new-tab">V2</a><span class="guide-details-li-text"></span>
    </li>
    <li>
        Checkout Previews <a href="https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api" target="new-tab">V2</a> and <a href="https://developer.niketech.com/docs/projects/Checkout%20Previews%20V3?tab=api" target="new-tab">V3</a> <span class="guide-details-li-text"></span>
    </li>

        <li>
            Checkouts <a href="https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api" target="new-tab">V2</a> and <a href="https://developer.niketech.com/docs/projects/Checkouts%20V3?tab=api" target="new-tab">V3</a> <span class="guide-details-li-text"></span>
        </li>
</ul>
</aside>

* [Supported Countries & Currencies:](/doc/commerce/checkout/checkout-country-currency.html) Refer to this guide for the list of supported country code and currency code combinations allowed by Cart & Checkout.

* [Wishlist:](/doc/commerce/checkout/use-wishlist.html) Learn how to add Wishlist to your shopping experience.

* [Carts:](/doc/commerce/checkout/use-carts.html) Learn how to manage a Cart as part of your checkout flow.

* [Fulfillment Offerings:](/doc/commerce/checkout/use-fulfillment-offerings.html) Enable your consumers to choose how and when to get Nike product.

* [Checkout:](/doc/commerce/checkout/use-checkout.html) Learn how to manage a Checkout as part of your shopping flow.

* [Payment:](/doc/commerce/payment/use-payment.html) Learn how to collect payment as part of your checkout flow.

* [Working with Circuit Breakers:](/doc/commerce/reference/caller-best-practices.html) Learn how to be a good client by following these best practices.

* [Glossary:](/doc/commerce/reference/glossary.html) Common terms explained.

* [Product Life Cycle:](/doc/commerce/reference/product-lifecycle.html) Discover how Nike products become available for purchase in an experience.

#### Connect

We're here to help.&nbsp;&nbsp;&nbsp;<i class="g72-chat"></i> [#Slack](slack://channel?team=T0G3T5X2B&id=C6A18NT7W)&nbsp;&nbsp;&nbsp;<i class="g72-email"></i> [Email](mailto:Lst-nde.docs@nike.com)