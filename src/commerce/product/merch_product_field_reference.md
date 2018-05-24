<link rel="stylesheet" href="https://assets.commerce.nikecloud.com/ncss/glyphs/2.0/css/glyphs.min.css">
<link rel="stylesheet" href="https://assets.commerce.nikecloud.com/ncss/0.17/dotcom/desktop/css/ncss.en-us.min.css">
<link rel="stylesheet" href="/css/style.css">
<script src="/js/nde.js" type="text/javascript"></script>

<!--
See Bitbucket (https://bitbucket.nike.com/projects/APID/repos/api-docs/browse/commerce/product/api_merch_product_reference.md) for version history of this document.
Author:  Jane Moore
-->

<a href="/index.html"><i class="g72-arrow-fill-left" style=""></i> <u>Back to NDe Documentation</u></a><a href="slack://channel?team=T0G3T5X2B&amp;id=C9Q1MNJ1J" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-black" style="float:right"><i class="g72-alert"></i> FIND AN ISSUE? SLACK US!></a>

# MERCHANDISED PRODUCT FIELD REFERENCE <i class="g72-swoosh"></i> (DRAFT)

##### Last Updated: 05/24/2018<br>Submit Feedback: Dev Portal Slack channel<a href="slack://channel?team=T0G3T5X2B&amp;id=C9Q1MNJ1J">#devportal</a>

This guide describes the product and value-added service merchandising codes flowing from Prodigy (the system of record) to the Merchandised Product API.

See the [Global Reference Guide](/doc/commerce/reference/global.html) for the list of countries, languages, channels and brands that the NIKE APIs support.

- [Status Codes](#status-codes)
- [Merchandising Groups](#merchandising-groups)
- [Genders](#genders)
- [Product Types](#product-types)
- [Style Types](#style-types)
- [Publish Types](#publish-types)

## <a name="status-codes"></a>Status Codes

Listed below are the product and value-added service status codes.

|Status Code|Description|
|---|---|
|**ACTIVE**|Fully merchandised and ready for customer purchase|
|**INACTIVE**|Incompletely merchandised and not ready for customer purchase|
|**HOLD**|Fully merchandised but not ready for customer purchase|
|**CANCEL**|No longer available for purchase|
|**CLOSEOUT**|Not available for purchase|

## <a name="merchandising-groups"></a>Merchandising Groups

Listed below are the merchandising group codes and the countries included within each NIKE sales geography.

|CN|EU|JP|US|XP|
|---|---|---|---|---|
|China|Austria<br>Belgium<br>Czech Republic<br>Denmark<br>Finland<br>France<br>Germany<br>Greece<br>Hungary<br>Ireland<br>Italy<br>Luxembourg<br>Netherlands<br>Poland<br>Portugal<br>Slovenia<br>Spain<br>Sweden<br>United Kingdom|Japan|United States|for future use|

## <a name="genders"></a>Genders

Listed below are the gender codes.  Adult unisex products are merchandised with both "MEN" and "WOMEN" gender codes.

|Gender Code|Description|
|---|---|
|**MEN**|Male adult|
|**WOMEN**|Female adult|
|**BOYS**|Male child|
|**GIRLS**|Female child|
|**KIDS**|Unisex child|

## <a name="product-types"></a>Product Types

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

## <a name="style-types"></a>Style Types

Listed below are the product style codes.

|Style Code|Description|
|---|---|
|**INLINE**|Non-customizable, saleable product|
|**NIKEID**|Customizable, saleable product built to order per customer specifications such as color, badge, material etc.|
|**VALUE_ADDED_SERVICE**|Saleable service customer purchases as a product add-on such as custom embroidering, gift wrap and gift messaging|
|**GIFT_CARD**|Physical or electronic debit card customer uses to purchase products and services|
|**VOUCHER**|Credit given to a customer after returning a product that the customer uses to purchase other products and services|

## <a name="publish-types"></a>Publish Types

Listed below are the publish type codes.

|Publish Code|Description|
|---|---|
|**FLOW**|Product that is available to all NIKE customers for purchase when merchandising is complete and inventory is available|
|**LAUNCH**|Product that is available for purchase by certain NIKE customers for a discrete time period when merchandising is complete and inventory is available|

## <a name="related-links"></a>Related Links

[NDe Documentation Home](/index.html)

[Getting Started](/doc/portal/consuming.html)

[Business Guides](/doc/portal/biz-guides.html)

[Developer's Guides](/doc/portal/dev-guides.html)