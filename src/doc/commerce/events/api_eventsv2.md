---
tags: pdf
category: use-case
position: 7
title: Events
url: /commerce/events/api_eventsv2.html
toc:
  - h2: API at a Glance
    url: /doc/commerce/events/api_eventsv2.html#api-at-a-glance
  - h2: Terms of Service
    url: /doc/commerce/events/api_eventsv2.html#terms-of-service
  - h2: Use Cases
    url: /doc/commerce/events/api_eventsv2.html#use-cases
  - h2: Endpoint Quick Reference
    url: /doc/commerce/events/api_eventsv2.html#api-endpoint-quick-reference
  - h2: Making Your First Request
    url: /doc/commerce/events/api_eventsv2.html#making-your-first-api-request
  - h2: Using Analytics Pipeline
    url: /doc/commerce/events/api_eventsv2.html#using-analytics-v2-pipeline
  - h2: Upgrading to the Latest Version
    url: /doc/commerce/events/api_eventsv2.html#upgrading-to-the-latest-version
  - h2: Best Practices
    url: /doc/commerce/events/api_eventsv2.html#best-practices
  - h2: Troubleshooting
    url: /doc/commerce/events/api_eventsv2.html#troubleshooting
  - h2: Glossary
    url: /doc/commerce/events/api_eventsv2.html#glossary
---

# ANALYTICS PIPELINE v2 API <i class="g72-swoosh"></i><br>DEVELOPER'S GUIDE

##### Last Updated: 10/01/2018<br>Submit Feedback: Dev Portal Slack channel <a href="slack://channel?team=T0G3T5X2B&amp;id=C9Q1MNJ1J">#devportal</a>

If you've read [Using NDe APIs](/doc/getting-started/using_nike_apis.html) and [Analytics Pipeline Overview](/doc/portal/overview-events.html), this guide provides the details necessary to integrate with the Nike Analytics Pipeline v2 API.

## <a name="api-at-a-glance"></a>API at a Glance

The <b>Analytics Pipeline v2 API</b> is your single destination to record analytics events, helping both user experiences and web services to track consumer and application behavior.

Because Analytics Pipeline is server-side and Nike-authored, it is much more customizable to your needs than a proprietary, client-side analytics solution.

Analytics events sent to this API are transformed and sent to multiple downstream systems/partners in real-time, allowing many needs to be fulfilled by sending a single event. Future integrations with other partners can be done without necessarily changing the contract of this API, thus making it easier (if not completely transparent) to you.

![](/images/analytics/events.png)

Here are a few ways in which analytics event data can be used:

- Track the success of marketing campaigns via tags or attribution
- Monitor user traffic and conversion metrics
- Track the success of new features (A/B testing)
- Alert on traffic anomalies

### Should I Use v1 or v2 of this API?

If you are integrating with Analytics Pipeline for the first time, use v2 as it is the most current version of the API.

The following table describes the key details of the API:

|Topic|Details|
|---|---|
|Use this API to|Send all consumer and application tracking events to a single endpoint|
|Who calls this API|TBD|
|Current Version|Analytics Pipeline v2|
|Scope/Limitations|Analytics events only. All countries supported. Do not use for sales, revenue, or available inventory information|
|SLAs|Response time (RT) and requests per second (RPS): <br>RT: 500 ms <br>RPS: 500|
|Domain|Commerce|
|Prerequisites|None|
|Contact Info|Slack: <a href="https://nikedigital.slack.com/messages/cic-nexus" target="_blank">#cic-nexus</a><br>Confluence space: <a href="https://confluence.nike.com/display/CN/CiC+UX+Foundation+Home" target="_blank">Analytics Pipeline API Team</a><br> Mailing List: [Lst-Nexus.Devops](mailto:Lst-Nexus.DevOps)<br><a name="product-owner"></a>Product Owner: <a href="mailto:randall.davis@nike.com" target="_blank">Randy Davis</a>|

### A Note about Segment

Segment is an analytics API and customer data platform which Nike utilizes. As you saw in the above diagram, it is one of several downstream integrations from the Analytics Pipeline API. By integrating with Segment once, Nike unlocks additional downstream integrations like Optimizely for A/B Testing, Kochava for mobile analytics, and several digital marketing integrations.

Reach out to the Analytics API Product Owner, [Randy Davis](mailto:randall.davis@nike.com), for information on the analytics opportunities available via Segment.

## <a name="terms-of-service"></a>Terms of Service

- Clients must not use analytics data collected with the Analytics Pipeline v2 API for sales, revenue, or available inventory data.
- High usage from a single IP address may be flagged by Nike bot detection and blocked.
- This API is not intended for application monitoring, logging, or reporting on server-side errors.

### <a name="authorization"></a>Authorization

