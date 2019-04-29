---
tags: pdf
#category: b-use-case
position: 3
title: Customization
url: /doc/commerce/customization/use-customization.html
toc:
  - h2: Introduction
    url: /doc/commerce/customization/use-customization.html#introduction
  - h2: 'Quick-Start: Running the Builder'
    url: /doc/commerce/customization/use-customization.html#quick-start-running-the-builder
  - h2: Show Customizable Products
    url: /doc/commerce/customization/use-customization.html#show-customizable-products
  - h2: Load the Builder UX and Listen for Updates
    url: /doc/commerce/customization/use-customization.html#load-the-builder-ux-and-listen-for-updates
  - h2: Finalize and Share Design
    url: /doc/commerce/customization/use-customization.html#finalize-and-share-designs
  - h2: API Endpoint Quick Reference
    url: /doc/commerce/customization/use-customization.html#api-endpoint-quick-reference
  - h2: Best Practices
    url: /doc/commerce/customization/use-customization.html#best-practices
  - h2: Troubleshooting
    url: /doc/commerce/customization/use-customization.html#troubleshooting
  - h2: Terms of Service
    url: /doc/commerce/customization/use-customization.html#terms-of-service
  - h2: Contacting the Team
    url: /doc/commerce/customization/use-customization.html#contacting-the-team
  - h2: Glossary
    url: /doc/commerce/customization/use-customization.html#glossary
  - h2: Document Change Log
    url: /doc/commerce/customization/use-customization.html#document-change-log
  - h2: Next Steps
    url: /doc/commerce/customization/use-customization.html#next-steps
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="new-tab" class="ncss-btn-secondary-grey guide-button"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING CUSTOMIZATION TO YOUR EXPERIENCE <i class="g72-swoosh"></i><br>DRAFT

---

##### Last Updated: 04/20/2019

