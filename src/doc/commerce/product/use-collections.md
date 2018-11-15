---
excluded_in_search: true
tags: pdf
category:
#category: b-use-case
position: 
title: Collections
url: /doc/commerce/product/use-collections.html
#toc:
#  - h2: Step 1: Create Terms & Collections
#    url:  /doc/commerce/product/use-collections.html#step-1
#  - h2: Step 2: Call Rollup Threads
#    url:  /doc/commerce/product/use-collections.html#step-2
#  - h2: API Endpoint Quick Reference
#    url:  /doc/commerce/product/use-collections.html#api-endpoint-quick-reference
#  - h2: Best Practices
#    url:  /doc/commerce/product/use-collections.html#best-practices
#  - h2: Troubleshooting
#    url:  /doc/commerce/product/use-collections.html#troubleshooting
#  - h2: Terms of Service
#    url:  /doc/commerce/product/use-collections.html#terms-of-service
#  - h2: Contacting the Team
#    url:  /doc/commerce/product/use-collections.html#contacting-the-team
#  - h2: Glossary
#    url:  /doc/commerce/product/use-collections.html#glossary
#  - h2: Document Change Log
#    url:  /doc/commerce/product/use-collections.html#document-change-log
#  - h2: Next Steps
#    url:  /doc/commerce/product/use-collections.html#next-steps
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn ncss-brand guide-button pt2-sm pr5-sm pb2-sm pl5-sm"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING COLLECTIONS TO YOUR EXPERIENCE <i class="g72-swoosh"></i><br>(DRAFT)

---

##### Last Updated: 11/10/2018

### Use Collections to add a custom set of products to your experience.

>**TIP**: Before using this guide, you should have already completed [Product Feeds Developer's Guide](/doc/commerce/product/api_product_feeds.html) and [Rollup Threads Developer's Guide](/doc/commerce/product/api_rollup_threads.html).

## What are Terms & Collections?

- **Collection**: a custom set of one or more [Product Threads](/doc/commerce/product/api_product_feeds.html#cards-threads-and-feeds) for a specific combination of marketplaces and channels.

- **Term**: a set of one or more Collections, grouped in a way that reflects a broader concept.

![Collections Overview](../../../images/commerce/product_feeds/collections-overview.png)

### Example

The Nike News team wants their NA and UK readers to be able to shop Nike.com products in one of their articles on news.nike.com. They create the following:

- **Term**: 'Nike News - Essential Running Gear'
- **Collections**: 'Nike News - Essential Running Gear NA', 'Nike News - Essential Running Gear UK'

![Collections Example](../../../images/commerce/product_feeds/collections-example2.png)

Each Collection contains 4 related running products for a particular marketplace and channel combination, in this case, 'NA/Nike.com' and 'UK/Nike app/SNKRS'.

By calling the Rollup Threads API with the Term, selecting marketplace as US, display the following in their app:

![Collections Example](../../../images/commerce/product_feeds/collections-example.png){:class="border"}

>**TIP**: Each Collection can have different products if desired.

### Other Use Cases

**Nike.com Member Shop**
![](../../../images/commerce/product_feeds/collections-member-shop.png)

**Nike.com Mal Pugh's Shop**
![](../../../images/commerce/product_feeds/collections-mal-pugh.png)

**NTC app Training Essentials**
![](../../../images/commerce/product_feeds/collections-NTC-essentials.png)

## Step 1: Create Terms & Collections

To create Terms and Collections, use the [Collections admin app](https://adminops.prod.commerce.nikecloud.com/collectionsui/terms){:target="blank"}.

### Create a Term

A Term has the following attributes:

|Attribute|Description|
|---|---|
|Term Type|The type of term, Global or Local|
|Term Name|The name of the term. Only shows within Collections admin|
|Term UUID|The unique identifier for the term that is **generated automatically by Collections admin**|
|Description|The description of the Term. Only shows within the Collections admin|

>**TIP**: Make note of the Term UUID as you will use it in Step 2.

### Create Collections

Next, create one or more Collections to go with the Term you previously created.

A Collection has the following attributes:

|Attribute|Description|
|---|---|
|Name|The name of the Collection|
|Term UUID|The UUID of the Term to which the Collection is associated|
|Marketplaces|The marketplaces (countries) defined for the Collection|
|Channels|The sales channels defined for the Collection|
|Resources|The product threads that are added to the Collection|

Add resources into the Collection by selecting from **Add Thread By** dropdown and entering one of the following about the product:

- Thread UUID
- Pre-Build ID
- Product ID
- Product UUID
- Style Code
- Style-Color

**Why have multiple Collections for a Term?**

The reason to have multiple Collections for a Term is to assign unique sets of products for different marketplace and channel combinations.

>**TIP**: For each product added into the Collection, an association is automatically created between the Term and the corresponding product threads in the Product Feeds API.

## Step 2: Call Rollup Threads

Use the **term UUID** obtained in Step 1 to call the [Rollup Threads API](https://developer.niketech.com/docs/projects/Product%20Feed%20Rollup%20Threads%20Service%20API%20V2?tab=api) with query parameter `filter=attributeIds(<term UUID>)`, along with other required or optional `filter` and `sort` query parameter values.

### Filtering by Channel & Marketplace

Channel and marketplace are both required parameters for Rollup Threads, so you have the opportunity to filter the products in the Term even further and essentially. 

The Rollup Threads API response contains the requested product threads.

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>See [API Endpoint Quick Reference](#api-endpoint-quick-reference) for endpoint details and links to API Reference documentation.
>
><i class="mr2-sm g72-check"></i>For more on syntax, see [Query Parameters](/doc/getting-started/using_nike_apis.html#query-parameters).

### Scenarios

Let's take a look at some scenarios.

|I want to...|Sample Query|
|---|---|
|Do this thing|`url to do this thing`|

### Executing the Request

Sample CURL for {}

```
CURL goes here
```

### Parsing the Response

The Rollup Threads response in specified in the [API Reference](https://developer.niketech.com/docs/projects/Product%20Feed%20Rollup%20Threads%20Service%20API%20V2?tab=api), but here's a few things to know about:

- All of the product threads that are stamped 
- Rollup Threads returns only active product threads. If you want inactive threads included in the response, call [Product Feeds Threads List](https://developer.niketech.com/nde-docs/doc/commerce/product/api_product_feeds.html#product-threads-list) instead.
- 


{Some hints/callouts about the data in the response and how it could be handled}

## API Endpoint Quick Reference

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|[Rollup Threads *List*](https://developer.niketech.com/docs/projects/Product%20Feed%20Rollup%20Threads%20Service%20API%20V2?tab=api){:target="blank"}|`/product_feed/rollup_threads/v2{?filter,anchor,count,sort,searchTerms,consumerChannelId,view,ruleStatus}`|GET|

## Best Practices

Listed below are some best practices for working with Collections.

### Common Questions

**Question 1**

Answer 1

## Contacting the Team

>**TIP**: To find out more, ask a question on [#collections](https://nikedigital.slack.com/messages/CA2EDLQ4X){:target="blank"}.

Need to contact the {} team?

|---|---|
|Slack|[](){:target="blank"}|
|Confluence Space|[](){:target="blank"}|
|Team Contacts|Person1 (Person1 email)|

## Glossary

See the [Glossary](/doc/commerce/reference/glossary.html) for related terms.

## Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft 11/10/2018|Initial Draft|

## Next Steps

You've learned how to add {} to your experience. Here are some next steps.

- [Capturing User Events](/doc/commerce/events/api_eventsv2.html)
- [Using NDe APIs](/doc/getting-started/using_nike_apis.html)
