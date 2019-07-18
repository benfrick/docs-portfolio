<!--Uncomment the front matter YAML only when ready to publish. Update any values in {} -->
---
# tags: pdf
# category: b-use-case
# position: {integer controlling sort position in sidebar}
# title: {sidebar title}
# url: {rel link to HTML e.g. /doc/commerce/customization/use-customization.html}
# toc:
#  - h2: Introduction
#    url: {rel link to HTML}#introduction
#  - h2: Key Terms
#    url: {rel link to HTML}#key-terms
#  - h2: Quick Start
#    url: {rel link to HTML}#quick-start
#  - h2: {Use case 1 Title}
#    url:  {rel link to HTML}#{use-case-1-title}
#  - h2: {Use case 2 Title}
#    url:  {rel link to HTML}#{use-case-2-title}
#  - h2: API Endpoint Quick Reference
#    url:  {rel link to HTML}#api-endpoint-quick-reference
#  - h2: Best Practices
#    url:  {rel link to HTML}#best-practices
#  - h2: Troubleshooting
#    url:  {rel link to HTML}#troubleshooting
#  - h2: Terms of Service
#    url:  {rel link to HTML}#terms-of-service
#  - h2: Contacting the Team
#    url:  {rel link to HTML}#contacting-the-team
#  - h2: Document Change Log
#    url:  {rel link to HTML}#document-change-log
#  - h2: Next Steps
#    url:  {rel link to HTML}#next-steps
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="new-tab" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING {} TO YOUR EXPERIENCE <i class="g72-swoosh"></i><br>DRAFT

---

##### Last Updated: {MM/DD/YYYY}

{} does some stuff and some things.

>**TIP**: Before using this guide you should have already completed [Some other guide](link to that guide).

## Introduction

In this guide, we will discuss...

### What is {}?

## Key Terms (if applicable)

Here are some key terms used in this document.

|Term|Definition|
|---|---|
|Term|Describe how this term applies to the API|

## Quick Start (if applicable)

Outline steps to quickly get up an running. Include cut and paste code snippets and complete cURLs if possible.

## {Use case 1 title e.g. Listing and Validating Payment Options}

<i class="g72-check"></i>&nbsp;&nbsp;**List payment options for Checkout**

<i class="g72-check"></i>&nbsp;&nbsp;**Validate payments**

### Step 1: {Step description}

Describe how to do this step.

### Customizing Your Results (if applicable)

You control what is returned in your result set and how it is sorted through URL parameters.

**Filtering**

The table below lists the fields by which you can filter your {} results. If no filter is applied, {this happens}. While some filters only allow one value, you can send multiple filters in the same request. For instance, {example}. Note that filter parameter names and values are case sensitive.

|Field Name|Description|Sample Value|
|---|---|
|**Field1**|||

**Sorting**