No authentication or authorization is required to use the Analytics Pipeline v2 API.

## <a name="use-cases"></a>Use Cases

With the Analytics Pipeline v2 API you can track:

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

## <a name="api-endpoint-quick-reference"></a>API Endpoint Quick Reference

For more information about each service and to try them out though the UI, visit the Nike Developer Portal through the links below.

### Analytics Pipeline v2 API

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|<a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/API.md" target="_blank">SEND A NEW EVENT BATCH</a>|/measure/uxevents/v1|POST|

## <a name="making-your-first-api-request"></a>Making Your First API Request

For your first Analytics Pipeline v2 API request, send an event that corresponds to a user clicking 'Change Billing Country' in the context of completing checkout in a web app.

### Gather Data Needed for the Request

First, gather the data needed to make the request.

#### URL

In production, all requests to the Analytics Pipeline v2 API go to the same endpoint URL using the POST method:

|HTTP Method|Endpoint URL|
|---|---|
|POST|https://api.nike.com/measure/uxevents/v1|

However, for your first request and anytime you are performing tests, use the Test endpoint URL:

https://experience.test.commerce.nikecloud.com/measure/uxevents/v1.

>**TIP:** The URL for v2 is the same as v1.

#### Headers

All requests must include the **Content-Type** header as follows:

|Header Name|Description|Required?|
|---|---|---|
|**Content-Type**|Content type of the request, "application/json" is only value allowed|Yes|

#### Body

To form the request body, answer the following questions by studying the API.md file:

- What is the event type that should be used for this event?

The event type **mouse** is described in the API.md as 'a mouse or touch event', and is the correct type to use here.

- What are the required fields in the schema which apply to all events AND what are the additional fields are required for this specific event type?

