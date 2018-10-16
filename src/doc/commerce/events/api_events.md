---
---

# ANALYTICS PIPELINE API <i class="g72-swoosh"></i><br>DEVELOPER'S GUIDE (DRAFT)

##### Last Updated: 04/19/2018<br>Submit Feedback: Dev Portal Slack channel <a href="slack://channel?team=T0G3T5X2B&amp;id=C9Q1MNJ1J">#devportal</a>

If you've read [Using NDe APIs](/doc/getting-started/using_nike_apis.html) and [Analytics Pipeline Overview](/doc/portal/overview-events.html), this guide provides the details necessary to integrate with the Nike Analytics Pipeline API.

## **In This Guide:**

[API at a Glance](#api-at-a-glance)

[Terms of Service](#terms-of-service)

<span class="toc-pad">[Authentication](#authentication)

[Use Cases](#use-cases)

[API Endpoint Quick Reference](#api-endpoint-quick-reference)

[Making Your First API Request](#making-your-first-api-request)

[Using Analytics Pipeline](#using-analytics-pipeline)

<span class="toc-pad">[Endpoint Details](#endpoint-details)

<span class="toc-pad">[Path & Query Parameters](#path--query-parameters)

<span class="toc-pad">[Request Headers](#request-headers)

<span class="toc-pad">[Request Body](#request-body)

<span class="toc-pad">[Response Body](#response-body)

[Upgrading to the Latest Version](#upgrading-to-the-latest-version)

[Troubleshooting](#troubleshooting)

[Glossary](#glossary)

[Release Notes](#release-notes)

[Document Change Log](#document-change-log)

[Related Links](#related-links)

## <a name="api-at-a-glance"></a>API at a Glance

The <b>Analytics Pipeline API</b> is your single destination to record analytics events, helping both user experiences and web services to track consumer and application behavior.

Because Analytics Pipeline is server-side and Nike-authored, it is much more customizable to your needs than a proprietary, client-side analytics solution.

Analytics events sent to this API are transformed and sent to multiple downstream systems/partners in real-time, allowing many needs to be fulfilled by sending a single event. Future integrations with other partners can be done without necessarily changing the contract of this API, thus making it easier (if not completely transparent) to you.

![](/images/analytics/events.png)

Here are a few ways in which analytics event data can be used:

- Track the success of marketing campaigns via tags or attribution
- Monitor user traffic and conversion metrics
- Track the success of new features (A/B testing)
- Alert on traffic anomalies

**Recent success stories include**:

<i class="g72-check"></i> Found issues with website/feature breakage quickly by alerting on sudden drops in traffic.

<i class="g72-check"></i> Track conversions from the addition of Visual Search features to Nike.com.

The following table describes the key details of the API:

|Topic|Details|
|---|---|
|Use this API to|Send all consumer and application tracking events to a single endpoint|
|Who calls this API|Nike.com PDP UX, Nike.com Visual Search UX, Nike.com Cloud Checkout UX, Buy Domain|
|Current Version|Analytics Pipeline v1|
|Scope/Limitations|Analytics events only. All countries supported. Do not use for sales, revenue, or available inventory information|
|SLAs|Response time (RT) and requests per second (RPS): <br>RT: 500 ms <br>RPS: 500|
|Domain|Commerce|
|Prerequisites|None|
|Contact Info|Slack: <a href="https://nikedigital.slack.com/messages/cic-nexus" target="_blank">#cic-nexus</a><br>Confluence space: <a href="https://confluence.nike.com/display/CN/CiC+UX+Foundation+Home" target="_blank">Analytics Pipeline API Team</a><br> Mailing List: [Lst-Nexus.Devops](mailto:Lst-Nexus.DevOps)<br><a name="product-owner"></a>Product Owner: <a href="mailto:randall.davis@nike.com" target="_blank">Randy Davis</a>|

### A Note about Segment

Segment is an analytics API and customer data platform which Nike utilizes. As you saw in the above diagram, it is one of several downstream integrations from the Analytics Pipeline API. By integrating with Segment once, Nike unlocks additional downstream integrations like Optimizely for A/B Testing, Kochava for mobile analytics, and several digital marketing integrations.

Reach out to the Analytics API Product Owner, [Randy Davis](mailto:randall.davis@nike.com), for information on the analytics opportunities available via Segment.

## <a name="terms-of-service"></a>Terms of Service

- Clients must not use analytics data collected with the Analytics Pipeline API for sales, revenue, or available inventory data.
- High usage from a single IP address may be flagged by Nike bot detection and blocked.
- This API is not intended for application monitoring, logging, or reporting on server-side errors.

### <a name="authentication"></a>Authentication

No authentication or authorization is required to use the Analytics Pipeline API.

## <a name="use-cases"></a>Use Cases

With the Analytics Pipeline API you can track:

- User-generated actions like clicks, taps, selections of options from a list, text entry, changes of view
- User-submitted searches
- User registrations
- Successful checkouts in a commerce app
- A/B Testing
- Mobile device events
- Metrics on global page events, e.g. page loads in a web app
- Ad campaigns, third-party or internal
- Client-side errors
- Timings of API requests
- Custom events

### A Note on Data Transformations

The data you send to this API is transformed (in most cases) to meet the requirements of the downstream systems to which it is ultimately sent, for example Adobe Analytics.

Here are some screenshots from Adobe Analytics to illustrate what kind of insights you can gain from sending events through this API:

<br>

![](/images/analytics/adobe1.png)

<br>

![](/images/analytics/adobe2.png)

<br>

>**TIP:** This guide does not include details of the data transformations. For more info, see [TBD]().

## <a name="api-endpoint-quick-reference"></a>API Endpoint Quick Reference

**Analytics Pipeline API**

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|<a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/API.md" target="_blank">SEND A NEW EVENT BATCH</a>|/measure/uxevents/v1|POST|

## <a name="making-your-first-api-request"></a>Making Your First API Request

For your first Analytics Pipeline API request, send an event that corresponds to a user clicking 'Change Billing Country' in the context of completing checkout in a web app.

### Gather Data Needed for the Request

First, gather the data needed to make the request.

#### URL

In production, all requests to the Analytics Pipeline API go to the same endpoint URL using the POST method:

|HTTP Method|Endpoint URL|
|---|---|
|POST|https://api.nike.com/measure/uxevents/v1|

However, for your first request and anytime you are performing tests, use the Test endpoint URL:

https://experience.test.commerce.nikecloud.com/measure/uxevents/v1

#### Headers

All requests must include the **Content-Type** header as follows:

|Header Name|Description|Required?|
|---|---|---|
|**Content-Type**|Content type of the request, "application/json" is only value allowed|Yes|

#### Body

To form the request body, answer the following questions by studying the API.md file and related JSON schema files:

- What is the event type that should be used for this event?

The event type **mouse** is described in the API.md as 'a mouse or touch event' and is the correct type to use here.

- What are the required fields in the schema which apply to all events AND what are the additional fields are required for this specific event type?

For any request to the Analytics Pipeline API, you will need to combine the required fields from the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/eventBatch.json" target="_blank">Event Batch Schema</a> and <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseEvent.json" target="_blank">Base Event Schema</a> along with an event-type schema, in this case the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/events/nexus/mouse.json" target="_blank">Mouse Event Schema</a>.

>Note: some event-type schemas specify additional required elements from the Base Event schema.

- What other relevant, optional fields should be included in the event?

This answer will depend on your reasons for tracking the event, and therefore will vary. For the sake of simplicity, only the required fields are included in the below example.

Once you've addressed all of the above questions, proceed to form a JSON request body. A finalized request body could look like this:

```
{
  "$schema": "../../schemas/eventBatch.json",
  "actorId": "53449035084208179402477208077095861290",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "id": "499068e1-cd49-4b06-b6a0-18f8b9831882",
      "timestamp": "2018-01-03T00:53:26.268Z",
      "platform": {
        "type": "web",
        "url": "https://www.nike.com/checkout",
        "pageTitle": "Nike.com Checkout",
        "referrer": "https://secure-store.nike.com/us/checkout/html/cart.jsp?l=cart&country=US&lang_locale=en_US&site=nikestore&returnURL=https://www.nike.com/t/air-jordan-1-retro-high-og-orange-mens-shoe-oe8vO8",
        "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
        "widthInPixels": 1920,
        "heightInPixels": 1080,
        "adobeVisitorId": "53449035084208179402477208077095861290"
      },
      "privacy": {
        "isFunctional": false,
        "isPerformance": true,
        "isMarketing": false
      },
      "application": {
        "name": "checkout",
        "version": "dev-0",
        "environment": "production",
        "domain": "dotcom",
        "division": "commerce",
        "platform": "cloud"
      },
      "locale": {
        "country": "us",
        "language": "en-us"
      },
      "eventName": "click_checkoutChangeBillingCountry",
      "eventType": "mouse",
      "properties": {
        "interactionType": "click",
        "mouseTarget": "change billing country",
        "view": {
          "channel": "checkout",
          "name": "tunnel"
        }
      }
    }
  ]
}
```

### Execute the Request

A cURL command can be used to execute the request from within your app. An example command is shown below (request body omitted for the sake of brevity, but you can use the example above):

```
curl -X POST \
  https://experience.test.commerce.nikecloud.com/measure/uxevents/v1 \
  -H 'Cache-Control: no-cache' \
  -H 'Content-Type: application/json' \
  -d '{<request body goes here>}'
```

### Parse the Response

The responses from the Analytics Pipeline API are simple to parse. If the event was successfully recorded, you will get an HTTP 200 response as shown below:

```
{
    "message": "Success"
}
```

If you receive any other response than this, something went wrong. See the [Response Body](#response-body) section for info on error responses.

## <a name="using-analytics-pipeline"></a>Using Analytics Pipeline

- [Analytics Pipeline Overview](#analytics-pipeline-overview)
- [Endpoint Details](#endpoint-details)
- [Path & Query Parameters](#path--query-parameters)
- [Request Headers](#request-headers)
- [Request Body](#request-body)
- [Response Body](#response-body)

### <a name="analytics-pipeline-overview"></a>Analytics Pipeline Overview

Use the Analytics Pipeline API as a single destination for tracking your user experience, service, or application events.

### <a name="endpoint-details"></a>Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**POST**|`/measure/uxevents/v1`|No|

### <a name="path--query-parameters"></a>Path & Query Parameters

There are no path nor query parameters to be used with the Analytics Pipeline API.

### <a name="request-headers"></a>Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Content-Type**|Content type of the request, **application/json** is only value allowed|Required|

### <a name="request-body"></a>Request Body

Forming a request body to the Analytics Pipeline API requires combining the following schema information:

- Event Batch: top-most level in the request structure, which is common to all event types. Includes an array of one or more events per the Base Event schema.
- Base Event: schema for the base event, mostly common to all event types. **However, certain event types schemas specify additional required elements from the Base Event schema.**
- Event Type: schema for a particular type of event, **which can specify additional elements that are required from the Base Event schema**.

Put another way, every request must include at minimum the required fields from the Event Batch and Base Event schemas, plus the required fields from an Event Type, plus any additional required fields from the Base Event as specified in that particular Event Type schema.

#### Event Batch & Base Event

The fields in the base event are described in the below table, by combining the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/eventBatch.json" target="_blank">Event Batch</a> and <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseEvent.json" target="_blank">Base Event</a> schemas:

|Element Name|Description|Required?|
|---|---|---|
|**$schema**|URL for the JSON schema version used|Optional|
|**actorId**|ID representing the principal actor in this event, minimum length of 1 character, e.g. "53449035084208179402477208077095861290"|Required|
|**resourceType**|Constant value that describes the type of resource. "dotcom/event_batch" is the only allowed value|Required|
|**resourceVersion**|Constant value that describes the version of this API contract. "v1" is the only allowed value|Required|
|**events**|Array of analytics events, minimum of 1|Required|
|events.**eventName**|Unique name for this event class, e.g. "click_checkoutChangeBillingCountry"|Required|
|events.**eventTags**|Array of event tags, one of "loginAttempt", "registrationComplete", "registrationStart", "userLogIn"|Optional|
|events.eventTags.**items**|One or more of "loginAttempt", "registrationComplete", "registrationStart", "userLogIn"|Optional|
|events.**eventType**|Unique name for this type of event, e.g. "mouse"|Required|
|events.**timestamp**|Date-time of the event, e.g. "1985-04-12T23:20:50.52Z"|Required|
|events.**id**|A UUID v4 for this event instance|Required|
|events.**application**|Object describing the app in which the event occurred|Required|
|events.application.**name**|App name|Required|
|events.application.**version**|Semver style or build number of app|Required|
|events.application.**environment**|App environment, one of "development", "test", or "production"|Required|
|events.application.**domain**|Experience domain of app, see list <a href="https://confluence.nike.com/display/DAHP/List+of+DTC+Experiences" target="_blank">here</a>|Required|
|events.application.**division**|Organization which the app domain falls under, e.g. "commerce"|Required|
|events.application.**platform**|Technology platform of the app, e.g. "cloud", "tesla"|Required|
|events.application.**other**|Other application data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|
|events.**locale**|Object describing the locale of event|Required|
|events.locale.**country**|ISO 3166 country code|Required|
|events.locale.**language**|BCP47 language code|Required|
|events.locale.**other**|Other locale data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|
|events.**privacy**||Required|
|events.privacy.**isFunctional**|Boolean specifying if event is categorized as functional|Required|
|events.privacy.**isMarketing**|Boolean specifying if event is categorized as marketing|Required|
|events.privacy.**isPerformance**|Boolean specifying if event is categorized as performance|Required|
|events.privacy.**other**|Other privacy data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|
|events.**platform**|Object describing app platform. Schema one of /webContext, /serviceContext, /mobileContext from <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseEvent.json" target="_blank">Base Event</a>|Required|
|events.platform.**type**|Platform type, "web"|Required|
|events.platform.**pageTitle**||Required|
|events.platform.**adobeVisitorId**||Optional|
|events.platform.**referrer**||Optional|
|events.platform.**userAgent**||Optional|
|events.platform.**widthInPixels**||Optional|
|events.platform.**heightInPixels**||Optional|
|events.platform.**url**||Optional|
|events.platform.**type**|Platform type, "service"|Required|
|events.platform.**domain**||Required|
|events.platform.**resource**||Optional|
|events.platform.**version**||Optional|
|events.platform.**type**|Platform type, "mobile"|Required|
|events.platform.**deviceId**||Optional|
|events.platform.**make**||Optional|
|events.platform.**model**||Optional|
|events.platform.**os**||Optional|
|events.platform.os.**name**||Optional|
|events.platform.os.**version**||Optional|
|events.platform.os.**idfa**||Optional|
|events.platform.os.**idfv**||Optional|
|events.platform.os.**adid**||Optional|
|events.platform.os.**other**|Other OS data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|
|events.platform.**other**|Other platform data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|
|events.**consumer**|Object describing the consumer/user context|Optional|
|events.consumer.**anonymousId**|A pseudo-unique substitute for a User ID, for cases when you don't have an absolutely unique identifier|Optional|
|events.consumer.**upmId**|Nike user profile identifier|Optional|
|events.consumer.**visitorId**|Unite visitor identifier|Required|
|events.consumer.**visitId**|Unite visit identifier|Required|
|events.consumer.**adobeMarketingCloudId**|The value of the s_vi cookie in the browser|Optional|
|events.consumer.**adobeVisitorId**|A value Adobe needs for identity|Optional|
|events.consumer.**isSwoosh**|Boolean where if true the user is a Nike employee|Required|
|events.consumer.**allowsMarketing**|Boolean where if true the user has opted into marketing events being collected|Required|
|events.consumer.**allowsPerformance**|Boolean where if true the user has opted into performance events being collected |Required|
|events.consumer.**other**|Other consumer data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|
|events.**marketing**|Object containing tracking parameters that tie to the Ad campaign|Optional|
|events.marketing.**campaignKey**|The campaign key for a specific Ad vendor|Required|
|events.marketing.**campaignValue**|The value for a specific Ad vendors campaign|Required|
|events.marketing.**clickIdKey**|The click identifier for a specific Ad vendors campaign|Required|
|events.marketing.**clickIdValue**|The click value for a specific user that clicks on a specific Ad|Required|
|events.marketing.**vendorKey**|The query parameter key for vendor identification|Required|
|events.marketing.**vendorValue**|The query parameter value for vendor identification|Required|
|events.marketing.**siteSource**|The query parameter value for SITESRC|Optional|
|events.marketing.**other**|Other campaign data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|
|events.**abTest**|Object containing the A/B testing context|Optional|
|events.abTest.**neo**|Object containing A/B test data for Neo|Optional|
|events.abTest.neo.**swimlane**|String|Optional|
|events.abTest.neo.**profiles**|Array|Optional|
|events.abTest.neo.profiles.**name**|String|Required|
|events.abTest.neo.profiles.**experiments**|Array of experiment data|Required|
|events.abTest.neo.profiles.experiments.**id**|String|Required|
|events.abTest.neo.profiles.experiments.**variation**|String|Required|
|events.abTest.neo.profiles.experiments.**other**|Other experiment data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|
|events.abTest.neo.profiles.**other**|Other profile data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|
|events.abTest.neo.**other**|Other Neo data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|
|events.abTest.**optimizely**|Array of A/B test data for Optimizely|Optional|
|events.abTest.optimizely.**experimentId**|Experiment identifier, string|Optional|
|events.abTest.optimizely.**experimentName**|Experiment name, string|Optional|
|events.abTest.optimizely.**variationId**|Variation identifier, string|Optional|
|events.abTest.optimizely.**variationName**|Variation name, string|Optional|
|events.abTest.**other**|Other A/B Test data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|
|events.**order**|Object containing the consumer order context. Cannot be combined with "products" context in same request|Optional|
|events.order.**checkoutId**|Generated id of a submitted checkout|Required|
|events.order.**orderId**|Id of a submitted order|Optional|
|events.order.**promoCode**|Promo code applied to checkout|Optional|
|events.order.shipping.**cost**|Shipping cost|Optional|
|events.order.shipping.**method**|Shipping method|Optional|
|events.order.vas.**giftWrap**|Number|Optional|
|events.order.vas.**other**|Number|Optional|
|events.order.**tax**|Tax on order|Optional|
|events.order.**discount**|Discount on order|Optional|
|events.order.**total**|Total of order|Optional|
|events.order.**currency**|Currency code on order|Optional|
|events.order.**products**|Array of at least one product, see 'events.products' in this table for schema|Optional|
|events.order.**payments**|Array of at least one payment on order|Optional|
|events.order.payments.**paymentType**|Type of payment|Required|
|events.order.payments.**stored**|Boolean that is true if payment is a stored payment|Required|
|events.order.payments.**other**|Other payment data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|
|events.**products**|Object containing product  context. Cannot be combined with "order" context in same request|Optional|
|events.products.**productId**|Product UUID|Required|
|events.products.**brand**|Brand of the product|Optional|
|events.products.**category**|Category of the product|Optional|
|events.products.**inventoryStatus**|Inventory status, one of "coming soon","discontinued","gift card","in stock","locked","nikeid","NONE","out of stock","preorder","unlocked:profile:in stock",null|Optional|
|events.products.**nikeSize**|Nike size code of the product|Optional|
|events.products.**pid**|Classic integer style product id|Optional|
|events.products.**priceAmount**|Price of product (number)|Optional|
|events.products.**priceCurrency**|Currency code of price|Optional|
|events.products.**priceStatus**|Price status, one of "clearance", "reduced", "regular", null|Optional|
|events.products.**productName**|Name of product|Optional|
|events.products.**productType**|Type of product|Optional|
|events.products.**quantity**|Unit quantity of product (number)|Optional|
|events.products.**skuId**|SKU UUID|Optional|
|events.products.**sportsTags**|N/A|Optional|
|events.products.**styleColor**|Style-color code of product|Optional|
|events.products.**styleType**|Style type of product|Optional|
|events.products.**subtitle**|Subtitle of product|Optional|
|events.products.**other**|Other product data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|
|events.**other**|A non-validated name-spaced region where domain-specific data can be added, per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|

#### Event Types

The following table lists all of the event types along with a description of how they should be used.

|Event Type|Description|
|---|---|
|**action**|A generic event for sending data otherwise not specified in another event type|
|**appLaunch**|An event to track the launching of an application on a mobile device|
|**changeView**|An event representing the user viewing a part of an application. It could represent a page, screen, or section|
|**checkoutConfirmation**|A checkout confirmation event from the buy domain|
|**error**|A collection of errors generated by the client or a service|
|**loginComplete**|An event for tracking a completed login|
|**metric**|An event for tracking metric data. It closely follows the Artemis/SignalFx schema|
|**mouse**|A mouse or touch event|
|**pageLoad**|Performance timings for browser page loads|
|**registrationComplete**|An event for tracking a completed registration|
|**search**|Event representing a user submitting a search|
|**selection**|Event tracking when the user makes a selection. e.g. select box, radio group or checkbox|
|**textInput**|Event representing a user entering text in an application. This should be dispatched on blur to avoid too many events|

>**TIP:** Each event-type schema must be combined with the base-event schema in order to have a fully-formed request body.

Next, each event type will be described in detail and a sample request body will be included for each.

##### Action

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|Type of event, only "action" is allowed|Required|
|events.**properties**|Object|Optional|
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>|Required|
|events.properties.view.**channel**||Required|
|events.properties.view.**name**||Optional|
|events.properties.view.**viewType**||Optional|
|events.properties.view.**contentBoostTags**|List of tags describing the enhanced content of the view, e.g. "video", "music", "game"|Optional|
|events.properties.**other**|Other event data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|

Sample request body:
```
{
  "actorId": "7894228d-5087-415f-80d0-55350568ea57",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "eventName": "generic_event",
      "eventType": "action",
      "application": {
        "name": "pdp",
        "environment": "production",
        "division": "commerce",
        "domain": "dotcom",
        "platform": "cloud",
        "version": ""
      },
      "platform": {
        "type": "web",
        "pageTitle": "Air Jordan 1 Retro High OG \"Cool Blue\" Men's Shoe. Nike.com",
        "referrer": "https://store.nike.com/us/en_us/pw/jordan/ofq",
        "url": "https://www.nike.com/t/air-jordan-1-retro-high-og-orange-mens-shoe-oe8vO8",
        "adobeVisitorId": "53449035084208179402477208077095861290",
        "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
        "heightInPixels": 1080,
        "widthInPixels": 1920
      },
      "properties": {
        "view": {
          "name": "Air Jordan 1 Retro High OG \"Cool Blue\" Men's Shoe",
          "channel": "pdp",
          "contentBoostTags": []
        }
      },
      "locale": {
        "country": "us",
        "language": "en-US"
      },
      "privacy": {
        "isMarketing": true,
        "isPerformance": true,
        "isFunctional": false
      },
      "id": "4aba00f1-02fa-4f9d-a66d-339ba05b7e30",
      "timestamp": "2018-01-03T00:40:35.918Z"
    }
  ]
}
```

##### App Launch

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|Type of event, only "appLaunch" is allowed|Required|
|events.**consumer**|Consumer context from Base Event|Required|
|events.**platform**|Platform context from Base Event|Required|
|events.platform.**type**|Platform type, only "mobile" is allowed|Required|
|events.**marketing**|Marketing context from Base Event|Required|

Sample request body:
```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "eventName": "snkrs_ios_open",
      "eventType": "appLaunch",
      "application": {
        "name": "snkrs",
        "environment": "production",
        "division": "commerce",
        "domain": "launch",
        "platform": "cloud",
        "version": ""
      },
      "consumer": {
        "upmId": "",
        "visitorId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "visitId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "isSwoosh": false,
        "allowsMarketing": true,
        "allowsPerformance": true
      },
      "marketing": {
      	"campaignKey": "jordan_4_retro",
      	"campaignValue": "30235f5664094b83",
      	"clickIdKey": "click_me",
      	"clickIdValue": "30235f5664094b83",
      	"vendorKey": "ads_r_us",
      	"vendorValue": "123456789"
      },
      "platform": {
        "type": "mobile",
        "deviceId": "2b6f0cc904d137be2e1730235f5664094b831186",
        "make": "Apple",
        "model": "A1549",
        "os": {
        	"name": "ios",
        	"version": "11.2.2",
        	"idfa": "2b6f0cc904d137be2e1730235f5664094b831186",
        	"idfv": "2b6f0cc904d137be2e1730235f5664094b831186"
        },
        "heightInPixels": 1080,
        "widthInPixels": 1920
      },
      "locale": {
        "country": "us",
        "language": "en-US"
      },
      "privacy": {
        "isMarketing": true,
        "isPerformance": true,
        "isFunctional": false
      },
      "id": "abc123xyz",
      "timestamp": "2018-01-03T00:40:35.918Z"
    }
  ]
}
```

##### Change View

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|Type of event, only "changeView" is allowed|Required|
|events.**properties**|Object|Required|
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>|Required|
|events.properties.view.**channel**||Required|
|events.properties.view.**name**||Optional|
|events.properties.view.**viewType**||Optional|
|events.properties.view.**contentBoostTags**|List of tags describing the enhanced content of the view, e.g. "video", "music", "game"|Optional|
|events.properties.**previousView**|Object representing the user previously viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>|Required|
|events.properties.previousView.**channel**||Required|
|events.properties.previousView.**name**||Optional|
|events.properties.previousView.**viewType**||Optional|
|events.properties.previousView.**contentBoostTags**|List of tags describing the enhanced content of the view, e.g. "video", "music", "game"|Optional|
|events.properties.**other**|Other event data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|

Sample request body:
```
{
  "actorId": "7894228d-5087-415f-80d0-55350568ea57",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "eventName": "load_pdp",
      "eventType": "changeView",
      "application": {
        "name": "pdp",
        "environment": "production",
        "division": "commerce",
        "domain": "dotcom",
        "platform": "cloud",
        "version": ""
      },
      "consumer": {
        "upmId": "",
        "visitorId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "visitId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "isSwoosh": false,
        "allowsMarketing": true,
        "allowsPerformance": true
      },
      "products": [
        {
          "productId": "12063010",
          "brand": "Jordan",
          "category": "Lifestyle",
          "inventoryStatus": "in stock",
          "pid": "12063010",
          "priceAmount": 175,
          "priceCurrency": "usd",
          "priceStatus": "regular",
          "productName": "Air Jordan 1 Retro High OG \"Cool Blue\" Men's Shoe"
        }
      ],
      "platform": {
        "type": "web",
        "pageTitle": "Air Jordan 1 Retro High OG \"Cool Blue\" Men's Shoe. Nike.com",
        "referrer": "https://store.nike.com/us/en_us/pw/jordan/ofq",
        "url": "https://www.nike.com/t/air-jordan-1-retro-high-og-orange-mens-shoe-oe8vO8",
        "adobeVisitorId": "53449035084208179402477208077095861290",
        "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
        "heightInPixels": 1080,
        "widthInPixels": 1920
      },
      "properties": {
        "view": {
          "name": "Air Jordan 1 Retro High OG \"Cool Blue\" Men's Shoe",
          "channel": "pdp",
          "contentBoostTags": []
        },
        "previousView": {
          "viewType": "unified profile",
          "channel": "login"
        }
      },
      "locale": {
        "country": "us",
        "language": "en-US"
      },
      "privacy": {
        "isMarketing": true,
        "isPerformance": true,
        "isFunctional": false
      },
      "id": "4aba00f1-02fa-4f9d-a66d-339ba05b7e30",
      "timestamp": "2018-01-03T00:40:35.918Z"
    }
  ]
}
```

##### Checkout Confirmation

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|Type of event, only "checkoutConfirmation" is allowed|Required|
|events.**properties**|Object|Required|
|events.properties.**checkoutId**|Checkout identifier, UUID, client provided|Required|
|events.properties.**orderId**|The unique order id generated for this checkout|Required|
|events.properties.**currency**|Currency code following the ISO 4217 standard|Required|
|events.properties.**totals**|Price details for the checkout in whole|Required|
|events.properties.totals.**subtotal**|Subtotal of the item costs for all items|Required|
|events.properties.totals.**valueAddedServicesTotal**|Total of value added services on the items|Required|
|events.properties.totals.**taxTotal**|Total of all taxes applied to the checkout|Required|
|events.properties.totals.**discountTotal**|Total of all discounts applied to the checkout|Required|
|events.properties.totals.**shippingTotal**|Total of all shipping costs (less shipping discounts) on the checkout|Required|
|events.properties.totals.**total**|Total price of the entire checkout, item costs + shipping costs + taxes (excluding 'VALUEADDEDTAX') less any discounts|Required|
|events.properties.totals.**other**|Other totals data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|

Sample request body:
```
{
  "actorId": "7894228d-5087-415f-80d0-55350568ea58",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "eventName": "checkout_complete",
      "eventType": "checkoutConfirmation",
      "application": {
        "name": "pdp",
        "environment": "production",
        "division": "commerce",
        "domain": "dotcom",
        "platform": "cloud",
        "version": ""
      },
      "platform": {
        "type": "web",
        "pageTitle": "Air Jordan 1 Retro High OG \"Cool Blue\" Men's Shoe. Nike.com",
        "referrer": "https://store.nike.com/us/en_us/pw/jordan/ofq",
        "url": "https://www.nike.com/t/air-jordan-1-retro-high-og-orange-mens-shoe-oe8vO8",
        "adobeVisitorId": "53449035084208179402477208077095861290",
        "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
        "heightInPixels": 1080,
        "widthInPixels": 1920
      },
      "properties": {
        "checkoutId": "986cad33-36bb-4cfd-a733-7e8de0a3dece",
        "orderId": "O123456789876",
        "currency": "USD",
		"totals": {
			"subtotal": 100,
			"valueAddedServicesTotal": 0,
			"taxTotal": 5,
			"discountTotal": 5,
			"shippingTotal": 10,
			"total": 110
		}
      },
      "locale": {
        "country": "us",
        "language": "en-US"
      },
      "privacy": {
        "isMarketing": true,
        "isPerformance": true,
        "isFunctional": false
      },
      "id": "4aba00f1-02fa-4f9d-a66d-339ba05b7e30",
      "timestamp": "2018-01-03T00:40:35.918Z"
    }
  ]
}
```

##### Error

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|Type of event, only "error" is allowed|Required|
|events.**properties**|Object|Required|
|events.properties.**errors**|Array of error data|Required|
|events.properties.errors.**code**|Error code, string|Optional|
|events.properties.errors.**message**|Error message, string|Optional|
|events.properties.errors.**field**|Error field, string|Optional|
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>|Optional|
|events.properties.view.**channel**||Required|
|events.properties.view.**name**||Optional|
|events.properties.view.**viewType**||Optional|
|events.properties.view.**contentBoostTags**|List of tags describing the enhanced content of the view, e.g. "video", "music", "game"|Optional|
|events.properties.**other**|Other error data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|

Sample request body:
```
{
  "$schema": "../../schemas/eventBatch.json",
  "actorId": "53449035084208179402477208077095861290",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "id": "16d25930-1c95-4cd8-bd39-320f60a0aaaf",
      "timestamp": "2018-01-03T00:57:11.837Z",
      "consumer": {
        "allowsPerformance": true,
        "allowsMarketing": true,
        "upmId": "123456789",
        "visitorId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "visitId": "13",
        "isSwoosh": true
      },
      "platform": {
        "type": "web",
        "url": "https://www.nike.com/checkout#payment",
        "pageTitle": "Nike.com Checkout",
        "referrer": "https://secure-store.nike.com/us/checkout/html/cart.jsp?l=cart&country=US&lang_locale=en_US&site=nikestore&returnURL=https://www.nike.com/t/air-jordan-1-retro-high-og-orange-mens-shoe-oe8vO8",
        "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
        "widthInPixels": 1920,
        "heightInPixels": 1080,
        "adobeVisitorId": "53449035084208179402477208077095861290"
      },
      "privacy": {
        "isFunctional": false,
        "isPerformance": true,
        "isMarketing": false
      },
      "abTest": {
        "neo": {
          "swimLane": "32",
          "profiles": [
            {
              "name": "main",
              "experiments": [
                {
                  "id": "3039-interceptor",
                  "variation": "a"
                },
                {
                  "id": "3250-interceptor",
                  "variation": "a"
                },
                {
                  "id": "3136-interceptor",
                  "variation": "a"
                }
              ]
            }
          ]
        }
      },
      "application": {
        "name": "checkout",
        "version": "dev-0",
        "environment": "production",
        "domain": "dotcom",
        "division": "commerce",
        "platform": "cloud"
      },
      "locale": {
        "country": "us",
        "language": "en-us"
      },
      "eventName": "error_checkoutServiceError",
      "eventType": "error",
      "properties": {
        "view": {
          "name": "order review",
          "channel": "checkout"
        },
        "errors": [
          {
            "code": "C06E97B8",
            "message": "Payment failed",
            "field": "modal"
          }
        ]
      },
      "products": [
        {
          "productName": "Air Jordan 1 Retro High OG \"Cool Blue\" Men's Shoe",
          "productId": "37c1d287-b591-556f-980c-50fba809d8c2",
          "styleColor": "AJ5997-455",
          "skuId": "8406ac5c-5b07-5742-b19a-e02163ebaf95",
          "priceAmount": 105,
          "priceCurrency": "USD",
          "quantity": 1,
          "pid": "12063010",
          "brand": "Jordan",
          "productType": "FOOTWEAR",
          "subtitle": "Men's Shoe",
          "styleType": "INLINE",
          "nikeSize": "8.5"
        }
      ]
    }
  ]
}
```

##### Login Complete

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|Type of event, only "loginComplete" is allowed|Required|
|events.**consumer**|Consumer context from the Base Event|Required|
|events.**marketing**|Consumer context from the Base Event|Required|

Sample request body:
```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "eventName": "snkrs_ios_login",
      "eventType": "loginComplete",
      "application": {
        "name": "snkrs",
        "environment": "production",
        "division": "commerce",
        "domain": "launch",
        "platform": "cloud",
        "version": ""
      },
      "consumer": {
        "upmId": "",
        "visitorId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "visitId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "isSwoosh": false,
        "allowsMarketing": true,
        "allowsPerformance": true
      },
      "marketing": {
      	"campaignKey": "jordan_4_retro",
      	"campaignValue": "30235f5664094b83",
      	"clickIdKey": "click_me",
      	"clickIdValue": "30235f5664094b83",
      	"vendorKey": "ads_r_us",
      	"vendorValue": "123456789"
      },
      "platform": {
        "type": "mobile",
        "deviceId": "2b6f0cc904d137be2e1730235f5664094b831186",
        "make": "Apple",
        "model": "A1549",
        "os": {
        	"name": "ios",
        	"version": "11.2.2",
        	"idfa": "2b6f0cc904d137be2e1730235f5664094b831186",
        	"idfv": "2b6f0cc904d137be2e1730235f5664094b831186"
        },
        "heightInPixels": 1080,
        "widthInPixels": 1920
      },
      "locale": {
        "country": "us",
        "language": "en-US"
      },
      "privacy": {
        "isMarketing": true,
        "isPerformance": true,
        "isFunctional": false
      },
      "id": "abc123xyz",
      "timestamp": "2018-01-03T00:40:35.918Z"
    }
  ]
}
```

##### Metric

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|Type of event, only "metric" is allowed|Required|
|events.**properties**|Object|Required|
|events.properties.**metricName**|Metric name, string|Required|
|events.properties.**metricType**|Metric type, one of "gauge", "counter", "cumulative_counter"|Required|
|events.properties.**dimensions**|Object|Required|
|events.properties.**metricValue**|Metric value, number|Required|
|events.properties.**other**|Other metric data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|

Sample request body:

```
{
  "$schema": "../../schemas/eventBatch.json",
  "actorId": "53449035084208179402477208077095861290",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "id": "99461f51-1d70-4ece-9433-7bffcf8a71f8",
      "timestamp": "2018-01-03T00:44:15.582Z",
      "consumer": {
        "allowsPerformance": true,
        "allowsMarketing": true,
        "upmId": "123456789",
        "visitorId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "visitId": "13",
        "isSwoosh": true
      },
      "platform": {
        "type": "web",
        "url": "https://www.nike.com/checkout",
        "pageTitle": "Nike.com Checkout",
        "referrer": "https://secure-store.nike.com/us/checkout/html/cart.jsp?l=cart&country=US&lang_locale=en_US&site=nikestore&returnURL=https://www.nike.com/t/air-jordan-1-retro-high-og-orange-mens-shoe-oe8vO8",
        "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
        "widthInPixels": 1920,
        "heightInPixels": 1080,
        "adobeVisitorId": "53449035084208179402477208077095861290"
      },
      "privacy": {
        "isFunctional": false,
        "isPerformance": true,
        "isMarketing": false
      },
      "abTest": {
        "neo": {
          "swimLane": "32",
          "profiles": [
            {
              "name": "main",
              "experiments": [
                {
                  "id": "3039-interceptor",
                  "variation": "a"
                },
                {
                  "id": "3250-interceptor",
                  "variation": "a"
                },
                {
                  "id": "3136-interceptor",
                  "variation": "a"
                }
              ]
            }
          ]
        }
      },
      "application": {
        "name": "checkout",
        "version": "dev-0",
        "environment": "production",
        "domain": "dotcom",
        "division": "commerce",
        "platform": "cloud"
      },
      "locale": {
        "country": "us",
        "language": "en-us"
      },
      "eventName": "checkoutPreviewComplete",
      "eventType": "metric",
      "properties": {
        "metricName": "firstCheckoutPreviewComplete",
        "metricType": "gauge",
        "dimensions": {
          "successCount": 2
        },
        "metricValue": 6919
      }
    }
  ]
}
```

##### Mouse

The fields for the **mouse** event type are:

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|Type of event, only "mouse" is allowed|Required|
|events.**properties**|Object|Required|
|events.properties.**interactionType**|Type of interaction (e.g. "click", "touch", "drag", etc.)|Required|
|events.properties.**mouseTarget**|Description of target of interaction, e.g. "change billing country"|Required|
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>|Required|
|events.properties.view.**channel**||Required|
|events.properties.view.**name**||Optional|
|events.properties.view.**viewType**||Optional|
|events.properties.view.**contentBoostTags**|List of tags describing the enhanced content of the view, e.g. "video", "music", "game"|Optional|
|events.properties.**other**|Other mouse data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|

Sample request body:

```
{
  "$schema": "../../schemas/eventBatch.json",
  "actorId": "53449035084208179402477208077095861290",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "id": "499068e1-cd49-4b06-b6a0-18f8b9831882",
      "timestamp": "2018-01-03T00:53:26.268Z",
      "consumer": {
        "allowsPerformance": true, 
        "allowsMarketing": true,
        "upmId": "123456789",
        "visitorId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "visitId": "13",
        "isSwoosh": true
      },
      "platform": {
        "type": "web",
        "url": "https://www.nike.com/checkout",
        "pageTitle": "Nike.com Checkout",
        "referrer": "https://secure-store.nike.com/us/checkout/html/cart.jsp?l=cart&country=US&lang_locale=en_US&site=nikestore&returnURL=https://www.nike.com/t/air-jordan-1-retro-high-og-orange-mens-shoe-oe8vO8",
        "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
        "widthInPixels": 1920,
        "heightInPixels": 1080,
        "adobeVisitorId": "53449035084208179402477208077095861290"
      },
      "privacy": {
        "isFunctional": false,
        "isPerformance": true,
        "isMarketing": false
      },
      "abTest": {
        "neo": {
          "swimLane": "32",
          "profiles": [
            {
              "name": "main",
              "experiments": [
                {
                  "id": "3039-interceptor",
                  "variation": "a"
                },
                {
                  "id": "3250-interceptor",
                  "variation": "a"
                },
                {
                  "id": "3136-interceptor",
                  "variation": "a"
                }
              ]
            }
          ]
        }
      },
      "application": {
        "name": "checkout",
        "version": "dev-0",
        "environment": "production",
        "domain": "dotcom",
        "division": "commerce",
        "platform": "cloud"
      },
      "locale": {
        "country": "us",
        "language": "en-us"
      },
      "eventName": "click_checkoutChangeBillingCountry",
      "eventType": "mouse",
      "properties": {
        "interactionType": "click",
        "mouseTarget": "change billing country",
        "view": {
          "channel": "checkout",
          "name": "tunnel"
        }
      },
      "products": [
        {
          "productName": "Air Jordan 1 Retro High OG \"Cool Blue\" Men's Shoe",
          "productId": "37c1d287-b591-556f-980c-50fba809d8c2",
          "styleColor": "AJ5997-455",
          "skuId": "8406ac5c-5b07-5742-b19a-e02163ebaf95",
          "priceAmount": 105,
          "priceCurrency": "USD",
          "quantity": 1,
          "pid": "12063010",
          "brand": "Jordan",
          "productType": "FOOTWEAR",
          "subtitle": "Men's Shoe",
          "styleType": "INLINE",
          "nikeSize": "8.5"
        }
      ]
    }
  ]
}
```

##### Page Load

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|Type of event, only "pageLoad" is allowed|Required|
|events.**properties**|Object|Required|
|events.properties.**navigationStartInMS**||Required|
|events.properties.**responseEndInMS**||Required|
|events.properties.**domContentLoadedInMS**||Required|
|events.properties.**domCompleteInMS**||Required|
|events.properties.**firstPaintInMS**||Required|
|events.properties.**pageLoadInMS**||Required|
|events.properties.**other**|Other page data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|

Sample request body:
```
{
  "$schema": "../../schemas/eventBatch.json",
  "actorId": "53449035084208179402477208077095861290",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "id": "ccde90ce-edac-47a1-bad8-391d0d13c813",
      "timestamp": "2018-01-03T00:44:12.007Z",
      "consumer": {
        "allowsPerformance": true,
        "allowsMarketing": true,
        "upmId": "",
        "visitorId": "",
        "visitId": "",
        "isSwoosh": false
      },
      "platform": {
        "type": "web",
        "url": "https://www.nike.com/checkout",
        "pageTitle": "Nike.com Checkout",
        "referrer": "https://secure-store.nike.com/us/checkout/html/cart.jsp?l=cart&country=US&lang_locale=en_US&site=nikestore&returnURL=https://www.nike.com/t/air-jordan-1-retro-high-og-orange-mens-shoe-oe8vO8",
        "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
        "widthInPixels": 1920,
        "heightInPixels": 1080,
        "adobeVisitorId": "53449035084208179402477208077095861290"
      },
      "privacy": {
        "isFunctional": false,
        "isPerformance": true,
        "isMarketing": false
      },
      "abTest": {
        "neo": {
          "swimLane": "32",
          "profiles": [
            {
              "name": "main",
              "experiments": [
                {
                  "id": "3039-interceptor",
                  "variation": "a"
                },
                {
                  "id": "3250-interceptor",
                  "variation": "a"
                },
                {
                  "id": "3136-interceptor",
                  "variation": "a"
                }
              ]
            }
          ]
        }
      },
      "application": {
        "name": "checkout",
        "version": "dev-0",
        "environment": "production",
        "domain": "dotcom",
        "division": "commerce",
        "platform": "cloud"
      },
      "locale": {
        "country": "us",
        "language": "en-us"
      },
      "eventName": "pageLoad",
      "eventType": "pageLoad",
      "properties": {
        "view": {
          "name": "APP_SHELL",
          "channel": "checkout"
        },
        "previousView": {
          "name": "loading",
          "channel": "checkout"
        },
        "navigationStartInMS": 1514940248663,
        "responseEndInMS": 1514940252002,
        "domContentLoadedInMS": 3339,
        "domCompleteInMS": 3339,
        "firstPaintInMS": 3339,
        "pageLoadInMS": 3339
      }
    }
  ]
}
```

##### Registration Complete

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|Type of event, only "registrationComplete" is allowed|Required|
|events.**consumer**|Consumer context from Base Event|Required|
|events.**marketing**|Marketing context from Base Event|Required|

Sample request body:
```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "eventName": "snkrs_ios_register",
      "eventType": "registrationComplete",
      "application": {
        "name": "snkrs",
        "environment": "production",
        "division": "commerce",
        "domain": "launch",
        "platform": "cloud",
        "version": ""
      },
      "consumer": {
        "upmId": "",
        "visitorId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "visitId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "isSwoosh": false,
        "allowsMarketing": true,
        "allowsPerformance": true
      },
      "marketing": {
      	"campaignKey": "jordan_4_retro",
      	"campaignValue": "30235f5664094b83",
      	"clickIdKey": "click_me",
      	"clickIdValue": "30235f5664094b83",
      	"vendorKey": "ads_r_us",
      	"vendorValue": "123456789"
      },
      "platform": {
        "type": "mobile",
        "deviceId": "2b6f0cc904d137be2e1730235f5664094b831186",
        "make": "Apple",
        "model": "A1549",
        "os": {
        	"name": "ios",
        	"version": "11.2.2",
        	"idfa": "2b6f0cc904d137be2e1730235f5664094b831186",
        	"idfv": "2b6f0cc904d137be2e1730235f5664094b831186"
        },
        "heightInPixels": 1080,
        "widthInPixels": 1920
      },
      "locale": {
        "country": "us",
        "language": "en-US"
      },
      "privacy": {
        "isMarketing": true,
        "isPerformance": true,
        "isFunctional": false
      },
      "id": "abc123xyz",
      "timestamp": "2018-01-03T00:40:35.918Z"
    }
  ]
}
```

##### Search

The following common elements are required:

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|Type of event, only "search" is allowed|Required|
|events.**properties**|Object|Required|

The above must be combined with one of the following:

|Element Name|Description|Required?|
|---|---|---|
|events.properties.**itemIndex**|Integer index of the search item as it's presented to the user in the list of search items|Optional|
|events.properties.**searchItem**|A type-ahead or autocomplete item the user selects|Optional|
|events.properties.**searchText**|The search text the user entered|Required|
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>|Optional|
|events.properties.view.**channel**||Required|
|events.properties.view.**name**||Optional|
|events.properties.view.**viewType**||Optional|
|events.properties.view.**contentBoostTags**|List of tags describing the enhanced content of the view, e.g. "video", "music", "game"|Optional|
|events.properties.**other**|Other search data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|

**OR**

|Element Name|Description|Required?|
|---|---|---|
|events.properties.**searchText**|The search text the user entered|Required|
|events.properties.**searchType**|The type of search used, "userEntered" allowed only|Required|
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>|Optional|
|events.properties.view.**channel**||Required|
|events.properties.view.**name**||Optional|
|events.properties.view.**viewType**||Optional|
|events.properties.view.**contentBoostTags**|List of tags describing the enhanced content of the view, e.g. "video", "music", "game"|Optional|
|events.properties.**other**|Other search data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|

**OR**

|Element Name|Description|Required?|
|---|---|---|
|events.properties.**itemIndex**|Integer index of the search item as it's presented to the user in the list of search items|Optional|
|events.properties.**searchItem**|A type-ahead or autocomplete item the user selects|Required|
|events.properties.**searchText**|The search text the user entered|Required|
|events.properties.**searchType**|The type of search used, "typeahead" or "visualSearch" allowed only|Required|
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>|Optional|
|events.properties.view.**channel**||Required|
|events.properties.view.**name**||Optional|
|events.properties.view.**viewType**||Optional|
|events.properties.view.**contentBoostTags**|List of tags describing the enhanced content of the view, e.g. "video", "music", "game"|Optional|
|events.properties.**other**|Other search data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|

Sample request body:

```
{
  "actorId": "123456789",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "id": "c3656c76-c2d9-4b73-be32-140b795d9521",
      "timestamp": "2018-01-03T00:34:12.701Z",
      "eventName": "click_navOnsiteSearchTypeahead",
      "eventType": "search",
      "application": {
        "name": "search",
        "environment": "production",
        "division": "commerce",
        "domain": "dotcom",
        "platform": "legacy",
        "version": "2.0.0"
      },
      "consumer": {
        "allowsMarketing": true,
        "allowsPerformance": true,
        "isSwoosh": true,
        "upmId": "123456789",
        "visitId": "13",
        "visitorId": "079ae31b-8282-4fed-8c6e-615c06cf51af"
      },
      "platform": {
        "type": "web",
        "pageTitle": "Official Jordan Store. Nike.com",
        "referrer": "https://www.nike.com/us/en_us/e/nike-plus-membership",
        "url": "https://store.nike.com/us/en_us/pw/jordan/ofq",
        "adobeVisitorId": "53449035084208179402477208077095861290",
        "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
        "heightInPixels": 1080,
        "widthInPixels": 1920
      },
      "properties": {
        "itemIndex": 0,
        "searchItem": "jordan",
        "searchText": "jordan",
        "searchType": "typeahead",
        "view": {
          "name": "visual search modal",
          "channel": "visual search"
        }
      },
      "locale": {
        "country": "us",
        "language": "en"
      },
      "privacy": {
        "isMarketing": false,
        "isPerformance": true,
        "isFunctional": false
      }
    }
  ]
}
```

##### Selection

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|Type of event, only "selection" is allowed|Required|
|events.**properties**|Object|Required|
|events.properties.**selectionTarget**|String|Required|
|events.properties.**selectionValue**|String|Required|
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>|Optional|
|events.properties.view.**channel**||Required|
|events.properties.view.**name**||Optional|
|events.properties.view.**viewType**||Optional|
|events.properties.view.**contentBoostTags**|List of tags describing the enhanced content of the view, e.g. "video", "music", "game"|Optional|
|events.properties.**other**|Other selection data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|

Sample request body:

```
{
  "$schema": "../../schemas/eventBatch.json",
  "actorId": "53449035084208179402477208077095861290",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "id": "9414ce5e-ec83-4b1f-a08d-6b73af9b65d8",
      "timestamp": "2018-01-03T00:51:07.153Z",
      "consumer": {
        "allowsPerformance": true,
        "allowsMarketing": true,
        "upmId": "123456789",
        "visitorId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "visitId": "13",
        "isSwoosh": true
      },
      "platform": {
        "type": "web",
        "url": "https://www.nike.com/checkout",
        "pageTitle": "Nike.com Checkout",
        "referrer": "https://secure-store.nike.com/us/checkout/html/cart.jsp?l=cart&country=US&lang_locale=en_US&site=nikestore&returnURL=https://www.nike.com/t/air-jordan-1-retro-high-og-orange-mens-shoe-oe8vO8",
        "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36",
        "widthInPixels": 1920,
        "heightInPixels": 1080,
        "adobeVisitorId": "53449035084208179402477208077095861290"
      },
      "privacy": {
        "isFunctional": false,
        "isPerformance": true,
        "isMarketing": false
      },
      "abTest": {
        "neo": {
          "swimLane": "32",
          "profiles": [
            {
              "name": "main",
              "experiments": [
                {
                  "id": "3039-interceptor",
                  "variation": "a"
                },
                {
                  "id": "3250-interceptor",
                  "variation": "a"
                },
                {
                  "id": "3136-interceptor",
                  "variation": "a"
                }
              ]
            }
          ]
        }
      },
      "application": {
        "name": "checkout",
        "version": "dev-0",
        "environment": "production",
        "domain": "dotcom",
        "division": "commerce",
        "platform": "cloud"
      },
      "locale": {
        "country": "us",
        "language": "en-us"
      },
      "eventName": "checkbox_checkoutSaveCardForLaterUse",
      "eventType": "selection",
      "properties": {
        "selectionTarget": "save card for later use",
        "selectionValue": "selected",
        "view": {
          "name": "payment",
          "channel": "checkout"
        }
      },
      "products": [
        {
          "productName": "Air Jordan 1 Retro High OG \"Cool Blue\" Men's Shoe",
          "productId": "37c1d287-b591-556f-980c-50fba809d8c2",
          "styleColor": "AJ5997-455",
          "skuId": "8406ac5c-5b07-5742-b19a-e02163ebaf95",
          "priceAmount": 105,
          "priceCurrency": "USD",
          "quantity": 1,
          "pid": "12063010",
          "brand": "Jordan",
          "productType": "FOOTWEAR",
          "subtitle": "Men's Shoe",
          "styleType": "INLINE",
          "nikeSize": "8.5"
        }
      ]
    }
  ]
}
```

##### Text Input

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|Type of event, only "textInput" is allowed|Required|
|events.**properties**|Object|Required|
|events.properties.**inputTarget**|String|Required|
|events.properties.**inputValue**|String|Required|
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>|Optional|
|events.properties.view.**channel**||Required|
|events.properties.view.**name**||Optional|
|events.properties.view.**viewType**||Optional|
|events.properties.view.**contentBoostTags**|List of tags describing the enhanced content of the view, e.g. "video", "music", "game"|Optional|
|events.properties.**other**|Other text input data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|Optional|

Sample request body:
```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "eventName": "snkrs_ios_text_input",
      "eventType": "textInput",
      "properties": {
    	"inputTarget": "someTextBox",
    	"inputValue": "some text"
		},
      "application": {
        "name": "snkrs",
        "environment": "production",
        "division": "commerce",
        "domain": "launch",
        "platform": "cloud",
        "version": ""
      },
      "consumer": {
        "upmId": "",
        "visitorId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "visitId": "079ae31b-8282-4fed-8c6e-615c06cf51af",
        "isSwoosh": false,
        "allowsMarketing": true,
        "allowsPerformance": true
      },
      "marketing": {
      	"campaignKey": "jordan_4_retro",
      	"campaignValue": "30235f5664094b83",
      	"clickIdKey": "click_me",
      	"clickIdValue": "30235f5664094b83",
      	"vendorKey": "ads_r_us",
      	"vendorValue": "123456789"
      },
      "platform": {
        "type": "mobile",
        "deviceId": "2b6f0cc904d137be2e1730235f5664094b831186",
        "make": "Apple",
        "model": "A1549",
        "os": {
        	"name": "ios",
        	"version": "11.2.2",
        	"idfa": "2b6f0cc904d137be2e1730235f5664094b831186",
        	"idfv": "2b6f0cc904d137be2e1730235f5664094b831186"
        },
        "heightInPixels": 1080,
        "widthInPixels": 1920
      },
      "locale": {
        "country": "us",
        "language": "en-US"
      },
      "privacy": {
        "isMarketing": true,
        "isPerformance": true,
        "isFunctional": false
      },
      "id": "abc123xyz",
      "timestamp": "2018-01-03T00:40:35.918Z"
    }
  ]
}
```

### <a name="response-body"></a>Response Body

The response body format is described below.

|Element Name|Description|Required?|
|---|---|---|
|**message**|Response message|Required|
|message.**eventBatchErrors**|Optional||

Sample HTTP 200 success response:

```
{
    "message": "Success"
}
```

Sample HTTP 400 error responses:

Scenario: request did not have the required **events** property
```
{
    "message": {
        "eventBatchErrors": [
            {
                "keyword": "required",
                "dataPath": "",
                "schemaPath": "#/required",
                "params": {
                    "missingProperty": "events"
                },
                "message": "should have required property 'events'"
            }
        ]
    }
}
```

Scenario: request had blank **actorId** property
```
{
    "message": {
        "eventBatchErrors": [
            {
                "keyword": "minLength",
                "dataPath": ".actorId",
                "schemaPath": "#/properties/actorId/minLength",
                "params": {
                    "limit": 1
                },
                "message": "should NOT be shorter than 1 characters"
            }
        ]
    }
}
```

Sample HTTP 500 error response:

Scenario: the API is having an issue taking the request.
```
{
    "error_id": "65b35de2-9e2e-4ba5-afc2-4f687cbf33a7",
    "errors": [
        {
            "code": 10,
            "message": "An error occurred while fulfilling the request"
        }
    ]
}
```

<!-- <a href="http://nikeweb-test.private.static.s3-website-us-east-1.amazonaws.com/fat/event-validator-ui/index.html" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

---

## <a name="upgrading-to-the-latest-version"></a>Upgrading to the Latest Version

Use the following tables to help your upgrade process from Analytics Pipeline v1 to v2.

The first table shows the v1-v2 mapping for the fields in the Event Batch & Base Event schema. The remaining tables show the mappings for the fields that are specific to each Event Type.

### <a name="event-batch--base-event-schema-mapping"></a>Event Batch & Base Event Schema Mapping

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|**$schema**|URL for the JSON schema version used|N/A (deprecated)|N/A||
|**actorId**|ID representing the principal actor in this event, minimum length of 1 character, e.g. "53449035084208179402477208077095861290"|**actorId**|(same)||
|**resourceType**|Constant value that describes the type of resource. "dotcom/event_batch" is the only allowed value|**resourceType**|(same)||
|**resourceVersion**|Constant value that describes the version of this API contract. "v1" is the only allowed value|**resourceVersion**|(same)|Even for v2, use "v1" here|
|**events**|Array of analytics events, minimum of 1|**events**|(same)||
|events.**eventName**|Unique name for this event class, e.g. "click_checkoutChangeBillingCountry"|events.**event**|Name of the action the user performed||
|events.**eventTags**|Array of event tags, one of "loginAttempt", "registrationComplete", "registrationStart", "userLogIn"|events.**eventTags**|(same)||
|events.**eventType**|Unique name for this type of event, e.g. "mouse"|events.**eventType**|(same)||
|events.**timestamp**|Date-time of the event, e.g. "1985-04-12T23:20:50.52Z"|events.**timestamp**|(same)||
|events.**id**|A UUID v4 for this event instance|events.**eventId**|(same)||
|events.application.**name**|App name|events.context.app.**name**|(same)||
|events.application.**version**|Semver style or build number of app|events.context.app.**version**|(same)||
|events.application.**environment**|App environment, one of "development", "test", or "production"|events.context.app.**environment**|(same)||
|events.application.**domain**|Experience domain of app, see list <a href="https://confluence.nike.com/display/DAHP/List+of+DTC+Experiences" target="_blank">here</a>|events.context.app.**domain**|(same)||
|events.application.**division**|Organization which the app domain falls under, e.g. "commerce"|events.context.app.**division**|(same)||
|events.application.**platform**|Technology platform of the app, e.g. "cloud", "tesla"|events.context.app.**platform**|(same)||
|events.locale.**country**|ISO 3166 country code|events.context.**locale**|(same)||
|events.locale.**language**|BCP47 language code|events.context.**language**|(same)||
|events.privacy.**isFunctional**|Boolean specifying if event is categorized as functional|N/A (deprecated)|N/A||
|events.privacy.**isMarketing**|Boolean specifying if event is categorized as marketing|events.context.privacy.**isMarketing**|||
|events.privacy.**isPerformance**|Boolean specifying if event is categorized as performance|events.context.privacy.**isPerformance**|||
|events.platform.**type**|Platform type, "web"|N/A (deprecated)|N/A||
|events.platform.**pageTitle**||events.context.page.**title**|||
|events.platform.**adobeVisitorId**||events.context.consumer.**adobeVisitorId**|||
|events.platform.**referrer**||events.context.page.**referrer**|||
|events.platform.**userAgent**||events.context.**userAgent**|||
|events.platform.**widthInPixels**||events.context.screen.**width**|||
|events.platform.**heightInPixels**||events.context.screen.**height**|||
|events.platform.**url**||events.context.page.**url**|||
|events.platform.**type**|Platform type, "service"|N/A (deprecated)|N/A||
|events.platform.**domain**||events.context.app.**domain**|||
|events.platform.**resource**||events.context.app.**resource**|||
|events.platform.**version**||events.context.app.**version**|||
|events.platform.**type**|Platform type, "mobile"||N/A (deprecated)|N/A||
|events.platform.**deviceId**||events.context.device.**id**|||
|events.platform.**make**||events.context.device.**manufacturer**|||
|events.platform.**model**||events.context.device.**model**|||
|events.platform.os.**name**||events.context.os.**name**|||
|events.platform.os.**version**||events.context.os.**version**|||
|events.platform.os.**idfa**||events.context.device.**id**|||
|events.platform.os.**idfv**||events.context.device.**id**|||
|events.platform.os.**adid**||events.context.device.**id**|||
|events.platform.os.**other**|Other OS data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||
|events.platform.**other**|Other platform data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||
|events.consumer.**anonymousId**|A pseudo-unique substitute for a User ID, for cases when you don't have an absolutely unique identifier|events.**anonymousId**|(same)||
|events.consumer.**upmId**|Nike user profile identifier|events.**userId**|A unique identifier for the user in your database||
|events.consumer.**visitorId**|Unite visitor identifier|N/A (deprecated)|N/A||
|events.consumer.**visitId**|Unite visit identifier|events.context.consumer.**visitId**|(same)||
|events.consumer.**adobeMarketingCloudId**|The value of the s_vi cookie in the browser|events.context.consumer.**adobeMarketingCloudId**|(same)||
|events.consumer.**adobeVisitorId**|A value Adobe needs for identity|events.context.consumer.**adobeVisitorId**|(same)||
|events.consumer.**isSwoosh**|Boolean where if true the user is a Nike employee|events.context.consumer.**isSwoosh**|(same)||
|events.consumer.**allowsMarketing**|Boolean where if true the user has opted into marketing events being collected|events.context.consumer.**allowsMarketing**|(same)||
|events.consumer.**allowsPerformance**|Boolean where if true the user has opted into performance events being collected |events.context.consumer.**allowsPerformance**|(same)||
|events.consumer.**other**|Other consumer data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||
|events.marketing.**campaignKey**|The campaign key for a specific Ad vendor|events.context.campaign.**source**|(same)||
|events.marketing.**campaignValue**|The value for a specific Ad vendors campaign|events.context.campaign.**value**|(same)||
|events.marketing.**clickIdKey**|The click identifier for a specific Ad vendors campaign|N/A (deprecated)|N/A||
|events.marketing.**clickIdValue**|The click value for a specific user that clicks on a specific Ad|N/A (deprecated)|N/A||
|events.marketing.**vendorKey**|The query parameter key for vendor identification|N/A (deprecated)|N/A||
|events.marketing.**vendorValue**|The query parameter value for vendor identification|N/A (deprecated)|N/A||
|events.marketing.**siteSource**|The query parameter value for SITESRC|N/A (deprecated)|N/A||
|events.marketing.**other**|Other campaign data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||
|events.abTest.neo.**swimlane**|String|events.**swimlane**|(same)||
|events.abTest.neo.profiles.**name**|Experiment name, string|events.**experimentName**|(same)||
|events.abTest.neo.profiles.experiments.**id**|Experiment identifier, string|events.**experimentId**|(same)||
|events.abTest.neo.profiles.experiments.**variation**|Variation identifier, string|events.**variationId**|(same)||
|events.abTest.neo.profiles.experiments.**other**|Other experiment data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>||||
|events.abTest.neo.profiles.**other**|Other profile data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>||||
|events.abTest.neo.**other**|Other Neo data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||
|events.abTest.optimizely.**experimentId**|Experiment identifier, string|events.**experimentId**|(same)||
|events.abTest.optimizely.**experimentName**|Experiment name, string|events.**experimentName**|(same)||
|events.abTest.optimizely.**variationId**|Variation identifier, string|events.**variationId**|(same)||
|events.abTest.optimizely.**variationName**|Variation name, string|N/A (deprecated)|N/A||
|events.abTest.**other**|Other A/B Test data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||
|events.order.**checkoutId**|Generated id of a submitted checkout|events.**checkoutId**|(same)||
|events.order.**orderId**|Id of a submitted order|events.**orderId**|(same)||
|events.order.**promoCode**|Promo code applied to checkout|events.**coupon**|(same)||
|events.order.shipping.**cost**|Shipping cost|events.**shipping**|(same)||
|events.order.shipping.**method**|Shipping method|events.**shippingMethod**|(same)||
|events.order.vas.**giftWrap**|Number|events.**valueAddedServicesTotal**|Total of all value-added services on the order||
|events.order.vas.**other**|Number|events.**valueAddedServicesTotal**|Total of all value-added services on the order||
|events.order.**tax**|Tax on order|events.**tax**|(same)||
|events.order.**discount**|Discount on order|events.**discount**|(same)||
|events.order.**total**|Total of order|events.**total**|(same)||
|events.order.**currency**|Currency code on order|events.**currency**|(same)||
|events.order.**products**|Array of at least one product, see 'events.products' in this table for mapping|N/A|||
|events.order.payments.**paymentType**|Type of payment|events.**paymentMethod**|(same)||
|events.order.payments.**stored**|Boolean that is true if payment is a stored payment|events.**paymentStored**|(same)||
|events.order.payments.**other**|Other payment data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||
|events.products.**productId**|Product UUID|events.**productId**|(same)||
|events.products.**brand**|Brand of the product|events.**brand**|(same)||
|events.products.**category**|Category of the product|events.**category**|(same)||
|events.products.**inventoryStatus**|Inventory status, one of "coming soon","discontinued","gift card","in stock","locked","nikeid","NONE","out of stock","preorder","unlocked:profile:in stock",null|events.**inventoryStatus**|(same)||
|events.products.**nikeSize**|Nike size code of the product|events.**size**|(same)||
|events.products.**pid**|Classic integer style product id|events.**pid**|(same)||
|events.products.**priceAmount**|Price of product (number)|events.***price**|(same)||
|events.products.**priceCurrency**|Currency code of price|events.**currency**|(same)||
|events.products.**priceStatus**|Price status, one of "clearance", "reduced", "regular", null|N/A (deprecated)|N/A||
|events.products.**productName**|Name of product|events.**name**|(same)||
|events.products.**productType**|Type of product|events.**type**|(same)||
|events.products.**quantity**|Unit quantity of product (number)|events.**quantity**|(same)||
|events.products.**skuId**|SKU UUID|events.**sku**|(same)||
|events.products.**sportsTags**|N/A|N/A (deprecated)|N/A||
|events.products.**styleColor**|Style-color code of product|events.**variant**|Variant of the product||
|events.products.**styleType**|Style type of product|events.**style**|Style of the product||
|events.products.**subtitle**|Subtitle of product|events.**subtitle**|(same)||
|events.products.**other**|Other product data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||
|events.**other**|A non-validated name-spaced region where domain-specific data can be added, per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||

### Action: Event Type Mapping

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.**eventType**|Type of event, only "action" is allowed|events.**eventType**|(same)||
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>||||
|events.properties.**other**|Other event data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||

### App Launch: Event Type Mapping

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.**eventType**|Type of event, only "appLaunch" is allowed|events.**eventType**|(same)||
|events.**consumer**|Consumer context from Base Event|See [Event Batch & Base Event](#event-batch--base-event-schema-mapping) table|N/A||
|events.**platform**|Platform context from Base Event|See [Event Batch & Base Event](#event-batch--base-event-schema-mapping) table|N/A||
|events.platform.**type**|Platform type, only "mobile" is allowed|N/A (deprecated)|N/A||
|events.**marketing**|Marketing context from Base Event|See 'Event Batch & Base Event' table|N/A||

### Change View: Event Type Mapping

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.**eventType**|Type of event, only "changeView" is allowed|events.**eventType**|(same)||
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>||||
|events.properties.**previousView**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>||||
|events.properties.**other**|Other event data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||

### Checkout Confirmation: Event Type Mapping

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.**eventType**|Type of event, only "checkoutConfirmation" is allowed|events.**eventType**|(same)||
|events.properties.**checkoutId**|Checkout identifier, UUID, client provided|events.**checkoutId**|(same)||
|events.properties.**orderId**|The unique order id generated for this checkout|events.**orderId**|(same)||
|events.properties.**currency**|Currency code following the ISO 4217 standard|events.**currency**|(same)||
|events.properties.**totals**|Price details for the checkout in whole|events.**totals**|(same)||
|events.properties.totals.**subtotal**|Subtotal of the item costs for all items|events.**subtotal**|(same)||
|events.properties.totals.**valueAddedServicesTotal**|Total of value added services on the items|events.**valueAddedServicesTotal**|(same)||
|events.properties.totals.**taxTotal**|Total of all taxes applied to the checkout|events.**tax**|(same)||
|events.properties.totals.**discountTotal**|Total of all discounts applied to the checkout|events.**discount**|(same)||
|events.properties.totals.**shippingTotal**|Total of all shipping costs (less shipping discounts) on the checkout|events.**shipping**|(same)||
|events.properties.totals.**total**|Total price of the entire checkout, item costs + shipping costs + taxes (excluding 'VALUEADDEDTAX') less any discounts|events.**totals**|(same)||
|events.properties.totals.**other**|Other totals data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||

### Error: Event Type Mapping

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.**eventType**|Type of event, only "error" is allowed|events.**eventType**|(same)||
|events.properties.errors.**code**|Error code, string|events.properties.errors.**code**|(same)||
|events.properties.errors.**message**|Error message, string|events.properties.errors.**message**|(same)||
|events.properties.errors.**field**|Error field, string|events.properties.errors.**field**|(same)||
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>||||
|events.properties.**other**|Other error data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||

### Login Complete: Event Type Mapping

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.**eventType**|Type of event, only "loginComplete" is allowed|events.**eventType**|(same)||
|events.**consumer**|Consumer context from the Base Event|See [Event Batch & Base Event](#event-batch--base-event-schema-mapping) table|N/A||
|events.**marketing**|Consumer context from the Base Event|See [Event Batch & Base Event](#event-batch--base-event-schema-mapping) table|N/A||

### Metric: Event Type Mapping

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.**eventType**|Type of event, only "metric" is allowed|events.**eventType**|(same)||
|events.properties.**metricName**|Metric name, string|events.properties.metric.**name**|(same)||
|events.properties.**metricType**|Metric type, one of "gauge", "counter", "cumulative_counter"|events.properties.metric.**type**|(same)||
|events.properties.**dimensions**|Object|events.properties.metric.**dimensions**|(same)||
|events.properties.**metricValue**|Metric value, number|events.properties.metric.**value**|(same)||
|events.properties.**other**|Other metric data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||

### Mouse: Event Type Mapping

The fields for the **mouse** event type are:

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.**eventType**|Type of event, only "mouse" is allowed|events.**eventType**|(same)||
|events.properties.**interactionType**|Type of interaction (e.g. "click", "touch", "drag", etc.)|events.properties.**interactionType**|(same)||
|events.properties.**mouseTarget**|Description of target of interaction, e.g. "change billing country"|events.properties.**mouseTarget**|(same)||
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>||||
|events.properties.**other**|Other mouse data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||

### Page Load: Event Type Mapping

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.**eventType**|Type of event, only "pageLoad" is allowed|events.**eventType**|(same)||
|events.properties.**navigationStartInMS**||events.properties.**navigationStartInMS**|(same)||
|events.properties.**responseEndInMS**||events.properties.**responseEndInMS**|(same)||
|events.properties.**domContentLoadedInMS**||events.properties.**domContentLoadedInMS**|(same)||
|events.properties.**domCompleteInMS**||events.properties.**domCompleteInMS**|(same)||
|events.properties.**firstPaintInMS**||events.properties.**firstPaintInMS**|(same)||
|events.properties.**pageLoadInMS**||events.properties.**pageLoadInMS**|(same)||
|events.properties.**other**|Other page data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||

### Registration Complete: Event Type Mapping

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.**eventType**|Type of event, only "registrationComplete" is allowed|events.**eventType**|(same)||
|events.**consumer**|Consumer context from Base Event|See [Event Batch & Base Event](#event-batch--base-event-schema-mapping) table|N/A||
|events.**marketing**|Marketing context from Base Event|See [Event Batch & Base Event](#event-batch--base-event-schema-mapping) table|N/A||

### Search: Event Type Mapping

The following common elements are required:

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.**eventType**|Type of event, only "search" is allowed|events.**eventType**|(same)||

The above must be combined with one of the following:

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.properties.**itemIndex**|Integer index of the search item as it's presented to the user in the list of search items|N/A (deprecated)|N/A||
|events.properties.**searchItem**|A type-ahead or autocomplete item the user selects|events.query.**item**|(same)||
|events.properties.**searchText**|The search text the user entered|events.query.**text**|(same)||
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>||||
|events.properties.**other**|Other search data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||

**OR**

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.properties.**searchText**|The search text the user entered|events.query.**text**|(same)||
|events.properties.**searchType**|The type of search used, "userEntered" allowed only|events.query.**type**|(same)||
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>||||
|events.properties.**other**|Other search data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||

**OR**

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.properties.**itemIndex**|Integer index of the search item as it's presented to the user in the list of search items|N/A (deprecated)|N/A||
|events.properties.**searchItem**|A type-ahead or autocomplete item the user selects|events.query.**item**|(same)||
|events.properties.**searchText**|The search text the user entered|events.query.**text**|(same)||
|events.properties.**searchType**|The type of search used, "typeahead" or "visualSearch" allowed only|events.query.**type**|(same)||
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>||||
|events.properties.**other**|Other search data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||

### Selection: Event Type Mapping

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.**eventType**|Type of event, only "selection" is allowed|events.**eventType**|(same)||
|events.properties.**selectionTarget**|String|events.**selectionTarget**|(same)||
|events.properties.**selectionValue**|String|events.**selectionValue**|(same)||
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>||||
|events.properties.**other**|Other selection data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||

### Text Input: Event Type Mapping

|V1 Field Name|Description|V2 Field Name|Description|Notes|
|---|---|---|---|---|
|events.**eventType**|Type of event, only "textInput" is allowed|events.**eventType**|(same)||
|events.properties.**inputTarget**|String|TBD|||
|events.properties.**inputValue**|String|TBD|||
|events.properties.**view**|Object representing the user viewing part of an application per the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/baseView.json" target="_blank">baseView schema</a>||||
|events.properties.**other**|Other text input data per <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/otherContexts.json" target="_blank">otherContext schema</a>|N/A (deprecated)|N/A||

## <a name="troubleshooting"></a>Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### Use Troubleshooting Tools

1. Check for validation errors logged in Splunk <a href="https://cdt-eng.splunkcloud.com/en-US/app/search/nexus_events_analytics_api#en-US/app/search/nexus_events_analytics_api?form.index_tok=lambda" target="_blank">here</a>

2. Use the sample requests in this document or those provided <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/test/sample-events" target="_blank">here</a> as a guide to forming valid requests for each event type.

## <a name="glossary"></a>Glossary

See the [Glossary](/doc/getting-started/glossary.html)

## <a name="release-notes"></a>Release Notes

There are no release notes at this time.

## <a name="document-change-log"></a>Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|02/27/2018|Initial Draft|
|Updated links|03/20/2018|Updated links to point to new dev portal|
|Updated external links|04/03/2018|Updated external links to open in new browser window|

## <a name="related-links"></a>Related Links

[NDe Docs Home](/index.html)

[Get Started](/doc/portal/get-started.html)