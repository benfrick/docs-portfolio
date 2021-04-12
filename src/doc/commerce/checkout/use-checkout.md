---
id: use-checkout
tags: pdf
category: b-use-case
position: 8
title: Checkout
url: /doc/commerce/checkout/use-checkout-backup.html
toc:
  - h2: Introduction
    url: /doc/commerce/checkout/use-checkout.html#introduction
  - h2: Key Terms
    url: /doc/commerce/checkout/use-checkout.html#key-terms
  - h2: Shipping Options
    url: /doc/commerce/checkout/use-checkout.html#shipping-options
  - h2: Address Geocoding
    url: /doc/commerce/checkout/use-checkout.html#address-geocoding
  - h2: Fulfillment Offerings
    url: /doc/commerce/checkout/use-checkout.html#fulfillment-offerings
  - h2: Shipping Address Validation
    url: /doc/commerce/checkout/use-checkout.html#shipping-address-validation
  - h2: Checkout Preview
    url: /doc/commerce/checkout/use-checkout.html#checkout-preview
  - h2: Checkout Submit
    url: /doc/commerce/checkout/use-checkout.html#checkout-submit
  - h2: API Quick Reference
    url: /doc/commerce/checkout/use-checkout.html#api-quick-reference
  - h2: Best Practices
    url: /doc/commerce/checkout/use-checkout.html#best-practices
  - h2: Troubleshooting
    url: /doc/commerce/checkout/use-checkout.html#troubleshooting
  - h2: Terms of Service
    url: /doc/commerce/checkout/use-checkout.html#terms-of-service
  - h2: Contacting the Team
    url: /doc/commerce/checkout/use-checkout.html#contacting-the-team
  - h2: Document Change Log
    url: /doc/commerce/checkout/use-checkout.html#document-change-log
  - h2: Next Steps
    url: /doc/commerce/checkout/use-checkout.html#next-steps
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING CHECKOUT TO YOUR EXPERIENCE

---

##### Last Updated: 04/12/2021

Manage the Checkout process for the consumer.

>**TIPS**:
>- Before using this guide, read [Using Nike APIs](/doc/getting-started/using-nike-apis.html) and [Cart & Checkout Overview](/doc/commerce/checkout/overview-checkout.html).
>- Use this Developer's Guide as a supplement to the API Reference for detailed use cases. See [API Quick Reference](#api-quick-reference) for links to all the API Reference docs discussed in this guide.
>- The steps involving **Payment** are covered in [Adding Payment to Your Experience](/doc/commerce/payment/use-payment.html)

## Introduction

### What is a Checkout?

A checkout represents a consumer's intent to complete a purchase and includes information necessary for the fulfillment of an order.

At Nike, a checkout includes **all of the information from cart plus**:

- Shipping methods **(Checkout V2 only)**
- Shipping addresses
- Fulfillment details including type, cost, and "get by" dates **(Checkout V3 only)**
- Payment methods
- Billing addresses
- Taxes

### Which Version of Checkout Should I Use?

