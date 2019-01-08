---
id: product-lifecycle
tags: pdf
category: d-reference
position: 4
title: Product Life Cycle
url: /commerce/reference/product-lifecycle.html
toc:
  - h2: Where Product Data Comes From
    url: /doc/commerce/reference/product-lifecycle.html#where-product-data-comes-from
  - h2: How Product Data Gest To the Customer
    url: /doc/commerce/reference/product-lifecycle.html#how-product-data-gets-to-the-customer
---

# PRODUCT LIFE CYCLE

##### Last Updated: 04/19/2018

---

![](/images/commerce/reference/product_life_cycle.png)

## Where Product Data Comes From

- **1a** The Product Depot Tool provides raw product data from various upstream Nike systems to Prodigy. The Prodigy Tool provides merchandised product, sku, pricing, value-added services and localized content to the Merchandised Product Service.

- **1b** The Taxonomy Service provides taxonomy (product attribute) IDs to the Merchandised Product Service used by the Search Service.

- **1c** The Catalog Service provides catalog IDs to the Merchandised Product Service.

- **2** Merchandised Product Service provides video and image URLS, catalog IDs, taxonomy IDs, merchandised products, prices, skus, value-added services and localized content to the Content Management Service (CMS).

- **3a** The Sterling Tool provides raw inventory data to the Availability Service. The Availability Service provides inventory information on a sku basis to the Product Feed Composer Service.

- **3b** The Launch Service provides launch dates to the Product Feed Composer Service (for launch products only).

- **3c** CMS provides Thread, Feed, and Card data to the Product Feed Composer Service.

- **4** Product Feed Composer Service assembles Launch, Feed, Thread, Card and Inventory data and pushes it to the Search Service.

## How Product Data Gets to the Customer

- **a** Nike experiences call the Product Feed service to get Feed and Thread data. Experience calls Scene 7/Cloudinary repository to get image and video media.

- **b** The Product Feed service gathers and returns Feed data. The Product Feed service calls the Search Service for Thread data. Scene 7/Cloudinary serve image and video media.

- **c** The Search Service gathers and returns Thread data to the Product Feed service based on the search criteria.

## Related Links

[NDe Docs Home](/index.html)

[Get Started](/doc/getting-started/get-started.html)