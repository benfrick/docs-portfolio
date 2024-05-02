---
id: sample-use-case
category: b-templates
position: 2
title: Use Case Template
url: /doc/templates/sample-use-case.html
status: active
tag: templates, use cases
toc:
  - h2: Introduction
    url: /doc/templates/sample-use-case.html#introduction
  - h2: Key Concepts & Terms
    url: /doc/templates/sample-use-case.html#key-concepts--terms
  - h2: Quick Start
    url: /doc/templates/sample-use-case.html#quick-start
  - h2: Use Case 1
    url: /doc/templates/sample-use-case.html#use-case-1
  - h2: Quick Reference
    url: /doc/templates/sample-use-case.html#api-endpoint-quick-reference
  - h2: Best Practices
    url: /doc/templates/sample-use-case.html#best-practices
  - h2: Troubleshooting
    url: /doc/templates/sample-use-case.html#troubleshooting
  - h2: Terms of Service
    url: /doc/templates/sample-use-case.html#terms-of-service
  - h2: Contacting the Team
    url: /doc/templates/sample-use-case.html#contacting-the-team
  - h2: Document Change Log
    url: /doc/templates/sample-use-case.html#document-change-log
  - h2: Next Steps
    url: /doc/templates/sample-use-case.html#next-steps
---

# {{ page.title }}
###### Last Updated: 05/01/2024
###### Tags: {{ page.tag }}

---

{} does some stuff and some things.

>**TIP**: Before using this guide, you should have already completed 
> [Some other guide]({{ "/doc/templates/sample-overview.html" | absolute_url }}).

## Introduction

In this guide, we will discuss how to use {} to...

### What is {}?

Describe the thing. Use a picture if possible.

#### Another Nested Topic

##### Nested Again

## Key Concepts & Terms

This section discusses the concepts and terms that are important to understanding {}.

### Concept #1

### Concept #2

### Terms

Here are some key terms used in this document.

###### Table 1: Key Terms

<!-- Use table labels only on larger tables where significant data is presented. 
Link to the label as necessary from elsewhere using the anchor name.-->

| Term | Definition                                           |
|------|------------------------------------------------------|
| Term | Define and describe how this term applies to the API |

## Quick Start

Outline steps to quickly get up and running. Include cut-and-paste code snippets 
and complete cURLs if possible/applicable.

## Use Case 1

<i class="g72-check"></i>&nbsp;&nbsp;**Do things and stuff**

### Step 1: Do a Thing

Describe how to do this step.

### Customizing Your Results

You control what is returned in your result set and how it is sorted through URL parameters.

**Filtering**

The table below lists the fields by which you can filter your {} results.
If no filter is applied, {this happens}.
While some filters only allow one value, you can send multiple filters in the same request.
For instance, {example}.
Note that filter parameter names and values are case-sensitive.

###### Table 2: Filters

| Field Name | Description | Sample Value |
|------------|-------------|--------------|
| **Field1** |             |              |

**Sorting**

You can sort {this thing} in several ways using the `sort` query parameter. 
You can sort by one or more order fields, separated by a comma.
If the field name you want to sort by is nested, refer to it with dot notation.

**Other Query Parameters**

{} also supports the {} query parameters to restrict the results {in this way}. 

Let's take a look at some scenarios.

###### Table 3: Scenarios

| I want to...  | Sample Query           |
|---------------|------------------------|
| Do this thing | `URL to do this thing` |

### Executing the Request

Listed below is {} POST request URL. This endpoint is not JWT-restricted.

```
{CURL goes here}
```

### Parsing the Response

{Some hints/callouts about the data in the response and how it could be handled}

>**TIPS:**
>- {Helpful tip that a user might need to know to complete this step}
>- {Another tip}

### Step 2: Do Another Longer Thing

Describe how to do another step.

{Copy the rest from Step 1 and paste here}

### Step 3: Do Thing 3

Describe how to do another step.

{Copy the rest from Step 1 and paste here}

### Step 4: Do Stuff

Describe how to do another step.

{Copy the rest from Step 1 and paste here}

## Quick Reference

{API Name}

- [Endpoint Name]({url for API Reference})
- [Endpoint Name]({url for API Reference})
- [Endpoint Name]({url for API Reference})

{API Name}

- [Endpoint Name]({url for API Reference})
- [Endpoint Name]({url for API Reference})
- [Endpoint Name]({url for API Reference})

## Best Practices

Listed below are some best practices for working with {}.

### Conditions for Retries

As a general rule, HTTP 4XX error codes (except for 429) should not be retried, 
but HTTP 5XX errors can be retried.
For general information on error retry practices,
see [Some Other Reference]().

### Caching Data

Describe what is cached and for how long, or if caching is not supported.

## Troubleshooting

- Use the general troubleshooting tips in the [Some Troubleshooting Doc]({URL}) guide.

- Use a Splunk query (requires access) to check for issues with your request.

- Contact the {} team on the [Slack-channel]({url for slack channel}) Slack channel for assistance.

## Terms of Service

### Authorization

#### Access Tokens

Most calls through the gateway require an access token to be sent in the request header.
This verifies that your app is authorized to perform the action on behalf of the user.

Access tokens are obtained by calling [Identity Provider 1]() or [Identity Provider 2]() prior to calling this API.

#### JSON Web Token

{Does this thing require JWT?}

For more, see the JWT section of [Using APIs](/doc/getting-started/using-apis.html#authorization).

### Sample Requests

Sample requests included throughout this guide contain unique IDs and access tokens that are 
spent/expired in the Production environment, and will not work as-is for testing purposes.
Replace with valid IDs/access tokens as necessary.

#### Required Request Headers

Listed below are the required request headers.
Header values may be set automatically, depending on your specific integration pattern.

| Header Name | Description |
|-------------|-------------|
| **Header1** |             |

>**TIP:** Super helpful tip here.

### Common Questions

**Question 1**

Answer 1

## Contacting the Team

Need to contact the {} team?

- [Slack]()
- [Confluence]()
- [Email]()

## Document Change Log

| Summary         | Date       |
|-----------------|------------|
| Initial publish | MM/DD/YYYY |

## Next Steps

You've learned how to add {} to your experience. Here are some next steps.

- [{Doc Title}]({URL})
- [{Doc Title}]({URL})