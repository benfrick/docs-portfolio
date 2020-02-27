---
---

# NIKE PARTNERS - PRODUCT INFORMATION FEED - DRAFT

---

##### Last Updated: 02/28/2020

Nike's Product Information Feed (PIF) pushes Nike products to partners on a scheduled basis.


## Introduction

The PIF supplies information that partners need to sell Nike products to their consumers through their ecommerce apps and experiences. Nike works closely with their partners to define a contract specifying the product data, data format, how often the partner needs the feed, and where to deliver it. Nike then sets up a configuration that customizes the feed to suit each partner's needs.

Let's take a look at some quick facts about the PIF.

###### Table 1: Product Information Feed At a Glance

|---|---|
|**Partner Types**|Retail (e.g. Nordstrom), Consumer (e.g. Google, Facebook)|
|**Countries**|United States|
|**Languages**|English|
|**Currencies**|US dollars|
|**Sizing**|US|
|**Delivery**|Push of eligible products|

## Product Information Feed Types

There are two types of PIFs, one for Retail Partners and one for Consumer Partners. The table below lists the key differences between the two feeds.

###### Table 2: Retail Partner Feed vs. Consumer Partner Feed

||Retail Partner|Consumer Partner|
|---|---|---|
|**Products included**|US line futures|Entire US product line|
|**Source of product data**|Nike selects futures products for a particular retail partner (store) and season via the Nike Offerings API|Monarch (style-color), Prodigy (copy, description, price, taxonomy),  Asset Delivery (image and video)|
|**Prices included**|Wholesale and MSRP|MSRP|
|**Inventory**|No inventory|Inventory available and products are saleable immediately|
|**How partner uses the feed**|As a catalog of Nike futures products for an upcoming season to help in their ordering process|To populate their ecommerce store with Nike Products and sell them to consumers immediately|
|**Season of products included**|Includes products 6 months ahead of current season|Products are not season-specific|

Now let's dig a little deeper into how the PIF works for each type of partner.

**Retail Partner Product Information Feed**

The Retail Partner PIF contains products curated specifically for the retailer. Partners use the feed as a catalog from which to purchase Nike product for a future season.

The Retail Partner PIF products are "futures", meaning they will be available to the retail partner to sell to their consumers 6 months in the future. Since these products will be manufactured in the future, they have no inventory.

**Consumer Partner Product Information Feed**

The Consumer PIF contains Nike product that has inventory and is available for sale immediately. Unlike the futures products in the Retail Partner PIF, there is no season associated with the consumer partner PIF products.

## How does the Product Information Feed Work?

![Product Info System Overview](/images/partner/product-info/partner-prod-info-sys-overview.png)

The PIF is made up of the transformation component and the delivery component.


**Transformation Component**

The transformation component ensures that the product data conforms to the partner's PIF contract. This may include renaming and restructuring data so it is arranged the way the partner expects. For instance, the transformation component may need to change the field name from `styleNumber` in the source data to `STYLE NUMBER` in the PIF per the partner contract.

**Delivery Component**

The delivery component is responsible for getting the transformed data to the partner in the agreed format at the expected time. The delivery component is flexible in how it performs both.

The delivery time and frequency of the PIF is configurable. Typically, it is pushed on a daily basis.

The delivery component can push the PIF to partners in several ways. It can call partner APIs, push files to AWS S3 buckets and push files using SSH File Transfer Protocol (sFTP) etc. It can also create PIFs in several file formats such as Comma-Separated Value (CSV) or Javascript Object Notation (JSON) format.

>**TIP:** Currently, the PIF cannot deliver product updates made since the last time it ran. All eligible products are included in the PIF each time.

**Default Fields**

Nike offers a default schema of product fields common to all partners. At a minimum, both the Retail Partner and Consumer Partner PIF includes the fields listed in the table below.

###### Table 3: Default Product Information Feed Fields

|Field Name|Example|
|---|---|
|Style Number|315122|
|Color Number|111|
|Style Name|Nike Air Force 1 '07|
|Description|Hoops in the park, Sunday BBQs and sunshine. The radiance lives on in the Nike Air Force 1 ’07, the b-ball OG that puts a fresh spin on what you know best: crisp leather in an all-white colorway for a statement look on and off the court.|
|Size|M 6/W 7.5|
|Price|90|