The **Customization Experience Platform (CXP)** unlocks your ability to add premium product customization features to your experience, similar to [Nike By You](https://store.nike.com/us/en_us/pw/nikeid-air-max-shoes/oolZb8dZoi3){:target="new-tab"} experiences like:

<img alt="Depiction of Nike By You web experience at Nike.com" src="/images/customization/nby-web-chrome.png" class="border" style="display:inline-block; width:75%; margin-right:20px; vertical-align: middle;">
<img alt="Depiction of Nike By You experience in the Nike App" src="/images/customization/nby-nike-app2.png" class="border" style="display:inline-block; width:20%; vertical-align:middle;">

>**TIP**: Before using this guide, you should have already completed [Customization Overview](/doc/commerce/customization/overview-customization.html).

## Introduction

In this guide, we will discuss how to integrate CXP customization features into your app.

### Welcome to the Builder

The Builder is a JavaScript bundle that is your main interface with CXP. It does the following:

- **UX**: Returns a fully-styled UX for customizing products
- **Data API**: Allows you to interact with product build data and CXP REST APIs

### REST APIs

CXP provides REST APIs to facilitate gather and storing customization data. You can call [these APIs](https://developer.niketech.com/?domains=Customization){:target="new-tab"} rather than using the Data API, if you choose.

## Quick-Start: Running the Builder

Just want to demo the Builder on your local? Read this section first, otherwise skip to [Show Customizable Products](#show-customizable-products).

### Step 1: Install Prerequisites

Follow the [Builder installation instructions](/doc/commerce/customization/builder-reference.html#installation) to install the prerequisites for running the Builder locally.

### Step 2: Load the Builder

In your app's source, open an HTML template and follow these steps:

- **Include the Builder bundle**

    Add a `<script>` tag in the `<body>` to include the Builder JavaScript bundle like:

    ```html
    <script src="https://assets.commerce.nikecloud.com/nikeid/builder/dist/b16Builder.bundle.min.js" type="text/javascript"></script>
    ```

- **Add a <div> for the Builder to load into**

    Add a `<div>` in the `<body>` with an `id="nikeid-app"` attribute like:

    ```html
    <div id="nikeid-app-container" style="width: 1000px; height: 800px;">
        <div id="nikeid-app">
        </div>
    </div>
    ```

- **Load the Builder**

    Add a `<script>` tag in the `<body>` that invokes the `nikeIdBuilder(rootElement, config)` function like:

    ```html
    <script>
      const builderApi = nikeIdBuilder(document.getElementById('nikeid-app'), {
        'nike-api-caller-id': 'com.nike:commerce.b16.localhost',
        pathName: 'KobeAD2exoFA18'
      })
    </script>
    ```

>TIPS:
>- The argument for the `rootElement` parameter can be populated with a method like `document.getElementbyId('element-id-where-builder-renders')`.
>- The argument for the `config` parameter must contain at minimum the `nike-api-caller-id` and `pathName` properties. See [Step 1: Load the Builder](#step-1-load-the-builder) for more.

- **Navigate to Your Local Host to View the Builder Experience**
    
    The Builder loads into your chosen HTML element (in this case, a `<div>` with attribute `id="nikeid-app"`), and it invokes the necessary services to render the experience:
    
    Browse to the HTML page on your localhost to view the Builder experience. The URL will vary depending on how your app is being served up locally.

    ![Image of Builder running locally in Chrome](/images/customization/builder-local-web.png)

### Sample HTML Template (Initializes Builder Only)

```html
<!DOCTYPE html>
<html>
<head>
    <title>Nike By You: Example</title>
    <meta charset="utf-8">
    <meta http-equiv="cache-control" content="max-age=0,no-cache,no-store"/>
    <meta http-equiv="expires" content="Tue, 01 Jan 1980 1:00:00 GMT"/>
    <meta http-equiv="pragma" content="no-cache,no-store"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no, viewport-fit=cover"/>
    <link rel="icon" href="//www.nike.com/favicon.ico"/>
    <script type="text/javascript">
    var nsgConfig = {
      HOST: '//www.nike.com',
      PLATFORM: 'mobile'
    };
    </script>
    <script type="text/javascript" src="//www.nike.com/styleguide/init/nsg.js"></script>
</head>
<body>
<div id="nikeid-app-container" style="width: 1000px; height: 800px;">
    <div id="nikeid-app">
    </div>
</div>
<script type="application/javascript"
        src="https://assets.commerce.nikecloud.com/nikeid/builder/dist/b16Builder.bundle.min.js"></script>
<script>
  const builderApi = nikeIdBuilder(document.getElementById('nikeid-app'), {    
    'nike-api-caller-id': 'com.nike:commerce.b16.localhost',
    pathName: 'KobeAD2exoFA18',
  })
</script>
</body>
</html>
```

>**TIP**: See more at [Customization Builder Reference](/doc/customization/builder-reference.html), which is the single source of truth for Builder functionality. 

## Show Customizable Products

|<i class="g72-check"></i>&nbsp;&nbsp;**Show customizable products**: Which products are customizable? What is the estimated delivery date?|

The first part of adding CXP to experiences is to show the consumer which products, and in which colors, can be customized. Whether it's a full [Nike By You](https://www.nike.com/us/en_us/c/nikeid){:target="new-tab"} web experience with it's product grid walls and Product Detail Pages (PDPs), or something else, you need to show consumers the customizable products.

![Nike By You PDP annotated with data sources](/images/customization/nby-pdp.png)

### Step 1: Show Customizable Products & Color Options

- Call either the [Product Feeds](/doc/commerce/product/use-product-feeds.html) or [Rollup Threads](/doc/commerce/product/use-rollup-threads.html) API to get a list of customizable products, along with relevant content.

- To select only 'Nike By You' products, use the `filter=attributeIds()` query parameter. Example URI: https://api.nike.com/product_feed/threads/v2?filter=channelId(d9a5bc42-4b9c-4976-858a-f159cf99c647)&filter=marketplace(US)&filter=language(en)&filter=attributeIds(92be6a0f-24dd-4e2e-87d0-5ce4ade3a923)
   
- Use the response data to drive the experience of browsing customizable products, whether it be a grid wall, feed, or something else.

Talk about showing PreBuilds here?
Talk about graphQL here?

>**TIPS**:
>- [Rollup Threads](/doc/commerce/product/use-rollup-threads.html) is best for grid wall, where alternate colors are shown with each product in the grid.
>- See [Adding Rollup Threads to Your Experience](/doc/commerce/product/use-rollup-threads.html) and [Adding Product Feeds to Your Experience](/doc/commerce/product/use-product-feeds.html) for more integration info.
>- See [TTAC](/doc/taxonomy/overview-taxonomy-tagging.html) for more about the benefits of using taxonomy tagging.

### Step 2: Show Size Availability

The consumer has made their product (style) and color selections by now, and this is also a good time to show them which sizes are available.

- Use the `setSizeAnswer` method of the Builder to get the necessary data to display size availability.

### Step 3: Show Estimated Delivery Date

- Call the Customization Availability API.

### Step 4: Show the Edit Design CTA

The consumer is ready to customize their product, and needs a way to launch the builder experience. Use an **Edit Design** CTA (call-to-action) button to allow them to do that.

Depending on your specific experience flow, the **Edit Design** CTA can be always active, or conditionally active, for example only after size selection.

## Load the Builder UX and Listen for Updates

|<i class="g72-check"></i>&nbsp;&nbsp;**Send consumers on design journeys**: What customization options are available? What does my design look like? How much will it cost?|

The consumer has selected to edit the design, so it's time to load the Builder UX.

![Nike By You example design UX](/images/customization/nby-design.png)

### Step 1: Load the Builder

If you completed [Quick Start: Run the Builder Locally](#quick-start-run-the-builder-locally), then you've already practiced loading the Builder. In this step, we'll do it again but with more complex arguments for the `nikeIdBuilder(rootElement, config)` function.

- Use the value in `objects.productInfo.customizedPreBuild.legacy.pathName` from the Product Feeds response (mentioned in [Step 1: Show Customizable Products & Color Options](#step-1-show-customizable-products--color-options)) as the `pathName` property like `pathName: 'af1LowChampsSU19'`.

### Step 2: Update UX for Builder Events

- Listen to price change, analytics, and "done" events coming from the builder and update your experience accordingly.

    Get notifications for actions within the builder using `bridge`, a property of the `config` parameter like:
    
    ```html
     bridge: {
       onAnalyticsEvent: function() {},
       onApiReady: function(api) {}, // api ready not build
       onDone: function(buildData) {},
       onError: function(error){},
       onPriceUpdate: function(priceData) {},
       onProductLoad: function(buildData) {} // build ready
     }
    ```

- Invoke `setBuild` to load a new build by prebuild id, metric id, or raw build data. This is mainly meant to "reset" the builder.

## Finalize and Share Designs

|<i class="g72-check"></i>&nbsp;&nbsp;**Finalize and share designs**: How do I finalize my design? How do I share it on social media?|

- Save design

![Nike By You example 'My Designs' UX](/images/customization/nby-my-designs.png)

## Best Practices

Listed below are some best practices for working with Customization.

## Troubleshooting

- Use the general troubleshooting tips in the [Using NDe APIs](/doc/getting-started/using-nike-apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) to check for issues with your request.

- Contact the CXP team on the [#cxp](https://nikedigital.slack.com/messages/GFH2GM02C){:target="new-tab"} Slack channel for assistance.

## Terms of Service

### Common Questions

**Question 1**

Answer 1

## Contacting the Team

Need to contact the Customization team?

|---|---|
|Slack|[#cxp](https://nikedigital.slack.com/messages/GFH2GM02C){:target="new-tab"}|
|Confluence Space|[NikeiD Systems Home](https://confluence.nike.com/display/NIDS/NikeiD+Systems+Home){:target="new-tab"}|
|Team Contacts|[Jason Mueller, Product Manager](mailto:jason.mueller@nike.com)|

## Glossary

See the [Glossary](/doc/commerce/reference/glossary.html) for related terms.

## Document Change Log

|Summary|Date|
|---|---|
|Initial draft|04/30/2019|

## Next Steps

You've learned how to add Customization to your experience. Here are some next steps.

- [Adding Cart & Checkout To Your Experience](/doc/commerce/checkout/use-checkout.html)
- [Using NDe APIs](/doc/getting-started/using-nike-apis.html)