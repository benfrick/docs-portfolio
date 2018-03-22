<link rel="stylesheet" href="https://assets.commerce.nikecloud.com/ncss/glyphs/2.0/css/glyphs.min.css"></link>
<link rel="stylesheet" href="https://assets.commerce.nikecloud.com/ncss/0.17/dotcom/desktop/css/ncss.en-us.min.css"></link>
<link rel="stylesheet" href="https://nde-devportal-docs.niketech.com/css/style.css"></link>


<!--
See Bitbucket (https://bitbucket.nike.com/projects/APID/repos/api-docs/browse/commerce/reference/product_lifecycle.md) for version history of this document.
Author:  Jane Moore
-->

# PRODUCT LIFE CYCLE REFERENCE GUIDE <i class="g72-swoosh"></i> (DRAFT)

###### Last Updated: 03/20/2018<br>Submit Feedback: API Doc [Slack channel #nde-doc](https://nikedigital.slack.com/messages/nde-doc)

![](https://nde-devportal-docs.niketech.com/images/commerce/reference/product_life_cycle.png)

## Where Product Data Comes From

1a The Product Depot Tool provides raw product data from various upstream Nike systems to Prodigy. The Prodigy Tool provides merchandised product, sku, pricing, value-added services and localized content to the Merchandised Product Service.

1b The Taxonomy Service provides taxonomy (product attribute) IDs to the Merchandised Product Service used by the Search Service.

1c The Catalog Service provides catalog IDs to the Merchandised Product Service.

2 Merchandised Product Service provides video and image URLS, catalog IDs, taxonomy IDs, merchandised products, prices, skus, value-added services and localized content to the Content Management Service (CMS).

3a The Sterling Tool provides raw inventory data to the Availability Service. The Availability Service provides inventory information on a sku basis to the Product Feed Composer Service.

3b The Launch Service provides launch dates to the Product Feed Composer Service (for launch products only).

3c CMS provides Thread, Feed, and Card data to the Product Feed Composer Service.

4 Product Feed Composer Service assembles Launch, Feed, Thread, Card and Inventory data and pushes it to the Search Service.

## How Product Data Gets to the Customer

a Nike experiences call the Product Feed service to get Feed and Thread data. Experience calls Scene 7/Cloudinary repository to get image and video media.

b The Product Feed service gathers and returns Feed data. The Product Feed service calls the Search Service for Thread data. Scene 7/Cloudinary serve image and video media.

c The Search Service gathers and returns Thread data to the Product Feed service based on the search criteria.

## <a name="related-links"></a>Related Links

[NDe Documentation Home](https://nde-devportal-docs.niketech.com/index.html)

[Getting Started](https://nde-devportal-docs.niketech.com/doc/getting-started/getting-started.html)

[Business Guides](https://nde-devportal-docs.niketech.com/doc/biz-guides.html)

[Developer's Guides](https://nde-devportal-docs.niketech.com/doc/dev-guides.html)