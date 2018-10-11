---
tags: pdf
category:
position: 2
title: Orders
url: /doc/commerce/order/use_order.html
toc:
  - h2: Overview
    url: /doc/commerce/order/use_order.html#overview
  - h2: Adding Order Summary
    url: /doc/commerce/order/use_order.html#order-summary
  - h2: Adding Order Details
    url: /doc/commerce/order/use_order.html#order-details
  - h2: Understanding Order Status
    url: /doc/commerce/order/use_order.html#order-status
  - Sending Your First Request
  - Best Practices
  - Troubleshooting
  - Terms of Service
  - Contacting the Team
  - Glossary
  - Document Change Log
  - Related Links
---

# ADDING ORDER HISTORY TO YOUR EXPERIENCE <i class="g72-swoosh"></i><br>

###### Last Updated: 10/5/2018

## <a name="overview">Overview</a>

Retrieve a complete order history for your consumers.

>**TIP**: Before using this guide you should have already completed [Adding Checkout to Your Experience](#).

Adding order history to your app is a two-step process.

<i class="numberCircle gray">1</i>Your application makes an API request to [retrieve all or a filtered list of a
consumer's
orders](#order-summary).

<i class="numberCircle gray">2</i>Using information from an order returned in the order summary response, your application makes a second API
request to [get detailed information for one consumer order](#order-details).

### What is an Order?

A Nike order consists of the following:

- Consumer's purchased items/services

- Consumer’s payment method(s) and billing address(es)

- Consumer’s shipping method(s) and shipping address(es)

- Pricing

- Taxes

- Discounts

[Insert diagram of high-level steps in the process]

Providing consumers a way to access their past orders enables them to check the progress of
product shipment and to view their product and payment history, no phone call required.


![](/images/commerce/order/order-life-cycle.png)

## Step 1: <a name="order-summary">List a consumer's orders</a>

Use the order summary API to get all of a consumer's Nike orders. You could make this information accessible to the
consumer as a self-service in your app. The information returned for each order is a limited set of data.
If you need a more in-depth picture of a consumer's order that contains pricing, tax information, shipping instructions and detailed product information, see [List the
details of
 a consumer's
 order](#order-details).

The order summary API requires that you pass certain headers in the request depending upon whether the consumer
is logged in, is a guest or an employee. For more information, see [Required Request Headers](#request-headers).

### Customizing Your Results

You can control what is returned in your result set and how it is sorted through URL parameters.

**Filtering**

The table below lists the fields by which you can filter your order summary results. If no filter is applied, all
of a consumer's orders are returned. While some filters only allow one value, you can filter by
 different types of filters in the same request. For instance, even though only one orderSubmitDateAfter filter value is
  allowed, you can request order summaries filtered by orderSubmitDateAfter and status. Note that filter parameter names
   and values are case sensitive.

|Order Field Name|Description|Sample Value|
|---|---|
|**status**|List orders with this status.|Cancelled|
|**orderType**|List orders of this type. You can only filter by one orderType at a time.|SALES_ORDER|
|**storeId**|List orders placed in this store. You can only filter by one storeId at a time.|28382|
|**orderSubmitDateAfter**|List orders placed after this date. You can only filter by one date at a time.|Format is yyyy-MM-dd'T'HH:mm:ssZ|

Order Summary request filtering by a status of 'Shipped' that were submitted after 2018-01-24.

`https://api.nike.com/order_mgmt/user_order_summary/v1?filter=storeId(12345)&filter=orderSubmitDateAfter(2018-01-24)
&filter=orderType(RESERVE_ORDER)`

Order Summary request filtering by a status of 'Shipped' or 'Delivered'.

`https://api.nike.com/order_mgmt/user_order_summary/v1?filter=status(Shipped,Delivered)`

**Sorting**

You can sort the consumer's orders in several ways using the `sort` query parameter. If no sorting is applied, orders are
returned in descending order by the orderSubmitDate field. You can sort by one or more order fields, separated by a comma. If your field is nested, refer to it with dot notation. For sort parameter syntax, see the [Query Parameters](/doc/getting-started/using_nike_apis.html#query-parameters){:target="_blank"} section of [Using NDe APIs](/doc/getting-started/using_nike_apis.html){:target="_blank"}.

Order Summary requested sorting by the field in descending order:

`https://api.nike.com/order_mgmt/user_order_summary/v1?sort=orderSubmitDateDesc`

**Other Query Parameters**

The Order History API also supports the `fields`, `count` and `anchor` query parameters to restrict the results to certain fields, restrict the number of results and to control pagination. For more information on syntax, see the [Query Parameters](/doc/getting-started/using_nike_apis.html#query-parameters){:target="_blank"} section of [Using NDe APIs](/doc/getting-started/using_nike_apis.html){:target="_blank"}.

### Understanding Order Status

An order contains three types of statuses:
- order
- order line (product or service purchased)
- payment

An order line of an order is a Nike service or product that the consumer has purchased that is associated with a quantity. Orders have at least one and may have many order lines. Each unit of an order line has it's own status and each status maps to a numeric status code. Order Details API returns the description of the lowest and highest status code. The status of the order depends on the status of each order line.

|Status Field Name|Description|API Name|
|---|---|---|
|status|Status of the order. Matches the orderLines.rolledUpStatus with the highest status code on the order.|Order Summary<br>Order Details|
|orderLines.rolledUpStatus|Status of an order line. Computed by "Partially" + status of the highest status code on this order line. Matches orderLines.maxOrderLineStatus. e.g. "Partially Shipped".|Order Summary<br>Order Details|
|orderLines.maxOrderLineStatus|Status of the highest status code on this order line. This status is included in orderLines.statuses.|Order Details|
|orderLines.minOrderLineStatus|Status of the lowest status code on this order line. This status is included in orderLines.statuses.|Order Details|
|orderLines.statuses|An array of statuses for each status code on this order line. The description with the highest status code matches orderLines.maxOrderLineStatus. The description with the lowest status code matches orderLines.minOrderLineStatus.|Order Details|
|paymentStatus|Status of payment.|Order Summary|


In the scenario illustrated by the Order Details response below, a consumer purchases three identical pair of Air Jordan size 10 men's shoes. Two pair are delivered to his home and one pair is in transit to his home from the warehouse. If the customer decides to return one pair, the pair he keeps has a status of "Delivered," the returned pair has a status of "Returned", and the pair in transit has a status of "Shipped". Because the "Delivered" status has the highest status code, the status at the order level is "Partially Delivered".


````
{
"status": "Partially Delivered",
...
"orderLines": [
        {
           ...

            "statuses": [
                {
                    "description": "Delivered",
                    "quantity": 1,
                    "date": "2018-01-30T12:16:51Z"
                },
                {
                    "description": "Shipped",
                    "quantity": 1,
                    "date": "2018-01-30T12:16:51Z"
                }
                {
                    "description": "Return Processed",
                    "quantity": 1,
                    "date": "2018-01-30T12:16:51Z"
                }
            ],
            "rolledUpStatus": "Partially Delivered",
            ...
            "maxOrderLineStatus": "Partially Delivered",
            ...
            "minOrderLineStatus": "Shipped",
            ...
        }
   }
}
```

For a complete list of status codes and their descriptions, see [Order Status Mapping for Consumers](https://confluence.nike.com/display/MOM/Order+Status+Mapping+for+Consumers){:target="_blank"}. Note that the User Status column values are not actually returned by either API. They are listed to help simplify the various Line Level status codes and statuses. Values in the Line Level Status column are returned in the Order Details response in the various status fields.


## Step 2: <a name="order-details">List the details of a consumer's order</a>

Use the order details API to get details of one consumer order. This API returns an in-depth picture of an order including product detail, tax information and line item details. If you are looking for higher level order information or you want to get all of a consumer's orders, see [List a consumer's orders](#order-summary).

The order details API requires that you pass certain headers in the request depending upon whether the consumer
is logged in, a guest or an employee. For more information, see [Required Request Headers](#request-headers).

### Required Request Parameters

For guest consumers, the orderNumber path parameter and email address query parameter are required for validation purposes. If the email address is missing from the request or does not match the shipTo email address on the guest's order, the API returns a 404.

### Customizing Your Results

You can control what is returned in your result set through URL parameters.

The Order Details API supports the `fields` query parameter to restrict the fields returned in the response. Since the Order Details API only returns one consumer order, the `anchor`, `sort`, `filter` and `count` query parameters are not supported. For more information on the `fields` query parameter syntax, see the [Query Parameters](/doc/getting-started/using_nike_apis.html#query-parameters){:target="_blank"} section of [Using NDe APIs](/doc/getting-started/using_nike_apis.html){:target="_blank"}.

Order Details request for orderNumber C00000123456 shipping to email address customer.email@nike.com, restricting the response fields to id, status and orderLines.shippingMethod.

`https://api.nike.com/order_mgmt/user_order_details/v1/C00000554850?filter=email(jane.moore@nike.com)&fields=id,status,orderLines.shippingMethod`



## <a name="api-endpoint-quick-reference"></a>API Endpoint Quick Reference


**Order Summary**
<a href="https://developer.niketech.com/docs/projects/BFF%20order%20summary?tab=api" target="_blank">Get a list of a consumer's orders</a>

**Order Details**
<a href="https://developer.niketech.com/docs/projects/BFF%20order%20Details?tab=api" target="_blank">Get the details of a consumer's order</a>



## <a name="sending-your-first-request"></a>Sending Your First Request

For your first request, send a request to the *User Order Summary* endpoint of the BFF Order Summary V1 API to list a
consumer's orders.

**1. Gather Info for the Request**

Our example endpoint *User Order Summary*, only supports the HTTP GET method. To list orders, send a GET request with (at minimum) the required request headers.

Assume that consumer for whom you are getting a list of orders for is a Nike+ member who has logged in with their Nike+ credentials. This indicates which request headers are required.

For the request headers, the following considerations apply (at minimum):

1. Always send `application/json` in both the **Accept** and **Content-Type** headers.

2. Send the user's access token as obtained from Unite services in the **Authorization** header.

```
Accept: application/json
Content-Type: application/json
Authorization: Bearer {your access token}
```

**2. Create the URL**

The <a href="https://developer.niketech.com/docs/projects/BFF%20order%20Details?tab=api" target="_blank">API.md</a> states that the required URL format is `/order_mgmt/user_order_summary/v1/`.

To build the full URL, prepend `https://api.nike.com` to the above path.

The complete URL is then https://api.nike.com/order_mgmt/user_order_summary/v1/.

**3. Execute the request**

Execute the request with a cURL command. Using the values gathered in steps 1 and 2, the final cURL command is:

```
```

**4. Parse the Response**

Assuming no errors, you will receive a response body similar to the following:

```

```


## <a name="best-practices"></a>Best Practices

### Conditions for Retries

For all Order APIs, the general rule is that HTTP 4XX error codes (except for 429) should not be retried but HTTP 5XX errors can be retried. For general information on Nike error retry practices, see <a href="https://confluence.nike.com/pages/viewpage.action?spaceKey=DAHP&title=API+-+Error+Patterns#API-ErrorPatterns-RetrylogicbasedonHTTPstatuscode" target="_blank">API Error Patterns</a> on Confluence.

### Honor the ETAs for Best Performance

For async endpoints that return an ETA, i.e. the estimated time for the job to be completed, it is important for your app to honor the ETA for best performance. For example, if the ETA is 2000ms, your app should wait 2000ms to start polling the /jobs endpoint to avoid consuming network and other resources unnecessarily.

### Test Scenarios



### Test Environment

It is recommended to test all Order endpoints in the production environment as opposed to the test environment. Using the test environment can have unpredictable results due to the many downstream services which these endpoints are reliant upon in order to provide typical 'production-like' responses.

There are boundaries for testing in production:

- Performance tests at high volumes should never be done in production.

### Caching Data

None of the endpoints described in this document support caching.

### Error Handling:



## <a name="troubleshooting"></a>Troubleshooting


## <a name="terms-of-service"></a>Terms of Service

It is recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#registration) guide on how to create and register your caller ID.

### <a name="authorization"></a>Authorization

#### Access Tokens

Most calls through the Nike API gateway (api.nike.com) require an access token be sent in the request header. This allows Nike to verify that your app is authorized to perform the action on behalf of the user.

Access tokens are obtained by calling Nike Unite services prior to calling the API which you ultimately want to reach.

To find out more on how to call Unite services to obtain access tokens, see the Authorization section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#authorization) guide.

#### JSON Web Token

Neither the *BFF Order Summary* nor *BFF Order Details* endpoints require the additional
authorization
 of a
 JSON Web Token (JWT). For more, see the JWT section of [Using NDe APIs](/doc/getting-started/using_nike_apis.html#jwt-json-web-token).

Listed below are ways to troubleshoot unexpected responses using this API.


<br>

### Sample Requests

The sample requests included throughout this guide often contain unique IDs and access tokens that are spent/expired in the Production environment, so you will not be able to copy and use them as-is for testing purposes. However, since other values in the request may still be valid and thus reusable, it may be convenient for you to copy the samples and change only the spent/expired values.

### User Types

The Nike Order APIs support 3 distinct user types:

- Member: user has logged in with their Nike+ account credentials

- Guest: user has not logged in (anonymous user)

- Employee: user is an employee of Nike or a subsidiary and has logged in with swoosh.com credentials (also known as Swoosh user type)

Depending on user type, certain aspects of the calls that you make to the Order APIs might need to be modified. This will be called out whenever applicable in the detailed endpoint sections which follow in this guide. Also, consider that not all user types might apply to your app (e.g. you might only support Members).

See the User Types section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#user-types) guide for more information.

### <a name="use-troubleshooting-tools"></a>Use Troubleshooting Tools

- Use the general troubleshooting tips in the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) to check for issues with your request.

- Contact the Orders team on the <a href="https://nikedigital.slack.com/messages/C1H7ZM7J4" target="_blank">#mp-athena</a> Slack channel for assistance.

### <a name="common-questions"></a>Common Questions

**Is it okay to call Order APIs if my app is hosted in an Amazon Web Services VPC?**

Yes. The APIs are exposed publicly so it does not matter where you are calling from. If you are calling repeatedly from a small set of IP addresses, it might be possible that Nike's bot-mitigation tools could interfere with your ability to make calls. If you are having issues, reach out to us for help.

#### <a name="request-headers"></a>Request Headers

Edge Router

Required request headers:

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|X|X|X|
|**Content-Type**|Content type of the request, application/json is only value allowed|X|X|X|
|**Authorization**|Your access token in the format of `Bearer {token}` indicating the consumer is logged in|X||X|
|**x-nike-visitorid**|Unique identifier for the guest, validated by the Edge router and passed through to the service||X||
|**x-nike-visitid**|Integer identifying the guest's session||X||
|**appId**|Application making the API request e.g. com.nike.sport.running.ios||X||

>**TIP:** For the Authorization header, use the token for the user's login session that you obtained from Nike Unite/Identity, prefixed by **Bearer ** (note the single space after Bearer). This is necessary for Nike to verify that you are authorized to perform the requested operation on behalf of the user.

## <a name="glossary"></a>Glossary

See the [Glossary](/doc/getting-started/glossary.html)

## <a name="document-change-log"></a>Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft 10/5/2018|Initial Draft|

## <a name="related-links"></a>Related Links

[NDe Documentation Home](/index.html)