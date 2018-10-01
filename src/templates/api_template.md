<link rel="stylesheet" href="https://assets.commerce.nikecloud.com/ncss/glyphs/2.0/css/glyphs.min.css"/>
<link rel="stylesheet" href="https://assets.commerce.nikecloud.com/ncss/0.17/dotcom/desktop/css/ncss.en-us.min.css"/>
<link rel="stylesheet" href="/css/style.css"/>
<script src="/js/nde.js" type="text/javascript"></script>

<!--
See Bitbucket (link to .md in APID repository) for version history of this document.
Author: Your Name
SME Consultants:
-->

<div class="guide-nav-container">
    <div class="guide-nav-column guide-nav-left">
        <a href="/index.html"><i class="g72-arrow-fill-left"></i>&nbsp;<u>Back to NDe Documentation</u></a>
    </div>
    <div class="guide-nav-column guide-nav-right">
        <a href="slack://channel?team=T0G3T5X2B&amp;id=C9Q1MNJ1J" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-black"><i class="g72-alert"></i>&nbsp;FIND AN ISSUE? SLACK US!</a>
    </div>
</div>

# {API NAME} API <i class="g72-swoosh"></i><br>DEVELOPER'S GUIDE (DRAFT)

###### Last Updated: MM/DD/YYYY<br>Submit Feedback: API Doc Slack channel <a href="https://nikedigital.slack.com/messages/nde-doc" target="_blank">#nde-doc</a>

---

If you've read [Using NDe APIs](/doc/getting-started/using_nike_apis.html), this guide provides the details necessary to integrate with the {API Name} API.

## **In this guide:**

