<link rel="stylesheet" href="https://assets.commerce.nikecloud.com/ncss/glyphs/2.0/css/glyphs.min.css"/>
<link rel="stylesheet" href="https://assets.commerce.nikecloud.com/ncss/0.17/dotcom/desktop/css/ncss.en-us.min.css"/>
<link rel="stylesheet" href="https://bitbucket.nike.com/projects/APID/repos/api-docs/raw/css/api-doc.css?at=refs%2Fheads%2Fmaster"/>

# Get Started with Product Feeds (DRAFT) <i class="g72-swoosh"></i>

###### Last Updated: 2/6/2018<br>Submit Feedback: API Doc Slack channel [#nde-doc](https://nikedigital.slack.com/messages/nde-doc)

---

Great apps like SNKRS, Nike+, Nike Training Club and Nike Running Club tell amazing stories while showcasing Nike products and making them available for purchase.

But how is all that visual content pulled together? It's done with Product Feeds and you can use it, too.

## **In this guide**:

[Overview](#overview)

[Features](#features)

[Considerations](#considerations)

[Connect](#connect)

[Next Steps](#next-steps)

## <a name="#overview"></a>Overview

Use Product Feeds to power compelling user experiences by accessing Nike digital product data and authored content in the form of Cards, Threads, and Feeds.

### What are Cards, Threads, and Feeds?

<i class="g72-arrow-thick-right"></i> **Cards** contain Nike product information or content such as notifications about upcoming Nike events.

<i class="g72-arrow-thick-right"></i> Related Cards are organized into **Threads** that tell a Nike story.

<i class="g72-arrow-thick-right"></i> Multiple Threads make up **Feeds**, customized for your users based on their chosen preferences.

<img src="https://bitbucket.nike.com/projects/APID/repos/api-docs/raw/images/commerce/product_feeds/nike_app_annotated.png?at=refs%2Fheads%2Fmaster"/>

## <a name="#features"></a>Features

Product Feeds is simple and easy to use: it does all the heavy lifting of gathering the content for you.

<i class="g72-plus-large"></i> Get all product feeds for your app, or a specific feed by its ID.

<i class="g72-plus-large"></i> Get all product threads for your app, or a specific thread by its ID. Since each thread includes its cards, no additional calls are required!

## <a name="#considerations"></a>Considerations

**Easy adoption**

Common implementations of Product Feeds involve only two calls: get all threads to display them to the user, then get a single thread when the user selects it.

**Prerequisites**

To get started, you need a channel identifier for your app. Contact the [Product Feeds Product Owner](http://developer.nikedev.com/?guide=https://bitbucket.nike.com/projects/APID/repos/api-docs/browse/commerce/product/api_product_feeds.md?raw#api-at-a-glance) to get one.

**Reliable and Scalable**

Nike services are built for reliability and scalability, reaping the benefits of cloud network architecture as the backbone of our services.

**The Latest Web Standards**

Join the web economy by using the common language of the internet to interact with Nike services. Your developers will be familiar with issuing JSON-formatted requests to Nike's REST web services using the standard HTTP web protocol.

## <a name="#connect"></a>Connect

We're here to help.

<i class="g72-chat"></i> [#Slack](https://nikedigital.slack.com/messages/developer-relations)

<i class="g72-email"></i> [Email](mailto:developer.relations@nike.com)

## <a name="next-steps"></a>Next Steps

**From here, explore the Product Feeds Developer Guide to get more details.**

<i class="g72-plus-large"></i> [Product Feeds Developer's Guide](http://developer.nikedev.com/?guide=https://bitbucket.nike.com/projects/APID/repos/api-docs/browse/commerce/product/api_product_feeds.md?raw)

<i class="g72-plus-large></i> [Supported Countries and Languages](https://confluence.nike.com/display/DEN/Product+Feeds+Supported+Languages+and+Locales)

<i class="g72-plus-large"></i> [SLA Documentation](http://developer.nikedev.com/?guide=https://bitbucket.nike.com/projects/APID/repos/api-docs/browse/commerce/product/api_product_feeds.md?raw#api-at-a-glance)

**The journey begins now!**