The Nike shopping experience involves several APIs. To support the latest features, sometimes certain API versions must be used together. See the [Which API Version Should I Use](/doc/commerce/checkout/overview-checkout.html#which-api-version-should-i-use) section of the **Cart & Checkout Overview** for more information on the Checkout version you need.

## Key Terms

Listed below are some terms important to understanding checkout.

###### Table 2: Key Terms for Checkout

|Term|Definition|
|---|---|
|**Address Geocoding**|Converts a text-based description of a location such as an address, into latitude and longitude coordinates|
|**Cart**|The virtual shopping cart used by Nike consumers to collect and compare items for purchase|
|**Checkout**|A collection of data, including cart data, describing what may become a consumer order|
|**Fapiao**|Tax-related invoice offered to China consumers only|
|<a id="legacy-def"></a>**Legacy fulfillment flow**|Checkout flow supporting ship to consumer address and digital delivery only|
|<a id="omni-channel-def"></a>**Omni-channel fulfillment flow**|Checkout flow supporting ship to consumer address, digital delivery, Buy-Online-Pickup-in-Store (BOPIS), pickup at third party location, and Instant Checkout|
|**Reverse geocoding**|Converts latitude and longitude coordinates into a text-based description of a location such as an address|
|**Source-aware**|Using consumer location and other factors to offer the best options of when, where, and how to receive Nike product|

## Shipping Options

<i class="g72-check"></i>&nbsp;&nbsp;**Get available shipping methods and estimated delivery dates**

>**TIP:** Shipping Options is for the [legacy fulfillment](#legacy-def) flow only. New implementations should use [Fulfillment Offerings](#fulfillment-offerings) instead.

Once the consumer finalizes their [cart](/doc/commerce/checkout/use-carts.html), it's time to begin the checkout process. If your app or experience is using the [legacy fulfillment](#legacy-def) flow, the first step for consumers is to select a shipping method.

Consumers are accustomed to selecting a shipping method (Standard, Two-Day, Next-Day for example) during the checkout process. But, how do you know which methods to present to them, based on their shopping context?

Use the [Shipping Options API](https://developer.niketech.com/docs/projects/Shipping%20Options?tab=api#shipping-options-post){:target="new-tab"} to retrieve the available shipping methods for a consumer's checkout.

#### Step 1: Display a List of Shipping Options

To show a UI of shipping options available for each item in a consumer's cart, execute a request to the *Shipping Options* endpoint. Pass the consumer's shopping country, currency, locale and item information including promotional codes.

Sample [Shipping Options API](https://developer.niketech.com/docs/projects/Shipping%20Options?tab=api#shipping-options-post){:target="new-tab"} POST request URI:

```
https://api.nike.com/buy/shipping_options/v2
```

A successful 200 response includes the available shipping methods for a consumer’s checkout, associated costs, estimated delivery dates, and discounts such as free shipping for members.

>**TIPS:**
- Although optional, pass a `shippingAddress` when available. In certain countries including the US, passing `shippingAddress` returns an estimated delivery date instead of an estimated delivery range.
- In China, shipping methods vary based on the province, city, and district combination.

## Address Geocoding

<i class="g72-check"></i>&nbsp;&nbsp;**Turn an address into latitude and longitude coordinates**

<i class="g72-check"></i>&nbsp;&nbsp;**Turn latitude and longitude coordinates into an address**

The [Geocoding API](https://developer.niketech.com/docs/projects/Geocoding?tab=api) allows you to interchange an address with latitude and longitude geo coordinates. This service is not JWT-protected.

### Get geographic coordinates from an address

Need to call an API that requires the consumer's latitude and longitude location coordinates but you only have the consumer's address? Call the **Get Geocodes from Address API** passing address information as query parameters. 

**Request Query Parameters**

|Parameter Name|Description|Required?|Example|
|---|---|---|
|**country**|2-alpha character ISO 3166 country code|**Required**|US|
|**address1**|String|Optional|One Bowerman Drive|
|**address2**|String|Optional|1st Floor|
|**address3**|String|Optional|Suite 100|
|**city**|String|Optional|Beaverton|
|**state**|ISO 3166-2 subdivision code. 2-alpha character ISO 3166-2 state code for US addresses|Optional|OR|
|**county**|String. Holds regional data for non-US addresses|Optional|Washington|
|**postalCode**|String. Both 5 digit and 5 digit-4 digit formats are supported for US addresses|Optional|97005|

>**Tip**: If address values contain spaces, enclose the value in quotes for example, `filter=address1("1 Bowerman Drive")`.

Sample [Get Geocodes from Address](https://developer.niketech.com/docs/projects/Geocoding?tab=api) cURL GET request:
```
curl -X GET "https://api.nike.com/buy/geocodes/v1?filter=country(US)&filter=address1("1 Bowerman Drive")&filter=city("Beaverton")&filter=state(OR)&filter=postalCode(97005)" -H  "accept: application/json; charset=UTF-8"
```
A successful 200 response contains the `country` passed in the request, `latitude`, `longitude` and in some cases, `geoDistance`. `geoDistance` represents the accuracy radius in meters between the geocode coordinates and the physical location.

### Get an address from geographic coordinates

For the convenience of consumers, your experience may not want to require them to enter their postal code in order to perform a location search by [Fulfillment Offerings](#fulfillment-offerings). You can turn latitude and longitude geo coordinates into a physical address by calling the **Get Address from Geocodes API**.

### Step 1: Get the consumer's geographic coordinates (optional)

If you don't have the consumer's latitude and longitude coordinates, you can get them from the [browser](https://developer.mozilla.org/en-US/docs/Web/API/Geolocation_API) or through the operating system's location API on an [iPhone](https://developer.apple.com/documentation/corelocation/getting_the_user_s_location) or [Android](https://developer.android.com/training/location) mobile device.

> **Note**: You will need the consumer's permission to get their location.

### Step 2: Get the consumers' address

Once you have the geo coordinates, call the **Get Address from Geocodes API** to retrieve the consumer's full address. Send `country`,`latitude` and `longitude` number values as query parameters in the GET request. All query parameters are required.

Sample [Get Address from Geocodes](https://developer.niketech.com/docs/projects/Geocoding?tab=api) cURL request:
```
curl -X GET "https://snkrs.prod.commerce.nikecloud.com/buy/reverse_geocodes/v1?filter=country(US)&filter=latitude(45.50696)&filter=longitude(-122.82701)" -H  "accept: application/json; charset=UTF-8"
```
A successful 200 response contains address information of the physical location matching the geocode coordinates passed in the request as well as latitude, longitude and geoDistance.

## Fulfillment Offerings

<i class="g72-check"></i>&nbsp;&nbsp;**Get available shipping and pickup locations, costs, and delivery/pickup dates**

>**TIP:** Fulfillment Offerings is for the [omni-channel](#omni-channel-def) fulfillment flow only

The [Fulfillment Offerings API](https://developer.niketech.com/docs/projects/Fulfillment%20Offerings?tab=api){:target="new-tab"} is a replacement of the [Shipping Options API](https://developer.niketech.com/docs/projects/Shipping%20Options?tab=api){:target="new-tab"} just discussed. Fulfillment offerings provides consumers more flexibility in choosing how, when, and where to get Nike products based on consumer location, availability and several other factors. They may be able to choose to have their items digitally delivered, shipped to an address of their choice, pick up at a Nike store, or pick up at a third party location. A user experience driven by the Fulfillment Offerings API helps the consumer make those decisions by providing the cost of each offering and "get by" dates that predict when the consumer can get the product.

See [Adding Fulfillment Offerings To Your Experience](/doc/commerce/checkout/use-fulfillment-offerings.html) for more information.

## Shipping Address Validation

<i class="g72-check"></i>&nbsp;&nbsp;**Ensure each shipping address is deliverable**

After the consumer selects or provides a personal shipping address through either the [Shipping Options](#shipping-options) or [Fulfillment Offerings](#fulfillment-offerings), validate the address with the [Address Validator API](https://developer.niketech.com/docs/projects/AddressValidator?tab=api){:target="new-tab"}. This endpoint can validate any type of address including a billing address.

This service calls a third party vendor to validate the shipping address passed in the request against an address database. The service response contains a `verficationCode`, `score`, and an address. Based on the quality of the address match, the service returns either the consumer-provided address or a corrected address. See the table below to understand how the `verificationCode` and `score` work together to determine what actions the consumer needs to take next.

###### Table 3: Address Validator Verification Codes and Scores with Next Steps

|Verification Code|Score|Consumer needs to|
|---|---|---|
|VERIFIED|95 or greater|Address provided by the consumer is verified and is returned in the response. No further action is required by the consumer.|
|VERIFIED|less than 95|Address provided by the consumer is missing information and a recommended address is returned in the response. Consumer needs to review the recommended address and decide to accept it or retry with a different address.|
|PARTIALLY_VERIFIED, UNVERIFIED, AMBIGUOUS, CONFLICT, REVERTED|any|Address provided by the consumer could not be verified and is returned in the response. Consumer needs to correct the address and retry.|

>**TIP:** The third party address validation service has a 512 character limit restriction on each address field and a 1024 character limit for the entire address. The client should truncate characters in any address field exceeding the field limit or address limit before making the request.

See the [Address Validation Service](https://confluence.nike.com/pages/viewpage.action?pageId=270586569){:target="new-tab"} page for more information on request and response field mappings between the Address Validator API and the third party.

Sample [Address Validator API](https://developer.niketech.com/docs/projects/AddressValidator?tab=api){:target="new-tab"} POST request URI. This is a synchronous endpoint and is not JWT-protected:

```
https://api.nike.com/location/address_validator/v1
```

## Checkout Preview

<i class="g72-check"></i>&nbsp;&nbsp;**Validate a checkout for fulfillment**

Next, let's make sure that the checkout details are accurate and that the process can proceed to the payment steps.

### Can I Skip This?

It is not required to [Request a Checkout Preview](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api#checkout-preview-request-checkout-preview-put){:target="new-tab"} in order for the consumer to complete their purchase. However, calling the endpoint to validate the order and payment details one last time increases the consumer's chance of a successful checkout.

You can use the details in a successful response to display the final payment amount to the consumer. Once the consumer confirms the payment method details and places the order, there will be a better chance of success.

>**NOTE**: Checkout Preview (and Checkout Submit in the next steps) operates asynchronously. This means that after you execute the initial request, you call another endpoint to get the result. See [Using Nike APIs](/doc/getting-started/using-nike-apis.html#asynchronous-operation) for more details.

### Which Version of Checkout Preview Should I Use?

See the [Which API Version Should I Use](/doc/commerce/checkout/overview-checkout.html#which-api-version-should-i-use) section of the **Cart & Checkout Overview** for the list of API versions that must be used together in a checkout flow.

Details on the available Checkout Preview versions are listed below.

Table 1: Checkout Preview API Versions

|Version|Description|
|---|---|
|V3|Used in [omni-channel](#omni-channel-def) shopping flow<br>Supports fulfillment offerings, including Buy-Online-Pickup-In-Store (BOPIS)|
|V2|Used in [legacy](#legacy-def) shopping flow<br>Limited to basic shipping options and estimated delivery date (EDD), for example Standard|

### Step 1: Request Checkout Preview

#### Checkout Preview V3

Execute a PUT request to [Request Checkout Preview](https://developer.niketech.com/docs/projects/Checkout%20Previews%20V3?tab=api#checkout-preview-request-checkout-preview-put){:target="new-tab"} endpoint, passing the complete cart and `fulfillmentDetails` returned from [fulfillment offerings](/doc/commerce/checkout/use-fulfillment-offerings.html) for each item .

The API ensures that the products and fulfillment details for each item are valid based on Nike pricing, availability, and other factors. You can also get product pricing, sales tax, fulfillment fees and tax, "get by" dates, and checkout subtotals in the response.


Sample V3 [Request Checkout Preview](https://developer.niketech.com/docs/projects/Checkout%20Previews%20V3?tab=api#checkout-preview-request-checkout-preview-put){:target="new-tab"} PUT request URI:
```
https://api.nike.com//buy/checkout_previews/v3/89rc115b-16e5-43b5-bcaf-dd6168c543u4
```

#### Checkout Preview V2

Execute a request to the [Request Checkout Preview](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api#checkout-preview-request-checkout-preview-put){:target="new-tab"} endpoint.

The API ensures that the products, shipping method(s), and shipping address(es) are valid based on Nike pricing and address rules. You can also get product pricing, sales tax, shipping fee and tax, estimated delivery date(s), and checkout subtotals in the response.

>**TIP:** For more context, see a step-by-step example of all the requests in a checkout in the diagram in the [Best Practices](#best-practices) section of this document. For more info about Payment, see [Adding Payment to Your Experience](/doc/commerce/payment/use-payment.html).

Sample V2 [Request a Checkout Preview](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api#checkout-preview-request-checkout-preview-put){:target="new-tab"} request URI:
```
https://api.nike.com/buy/checkout_previews/v2/61bc115b-16e5-43b5-bcaf-dd6168c543f8
```

### Step 2: Retrieve Checkout Preview Job

After calling either V2 or V3 **Request a Checkout Preview** and receiving a HTTP 202 response, execute a request to either V2 or V3 **Retrieve Checkout Preview Job** using the same checkout ID to check the status of your job.

To know if the job is done, check the value of the **status** field in the response body as follows:

- `"status": "PENDING"`: job processing has not started

- `"status": "IN_PROGRESS"`: job processing is in progress

- `"status": "COMPLETED"`: job has completed

Once you receive a job status of COMPLETED, get the results of your job by parsing the data in the **response** object.

Sample V3 [Retrieve Checkout Preview Job](https://developer.niketech.com/docs/projects/Checkout%20Previews%20V3?tab=api#checkout-preview-retrieve-checkout-preview-job-get){:target="new-tab"} request URI:
```
https://api.nike.com/buy/checkout_previews_jobs/v3/89rc115b-16e5-43b5-bcaf-dd6168c543u4
```

Sample V2 [Retrieve Checkout Preview Job](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api#checkout-preview-retrieve-checkout-preview-job-get-1){:target="new-tab"} request URI:
```
https://api.nike.com/buy/checkout_previews/v2/jobs/61bc115b-16e5-43b5-bcaf-dd6168c543f8
```

## Checkout Submit

<i class="g72-check"></i>&nbsp;&nbsp;**Submit a checkout for fulfillment**

### Which Version of Checkout Submit Should I Use?

See the [Which API Version Should I Use](/doc/commerce/checkout/overview-checkout.html#which-api-version-should-i-use) section of the **Cart & Checkout Overview** for the list of API versions that must be used together in a checkout flow.

Details on the available Checkout Submit versions are listed below.

Table 1: Checkout Submit API Versions

|Version|Description|
|---|---|
|V3|Used in [omni-channel](#omni-channel-def) shopping flow<br>Supports fulfillment offerings, including Buy-Online-Pickup-In-Store (BOPIS)|
|V2|Used in [legacy](#legacy-def) shopping flow<br>Limited to basic shipping options and estimated delivery date (EDD), for example Standard|


### Step 1: Request Checkout Submit

Checkout Submit performs the final validations of the consumer's information, requests payment authorization, and if everything succeeds, submits the checkout for fulfillment.

>**TIPS:**
>- You must have previously called the Payment Preview API to collect the required payment information, most notably the mandatory Payment Preview **id**. See the [Adding Payment to Your Experience](/doc/commerce/payment/use-payment.html) for more info.
>- Optionally, for Japan only, send `GIFT_RECEIPT` in the **invoiceInfo** block, which prevents prices from being printed on the packing slip that is included with the product shipment.
>- Optionally, for China only, send `ELECTRONIC_FAPIAO` in **invoiceInfo** for Fapiao, which is a special tax invoice. If the consumer indicates a preference for Fapiao, they can enter a personal message to be used as a title for the invoice. For example:

```
"invoiceInfo": {
    "type": "ELECTRONIC_FAPIAO",
    "detail": "The consumer's personal title for the invoice"
}
```

**Checkout Submit V3**

Execute a PUT request to the **Request a Checkout Submit** endpoint, passing the complete cart and `fulfillmentDetails` returned from [fulfillment offerings](/doc/commerce/checkout/use-fulfillment-offerings.html) for each item.

Sample [Request Checkout Submit](https://developer.niketech.com/docs/projects/Checkouts%20V3?tab=api#checkout-request-a-checkout-submit-put
){:target="new-tab"} PUT request URI:
```
https://api.nike.com/buy/checkouts/v3/61bc115b-16e5-43b5-bcaf-dd6168c543f8
```

**Checkout Submit V2**

Execute a request to the **Request a Checkout Submit** endpoint when your consumer is ready to complete their purchase.

Sample [Request Checkout Submit](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api#checkout-request-a-checkout-submit-put){:target="new-tab"} request URI:
```
https://api.nike.com/buy/checkouts/v2/61bc115b-16e5-43b5-bcaf-dd6168c543f8
```

### Step 2: Retrieve Checkout Submit Job

After calling either V2 or V3 **Request Checkout Submit** endpoint and receiving a HTTP 202 response, execute a request to either the V2 or V3 **Retrieve Checkout Submit Job** using the same checkout ID to check the status of your job.

The same job statuses apply for this endpoint as they do for [Retrieve Checkout Preview Job](#step-2-retrieve-checkout-preview-job). Once you observe a job status of COMPLETED, get the results of your job by parsing the data in the **response** object.

Sample V3 [Retrieve Checkout Submit Job](https://developer.niketech.com/docs/projects/Checkouts%20V3?tab=api#checkout-retrieve-checkout-submit-job-get){:target="new-tab"} GET request URI:
```
https://api.nike.com/buy/checkouts/v3/jobs/61bc115b-16e5-43b5-bcaf-dd6168c543f8
```

Sample V2 [Retrieve Checkout Submit Job](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api#checkout-retrieve-checkout-submit-job-get){:target="new-tab"} GET request URI:
```
https://api.nike.com/buy/checkouts/v2/jobs/61bc115b-16e5-43b5-bcaf-dd6168c543f8
```


## API Quick Reference

**Shipping Options**
- [Shipping Options](https://developer.niketech.com/docs/projects/Shipping%20Options?tab=api){:target="new-tab"}

**Address Validator**
- [Address Validator](https://developer.niketech.com/docs/projects/AddressValidator?tab=api){:target="new-tab"}

**Address Geocoding**
- [Get Geocodes from Address](https://developer.niketech.com/docs/projects/Geocoding?tab=api)
- [Get Address from Geocodes](https://developer.niketech.com/docs/projects/Geocoding?tab=api)

**Checkouts**
- Request Checkout Preview [V2](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api#checkout-preview-request-checkout-preview-put){:target="new-tab"} and [V3](https://developer.niketech.com/docs/projects/Checkout%20Previews%20V3?tab=api#checkout-preview-request-checkout-preview-put){:target="new-tab"}
- Retrieve Checkout Preview Job [V2](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api#checkout-preview-retrieve-checkout-preview-job-get){:target="new-tab"} and [V3](https://developer.niketech.com/docs/projects/Checkout%20Previews%20V3?tab=api#checkout-preview-retrieve-checkout-preview-job-get){:target="new-tab"}
- Request Checkout Submit [V2](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api#checkout-request-a-checkout-submit-put){:target="new-tab"} and [V3](https://developer.niketech.com/docs/projects/Checkouts%20V3?tab=api#checkout-request-a-checkout-submit-put){:target="new-tab"}
- Retrieve Checkout Submit Job [V2](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api#checkout-retrieve-checkout-submit-job-get){:target="new-tab"} and [V3](https://developer.niketech.com/docs/projects/Checkouts%20V3?tab=api#checkout-retrieve-checkout-submit-job-get){:target="new-tab"}
- Request Checkout Submit (Launch) [V2](https://developer.niketech.com/docs/projects/Checkouts%20V2?tab=api#launch-checkout-request-a-checkout-submit-put){:target="new-tab"}

## Best Practices

Here are some best practices. We'll start with an example sequence of API calls to execute an entire checkout:

### Example Implementation Diagram

![](/images/commerce/buy/checkout_seq_dgm.png){:class="border"}

### User Types

The Checkout API supports 3 distinct user types:

- Member: user has logged in with their Nike+ account credentials

- Guest: user has not logged in (anonymous user)

- Employee: user is an employee of Nike or a subsidiary and has logged in with swoosh.com credentials (also known as Swoosh user type)

Depending on user type, certain aspects of the calls that you make to the Checkout API might need to be modified. Also, consider that not all user types might apply to your app. For example, your app might only support Members.

See the User Types section of the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#user-types) guide for more information.

### Request Headers

The following request headers are common to all of the Cart & Checkout APIs:

###### Table 3: Common Request Headers to Checkout APIs

|Header Name|Description|Member|Guest|Employee|
|---|---|---|---|---|
|**Accept**|Content type you will accept in response, application/json is only value allowed|X|X|X|
|**Content-Type**|Content type of the request, application/json is only value allowed|X|X|X|
|**Authorization**|Your access token in the format of `Bearer {token}` indicating the consumer is logged in|X||X|
|**x-nike-visitorid**|Identifier for the guest (i.e. not logged-in) consumer, validated by the Edge router and passed through to the service||X||

>**TIP:** For the Authorization header, use the token for the consumer's login session that you obtained from Nike Unite/Identity, prefixed by **Bearer ** (note the single space after Bearer). This is necessary for Nike to verify that you are authorized to perform the requested operation on behalf of the consumer.

### Supported Countries & Currencies

For the list of country code and currency code combinations supported by Cart & Checkout see [Countries & Currencies](/doc/commerce/checkout/checkout-country-currency.html)

### Idempotence

[Idempotence](http://restcookbook.com/HTTP%20Methods/idempotency/){:target="new-tab"} means that the result of a successful request is independent of the number of times it is executed. What does that mean for the Checkout API? Each PUT request to **Request a Checkout Preview** and **Request Checkout Submit** includes 1) a client-generated UUID (checkout ID) in the URL and 2) an Entity in the request body. There are 4 possible scenarios:

###### Table 4: Scenarios Illustrating Idempotence Behavior for Checkout Requests

|Scenario|Result|
|---|---|
|UUID and Entity are new to the system (base use case)|Client receives HTTP 202 response, request processed as new job|
|UUID and Entity match a prior request|Client receives the exact same HTTP 202 response from the prior request (no new job processed)|
|UUID used previously, Entity is new|Client receives HTTP 409 error response (no new job processed)|
|UUID is new, Entity previously submitted under another UUID|Client receives HTTP 202 response, request processed as new job|

>**TIP:** For more, see the Idempotence Guarantee section of the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#idempotence-guarantee) guide.

### Conditions for Retries

For retry information by Checkout endpoint, visit [Retry Patterns for Checkout Clients](https://confluence.nike.com/display/DAHP/DRAFT+-+Retry+Pattern+for+Checkout+Service+Clients){:target="new-tab"} in Confluence.

For all Checkout APIs, the general rule is that HTTP 4XX error codes (except for 429) should not be retried but HTTP 5XX errors can be retried. For general information on Nike error retry practices, see [API Error Patterns](https://confluence.nike.com/pages/viewpage.action?spaceKey=DAHP&title=API+-+Error+Patterns#API-ErrorPatterns-RetrylogicbasedonHTTPstatuscode){:target="new-tab"} on Confluence.

### Honor the ETAs for Best Performance

For async endpoints that return an ETA, i.e. the estimated time for the job to be completed, it is important for your app to honor the ETA for best performance. For example, if the ETA is 2000ms, your app should wait 2000ms to start polling the /jobs endpoint to avoid consuming network and other resources unnecessarily.

### Test Scenarios

Here is an example list of test scenarios for a consumer experience that is integrating with the Checkout API.

- Single Product (non-customizable only) - Single Payment (Credit Card)

- Single Product (non-customizable only) - Single Payment (Gift Card)

- Single Product (non-customizable only) - Single Payment (PayPal)

- Multiple Products (non-customizable only) - Single Payment (Credit Card)

- Single Product (customizable only) - Single Payment (Credit Card)

- Single Product (customizable only) - Single Payment (PayPal)

- Single Product (non-customizable only) - Multiple Payment (Credit Card & Gift Card)

- Single Product (customizable only) - Multiple Payment (Credit Card & Gift Card)

- Multiple Products (customizable only) - Single Payment (Credit Card)

- Mixed Products (customizable & non-customizable) - Single Payment (Credit Card)

- Mixed Products (customizable & non-customizable) - Single Payment (PayPal)

- Mixed Products (customizable & non-customizable) - Multiple Payment (Credit Card & Gift Card)

>**TIPS:**
>- While inspecting browser activity on www.nike.com/launch, you can change your shopping country with the flag icon at the upper right of the homepage.
>- You can place an order to observe all the checkout calls. Orders can be cancelled via self-service within 30 minutes of submission, otherwise contact Nike Consumer Services.

### Test Environment

Test low-volume requests using production Checkout endpoints rather test environment endpoints. Test environment endpoint responses can be unpredictable due to the many downstream services these endpoints rely on in order to simulate typical 'production-like' responses.

Keeping in mind the following:

- Performance tests at high volumes should never be done in production.

- Calling **Request a Checkout Submit** in production can result in actual Nike orders being sent for fulfillment, and actual payment methods being authorized and/or charged. Proceed with caution.

### Caching Data

None of the endpoints described in this document support caching.

### Error Handling: Which JSON Field Had The Error?

In error responses from APIs, Nike uses the [JSON Pointer](https://tools.ietf.org/html/rfc6901){:target="new-tab"} standard to indicate which field of the request JSON had the error.

Sample Carts error message using the JSON Pointer standard:
```
{
    "message": "Validation Failed",
    "errors": [{
        "field": "/request/items/0/contactInfo/email",
        "code": "INVALID_EMAIL",
        "message": "Invalid email"
    }]
}
```

## Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### Tools

- Use the general troubleshooting tips in the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) to check for issues with your request.

- Contact the Buy team on the [#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV){:target="new-tab"} Slack channel for assistance.

### Common Questions

**Is it okay to call Checkout APIs if my app is hosted in an Amazon Web Services VPC?**

Yes. The APIs are exposed publicly so it should not matter where you are calling from. If you are calling repeatedly from a small set of IP addresses, it might be possible that Nike's bot-mitigation tools could interfere with your ability to make calls. If you are having issues, reach out to us for help.

**Why does my Checkout Submit job sometimes take a long time to complete?**

Checkout Submits initiate a lot of behind-the-scenes API calls, the duration of which is somewhat unpredictable. Depending on the total volume of requests happening at the time your request was submitted, combined with the payment method and shipping country selected by the consumer, it may take several seconds to get a completed job. Best case is about 5 seconds, worst case can be well over a minute. If the job times out, you will get a 'completed with error' job status.

## Terms of Service

It is recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#registration) guide on how to create and register your caller ID.

### Authentication

#### Access Tokens

Most calls through the Nike API gateway (api.nike.com) require an access token be sent in the request header. This allows Nike to verify that your app is authorized to perform the action on behalf of the consumer. Access tokens are obtained by calling Nike Unite services prior to calling the API which you ultimately want to reach.

See [Using Nike APIs](/doc/getting-started/using-nike-apis.html#authorization) guide for more on how to call Unite services.

#### JSON Web Token

Only one Buy API endpoint requires the additional authorization of a JSON Web Token (JWT), **Checkout Submit (Launch)**. For more information, see the JWT section of [Using Nike APIs](/doc/getting-started/using-nike-apis.html#jwt-json-web-token).

## Contacting the Team

Need to contact the Buy team?

|Slack|[#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV){:target="new-tab"}|
|Confluence Space|[CiC Order Capture](https://confluence.nike.com/pages/viewpage.action?pageId=163654070){:target="new-tab"}|
|Team Contacts|[Dan Robertson](mailto:dan.robertson@nike.com), [Saket Shrivastava](mailto:saket.shrivastava@nike.com), [Sree Krishna](mailto:sree.krishna@nike.com) (Address Validation)|

## Document Change Log

|Summary|Date|
|---|---|
|Initial publish|10/02/2018|
|Added Key Terms|08/01/2019|
|Added Address Validation|09/30/2019|
|Moved Cart and Wishlist to separate docs, added Checkout Preview V3 and Checkout Submit V3 content|04/30/2020|
|Added Address Geocoding|4/12/2021|

## Next Steps

You've learned how to add Checkout to your experience. Here are some related topics.

- [Wishlist](/doc/commerce/checkout/use-wishlists.html)
- [Cart & Cart Review](/doc/commerce/checkout/use-carts.html)
- [Fulfillment Offerings](/doc/commerce/checkout/use-fulfillment-offerings.html)
- [Payment](/doc/commerce/payment/use-payment.html)
- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)
- [Supported Countries & Currencies](/doc/commerce/checkout/checkout-country-currency.html)