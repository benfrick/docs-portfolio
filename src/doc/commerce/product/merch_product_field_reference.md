---
id: merch_product_field_reference
tags: pdf
category: d-reference
position: 6
title: Merch Product Fields
url: /commerce/product/merch_product_field_reference.html
toc:
  - h2: Status Codes
    url: /doc/commerce/product/merch_product_field_reference.html#status-codes
  - h2: Merchandising Groups
    url: /doc/commerce/product/merch_product_field_reference.html#merchandising-groups
  - h2: Genders
    url: /doc/commerce/product/merch_product_field_reference.html#genders
  - h2: Product Types
    url: /doc/commerce/product/merch_product_field_reference.html#product-types
  - h2: Style Types
    url: /doc/commerce/product/merch_product_field_reference.html#style-types
  - h2: Publish Types
    url: /doc/commerce/product/merch_product_field_reference.html#publish-types
---

# MERCHANDISED PRODUCT FIELD REFERENCE

##### Last Updated: 05/24/2018

This guide describes the product and value-added service merchandising codes flowing from Prodigy (the system of record) to the Merchandised Product API.

See the [Global Reference Guide](/doc/commerce/reference/global.html) for the list of countries, languages, channels and brands that the NIKE APIs support.

## Status Codes

Listed below are the product and value-added service status codes.

|Status Code|Description|
|---|---|
|**ACTIVE**|Fully merchandised and ready for purchase|
|**INACTIVE**|Incompletely merchandised and not ready for purchase|
|**HOLD**|Fully merchandised but not available for purchase|
|**CANCEL**|Never manufactured or manufactured but never made it to market|
|**CLOSEOUT**|No longer available for purchase|

## Merchandising Groups

Listed below are the merchandising group codes and the countries included within each NIKE sales geography.

|CN|EU|JP|US|XP|
|---|---|---|---|---|
|China|Austria<br>Belgium<br>Czech Republic<br>Denmark<br>Finland<br>France<br>Germany<br>Greece<br>Hungary<br>Ireland<br>Italy<br>Luxembourg<br>Netherlands<br>Poland<br>Portugal<br>Slovenia<br>Spain<br>Sweden<br>United Kingdom|Japan|United States|for future use|

## Genders

Listed below are the gender codes.  Adult unisex products are merchandised with both "MEN" and "WOMEN" gender codes.

|Gender Code|Description|
|---|---|
|**MEN**|Male adult|
|**WOMEN**|Female adult|
|**BOYS**|Male child|
|**GIRLS**|Female child|
|**KIDS**|Unisex child|

## Product Types

Listed below are the product type codes.

|Style Code|Description|
|---|---|
|**FOOTWEAR**|Product that covers the foot|
|**APPAREL**|Product that covers the body |
|**EQUIPMENT**|Product that is core to playing a sport such as shin guards or soccer ball|
|**ACCESSORIES**|Product that is not core to playing a sport such as sunglasses or a water bottle|
|**PHYSICAL_GIFT_CARD**|Physical, pre-loaded debit card shipped to the customer|
|**DIGITAL_GIFT_CARD**|Electronic, pre-loaded debit card sent electronically to the customer|
|**VOUCHER**|Credit given to a customer after returning a product that the customer uses to purchase other products and services|
|**GIFT_WRAP**|Value-added service where product is wrapped for gift purposes|
|**GIFT_MESSAGE**|Value-added service where a gift message is packaged with the product|
|**JERSEY_ID**|Team jersey product bought in bulk for a team with customizable team number, emblem and name. This is not a NIKEiD product.|

## Style Types

Listed below are the product style codes.

|Style Code|Description|
|---|---|
|**INLINE**|Non-customizable, saleable product|
|**NIKEID**|Customizable, saleable product built to order per customer specifications such as color, badge, material etc.|
|**VALUE_ADDED_SERVICE**|Saleable service customer purchases as a product add-on such as custom embroidering, gift wrap and gift messaging|
|**GIFT_CARD**|Physical or electronic debit card customer uses to purchase products and services|
|**VOUCHER**|Credit given to a customer after returning a product that the customer uses to purchase other products and services|

## Publish Types

Listed below are the publish type codes.

|Publish Code|Description|
|---|---|
|**FLOW**|Product that is available to all NIKE customers for purchase when merchandising is complete and inventory is available|
|**LAUNCH**|Product that is available for purchase by certain NIKE customers for a discrete time period when merchandising is complete and inventory is available|

## Related Links

[NDe Docs Home](/index.html)

[Get Started](/doc/getting-started/get-started.html)