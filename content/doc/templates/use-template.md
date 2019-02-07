<!--Uncomment the front matter YAML only when ready to publish. Update any values in {} -->
---
# tags: pdf
# category: b-use-case
# position: {number}
# title: {sidebar title}
# url: {rel link to HTML}
# toc:
#  - h2: 
#    url:  {rel link to HTML}#step-1
#  - h2: 
#    url:  {rel link to HTML}#step-2
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
#  - h2: Glossary
#    url:  {rel link to HTML}#glossary
#  - h2: Document Change Log
#    url:  {rel link to HTML}#document-change-log
#  - h2: Next Steps
#    url:  {rel link to HTML}#next-steps
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn-secondary-grey guide-button"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING {} TO YOUR EXPERIENCE <i class="g72-swoosh"></i><br>DRAFT

---

##### Last Updated: 11/10/2018

{} does some stuff and some things.

>**TIP**: Before using this guide you should have already completed [Some other guide](link to that guide).

### What is {}?

## Step 1:

### Customizing Your Results

You control what is returned in your result set and how it is sorted through URL parameters.

**Filtering**

The table below lists the fields by which you can filter your {} results. If no filter is applied, {this happens}. While some filters only allow one value, you can send multiple filters in the same request. For instance, {example}. Note that filter parameter names and values are case sensitive.

|Field Name|Description|Sample Value|
|---|---|
|**Field1**|||

**Sorting**

You can sort {this thing} in several ways using the `sort` query parameter. You can sort by one or more order fields, separated by a comma. If the field name you want to sort by is nested, refer to it with dot notation. For sort parameter syntax, see the [Query Parameters](/doc/getting-started/using-nike-apis.html#query-parameters) section of [Using NDe APIs](/doc/getting-started/using-nike-apis.html).

>TIP: It is recommended that your app pass the sort query parameter in the request to ensure that the results are sorted appropriately for your experience.

**Other Query Parameters**

{} also supports the {} query parameters to restrict the results {in this way}. For more information on syntax, see the [Query Parameters](/doc/getting-started/using-nike-apis.html#query-parameters) section of [Using NDe APIs](/doc/getting-started/using-nike-apis.html).

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

{Some hints/callouts about the data in the response and how it could be handled}

## Step 2:

### Required Request Parameters

### Customizing Your Results

You control what is returned in your result set through URL parameters. {Brief description of which ones are supported by this thing. Link to [Query Parameters](/doc/getting-started/using-nike-apis.html#query-parameters) in [Using NDe APIs](/doc/getting-started/using-nike-apis.html) as necessary.}

Let's take a look at some scenarios.

|I want to|Sample Query|
|---|---|
|do this thing|`url to do this thing`|

### Executing the Request

Sample CURL 1:

```
CURL goes here
```

Sample CURL 2:

```
CURL goes here
```

### Parsing the Response

{Some hints/callouts about the data in the response and how it could be handled}

## API Endpoint Quick Reference

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|[]({url for API Reference}){:target="blank"}|`/product_feed/collection_terms/v2{?filter,searchTerms,sort,anchor,count}`||

## Best Practices

Listed below are some best practices for working with Collections.

### Conditions for Retries

For all Nike Cloud APIs, the general rule is that HTTP 4XX error codes (except for 429) should not be retried but HTTP 5XX errors can be retried. For general information on Nike error retry practices, see [API Error Patterns](https://confluence.nike.com/display/NEA/API+Standards#APIStandards-Errors){:target="blank"} on Confluence.

### Test Environment

It is recommended to test all endpoints in the production environment as opposed to the test environment. Using the test environment can have unpredictable results due to the many downstream services which these endpoints are reliant upon in order to provide typical 'production-like' responses.

There are boundaries for testing in production:

- Performance tests at high volumes should never be done in production. All performance tests should be done in test.

### Caching Data

None of the endpoints described in this document support caching.

## Troubleshooting

- Use the general troubleshooting tips in the [Using NDe APIs](/doc/getting-started/using-nike-apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) to check for issues with your request.

- Contact the {} team on the [#slack-channel]({url for slack channel}){:target="blank"} Slack channel for assistance.

## Terms of Service
<!--
It is recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of the [Using NDe APIs](/doc/getting-started/using-nike-apis.html#registration) guide on how to create and register your caller ID.
-->
### Authorization

#### Access Tokens

Most calls through the Nike API gateway (api.nike.com) require an access token be sent in the request header. This allows Nike to verify that your app is authorized to perform the action on behalf of the user.

Access tokens are obtained by calling Nike Unite services prior to calling the API which you ultimately want to reach.

To find out more on how to call Unite services to obtain access tokens, see the Authorization section of the [Using NDe APIs](/doc/getting-started/using-nike-apis.html#authorization) guide.

#### JSON Web Token

{Does this thing require JWT?}

For more, see the JWT section of [Using NDe APIs](/doc/getting-started/using-nike-apis.html#jwt-json-web-token).

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

- [Capturing User Events](/doc/commerce/events/use-eventsv2.html)
- [Using NDe APIs](/doc/getting-started/using-nike-apis.html)