You can sort {this thing} in several ways using the `sort` query parameter. You can sort by one or more order fields, separated by a comma. If the field name you want to sort by is nested, refer to it with dot notation. For sort parameter syntax, see the [Query Parameters](/doc/getting-started/using-nike-apis.html#query-parameters) section of [Using Nike APIs](/doc/getting-started/using-nike-apis.html).

**Other Query Parameters**

{} also supports the {} query parameters to restrict the results {in this way}. For more information on syntax, see the [Query Parameters](/doc/getting-started/using-nike-apis.html#query-parameters) section of [Using Nike APIs](/doc/getting-started/using-nike-apis.html).

Let's take a look at some scenarios.

|I want to...|Sample Query|
|---|---|
|Do this thing|`url to do this thing`|

### Executing the Request


Listed below is {} POST request URL. This endpoint is not JWT-restricted.
```
{CURL goes here}
```

### Parsing the Response

{Some hints/callouts about the data in the response and how it could be handled}


>**TIPS:**
>- {helpful tip user needs to know in order to complete this step}
>- {Another tip}

### Step 2: {Step description}

Describe how to do this step.

### Customizing Your Results (if applicable)

You control what is returned in your result set and how it is sorted through URL parameters.

**Filtering**

The table below lists the fields by which you can filter your {} results. If no filter is applied, {this happens}. While some filters only allow one value, you can send multiple filters in the same request. For instance, {example}. Note that filter parameter names and values are case sensitive.

|Field Name|Description|Sample Value|
|---|---|
|**Field1**|||

**Sorting**

You can sort {this thing} in several ways using the `sort` query parameter. You can sort by one or more order fields, separated by a comma. If the field name you want to sort by is nested, refer to it with dot notation. For sort parameter syntax, see the [Query Parameters](/doc/getting-started/using-nike-apis.html#query-parameters) section of [Using Nike APIs](/doc/getting-started/using-nike-apis.html).

**Other Query Parameters**

{} also supports the {} query parameters to restrict the results {in this way}. For more information on syntax, see the [Query Parameters](/doc/getting-started/using-nike-apis.html#query-parameters) section of [Using Nike APIs](/doc/getting-started/using-nike-apis.html).

Let's take a look at some scenarios.

|I want to...|Sample Query|
|---|---|
|Do this thing|`url to do this thing`|

### Executing the Request


Listed below is {} POST request URL. This endpoint is not JWT-restricted.
```
{CURL goes here}
```

### Parsing the Response

{Some hints/callouts about the data in the response and how it could be handled}


>**TIPS:**
>- {helpful tip user needs to know in order to complete this step}
>- {Another tip}

## API Endpoint Quick Reference

{API Name}

- [Endpoint Name]({url for API Reference}){:target="new-tab"}
- [Endpoint Name]({url for API Reference}){:target="new-tab"}
- [Endpoint Name]({url for API Reference}){:target="new-tab"}

{API Name}

- [Endpoint Name]({url for API Reference}){:target="new-tab"}
- [Endpoint Name]({url for API Reference}){:target="new-tab"}
- [Endpoint Name]({url for API Reference}){:target="new-tab"}

## Best Practices (if applicable)

Listed below are some best practices for working with {}.

### Conditions for Retries

For all Nike Cloud APIs, the general rule is that HTTP 4XX error codes (except for 429) should not be retried but HTTP 5XX errors can be retried. For general information on Nike error retry practices, see [API Error Patterns](https://confluence.nike.com/display/NEA/API+Standards#APIStandards-Errors){:target="new-tab"} on Confluence.

### Test Environment

It is recommended to test all endpoints in the production environment as opposed to the test environment. Using the test environment can have unpredictable results due to the many downstream services which these endpoints are reliant upon in order to provide typical 'production-like' responses.

There are boundaries for testing in production:

- Performance tests at high volumes should never be done in production. All performance tests should be done in test.

### Caching Data

Describe what is cached and for how long, or if caching is not supported.

## Troubleshooting

- Use the general troubleshooting tips in the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) to check for issues with your request.

- Contact the {} team on the [#slack-channel]({url for slack channel}){:target="new-tab"} Slack channel for assistance.

## Terms of Service
<!--
It is recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#registration) guide on how to create and register your caller ID.
-->
### Authorization

#### Access Tokens

Most calls through the Nike API gateway (api.nike.com) require an access token be sent in the request header. This allows Nike to verify that your app is authorized to perform the action on behalf of the user.

Access tokens are obtained by calling Nike Unite services prior to calling the API which you ultimately want to reach.

To find out more on how to call Unite services to obtain access tokens, see the Authorization section of the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#authorization) guide.

#### JSON Web Token

{Does this thing require JWT?}

For more, see the JWT section of [Using Nike APIs](/doc/getting-started/using-nike-apis.html#jwt-json-web-token).

### Sample Requests

Sample requests included throughout this guide contain unique IDs and access tokens that are spent/expired in the Production environment, so you will not be able use them as-is for testing purposes. Reuse what you can and replace with valid IDs/access tokens when necessary.

#### Required Request Headers

Listed below are the required request headers. Since most requests come through the Nike Edge router, these header values will be set automatically, provided your app experience calls the Unite services first to get an access token and passes that token in the request.

|Header Name|Description|
|---|---|
|**Header1**||

>**TIP:** For the Authorization header, use the token for the consumer's login session that you obtained from Nike Unite/Identity, prefixed by **Bearer ** (note the single space after Bearer). This is necessary for Nike to verify that your app is authorized to perform the requested operation on behalf of the consumer.

### Common Questions

**Question 1**

Answer 1

## Contacting the Team

Need to contact the {} team?

|---|---|
|Slack|[](){:target="new-tab"}|
|Confluence Space|[](){:target="new-tab"}|
|Team Contacts|Person1 (Person1 email)|

## Document Change Log

|Summary |Date |
|---|---|---|
|Initial publish|MM/DD/YYYY|

## Next Steps

You've learned how to add {} to your experience. Here are some next steps.

[{Doc Title}]({URL})

[Commerce Docs Home](/index.html)

[Get Started](/doc/getting-started/get-started.html)