See the [Request Body](#request-body) section for details on how to combine the various schemas into a properly-formed request.

- What other relevant, optional fields should be included in the event?

This answer will depend on your reasons for tracking the event, and therefore will vary.

Once you've addressed all of the above questions, proceed to form a JSON request body. A finalized request body could look like this:

```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "schemaVersion": 2,
      "properties": {
        "interactionType": "interactionType",
        "mouseTarget": "mouseTarget",
        "channel": "channel"
      },
      "userId": "upmId",
      "event": "eventName",
      "context": {
        "app": {
          "environment": "development",
          "domain": "domain",
          "division": "division",
          "platform": "platform",
          "name": "name",
          "version": "version",
          "build": "version"
        },
        "privacy": {
          "isMarketing": true,
          "isPerformance": true
        },
        "consumer": {
          "visitId": "visitId",
          "isSwoosh": true,
          "allowsMarketing": true,
          "allowsPerformance": true
        },
        "campaign": {
          "name": "campaignValue",
          "source": "campaignKey"
        },
        "locale": "language"
      },
      "timestamp": "1985-04-12T23:20:50.52Z",
      "productId": "productId",
      "brand": "brand",
      "category": "category",
      "inventoryStatus": "coming soon",
      "size": "nikeSize",
      "pid": "pid",
      "price": 1,
      "name": "productName",
      "type": "productName",
      "quantity": 1,
      "sku": "skuId",
      "style": "styleType",
      "subtitle": "subtitle",
      "eventType": "mouse",
      "eventTags": [
        "loginAttempt"
      ],
      "eventId": "id",
      "platform": "web",
      "experimentName": "name",
      "experimentId": "id",
      "variationId": "variation"
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

The responses from the Analytics Pipeline v2 API are simple to parse. If the event was successfully recorded, you will get an HTTP 200 response as shown below:

```
{
    "message": "Success"
}
```

If you receive any other response than this, something went wrong. See the [Response Body](#response-body) section for info on error responses.

## <a name="using-analytics-v2-pipeline"></a>Using Analytics v2 Pipeline

- [Analytics Pipeline Overview](#analytics-pipeline-overview)
- [Endpoint Details](#endpoint-details)
- [Path & Query Parameters](#path--query-parameters)
- [Request Headers](#request-headers)
- [Request Body](#request-body)
- [Response Body](#response-body)

### <a name="analytics-pipeline-overview"></a>Analytics Pipeline Overview

Use the Analytics Pipeline v2 API as a single destination for tracking your user experience, service, or application events.

### <a name="endpoint-details"></a>Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**POST**|`/measure/uxevents/v1`|No|

### <a name="path--query-parameters"></a>Path & Query Parameters

There are no path nor query parameters to be used with the Analytics Pipeline v2 API.

### <a name="request-headers"></a>Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Content-Type**|Content type of the request, **application/json** is only value allowed|Required|

### <a name="request-body"></a>Request Body

Forming a request body to the Analytics Pipeline v2 API requires combining the following schema information:

- <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/eventBatch.json" target="_blank">Event Batch</a>: top-most level in the request structure, which is common to all event types. Includes an array of one or more events.
- <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/common-fields.json" target="_blank">Common Fields</a>: common fields to be included for each event
- One of the following schemas: <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/page.json" target="_blank">Page</a>, <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/track.json" target="_blank">Track</a>, <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/identify.json" target="_blank">Identify</a>
- All of the following schemas: <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/ab-test.json" target="_blank">A-B Test</a>, <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/e-commerce.json" target="_blank">E-commerce</a>, <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/nike.json" target="_blank">Nike</a>

![](/images/analytics/events_v2_schema.png)

>Note: the Nike schema contains a field, **eventType**, that is a direct carryover from v1 (i.e. same exact values must be used). See more below on [Event Types](#event-types).

Next, we will discuss the details of each of the above schemas, including which fields are required.

#### Batch & Common Fields

The fields in the <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/batch.json" target="_blank">Batch</a> and <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/common-fields.json" target="_blank">Common Fields</a> schemas are described in the below table:

|Element Name|Description|Required?|
|---|---|---|
|**$schema**|URL for the JSON schema version used|Optional|
|**actorId**|ID representing the principal actor in this event, minimum length of 1 character, e.g. "53449035084208179402477208077095861290"|Required|
|**resourceType**|Constant value that describes the type of resource. "dotcom/event_batch" is the only allowed value|Required|
|**resourceVersion**|Constant value that describes the version of this API contract. "v1" is the only allowed value|Required|
|**events**|Array of analytics events, minimum of 1|Required|
|events.**anonymousId**|A pseudo-unique substitute for a User ID, for cases when you don't have a unique identifier.|Required if **userId** is not present|
|events.**userId**|A unique identifier for the user in your database|Required if **anonymousId** is not present|
|events.**type**|Type of event, one of "track", "page", "identify"|Optional|
|events.**event**|The name of the action the user performed|Optional|
|events.context.**active**|Boolean for whether a user is active|Optional|
|events.context.app.**name**|App name|Optional|
|events.context.app.**version**|Semver style or build number of app|Optional|
|events.context.app.**build**|Semver style or build number of app|Optional|
|events.context.campaign.**name**|The value for a specific Ad vendors campaign|Optional|
|events.context.campaign.**source**|The campaign key for a specific Ad vendor|Optional|
|events.context.campaign.**medium**|TBD|Optional|
|events.context.campaign.**term**|TBD|Optional|
|events.context.campaign.**content**|TBD|Optional|
|events.context.device.**id**|User's device identifier|Optional|
|events.context.device.**manufacturer**|User's device manufacturer|Optional|
|events.context.device.**model**|Device model|Optional|
|events.context.device.**name**|TBD|Optional|
|events.context.device.**type**|TBD|Optional|
|events.context.device.**version**|TBD|Optional|
|events.context.**ip**|Current user's IP address|Optional|
|events.context.library.**name**|Library name|Optional|
|events.context.library.**version**|Library version|Optional|
|events.context.**locale**|Locale string for the current user, e.g. "en-US"|Optional|
|events.context.location.**city**|User's city name|Optional|
|events.context.location.**country**|User's ISO-3166 country code|Optional|
|events.context.location.**latitude**|User's latitude|Optional|
|events.context.location.**longitude**|User's longitude|Optional|
|events.context.location.**region**|TBD|Optional|
|events.context.location.**speed**|TBD|Optional|
|events.context.network.**bluetooth**|TBD|Optional|
|events.context.network.**carrier**|TBD|Optional|
|events.context.network.**cellular**|TBD|Optional|
|events.context.network.**wifi**|TBD|Optional|
|events.context.os.**name**|User's operating system name|Optional|
|events.context.os.**version**|User's operating system version|Optional|
|events.context.page.**hash**|TBD|Optional|
|events.context.page.**path**|TBD|Optional|
|events.context.page.**referrer**|TBD|Optional|
|events.context.page.**search**|TBD|Optional|
|events.context.page.**title**|TBD|Optional|
|events.context.page.**url**|TBD|Optional|
|events.context.referrer.**type**|TBD|Optional|
|events.context.referrer.**name**|TBD|Optional|
|events.context.referrer.**url**|TBD|Optional|
|events.context.referrer.**link**|TBD|Optional|
|events.context.screen.**density**|TBD|Optional|
|events.context.screen.**height**|Screen height in pixels|Optional|
|events.context.screen.**width**|Screen width in pixels|Optional|
|events.context.**timezone**|TBD|Optional|
|events.context.traits.**track**|TBD|Optional|
|events.context.traits.**identify**|TBD|Optional|
|events.context.**userAgent**|TBD|Optional|
|events.integrations.**All**|Boolean where if true the message should be sent to all destinations|Optional|
|events.**originalTimeStamp**|Time on the client device when call was invoked|Optional|
|events.**sentAt**|Time on client device when call was sent|Optional|
|events.**receivedAt**|Time on Segment server clock when the call was received|Optional|
|events.**timestamp**|Calculated by Segment to correct client-device clock skew|Optional|

#### Page, Track, Identify

Each request must contain **ONE** of the following three schemas:

##### Page

|Element Name|Description|Required?|
|---|---|---|
|**name**|Name of the page|Required|
|events.properties.**name**|Name of the page - This is reserved for future use||
|events.properties.**path**|Path portion of the URL of the page||
|events.properties.**referrer**|Full URL of the previous page||
|events.properties.**search**|Query string portion of the URL of the page||
|events.properties.**title**|Title of the page||
|events.properties.**url**|Full URL of the page||

##### Track

|Element Name|Description|Required?|
|---|---|---|
|events.properties.**revenue**|Amount of revenue an event result in||
|events.properties.**currency**|Currency of the revenue an event result in||
|events.properties.**currency**|An abstract value to associate with an event||

##### Identify

|Element Name|Description|Required?|
|---|---|---|
|events.**anonymousId**|A pseudo-unique substitute for a User ID, for cases when you don't have an absolutely unique identifier.|Required|
|events.**userId**|A unique identifier for the user in your database||
|events.traits.address.**city**|City of a user||
|events.traits.address.**country**|Country of a user||
|events.traits.address.**postalCode**|Postal code of a user||
|events.traits.address.**state**|State of a user||
|events.traits.address.**street**|Street of a user||
|events.traits.**age**|Street address of a user||
|events.traits.**avatar**|Street address of a user||
|events.traits.**birthday**|Street address of a user||
|events.traits.company.**name**|Street address of a user||
|events.traits.company.**id**|Street address of a user||
|events.traits.company.**industry**|Street address of a user||
|events.traits.company.**employee_count**|Street address of a user||
|events.traits.company.**plan**|Street address of a user||
|events.traits.**createdAt**|Date the user's account was first created (as string)||
|events.traits.**description**|Description of the user||
|events.traits.**email**|Email address of a user||
|events.traits.**firstName**|First name of user||
|events.traits.**gender**|Gender of a user||
|events.traits.**id**|Unique ID in your database for a user||
|events.traits.**lastName**|Last name of a user||
|events.traits.**name**|Full name of a user||
|events.traits.**phone**|Phone number of a user||
|events.traits.**title**|Title of a user||
|events.traits.**username**|User's username, should be unique to each user||
|events.traits.**website**|Website of a user||

#### A/B Test, E-Commerce, Nike

Each request must contain **ALL** of the following schemas:

##### A/B Test

|Element Name|Description|Required?|
|---|---|---|
|events.**swimLane**|TBD|Optional|
|events.**experimentName**|TBD|Optional|
|events.**experimentId**|TBD|Optional|
|events.**variationId**|TBD|Optional|

##### E-Commerce

|Element Name|Description|Required?|
|---|---|---|
|events.**orderId**|The id of the completed order|Optional|
|events.**checkoutId**|The generated id of a submitted order|Optional|
|events.**coupon**|Coupon/promo code applied|Optional|
|events.**tax**|Total tax associated with the transaction|Optional|
|events.**discount**|Total discount associated with the transaction|Optional|
|events.**total**|Revenue with discounts and coupons added in|Optional|
|events.**subtotal**|TBD|Optional|
|events.**valueAddedServicesTotal**|TBD|Optional|
|events.**currency**|Currency of the transaction|Optional|
|events.**shipping**|Shipping cost associated with the transaction|Optional|
|events.**shippingMethod**|The chosen shipping method|Optional|
|events.**productId**|TBD|Optional|
|events.**brand**|Brand associated with the product|Optional|
|events.**category**|Product category|Optional|
|events.**inventoryStatus**|Product inventory status, one of "in stock","coming soon","preorder","out of stock","locked","unlocked:profile:in stock","nikeid","gift card","NONE",null|Optional|
|events.**size**|Product size|Optional|
|events.**pid**|Classic integer style product id|Optional|
|events.**price**|Price of the product|Optional|
|events.**name**|Name of the product|Optional|
|events.**type**|Type of product|Optional|
|events.**quantity**|Quantity of product|Optional|
|events.**sku**|SKU of product|Optional|
|events.**style**|Style of product|Optional|
|events.**subtitle**|Subtitle of product|Optional|
|events.**paymentMethod**|Payment method chosen|Optional|
|events.**paymentStored**|Boolean where if true the payment method is stored|Optional|
|events.query.**type**|The type of search used, e.g. "userEntered", "typeahead", "visualSearch"|Optional|
|events.query.**text**|Text the user entered to generate a search|Optional|
|events.query.**item**|Topic of the search, either the user-entered text or the type-ahead, auto-complete or visual-search item the user selected|Optional|
|events.**variant**|Variant of the product|Optional|

##### Nike

|Element Name|Description|Required?|
|---|---|---|
|events.**eventType**|The type of event, see [Event Types](#event-types)|Optional|
|events.**eventTags**|Array of event tags, minimum of 1|Optional|
|events.**eventId**|A UUID v4 for this event instance|Optional|
|events.**platform**|Platform type, one of "web", "domain, or "mobile"|Optional|
|events.context.app.**environment**|App environment, one of "development", "test", or "production"|Optional|
|events.context.app.**domain**|Experience domain of app, see list <a href="https://confluence.nike.com/display/DAHP/List+of+DTC+Experiences" target="_blank">here</a>|Optional|
|events.context.app.**resource**|Name of API resource of the |Optional|
|events.context.app.**division**|Organization which the app domain falls under, e.g. "commerce"|Optional|
|events.context.app.**platform**|Technology platform of the app, e.g. "cloud", "tesla"|Optional|
|events.context.privacy.**isMarketing**|Boolean specifying if event is categorized as marketing-related|Optional|
|events.context.privacy.**isPerformance**|Boolean specifying if event is categorized as performance-related|Optional|
|events.context.consumer.**adobeVisitorId**|Adobe identifier for Adobe Analytics (Omniture)|Optional|
|events.context.consumer.**visitId**|Unite visit identifier|Optional|
|events.context.consumer.**isSwoosh**|Boolean where if true the user is a Nike employee|Optional|
|events.context.consumer.**allowsMarketing**|Boolean where if true the user has opted into marketing events being collected|Optional|
|events.context.consumer.**allowsPerformance**|Boolean where if true the user has opted into performance events being collected|Optional|
|events.context.consumer.**savedAddressCount**|Number of addresses the consumer has saved|Optional|
|events.properties.**selectionTarget**|TBD|Optional|
|events.properties.**selectionValue**|TBD|Optional|
|events.properties.**navigationStartInMs**|TBD|Optional|
|events.properties.**responseEndInMs**|TBD|Optional|
|events.properties.**domContentLoadedInMs**|TBD|Optional|
|events.properties.**firstPaintInMs**|TBD|Optional|
|events.properties.**interactionType**|Type of interaction (e.g. "click", "touch", "drag", etc.)|Optional|
|events.properties.**mouseTarget**|Description of target of interaction, e.g. "change billing country"|Optional|
|events.properties.**channel**|TBD|Optional|
|events.properties.previousView.**name**|TBD|Optional|
|events.properties.previousView.**channel**|TBD|Optional|
|events.properties.errors.**code**|Error code, string|Optional|
|events.properties.errors.**message**|Error message, string|Optional|
|events.properties.errors.**field**|Error field, string|Optional|
|events.properties.metric.**name**|Metric name, string|Optional|
|events.properties.metric.**type**|Metric type, one of "gauge", "counter", "cumulative_counter"|Optional|
|events.properties.metric.**dimensions**|Object|Optional|
|events.properties.metric.**value**|Metric value, number|Optional|

#### Event Types

The following table lists all of the possible values that should be sent in the **eventType** field, along with the context in which they should be used (Note: no changes from v1):

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

#### Sample Requests by Event Type

##### Action

```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "schemaVersion": 2,
      "properties": {
        "channel": "channel"
      },
      "userId": "upmId",
      "event": "eventName",
      "context": {
        "app": {
          "environment": "development",
          "domain": "domain",
          "division": "division",
          "platform": "platform",
          "name": "name",
          "version": "version",
          "build": "version"
        },
        "privacy": {
          "isMarketing": true,
          "isPerformance": true
        },
        "consumer": {
          "visitId": "visitId",
          "isSwoosh": true,
          "allowsMarketing": true,
          "allowsPerformance": true
        },
        "campaign": {
          "name": "campaignValue",
          "source": "campaignKey"
        },
        "locale": "language"
      },
      "timestamp": "1985-04-12T23:20:50.52Z",
      "productId": "productId",
      "brand": "brand",
      "category": "category",
      "inventoryStatus": "coming soon",
      "size": "nikeSize",
      "pid": "pid",
      "price": 1,
      "name": "productName",
      "type": "productName",
      "quantity": 1,
      "sku": "skuId",
      "style": "styleType",
      "subtitle": "subtitle",
      "eventType": "action",
      "eventTags": [
        "loginAttempt"
      ],
      "eventId": "id",
      "platform": "web",
      "experimentName": "name",
      "experimentId": "id",
      "variationId": "variation"
    }
  ]
}
```

##### App Launch

N/A

##### Change View

```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "schemaVersion": 2,
      "properties": {
        "channel": "channel",
        "previousView": {
          "name": "name",
          "channel": "channel"
        }
      },
      "userId": "upmId",
      "event": "eventName",
      "context": {
        "app": {
          "environment": "development",
          "domain": "domain",
          "division": "division",
          "platform": "platform",
          "name": "name",
          "version": "version",
          "build": "version"
        },
        "privacy": {
          "isMarketing": true,
          "isPerformance": true
        },
        "consumer": {
          "visitId": "visitId",
          "isSwoosh": true,
          "allowsMarketing": true,
          "allowsPerformance": true
        },
        "campaign": {
          "name": "campaignValue",
          "source": "campaignKey"
        },
        "locale": "language"
      },
      "timestamp": "1985-04-12T23:20:50.52Z",
      "productId": "productId",
      "brand": "brand",
      "category": "category",
      "inventoryStatus": "coming soon",
      "size": "nikeSize",
      "pid": "pid",
      "price": 1,
      "name": "productName",
      "type": "productName",
      "quantity": 1,
      "sku": "skuId",
      "style": "styleType",
      "subtitle": "subtitle",
      "eventType": "changeView",
      "eventTags": [
        "loginAttempt"
      ],
      "eventId": "id",
      "platform": "web",
      "experimentName": "name",
      "experimentId": "id",
      "variationId": "variation"
    }
  ]
}
```

##### Checkout Confirmation

```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "schemaVersion": 2,
      "userId": "upmId",
      "event": "eventName",
      "context": {
        "app": {
          "environment": "development",
          "domain": "domain",
          "division": "division",
          "platform": "platform",
          "name": "name",
          "version": "version",
          "build": "version"
        },
        "privacy": {
          "isMarketing": true,
          "isPerformance": true
        },
        "consumer": {
          "visitId": "visitId",
          "isSwoosh": true,
          "allowsMarketing": true,
          "allowsPerformance": true
        },
        "campaign": {
          "name": "campaignValue",
          "source": "campaignKey"
        },
        "locale": "language"
      },
      "timestamp": "1985-04-12T23:20:50.52Z",
      "subtotal": 1,
      "valueAddedServicesTotal": 1,
      "productId": "productId",
      "brand": "brand",
      "category": "category",
      "inventoryStatus": "coming soon",
      "size": "nikeSize",
      "pid": "pid",
      "price": 1,
      "name": "productName",
      "type": "productName",
      "quantity": 1,
      "sku": "skuId",
      "style": "styleType",
      "subtitle": "subtitle",
      "eventType": "checkoutConfirmation",
      "eventTags": [
        "loginAttempt"
      ],
      "eventId": "id",
      "platform": "web",
      "experimentName": "name",
      "experimentId": "id",
      "variationId": "variation"
    }
  ]
}
```

##### Error

```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "schemaVersion": 2,
      "properties": {
        "channel": "channel"
      },
      "userId": "upmId",
      "event": "eventName",
      "context": {
        "app": {
          "environment": "development",
          "domain": "domain",
          "division": "division",
          "platform": "platform",
          "name": "name",
          "version": "version",
          "build": "version"
        },
        "privacy": {
          "isMarketing": true,
          "isPerformance": true
        },
        "consumer": {
          "visitId": "visitId",
          "isSwoosh": true,
          "allowsMarketing": true,
          "allowsPerformance": true
        },
        "campaign": {
          "name": "campaignValue",
          "source": "campaignKey"
        },
        "locale": "language"
      },
      "timestamp": "1985-04-12T23:20:50.52Z",
      "productId": "productId",
      "brand": "brand",
      "category": "category",
      "inventoryStatus": "coming soon",
      "size": "nikeSize",
      "pid": "pid",
      "price": 1,
      "name": "productName",
      "type": "productName",
      "quantity": 1,
      "sku": "skuId",
      "style": "styleType",
      "subtitle": "subtitle",
      "eventType": "error",
      "eventTags": [
        "loginAttempt"
      ],
      "eventId": "id",
      "platform": "web",
      "experimentName": "name",
      "experimentId": "id",
      "variationId": "variation"
    }
  ]
}

