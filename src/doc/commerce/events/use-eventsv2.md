---
id: use-eventsv2
tags: pdf
category: b-use-case
position: 7
title: Events
url: /doc/commerce/events/use-eventsv2.html
toc:
  - h2: API at a Glance
    url: /doc/commerce/events/use-eventsv2.html#api-at-a-glance
  - h2: Terms of Service
    url: /doc/commerce/events/use-eventsv2.html#terms-of-service
  - h2: Use Cases
    url: /doc/commerce/events/use-eventsv2.html#use-cases
  - h2: API Endpoint Quick Reference
    url: /doc/commerce/events/use-eventsv2.html#api-endpoint-quick-reference
  - h2: Using Analytics Pipeline
    url: /doc/commerce/events/use-eventsv2.html#using-analytics-pipeline
  - h2: Upgrading to the Latest Version
    url: /doc/commerce/events/use-eventsv2.html#upgrading-to-the-latest-version
  - h2: Troubleshooting
    url: /doc/commerce/events/use-eventsv2.html#troubleshooting
  - h2: Document Change Log
    url: /doc/commerce/events/use-eventsv2.html#document-change-log
  - h2: Related Links
    url: /doc/commerce/events/use-eventsv2.html#related-links
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING ANALYTICS PIPELINE <br>TO YOUR EXPERIENCE

---

##### Last Updated: 10/01/2018

If you've read [Using Nike APIs](/doc/getting-started/using-nike-apis.html) and [Analytics Pipeline Overview](/doc/commerce/events/overview-events.html), this guide provides the details necessary to integrate with the Nike Analytics Pipeline API.

## API at a Glance

The <b>Analytics Pipeline API</b> is your single destination to record analytics events, helping both user experiences and web services to track consumer and application behavior.

Because Analytics Pipeline is server-side and Nike-authored, it is much more customizable to your needs than a proprietary, client-side analytics solution.

Analytics events sent to this API are transformed and sent to multiple downstream systems/partners in real-time, allowing many needs to be fulfilled by sending a single event. Future integrations with other partners can be done without necessarily changing the contract of this API, thus making it easier (if not completely transparent) to you.

![](/images/analytics/events.png){:style="margin:10px 0px 10px 0px;"}

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
|Current Version|v2|
|Scope/Limitations|Analytics events only. All countries supported. Do not use for sales, revenue, or available inventory information|
|SLAs|Response time (RT) and requests per second (RPS): <br>RT: 500 ms <br>RPS: 500|
|Domain|Commerce|
|Prerequisites|None|
|Contact Info|Slack: [#cic-nexus](https://nikedigital.slack.com/messages/cic-nexus){:target=:blank"}<br>Confluence space: [Analytics Pipeline API](https://confluence.nike.com/display/CN/CiC+UX+Foundation+Home){:target="new-tab"}<br> Mailing List: [Lst-Nexus.Devops](mailto:Lst-Nexus.DevOps)<br>Product Owner: [Randy Davis](mailto:randall.davis@nike.com){:target="new-tab"}|

### A Note about Segment

Segment is an analytics API and consumer data platform which Nike utilizes. As you saw in the above diagram, it is one of several downstream integrations from the Analytics Pipeline API. By integrating with Segment once, Nike unlocks additional downstream integrations like Optimizely for A/B Testing, Kochava for mobile analytics, and several digital marketing integrations.

Reach out to the Analytics API Product Owner, [Randy Davis](mailto:randall.davis@nike.com), for information on the analytics opportunities available via Segment.

## Terms of Service

- Clients must not use analytics data collected with the Analytics Pipeline API for sales, revenue, or available inventory data.
- High usage from a single IP address may be flagged by Nike bot detection and blocked.
- This API is not intended for application monitoring, logging, or reporting on server-side errors.

### Authorization

No authentication or authorization is required to use the Analytics Pipeline API.

## Use Cases

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

![](/images/analytics/adobe1.png){:class="border"}

![](/images/analytics/adobe2.png){:class="border"}

## API Endpoint Quick Reference

For more information about each service and to try them out though the UI, visit the Nike Developer Portal through the links below.

### Analytics Pipeline API

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|[SEND A NEW EVENT BATCH](https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/API.md){:target="new-tab"}|/measure/uxevents/v1|POST|

## Using Analytics Pipeline

- [Analytics Pipeline Overview](#analytics-pipeline-overview)
- [Endpoint Details](#endpoint-details)
- [Path & Query Parameters](#path--query-parameters)
- [Request Headers](#request-headers)
- [Request Body](#request-body)
- [Response Body](#response-body)

### Analytics Pipeline Overview

Use the Analytics Pipeline API as a single destination for tracking your user experience, service, or application events.

### Endpoint Details

|HTTP Method|URI Path|Restricted?|
|---|---|---|
|**POST**|`/measure/uxevents/v1`|No|

### Path & Query Parameters

There are no path nor query parameters to be used with the Analytics Pipeline API.

### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Content-Type**|Content type of the request, **application/json** is only value allowed|Required|

### Request Body

Forming a request body to the Analytics Pipeline API requires combining the following schema information:

- [Event Batch](https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v1/eventBatch.json){:target="new-tab"}: top-most level in the request structure, which is common to all event types. Includes an array of one or more events.
- [Common Fields](https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/common-fields.json){:target="new-tab"}: common fields to be included for each event
- One of the following schemas: [Page](https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/page.json){:target="new-tab"}, [Track](https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/track.json){:target="new-tab"}, [Identify](https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/identify.json){:target="new-tab"}
- All of the following schemas: [A-B Test](https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/ab-test.json){:target="new-tab"}, [E-commerce](https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/e-commerce.json){:target="new-tab"}, [Nike](https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/nike.json){:target="new-tab"}

![](/images/analytics/events_v2_schema.png){:width="40%"}

>Note: the Nike schema contains a field, **eventType**, that is a direct carryover from v1 (i.e. same exact values must be used). See more below on [Event Types](#event-types).

Next, we will discuss the details of each of the above schemas, including which fields are required.

#### Batch & Common Fields

The fields in the [Batch](https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/batch.json){:target="new-tab"} and [Common Fields](https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/schemas/v2/segment/common-fields.json){:target="new-tab"} schemas are described in the below table:

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
|events.context.app.**domain**|Experience domain of app, see list [here](https://confluence.nike.com/display/DAHP/List+of+DTC+Experiences){:target="new-tab"}|Optional|
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

## Upgrading to the Latest Version

If you are currently using version 1 of this API and need information for upgrading, see the [Analytics Pipeline v1 Developer's Guide](/doc/commerce/events/use-events.html).

## Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### Use Troubleshooting Tools

1. Check for validation errors logged in Splunk [here](https://nike.splunkcloud.com/en-US/app/search){:target="new-tab"}

2. Use the sample requests in this document or those provided [here](https://bitbucket.nike.com/projects/FAT/repos/events-api/browse/packages/modules/event-schemas/test/sample-events){:target="new-tab"} as a guide to forming valid requests for each event type.

## Document Change Log

|Summary|Date|
|---|---|
|Initial publish|02/14/2018|
|Updated external links|04/03/2018|
|Updated TOC|10/01/2018|

## Related Links

- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)