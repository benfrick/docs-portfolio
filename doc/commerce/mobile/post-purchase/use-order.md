---
id: post-purchase
tags: pdf
#category: b-use-case
position: 13
title: Mobile Order History
url: /doc/commerce/mobile/post-purchase/use-order.html
toc:
- h2: Introduction
  url: /doc/commerce/mobile/post-purchase/use-order.html#introduction
- h2: Key Terms
  url: /doc/commerce/mobile/post-purchase/use-order.html#key-terms
- h2: List a Member's Orders
  url: /doc/commerce/mobile/post-purchase/use-order.html#step-1-list-a-members-orders
- h2: List a Member's Order Details
  url: /doc/commerce/mobile/post-purchase/use-order.html#step-2-list-a-members-order-details
- h2: List Pickup Details
  url: /doc/commerce/mobile/post-purchase/use-order.html#step-3-list-pickup-details
- h2: List a Guest's Order Details
  url: /doc/commerce/mobile/post-purchase/use-order.html#step-1-list-a-guests-order-details
- h2: Understanding MSRP Calculation
  url: /doc/commerce/mobile/post-purchase/use-order.html#understanding-msrp-calculation
- h2: API Quick Reference
  url: /doc/commerce/mobile/post-purchase/use-order.html#api-quick-reference
- h2: Best Practices
  url: /doc/commerce/mobile/post-purchase/use-order.html#best-practices
- h2: Troubleshooting
  url: /doc/commerce/mobile/post-purchase/use-order.html#troubleshooting
- h2: Terms of Service
  url: /doc/commerce/mobile/post-purchase/use-order.html#terms-of-service
- h2: Common Questions
  url: /doc/commerce/mobile/post-purchase/use-order.html#common-questions
- h2: Contacting the Team
  url: /doc/commerce/mobile/post-purchase/use-order.html#contacting-the-team
- h2: Document Change Log
  url: /doc/commerce/mobile/post-purchase/use-order.html#document-change-log
- h2: Next Steps
  url: /doc/commerce/mobile/post-purchase/use-order.html#next-steps
---
DRAFT
{% include dev-header.html %}

---

##### Last Updated: 1/25/2022

Retrieve a complete order history for your mobile consumers with the added flexibility of self-service options such as "Start a Return" and "Track Shipment" using the [Post Purchase API]{:target="_blank"}.

>**TIP**: Before using this guide, we recommend reading [Adding Consumer Order History to Your Experience] to understand the basics of Order History.

## Introduction

The use-case flows for registered members/employees and guests are described below.

### For Registered Members and Employees

Adding order history to your mobile app for a registered member is a three-step process:

