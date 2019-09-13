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
  - h2: Wish Lists
    url: /doc/commerce/checkout/use-fulfillment-offerings.html#carts
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

##### Last Updated: 06/20/2019

Use [Fulfillment Offerings](#fulfillment-offerings) to show consumers the options for getting their purchases, no matter where they are.

>**TIPS**:
>- Before using this guide, read [Using Nike APIs](/doc/getting-started/using-nike-apis.html) and [Cart & Checkout Overview](/doc/commerce/checkout/overview-checkout.html).
>- Use this guide as a supplement to the API Reference for detailed use cases. See [API Quick Reference](#api-quick-reference) for links to all the API Reference docs discussed here.
>- The steps involving **Payment** are covered in [Adding Payment to Your Experience](/doc/commerce/payment/use-payment.html).

## Introduction

In a checkout experience, consumers are accustomed to selecting a fulfillment method (e.g. Two-Day shipping) and being shown the costs and estimated delivery dates.

But what if you want to show them additional options, like a list of nearby stores or other locations where they can pick up their order?

[Fulfillment Offerings](#fulfillment-offerings) gives you all you need to drive a 'Shipping' selection experience like the one shown here.

![](/images/commerce/buy/f-offs-select-options.png)

### What are Fulfillment Offerings?

Fulfillment Offerings are the options that the consumer has for receiving the items they are about to purchase. So, how does it work?

For each item in a checkout that you send to Fulfillment Offerings, one or more offerings is returned. Each offering has the following attributes:

|Offering Attribute|Description|Example|
|---|---|---|
|**Fulfillment Type**|The type of fulfillment offering|`"type": "SHIP"`,`"type": "PICKUP"`|
|**Location**|Delivery destinations|postal/email addresses, store IDs, pickup locations, GPS coordinates|
|**'Get By' Date**|Estimated date (min/max) for the item to be fulfilled|`"dateTime": "2019-02-09T23:59:59.000Z"`|
|**Expiration Date**|The date on which the offering expires|`"offerExpiration": "2019-02-07T00:00:00.000Z"`|
|**Price**|Price of the offering|`"total": 8`|

#### Fulfillment Types

Offerings are grouped by Fulfillment Type. Here are the possible values:

|Type|Description|Example|
|---|---|---|
|`SHIP`|Consumer receives the order at their postal address.|Carrier delivers order to a home address|
|`PICKUP`|Consumer picks up the order at a Nike store or third-party pickup location|'Buy Online Pickup In Store' (BOPIS).|
|`INSTORE`|Consumer completes self-checkout via mobile while in a retail store|Instant Checkout in the Nike app|
|`DIGITAL`|Consumer receives the order at their digital address|Digital gift card is delivered by email.|

#### What Data Do I Need To Provide?

The minimum required data to send to Fulfillment Offerings is:

- `country` code (e.g. US)
- `currency` code (e.g. USD)
- List of `items`, each having:
    - Unique item `id`
    - Item `quantity`
    - `locations` (one or more of `address/shipping`, `address/digital`, `location/search`, `store/store_views`, `location/pick_up_locations`)

>**TIP**: See the [Fulfillment Offerings API Reference](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} for the most up-to-date requirements.

#### Searching for Offerings Using Consumer Location and Intents

What if you want to get additional offerings to show the consumer, for example, based on their GPS coordinates? What if you already know the consumer's intended fulfillment type for some items, but not all items?

For this you can *optionally* send any of the following to Fulfillment Offerings:

- **Location search data** (e.g. GPS coordinates, radius)
- **Known Addresses** (shipping, email or other known addresses for that consumer)
- **Promotion discount codes**
- **Allowed fulfillment types** (e.g. return only 'SHIP' and 'PICKUP' types)

Fulfillment Offerings adjusts the results based on what you send, making for an efficient way to drive the experience.

#### What is BOPIS?

Fulfillment Offerings supports the 'Buy Online, Pickup In Store' (BOPIS) scenario. This is the scenario when the consumer completes the checkout in the app/web, then travels to a nearby store to pick up their order. See [BOPIS]() for further details.

**Summary**: Fulfillment Offerings returns everything you need to drive a 'Shipping' selection experience.

## Key Terms

|Term|Definition|
|---|---|
|Fulfillment Group||
|Get By||
|Item(s)||
|Expiration Date||
|Offering Type||
|Pickup Location||
|Search Nearby||
|Shipping Address||
|Store||
|Email|A type of 'Digital Address' used for Digital Gift Card fulfillment|

## Fulfillment Offerings

<i class="g72-check"></i>&nbsp;&nbsp;**Get fulfillment offerings**
<i class="g72-check"></i>&nbsp;&nbsp;**Get shipping options (legacy)**

### Get Fulfillment Offerings

Query Params for GET request:

- Fulfillment Type (as `fulfillmentTypes`)
- Location as (`country` or `country` and `postalCode`)
- Product data (as `skuId` or `gtin`)

The returned offerings are grouped logically in the API response. For example, if there are multiple options for fulfillment type 'SHIP', then they are grouped together.

### Get Shipping Options (Legacy)

>**IMPORTANT**: The Shipping Options API will be deprecated. New integrators should use Fulfillment Offerings.

Use the [Shipping Options API](https://developer.niketech.com/docs/projects/Shipping%20Options?tab=api#shipping-options-post){:target="new-tab"} to retrieve the available shipping methods for a consumer's checkout, including any associated costs, estimated delivery dates, or discounts (such as free shipping for members).

To get the shipping options, execute a request to the *Shipping Options* endpoint.

Sample [Shipping Options API](https://developer.niketech.com/docs/projects/Shipping%20Options?tab=api#shipping-options-post){:target="new-tab"} request URI:

```
https://api.nike.com/buy/shipping_options/v2
```

>**TIP:** Although optional, including a shippingAddress is recommended whenever possible. In China, shipping methods can vary based on the province, city, and district combination. Also, for certain countries (e.g. US), including the shipping address can get you an estimated delivery date versus an estimated delivery range.

## API Quick Reference

- [Fulfillment Offerings](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"}
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
|Initial draft|06/20/2019|Initial Draft|

## Next Steps

You've learned how to add Fulfillment Offerings to your experience. Here are some next steps.

- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)
- [Supported Countries & Currencies](/doc/commerce/checkout/checkout-country-currency.html)