```

##### Login Complete

N/A

##### Metric

```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "schemaVersion": 2,
      "properties": {
        "metric": {
          "name": "metricName",
          "type": "gauge",
          "value": 1
        }
      },
      "userId": "upmId",
      "event": "eventName",
      "context": {
        "app": {
          "environment": "development",
          "domain": "domain",
          "division": "division",
          "platform": "platform",
          "name": "name",
          "version": "version",
          "build": "version"
        },
        "privacy": {
          "isMarketing": true,
          "isPerformance": true
        },
        "consumer": {
          "visitId": "visitId",
          "isSwoosh": true,
          "allowsMarketing": true,
          "allowsPerformance": true
        },
        "campaign": {
          "name": "campaignValue",
          "source": "campaignKey"
        },
        "locale": "language"
      },
      "timestamp": "1985-04-12T23:20:50.52Z",
      "productId": "productId",
      "brand": "brand",
      "category": "category",
      "inventoryStatus": "coming soon",
      "size": "nikeSize",
      "pid": "pid",
      "price": 1,
      "name": "productName",
      "type": "productName",
      "quantity": 1,
      "sku": "skuId",
      "style": "styleType",
      "subtitle": "subtitle",
      "eventType": "metric",
      "eventTags": [
        "loginAttempt"
      ],
      "eventId": "id",
      "platform": "web",
      "experimentName": "name",
      "experimentId": "id",
      "variationId": "variation"
    }
  ]
}
```

##### Mouse

```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "schemaVersion": 2,
      "properties": {
        "interactionType": "interactionType",
        "mouseTarget": "mouseTarget",
        "channel": "channel"
      },
      "userId": "upmId",
      "event": "eventName",
      "context": {
        "app": {
          "environment": "development",
          "domain": "domain",
          "division": "division",
          "platform": "platform",
          "name": "name",
          "version": "version",
          "build": "version"
        },
        "privacy": {
          "isMarketing": true,
          "isPerformance": true
        },
        "consumer": {
          "visitId": "visitId",
          "isSwoosh": true,
          "allowsMarketing": true,
          "allowsPerformance": true
        },
        "campaign": {
          "name": "campaignValue",
          "source": "campaignKey"
        },
        "locale": "language"
      },
      "timestamp": "1985-04-12T23:20:50.52Z",
      "productId": "productId",
      "brand": "brand",
      "category": "category",
      "inventoryStatus": "coming soon",
      "size": "nikeSize",
      "pid": "pid",
      "price": 1,
      "name": "productName",
      "type": "productName",
      "quantity": 1,
      "sku": "skuId",
      "style": "styleType",
      "subtitle": "subtitle",
      "eventType": "mouse",
      "eventTags": [
        "loginAttempt"
      ],
      "eventId": "id",
      "platform": "web",
      "experimentName": "name",
      "experimentId": "id",
      "variationId": "variation"
    }
  ]
}
```

##### Page Load

```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "schemaVersion": 2,
      "properties": {
        "channel": "channel",
        "previousView": {
          "name": "name",
          "channel": "channel"
        }
      },
      "userId": "upmId",
      "event": "eventName",
      "context": {
        "app": {
          "environment": "development",
          "domain": "domain",
          "division": "division",
          "platform": "platform",
          "name": "name",
          "version": "version",
          "build": "version"
        },
        "privacy": {
          "isMarketing": true,
          "isPerformance": true
        },
        "consumer": {
          "visitId": "visitId",
          "isSwoosh": true,
          "allowsMarketing": true,
          "allowsPerformance": true
        },
        "campaign": {
          "name": "campaignValue",
          "source": "campaignKey"
        },
        "locale": "language"
      },
      "timestamp": "1985-04-12T23:20:50.52Z",
      "productId": "productId",
      "brand": "brand",
      "category": "category",
      "inventoryStatus": "coming soon",
      "size": "nikeSize",
      "pid": "pid",
      "price": 1,
      "name": "productName",
      "type": "productName",
      "quantity": 1,
      "sku": "skuId",
      "style": "styleType",
      "subtitle": "subtitle",
      "eventType": "pageLoad",
      "eventTags": [
        "loginAttempt"
      ],
      "eventId": "id",
      "platform": "web",
      "experimentName": "name",
      "experimentId": "id",
      "variationId": "variation"
    }
  ]
}
```
##### Registration Complete

N/A

##### Search

```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "schemaVersion": 2,
      "properties": {
        "channel": "channel",
        "previousView": {},
        "errors": {},
        "metric": {}
      },
      "userId": "12345",
      "event": "testPageLoad",
      "context": {
        "abTest": {
          "neo": {
            "profiles": {
              "experiments": {}
            }
          }
        },
        "app": {
          "environment": "development",
          "domain": "dotcom",
          "division": "commerce",
          "platform": "cloud",
          "name": "omniture-test",
          "version": "0.0.1",
          "build": "0.0.1"
        },
        "previousApp": {},
        "privacy": {
          "isMarketing": true,
          "isPerformance": true
        },
        "consumer": {
          "adobeVisitorId": "adobeVisitorId value",
          "visitId": "0365cb0c-ed76-11e6-bc64-92361f002671"
        },
        "campaign": {},
        "device": {},
        "library": {},
        "locale": "en-us",
        "location": {
          "country": "us"
        },
        "page": {
          "referrer": "http://www.nike.com/referringPage",
          "title": "A Test Page",
          "url": "http://www.nike.com/testPage"
        },
        "referrer": {},
        "screen": {
          "height": 980,
          "width": 1900
        },
        "traits": {},
        "userAgent": "eventsTester,0.0.1"
      },
      "integrations": {},
      "timestamp": "1985-04-12T23:20:50.52Z",
      "eventType": "search",
      "eventId": "5cfe1c1d-0319-4c6a-b18d-80119632f1e1",
      "platform": "web"
    }
  ]
}
```

##### Selection

```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "schemaVersion": 2,
      "properties": {
        "selectionTarget": "selectionTarget",
        "selectionValue": "selectionValue",
        "channel": "channel"
      },
      "userId": "upmId",
      "event": "eventName",
      "context": {
        "app": {
          "environment": "development",
          "domain": "domain",
          "division": "division",
          "platform": "platform",
          "name": "name",
          "version": "version",
          "build": "version"
        },
        "privacy": {
          "isMarketing": true,
          "isPerformance": true
        },
        "consumer": {
          "visitId": "visitId",
          "isSwoosh": true,
          "allowsMarketing": true,
          "allowsPerformance": true
        },
        "campaign": {
          "name": "campaignValue",
          "source": "campaignKey"
        },
        "locale": "language"
      },
      "timestamp": "1985-04-12T23:20:50.52Z",
      "productId": "productId",
      "brand": "brand",
      "category": "category",
      "inventoryStatus": "coming soon",
      "size": "nikeSize",
      "pid": "pid",
      "price": 1,
      "name": "productName",
      "type": "productName",
      "quantity": 1,
      "sku": "skuId",
      "style": "styleType",
      "subtitle": "subtitle",
      "eventType": "selection",
      "eventTags": [
        "loginAttempt"
      ],
      "eventId": "id",
      "platform": "web",
      "experimentName": "name",
      "experimentId": "id",
      "variationId": "variation"
    }
  ]
}
```

##### Text Input

```
{
  "actorId": "7894225087415055350568",
  "resourceType": "dotcom/event_batch",
  "resourceVersion": "v1",
  "events": [
    {
      "schemaVersion": 2,
      "properties": {
        "channel": "channel"
      },
      "userId": "upmId",
      "event": "eventName",
      "context": {
        "app": {
          "environment": "development",
          "domain": "domain",
          "division": "division",
          "platform": "platform",
          "name": "name",
          "version": "version",
          "build": "version"
        },
        "privacy": {
          "isMarketing": true,
          "isPerformance": true
        },
        "consumer": {
          "visitId": "visitId",
          "isSwoosh": true,
          "allowsMarketing": true,
          "allowsPerformance": true
        },
        "campaign": {
          "name": "campaignValue",
          "source": "campaignKey"
        },
        "locale": "language"
      },
      "timestamp": "1985-04-12T23:20:50.52Z",
      "productId": "productId",
      "brand": "brand",
      "category": "category",
      "inventoryStatus": "coming soon",
      "size": "nikeSize",
      "pid": "pid",
      "price": 1,
      "name": "productName",
      "type": "productName",
      "quantity": 1,
      "sku": "skuId",
      "style": "styleType",
      "subtitle": "subtitle",
      "eventType": "textInput",
      "eventTags": [
        "loginAttempt"
      ],
      "eventId": "id",
      "platform": "web",
      "experimentName": "name",
      "experimentId": "id",
      "variationId": "variation"
    }
  ]
}
```

### <a name="response-body"></a>Response Body

|Element Name|Description|Required?|
|---|---|---|
|**message**|Response message|Required|

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

If you are currently using version 1 of this API and need information for upgrading, see the [Analytics Pipeline v1 Developer's Guide](/doc/commerce/events/api_events.html).

## <a name="troubleshooting"></a>Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### Use Troubleshooting Tools

1. Check for validation errors logged in Splunk <a href="https://cdt-eng.splunkcloud.com/en-US/app/search/nexus_events_analytics_api#en-US/app/search/nexus_events_analytics_api?form.index_tok=lambda" target="_blank">here</a>

2. Use the sample requests in this document or those provided <a href="https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/test/sample-events" target="_blank">here</a> as a guide to forming valid requests for each event type.

## <a name="glossary"></a>Glossary

See the [Glossary](/doc/getting-started/glossary.html)

## <a name="document-change-log"></a>Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|02/14/2018|Initial Draft|
|Updated external links|04/03/2018|Updated external links to open in new browser window|
|Updated TOC|10/01/2018|Removed 'In this guide', replaced with sidebar TOC|

## <a name="related-links"></a>Related Links

[NDe Docs Home](/index.html)

[Get Started](/doc/portal/get-started.html)