[API at a Glance](#api-at-a-glance)

[Terms of Service](#terms-of-service)

<span class="toc-pad">[Authorization](#authorization)

[Use Cases](#use-cases)

[API Endpoint Quick Reference](#api-endpoint-quick-reference)

[High-Level Concept 1](#high-level-concept-1)

[High-Level Concept 2](#high-level-concept-2)

[Making Your First API Request](#making-your-first-api-request)

[Using Service1](#using-service1)

[Upgrading to the Latest Version](#upgrading-to-the-latest-version)

[Best Practices](#best-practices)

[Troubleshooting](#troubleshooting)

<span class="toc-pad">[Use Troubleshooting Tools](#use-troubleshooting-tools)

<span class="toc-pad">[Common Questions](#common-questions)

[Glossary](#glossary)

[Release Notes](#release-notes)

[Document Change Log](#document-change-log)

[Related Links](#related-links)

## <a name="api-at-a-glance"></a>API at a Glance

<!--
* What does this API do?
* Who calls this API, and why?
* What versions are used and who calls them?
* What is the SLA for each endpoint?
* What domain is this API in? Analytics, Brand, Commerce, Identity, Social, Sport
* What do I need to do before I can use this API?
* What is the Slack Channel, Confluence Space, and who is the Product Owner?
-->

|Topic|Details|
|---|---|
|Use these APIs to|useful functionality<br>useful functionality|
|Who calls this API?|SNKRs App, Nike App etc.|
|Versions|service name, version number and geography|
|SLA|service name, version number and time in ms.|
|Domain|Analytics, Brand, Commerce, Identity, Social, Sport|
|Prerequisites|API Registration<br>JWT|
|Contact Info|Slack channel, Confluence space URI, Product Owner |

## <a name="terms-of-service"></a>Terms of Service

It is recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of [Using NDe APIs](/doc/getting-started/using_nike_apis.html#registration) on how to create and register your caller ID.

### <a name="authorization"></a>Authorization

<!--Discuss any authorization requirements for calling the API-->

## <a name="use-cases"></a>Use Cases
<!--
 * What are the most common use cases of this API?
 * What endpoints are involved in each use case?
 * What are the typical call flows of clients interacting with this API?  Use-case or context diagrams are good here!
 -->

|I want to...|API(s) to use|
|---|---|
|do something|API Name|
|do something else|API Name|

## <a name="api-endpoint-quick-reference"></a>API Endpoint Quick Reference

|HTTP Verb|Endpoint Name|Endpoint Description|URI Format|
|---|---|---|---|
|GET|Endpoint Name|Description|`endpoint URI`|
|POST|Endpoint Name|Description|`endpoint URI`|
|PUT|Endpoint Name|Description|`endpoint URI`|
|DELETE|Endpoint Name|Description|`endpoint URI`|

## <a name="high-level-concept-1"></a>High-Level Concept 1

<!--Discuss foundational concepts that are crucial to understanding the API and what it does-->

## <a name="high-level-concept-2"></a>High-Level Concept 2

<!--Discuss foundational concepts that are crucial to understanding the API and what it does-->

## <a name="making-your-first-api-request"></a>Making your first API request
<!--
* How do I call this API?
* What are the parameters necessary to make a call and where do I get them?
* What does a successful response look like?
-->

State clearly what this first request will accomplish.

1. Gather data needed for the request

|HTTP Method|Endpoint URI|
|---|---|
|GET|endpoint URI|

|Filter Parameter Name|Filter Value|
|---|---|
|**filter name**|filter value|
|**filter name**|filter value|

2. Execute the request

Describe the parts of the URI and show a full sample URI request with body (for POST requests)

3. Parse the response

See the output of the successful JSON 200 response below.

```
{}
```

>**TIP:** For detailed information on this service, see the [Endpoint1](#endpoint1-name) section.

## <a name="using-service1"></a>Using Service1

- [Service1 Overview](#service1-overview)

- [Endpoint1](#endpoint1-name)

### <a name="service1-overview"></a>Service1 Overview

Describe what the service does.

### <a name="endpoint1-name"></a>Endpoint1 Name

<!--Describe what the endpoint does.  Is it synchronous or asynchronous? How and why would I use this?-->

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PUT**|`endpoint1 url`|**Yes**|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**parameter**|Path|description|String|**Required**|
|**parameter**|Query|description|String|Optional|

Let's take a look at some *endpoint1* scenarios.

|I Want to List|Sample Query|
|---|---|
|scenario|endpoint URI|
|another scenario|endpoint URI|

#### <a name="endpoint1-request-headers"></a>Request Headers

|Header Name|Description|Required?|
|---|---|
|**headername**|description|**Required**|
|**headername**|description|Optional|

#### <a name="endpoint1-request-body"></a>Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**fieldname**|data type|description|**Required**|
|**fieldname**|data type|description|Optional|
|fieldname.**fieldname**|data type|description|Optional|
|fieldname.fieldname.**fieldname**|data type|description|Optional|

Sample *Endpoint1* request URI:
```

```

Sample *Endpoint1* request body:
```

```

#### <a name="endpoint1-response-body"></a>Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**fieldname**|data type|description|**Required**|
|**fieldname**|data type|description|Optional|
|fieldname.**fieldname**|data type|description|Optional|
|fieldname.fieldname.**fieldname**|data type|description|Optional|

Sample *endpoint1* 200 response
```

```

Sample *endpoint1* 400 response
```

```

## <a name="upgrading-to-the-latest-version"></a>Upgrading to the latest version
<!--
* Is this API nearing end of life?
* Which version should my application call?
* What versions are in use and by whom?
* What are the differences between the old and new version?
* What is the field and URI mapping?
* When do I have to upgrade and why?
 -->

## <a name="best-practices"></a>Best Practices
<!--
 * OPTIONAL: What are best practices in calling this API e.g. caching, retries, order of calls, error handling?
 -->

## <a name="troubleshooting"></a>Troubleshooting
<!--
* What do I need to look out for?
* What are common questions asked of the Team about the API?
* When do I need to contact the Team and what info do I need to provide?
 -->

Listed below are ways to troubleshoot unexpected responses using this API.

### <a name="use-troubleshooting-tools"></a>Use Troubleshooting Tools
<!--Provide some specific troubleshooting tips for this API like Splunk or New Relic dashboards/queries or similar. Link to general guide (troubleshooting section)-->

### <a name="common-questions"></a>Common Questions
<!--Frequently-asked questions related to troubleshooting-->

## <a name="glossary"></a>Glossary
<!--
* What are the terms and concepts used in this API that are not common? Add them to the master glossary at the link below.
-->

See the [Glossary](/doc/getting-started/glossary.html)

## <a name="release-notes"></a>Release Notes
<!--
* What is the difference in functionality between the old release and most the recent release?
-->

## <a name="document-change-log"></a>Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|MM/DD/YYYY|Initial Draft|

## <a name="related-links"></a>Related Links

[NDe Documentation Home](/index.html)

[Getting Started](/doc/portal/consuming.html)

[Business Guides](/doc/portal/biz-guides.html)

[Developer's Guides](/doc/portal/dev-guides.html)