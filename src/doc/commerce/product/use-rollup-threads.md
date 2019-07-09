---
id: use-rollup-threads
tags: pdf
category: b-use-case
position: 2
title: Rollup Threads
url: /doc/commerce/product/use-rollup-threads.html
toc:
  - h2: What is a Rollup Thread?
    url: /doc/commerce/product/use-rollup-threads.html#what-is-a-rollup-thread
  - h2: Get a List of Rollup Threads
    url: /doc/commerce/product/use-rollup-threads.html#get-a-list-of-rollup-threads
  - h2: API Quick Reference
    url: /doc/commerce/product/use-rollup-threads.html#api-quick-reference
  - h2: Best Practices
    url: /doc/commerce/product/use-rollup-threads.html#best-practices
  - h2: Troubleshooting
    url: /doc/commerce/product/use-rollup-threads.html#troubleshooting
  - h2: Terms of Service
    url: /doc/commerce/product/use-rollup-threads.html#terms-of-service
  - h2: Glossary
    url: /doc/commerce/product/use-rollup-threads.html#glossary
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING ROLLUP THREADS TO YOUR EXPERIENCE

---

##### Last Updated: 04/08/2019

Use the [Rollup Threads API](https://developer.niketech.com/docs/projects/Product%20Feed%20Rollup%20Threads%20Service%20API%20V2?tab=api){:target="new-tab"} to get related product content for your digital experience, for example to show consumers a grid wall of Nike products.

>**TIP:** Before using this guide, first read the [Product Feeds Developer's Guide](/doc/commerce/product/use-product-feeds.html) to understand the basics about Threads.

## What is a Rollup Thread?

A Thread contains content and information about a Nike product, and you can get a list of threads from the [Product Feeds API](/doc/commerce/product/use-product-feeds.html). The [Rollup Threads API](https://developer.niketech.com/docs/projects/Product%20Feed%20Rollup%20Threads%20Service%20API%20V2?tab=api){:target="new-tab"} takes it a step further.

A **Rollup Thread** is a Thread that is related to, and nested within, a Parent Thread. For example: a Thread containing content for a particular shoe color might have seven Rollup Threads nested within in it, one for each of the other available colors of that shoe.

Using Rollup Threads makes it simpler for you to build a product grid wall experience like this:

![](/images/commerce/product_feeds/gridwall.png)

This is just one example of how a Parent Thread can have one or more related Rollup Threads. We'll discuss this more later in [Choosing the Rollup Threads You Need](#choosing-the-rollup-threads-you-need).

Next, we'll get started with interacting with the Rollup Threads API.

## Get a List of Rollup Threads

<i class="g72-check"></i>&nbsp;&nbsp;**Product Grid Wall: Get product threads along with related 'rollup' threads**

<i class="g72-check"></i>&nbsp;&nbsp;**Get customized search results**

### Getting Started

To get a list of Threads along with the associated Rollup Threads, execute a request to the [Rollup Threads List](https://developer.niketech.com/docs/projects/Product%20Feed%20Rollup%20Threads%20Service%20API%20V2?tab=api#rollup-threads-rollup-threads-list-get){:target="new-tab"} endpoint.

Here are some sample URIs to get you started:

|Use Case|Sample Query|
|---|---|
|Threads for a taxonomy ID|https://api.nike.com/product_feed/rollup_threads/v2?consumerChannelId=d9a5bc42-4b9c-4976-858a-f159cf99c647&filter=marketplace(US)&filter=language(en)&filter=taxonomyIds(c2228131-f12b-4513-84cd-55ae15d6723d)|
|Search all Nike.com products in US by "Men's Jordan", sorted by newest first|https://api.nike.com/product_feed/rollup_threads/v2?consumerChannelId=d9a5bc42-4b9c-4976-858a-f159cf99c647&filter=language(en)&filter=marketplace(US)&searchTerms=Men's%20Jordan&sort=effectiveStartSellDateDesc|

>**TIP:** For sample responses, see the [Rollup Threads API Reference](https://developer.niketech.com/docs/projects/Product%20Feed%20Rollup%20Threads%20Service%20API%20V2?tab=api){:target="new-tab"}.

### Prerequisites

In order to use the Rollup Threads API, you will first need to:

- **Obtain a Consumer Channel ID -- REQUIRED**
- **Configure Custom Search Rules -- OPTIONAL**

See [Consumer Channel ID & View](https://confluence.nike.com/pages/viewpage.action?pageId=233771813){:target="new-tab"} for instructions on the above steps.

### Choosing the Parent Threads You Need

To choose only the Parent Threads that you need, append any of the [supported query parameters](https://developer.niketech.com/docs/projects/Product%20Feed%20Rollup%20Threads%20Service%20API%20V2?tab=api){:target="new-tab"} to your request URI to get more specific results in the response.

Here are a few example query parameters.

|Desired filter criteria|Example Query Param|
|---|---|
|Women's products|`filter=productInfo.merchProduct.genders(WOMEN)`|
|Search keyword|`searchTerms=Your%20search%20terms%20here`|
|Search Rules 'View'|`view=SEARCH_RESULTS`|

>**TIPS:** 
>- The [Product Feeds API Reference](https://developer.niketech.com/docs/projects/Product%20Feed%20Rollup%20Threads%20Service%20API%20V2?tab=api){:target="new-tab"} is the source of truth for all supported query parameters.
>- For more on Search Rules, see [Rollup by Search Rules](#rollup-by-search-rules)

### Choosing the Rollup Threads You Need

Next, choose which Rollup Threads are sent with each Parent Thread using one of the following options:

#### Default Rollup

By default, the rollup is determined by the value in the **productInfo.merchProduct.productRollup.key** field in the API response. The rollup keys are created in the Nike product information system.

>TIP: Generally speaking, the default rollup is by Nike style code. If you need a different rollup, use one of the below options.

#### Rollup by Rollup Key

Specify a particular rollup key by including the filter query parameter `rollupKey` in your request URI, for example `?filter=rollupKey(0cc4QN)`.

#### Rollup by Search Rules

The most powerful way to control the rollup is to configure search rules in the Apollo tool. This will **override the default rollup behavior described above, exclusively for your consumerChannelId**.

For example, you can create a rule in Apollo to exclude customized Nike ID products or gift cards from your results.

Multiple sets of search rules can be defined in **views** in Apollo and then accessed in the Rollup Threads API via the `view` query parameter.

See [Consumer Channel ID & View](https://confluence.nike.com/pages/viewpage.action?pageId=233771813){:target="new-tab"} for instructions on how to set up views.

### Consumer Channel ID Versus Channel ID

Your Consumer Channel ID is unique to your app and allows you to have custom search rules to return only the Parent and Rollup Threads that you need. But how is Consumer Channel ID related to the Channel ID you might be using with Product Feeds API?

Consumer Channel ID and Channel ID are not directly related and therefore should not be used interchangeably. Both are unique IDs that help you to get only the data you need from each respective API.

**When calling the Product Feed Rollup Threads API, Consumer Channel ID is required and Channel ID is not allowed.**

>**NOTE**: Threads returned by the Product Feed Rollup Threads API are pre-filtered for the Nike.com Channel ID.

### I Already Use Product Feeds v2. How is This API Response Different?

The following diagram describes the how the structure of the response from the Rollup Threads API differs from Product Feeds:

![](/images/commerce/product_feeds/rollup_threads_response.png)

## API Quick Reference

|HTTP Verb|Endpoint Name|Endpoint Description|URI Format|
|---|---|---|---|
|GET|Rollup Threads|[Get a product Thread with related Threads nested within](https://developer.niketech.com/docs/projects/Product%20Feed%20Rollup%20Threads%20Service%20API%20V2?tab=api){:target="new-tab"}|`/product_feed/rollup_threads/v2{?filter,anchor,count,sort,searchTerms,rollupCount,rollupField,consumerChannelId}`|

## Best Practices

See the Best Practices section of the [Product Feeds Developer's Guide](/doc/commerce/product/use-product-feeds.html#best-practices).

## Troubleshooting

**I'm getting a 200 response, but the Thread data and/or Rollup Threads are not as expected**

- Check your Smart Search rules configuration in the Apollo application to ensure that the rules are correct.
- Check the rollup key & type from Prodigy for the Parent Thread is as expected.
- Reach out to Product Feeds team on Slack for assistance: [#nde-product-feeds](https://nikedigital.slack.com/messages/CAPF62A66){:target="new-tab"}

>**TIP:** See the Troubleshooting section of the [Product Feeds Developer's Guide](/doc/commerce/product/use-product-feeds.html#troubleshooting) for more general troubleshooting information.

## Terms of Service

It is recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of [Using Nike APIs](/doc/getting-started/using-nike-apis.html#registration) on how to create and register your caller ID.

### Authentication

No authentication or authorization is required to use this API.

## Glossary

See the [Glossary](/doc/commerce/reference/glossary.html).

## Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|05/17/2018|Initial Draft|
|Update|07/19/2018|Updated how to obtain a consumerChannelId|

## Related Links

[Commerce Docs Home](/index.html)

[Get Started](/doc/getting-started/get-started.html)