**1.** Your mobile app makes a [Member List Orders]{:target="new-tab"} request to retrieve all or a filtered [list a member's orders](#step-1-list-a-members-orders).

**2.** Using an order ID from the **Member List Orders** response, your mobile app makes a request to the [Member List Order Details by ID]{:target="new-tab"} to [list order details for a member](#step-2-list-a-members-order-details).

**3.** Your mobile app makes a call to [List Pickup Details]{:target="new-tab"} to get a [list of pickup points](#step-3-list-pickup-details) for the order based on where the consumer can pick up their items.

### For Guests

Adding order history to your mobile app for a guest consumer is a two-step process:

**1.** Using an order ID provided by the guest, your mobile app makes a [Guest List Order Details by ID]{:target="new-tab"} request to [list order details for a guest](#step-1-list-a-guests-order-details).

**2.** Your mobile app makes a call to [List Pickup Details]{:target="new-tab"} to get a [list of pickup details](#step-3-list-pickup-details) for the order based where the consumer can pick up their items.

## Key Terms

See the [Key Terms](/doc/commerce/order/use-order.html#key-terms) section of the Consumer Order History guide for more information on order history terms and concepts.

## Step 1: List a Member's Orders

Use the **Member List Orders** endpoint to get either all or a filtered list of orders for a Nike member. By making their past orders available to members as a self-service in your app, they can view their product and payment history without having to contact Consumer Services.

>**TIPS**
- For the required request headers, see [Required Request Headers](#required-request-headers).
- To avoid a 404 response, the authentication header for a member request must match the member who created the order.

### Customizing Your Results

The **Member List Orders** endpoint supports the `timezone`, `count` and `anchor` query parameters to restrict the results to a certain timezone, restrict the number of results, and control pagination. For more information on syntax, see the [Query Parameters](/doc/getting-started/using-nike-apis.html#query-parameters) section of Using Nike APIs.

### Executing the Request

Sample CURL for Member List Orders:

```
curl -X GET \
  https://api.nike.com/orders/history/v1 \
  -H 'Authorization: Bearer <your token here>' \
  -H 'nike-api-caller-id: <caller id here>' \
  -H 'Accept: application/json' \
  -H 'country: us' \
  -H 'language: en'
```

### Common Response Considerations

The **Member List Orders**, **Member List Order Details by ID**, and **Guest List Order Details by ID** JSON responses contain several fields relating to status. Examples of order status are "Shipped", "Partially Delivered", and "Return Processed". See [Understanding Order Status] for more detail about how status is determined, and the suggested order statuses to display in your experience.

Depending upon the status of an order, the response may also include one or more action objects. Action objects include a callback link to the mobile app and a corresponding web link. Display the actions in the order results UI of your mobile experience so consumers can "Buy It Again", check "Order Details", and more. 

```
      "actions": {
        "buyItAgain": {
          "appCallback": "string",
          "webLink": "string"
        },
        "orderDetails": {
          "appCallback": "string",
          "webLink": "string"
        }
      }
```

See the [Post Purchase API]{:target="_blank"} for a full list of fields in each API's response.

## Step 2: List a Member's Order Details

Use the [Member List Order Details by ID]{:target="new-tab"} endpoint to get details for a member's order by ID. This API returns a complete picture of an order including product detail, tax information, and line item details. If you are looking for higher level order information, or you want information on more than one order for a member, see [list a member's orders](#step-1-list-a-members-orders).

### Required Request Parameters

The `country` and `language` path parameters are required.

>**TIPS**:
>- For the required request headers, see [Required Request Headers](#required-request-headers).
>- To avoid a 404 response, the authentication header for a member request must match the member who created the order.


### Executing the Request

Sample CURL for Member List Order Details by ID C00011554850 for a member/employee:

```
curl -X GET \
  https://api.nike.com/orders/history/v1/C00011554850 \
  -H 'Authorization: Bearer <your token here>' \
  -H 'nike-api-caller-id: <caller id here>' \
  -H 'Accept: application/json' \
  -H 'country: us' \
  -H 'language: en'
```

### Parsing the Response

See the [Common Response Considerations](#common-response-considerations) for information on response fields including order status and actions.

## Step 3: List Pickup Details

Use the [List Pickup Details](https://developer.niketech.com/docs/projects/Post%20Purchase%20API?tab=api){:target="new-tab"} endpoint to gather a list of pickup points that both guests and members can use to pick up their Nike order in person.

### Required Request Parameters

The `country` and `language` path parameters are required.

>**TIPS**:
>- For the required request headers, see [Required Request Headers](#required-request-headers).
>- This endpoint does not require a JWT.

### Executing the Request

Sample CURL for List Pickup Details in the US postal code 97035:

```
curl -X GET \
  https://api.nike.com/buy/pickupcodes/v1?country=US&postalCode=97005 \
  -H 'nike-api-caller-id: <caller id here>' \
  -H 'Accept: application/json'
```

### Parsing the Response
The response contains the pickup details available to the consumer, including address, GPS coordinates, and hours of operation. See [Fulfillment Offerings](/doc/commerce/checkout/use-fulfillment-offerings.html) for more detailed information on pickup details. 

## Step 1: List a Guest's Order Details

Use the [Guest List Order Details by ID]{:target="new-tab"} endpoint to get details for a guest's order by ID. This API returns a complete picture of an order including product detail, tax information and line item details.

### Required Request Parameters

The `country` and `language` path parameters are required.

>**TIPS**: 
>- For the required request headers, see [Required Request Headers](#required-request-headers).
>- Order ID is required as a path parameter
>- Either `telephoneNumber` or `email` is required as a query parameter

### Executing the Request

Sample CURL for Guest List Order Details by (order) ID C00011554850 for a guest shopping in the US in the English language:

```
curl -X GET \
  https://api.nike.com/orders/summary/v1/C00011554850?email=guest.user@test.com \
  -H 'nike-api-caller-id: <caller id here>' \
  -H 'x-nike-visitorid: 2c83877b-10fa-44da-a92d-2451efef8671' \
  -H 'x-nike-visitid: 2' \
  -H 'country: us' \
  -H 'language: en' \
  -H 'Accept: application/json'  
```

### Parsing the Response

See the [Common Response Considerations](#common-response-considerations) for information on response fields including order status and actions.

## Step 2: List Pickup Details
See the [List Pickup Details](#step-3-list-pickup-details) section for more details on how to list pickup details for a guest.

## Understanding MSRP Calculation

The Manufacturer's Suggested Retail Price (MSRP) in the both the Member List Order Details by ID and Guest List Order Details by ID response come from downstream services. When the downstream service returns a null MSRP, the Post Purchase API attempts to calculate the value. 

The Post Purchase API:

1. Gets the MSRP value from the [Product Feeds V2 API]{:target="new-tab"}. 
2. Gets the line item quantity and retail price from the [User Order Details API]{:target="new-tab"}. 
3. If MSRP is null, it calculates and compares two variables to determine MSRP, `possibleMSRP` and `lineItemChargedPrice`. 
4. Based on the value of the two variables and other factors, it determines whether to include both MSRP and `lineItemChargedPrice` in the response, or just `lineItemChargedPrice`.

The calculations and comparisons of `possibleMSRP` and `lineItemChargedPrice` are described below.

> **TIP**: Certain geographies such as Japan explicitly require that MSRP be excluded from the order details response.

Listed below are the fields and variables involved in determining MSRP and if MSRP should be included in the response.

###### Table 1: MSRP-related Fields

|Field/Variable Name|Where the value comes from|How it is used|
|---|---|---|
|MSRP|Product Feeds V2 service or if null, calculated by comparing `possibleMSRP` and `lineItemChargedPrice` temporary variables|If MSRP value from downstream service is null, Post Purchase API calculates MSRP instead|
|`lineItemChargedPrice`|Temporary variable calculated using retail price|Compared with `possibleMSRP` to determine if MSRP should be included in the response|
|`possibleMSRP`|Temporary variable calculated from quantity, MSRP and retail price|Compared with `lineItemChargedPrice` to determine if MSRP should be included in the response|
|quantity|User Order Details service|Represents the quantity of the line item on the order|
|retail price|User Order Details service|Represents the merchandised price of a single unit of the line item on the order, before applying discounts|

### Step 1: Calculate possibleMSRP
![Graphic showing how possibleMSRP is calcuated](/images/commerce/order/mobile/possiblemsrp.png)

### Step 2: Calculate lineItemChargedPrice

`lineItemChargedPrice` comes from [User Order Details API]{:target="new-tab"} service's `linePriceInformation.retailPrice`. This price is for the entire quantity of the order line after applying all discounts.

![Graphic showing how lineItemChargePrice is calcuated](/images/commerce/order/mobile/lineItemChargePrice.png)

### Step 3: Evaluate if MSRP Should be Included in the Response
![Graphic showing how MSRP is returned in the response](/images/commerce/order/mobile/msrpdetermination.png)

## API Quick Reference

###### Table 2: Post Purchase Endpoints

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|[Member List Orders]{:target="new-tab"}|/orders/history/v1|GET|
|[Member List Order Details by ID]{:target="new-tab"}|/orders/history/v1/{order-id}|GET|
|[Guest List Order Details by ID]{:target="new-tab"}|/orders/summary/v1/{order-id}|GET|
|[List Pickup Details]{:target="new-tab"}|/buy/pickupcodes/v1|GET|

## Best Practices

Listed below are some best practices for working with the Post Purchase API.

### Conditions for Retries

The general rule is that HTTP 4XX error codes (except for 429) should not be retried, but HTTP 5XX errors can be retried. For general information on Nike error retry practices, see [API Error Patterns](https://confluence.nike.com/display/NEA/API+Standards#APIStandards-Errors){:target="new-tab"} on Confluence.

### Testing

It is recommended to test all Post Purchase endpoints in the production environment as opposed to the test environment. Using the test environment can have unpredictable results, due to the many downstream dependencies required to provide 'production-like' responses.

**Q: What are the boundaries for testing in production?**

Performance tests at high volumes should **never** be done in production. All performance tests should be done in test.

**Q: Is this service available in the test environment?**

All services are available in the test environment, however, the data and services are not always available for end-to-end testing.

**Q: Why are our integration tests (that use the test environment) failing?**

When integrating for the first time, we can help ensure basic connectivity in the test environment before you deploy to production. However, we do not recommend relying on connections to the test environment on an ongoing basis, and provide no guarantees on the availability or retention of the data.

Teams should not introduce breaking changes in their contracts, so **mocking downstream dependencies** is often recommended to decouple development & testing between teams.

>**TIP**: Tools like [WireMock](http://wiremock.org){:target="new-tab"} allow you to mock out services for integration testing. Also, techniques like dark deployments & traffic shadowing can be used in Prod to validate new functionality.

**Q: Why is an order not showing up in the test environment?**

There are not as many system resources dedicated to the test environment, causing delays in asynchronous processing.

### Caching Data

To minimize calls to [Product Feeds V2 API]{:target="new-tab"}, the Post Purchase API caches product data.

## Troubleshooting

Here are some troubleshooting tips:

- Use the [General Troubleshooting](/doc/getting-started/using-nike-apis.html#troubleshooting) tips in the Using Nike APIs guide.
- Use a Splunk query (requires access) to check for issues with your request.
- Contact the Post Purchase team on the [#post-purchase]{:target="new-tab"} Slack channel for assistance.

## Terms of Service

Following are the terms of service for the Post Purchase APIs.

### Authorization

#### Access Tokens

Calls to the Member List Orders and Member List Order Details by ID endpoints require an access token be sent in the request header. This allows Nike to verify that your app is authorized to perform the action on behalf of the consumer.

Access tokens are obtained by calling Nike Unite services prior to calling the API which you ultimately want to reach.

To find out more on how to call Unite services to obtain access tokens, see the [Authorization](/doc/getting-started/using-nike-apis.html#authorization) section of the Using Nike APIs guide.

### User Types

The Order APIs support 3 distinct user types:

- Member: user has logged in with their Nike account credentials
- Guest: user has not logged in (anonymous user)
- Employee: user is an employee of Nike or a subsidiary and has logged in with swoosh.com credentials (also known as Swoosh user type)

### Required Request Headers

Listed below are the required request headers, which vary based on user type. Since most Member List Orders, Member List Order Details by ID and Guest List Order Details by ID requests come through the Nike Edge router, these header values will be set automatically, provided your app calls the Unite services first to get an access token and passes that token in the request.

###### Table 3: Required Order History Request Headers by User Type

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|X|X|X|
|**Content-Type**|Content type of the request, application/json is only value allowed|X|X|X|
|**Authorization**|Your access token in the format of `Bearer {token}` indicating the consumer is logged in|X||X|
|**nike-api-caller-id**|Application making the API request e.g. com.nike.sport.running.ios|X|X|X|
|**x-nike-visitorid**|Unique identifier for the guest, validated by the Edge router and passed through to the service. Applies only to the Guest List Order Details by ID API.||X||
|**x-nike-visitid**|Integer identifying the guest's session. Applies only to the Guest List Order Details by ID API.||X||

>**TIP:** For the Authorization header, use the token for the consumer's login session that you obtained from Nike Unite/Identity, prefixed by `Bearer ` (note the single space after Bearer). This is necessary for Nike to verify that your app is authorized to perform the requested operation on behalf of the consumer.

See the [User Types](/doc/getting-started/using-nike-apis.html#user-types) section of the Using Nike APIs guide for more information.

### Sample Requests

Sample requests included throughout this guide contain unique IDs and access tokens that are spent/expired in the Production environment, so you will not be able to use them as-is for testing purposes. Reuse what you can and replace with valid IDs/access tokens when necessary.

## Common Questions

Refer to the [Common Questions](/doc/commerce/order/use-order.html#common-questions) section of consumer Order History for information on how to identify types of orders.

### General Setup & Configuration

**Q: Can I call the Post Purchase API if my app is hosted in an Amazon Web Services VPC?**

Yes. The Post Purchase API is exposed publicly, so it does not matter where you are calling from. If you are calling repeatedly from a small set of IP addresses, it might be possible that Nike's bot-mitigation tools could interfere with your ability to make calls. If you are having issues, reach out to the [#post-purchase]{:target="new-tab"} Slack channel for help.

**Q: How do I get my appId on the allowed list?**

Reach out to @post_purch_api_team in our [#post-purchase]{:target="new-tab"} Slack channel to get help with adding your appId to the allowed list.

## Contacting the Team

Need to contact the Post Purchase team?

|---|---|
|Slack|[#post-purchase]{:target="new-tab"}|
|Confluence Space|[Post Purchase API Team](https://confluence.nike.com/display/POST/Post+Purchase+API?src=sidebar){:target="new-tab"}|
|Team Contacts|Intake - [Lauren Formichella](mailto:lauren.formichella@nike.com){:target="new-tab"}|

## Document Change Log

|Summary|Date|
|---|---|---|
|Initial publish|1/25/2022|

## Next Steps

You've learned how to add Post Purchase to your experience. Here are some related guides.

- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)
- [Adding Consumer Order History to Your Experience](/doc/commerce/order/use-order.html)

[Post Purchase API]: https://developer.niketech.com/docs/projects/Post%20Purchase%20API?tab=api
[User Order Details API]: https://developer.niketech.com/docs/projects/User%20order%20summary?tab=api
[Adding Consumer Order History to Your Experience]: /doc/commerce/order/use-order.html
[Understanding Order Status]: /doc/commerce/order/use-order.html#understanding-order-status
[Product Feeds V2 API]: https://developer.niketech.com/docs/projects/Product%20Feed%20Service%20API%20V2?tab=api
[List Pickup Details]: https://developer.niketech.com/docs/projects/Post%20Purchase%20API?tab=api
[Member List Orders]: https://developer.niketech.com/docs/projects/Post%20Purchase%20API?tab=api
[Member List Order Details by ID]: https://developer.niketech.com/docs/projects/Post%20Purchase%20API?tab=api
[Guest List Order Details by ID]: https://developer.niketech.com/docs/projects/Post%20Purchase%20API?tab=api
[#post-purchase]: https://nikedigital.slack.com/archives/C02BRELVB7A