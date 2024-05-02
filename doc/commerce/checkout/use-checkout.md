---
id: use-checkout
category: b-use-case
position: 8
title: Checkout
url: /docs-portfolio/doc/commerce/checkout/use-checkout-backup.html
toc:
  - h2: Introduction
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#introduction
  - h2: Key Terms
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#key-terms
  - h2: Cart Reviews
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#cart-reviews
  - h2: Fulfillment Offerings
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#fulfillment-offerings
  - h2: Shipping Address Validation
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#shipping-address-validation
  - h2: Value-Added Services
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#value-added-services
  - h2: Checkout Preview
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#checkout-preview
  - h2: Checkout Submit
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#checkout-submit
  - h2: API Quick Reference
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#api-quick-reference
  - h2: Best Practices
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#best-practices
  - h2: Troubleshooting
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#troubleshooting
  - h2: Terms of Service
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#terms-of-service
  - h2: Contacting the Team
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#contacting-the-team
  - h2: Document Change Log
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#document-change-log
  - h2: Next Steps
    url: /docs-portfolio/doc/commerce/checkout/use-checkout.html#next-steps
---

##### Last Updated: 05/01/2024

Manage the Checkout process for the consumer.

> **TIPS**:
>- Before using this guide, read [Using APIs](/docs-portfolio/doc/getting-started/using-apis.html) and
   [Cart & Checkout Overview](/docs-portfolio/doc/commerce/checkout/overview-checkout.html).
>- Use this Developer's Guide to supplement the API Reference with detailed use cases.
   See [API Quick Reference](#api-quick-reference) for links to all the API Reference docs discussed in this guide.
>- The steps involving **Payment** are covered in
   [Adding Payment to Your Experience](/docs-portfolio/doc/commerce/payment/use-payment.html)

## Introduction

In this guide, you'll learn how to add checkout to your experience.

### What is a Checkout?

A checkout represents a consumer's intent to complete a purchase
and includes information necessary for the fulfillment of an order.

A checkout includes **all the information from a cart, plus the following**:

- Shipping addresses
- Fulfillment details including type, cost, and "get by" dates **(Checkout V3 only)**
- Payment methods
- Billing addresses
- Taxes

### Which Version of Checkout Should I Use?

The shopping experience involves several APIs.
To support the latest features, sometimes certain API versions must be used together.
See [Which API Version Should I Use](/docs-portfolio/doc/commerce/checkout/overview-checkout.html#which-api-version-should-i-use)
in the **Cart & Checkout Overview** for more information on the Checkout version you need.

## Key Terms

Listed below are some terms important to understanding checkout.

###### Table 1: Key Terms for Checkout

| Term                                                          | Definition                                                                                                                                                    |
|---------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **Cart**                                                      | The virtual shopping cart used by consumers to collect and compare items for purchase                                                                         |
| **Checkout**                                                  | A collection of data, including cart data, describing what may become a consumer order                                                                        |
| **Fapiao**                                                    | Tax-related invoice offered to China consumers only                                                                                                           |
| <a id="legacy-def"></a>**Legacy fulfillment flow**            | Checkout flow supporting ship to consumer address and digital delivery only                                                                                   |
| <a id="omni-channel-def"></a>**Omnichannel fulfillment flow** | Checkout flow supporting ship to consumer address, digital delivery, Buy-Online-Pickup-in-Store (BOPIS), pickup at third party location, and Instant Checkout |
| **SMS**                                                       | Short Message Service used to send text messages to mobile phones                                                                                             |
| **Source-aware**                                              | Using consumer location and other factors to offer the best options of when, where, and how to receive products                                               |
| **VAS (Value-Added Service)**                                 | Additional services that can be applied to items like gift wrap and/or gift messages                                                                          |

## Cart Reviews

Use the Cart Reviews V2 API to show the consumer a summary of their cart as an initial step in the checkout,
or alternatively, as an intermediate step between cart and checkout.

The cart summary includes updated subtotals of all cart items, taxes, estimated delivery/pick-up dates and costs.

Cart Reviews V2 is used in
the [omnichannel](/docs-portfolio/doc/commerce/checkout/overview-checkout.html#which-api-version-should-i-use) shopping flow.
It supports [fulfillment offerings](/docs-portfolio/doc/commerce/checkout/use-fulfillment-offerings.html), including
Buy-Online-Pickup-In-Store (BOPIS).

### Step 1: Request a Cart Review

Execute a PUT request
to
the [Create a Job]()
endpoint with a complete cart,
passing the **country**, **currency**,
and **fulfillmentDetails**
for each item returned from [fulfillment offerings](/docs-portfolio/doc/commerce/checkout/use-fulfillment-offerings.html)
associated with the consumer.
The `id` path parameter is a client-generated UUID.

> **NOTE**: Cart Reviews V2 operates asynchronously.
> This means that after you execute the initial request, you call
> another endpoint to get the result.
> See [Using APIs](/docs-portfolio/doc/getting-started/using-apis.html#asynchronous-operation) for more details.

Sample [Create a Job]()
PUT request URI:

```
https://api.domain.com/buy/cart_reviews/v2/52bc115b-16e5-43b5-bcaf-dd6168c543g9
```

After
calling [Create a Job]()
and receiving an HTTP 202 response,
execute a GET request
to [Retrieve a Job Result]()
using the same Cart Reviews ID to check the status of your job.

To know if the job is done, check the value of the status field in the response body as follows:

- `"status"`: `"PENDING"`: job processing has not started

- `"status"`: `"IN_PROGRESS"`: job processing is in progress

- `"status": "COMPLETED"`: job has completed

Once you receive a job status of `COMPLETED`, get the results of your job by parsing the data in the response object.

Sample [Retrieve a Job Result]()
GET request:

```
https://api.domain.com/buy/cart_reviews/v2/52bc115b-16e5-43b5-bcaf-dd6168c543g9
```

A successful 200 response in the `COMPLETED` state contains `currency`, `locale` and `fulfillmentGroups` information.

## Fulfillment Offerings

<i class="g72-check"></i>&nbsp;&nbsp;**Get available shipping and pickup locations, costs, and delivery/pickup dates**

> **TIP:** Fulfillment Offerings is for the [omnichannel](#omni-channel-def) fulfillment flow only

The [Fulfillment Offerings API]()
provides consumers more flexibility in choosing how, when,
and where to get products based on consumer location, availability, and several other factors.
They may be able to choose to have their items digitally delivered,
shipped to an address of their choice, pick up at a retail store, or pick up at a third-party location.
A user experience
driven by the Fulfillment Offerings API helps the consumer make those decisions by providing the cost of each offering
and "get by"
dates that predict when the consumer can get the product.

See [Adding Fulfillment Offerings To Your Experience](/docs-portfolio/doc/commerce/checkout/use-fulfillment-offerings.html) for more
information.

## Shipping Address Validation

After the consumer selects
or provides a personal shipping address through either the Shipping Options or Fulfillment Offerings,
validate the address with the Address Validation API.
See the [Address Validation](/docs-portfolio/doc/commerce/checkout/use-address.html#address-validation) section of the **Address Tools
** guide for more information.

## Value-Added Services

The consumer can choose to add optional **value-added services
(VAS)** like **gift wrap** or **gift messages** to specific items in a checkout.
In your app, you can create these VAS instructions
using the [Gift Wrap](#gift-wrap) and [Gift Messages](#gift-messages) APIs.
These APIs allow you to:

- Validate that the VAS is approved to be added to the particular item (`skuid`) in a checkout
- Later successfully submit that checkout with VAS using other Checkout APIs

### Gift Wrap

To add a gift wrap VAS instruction to a `skuId` in a checkout, follow these steps:

1. Execute a request to
   the [Gift Wrap PUT endpoint]()
   with a `valueAddedServiceId` (always `cffd7c09-f634-b6ed-339e-081089c2b2b8`),`skuId`,
   and `country` to create the VAS instruction.

   The `id` path parameter is a client-generated UUID.

2. If the API successfully creates the gift wrap VAS instruction for that `skuId`, it returns a 201 response.

3. (Optional) Get a gift wrap VAS instruction by its ID from
   the [Gift Wrap GET endpoint]().

4. Include the VAS instructions when you submit the checkout.
   This ensures that all necessary fees and taxes are added to the checkout,
   and that the VAS instructions can be carried out during order fulfillment.

### Gift Messages

To add a gift message VAS instruction to a `skuId` in a checkout, follow these steps:

1. Execute a request to
   the [Gift Message
   PUT endpoint]()
   with a `valueAddedServiceId` (always `d6046ee3-ab06-46d0-a38d-e71e7710dcd9`),`skuId`,
   and the `giftMessage` (string entered by the consumer) to create the VAS instruction.

   The `id` path parameter is a client-generated UUID.

   The `country`, `locale`, and `language` are also required in the request body.

2. If the API successfully creates the gift message VAS instruction for that `skuId`, it returns a 201 response.

3. (Optional) Get a gift message VAS instruction by its ID from
   the [Gift Message GET endpoint]().

4. Include the VAS instructions when you submit the checkout.
   This ensures that all necessary fees and taxes are added to the checkout,
   and that the VAS instructions can be carried out during order fulfillment.

## Checkout Preview

<i class="g72-check"></i>&nbsp;&nbsp;**Validate a checkout for fulfillment**

Next, let's make sure that the checkout details are accurate and that the process can proceed to the payment steps.

### Can I Skip This?

It is not required
to [Request a Checkout Preview]()
in order for the consumer to complete their purchase.
However,
calling the endpoint
to validate the order and payment details one last time increases the consumer's chance of a successful checkout.

You can use the details in a successful response to display the final payment amount to the consumer.
Once the consumer confirms the payment method details and places the order, there will be a better chance of success.

Checkout Preview V3 is used in [omnichannel](#omni-channel-def) shopping flow, and supports fulfillment offerings,
including Buy-Online-Pickup-In-Store (BOPIS) and SMS (China only).

> **NOTE**: Checkout Preview (and Checkout Submit in the next steps) operates asynchronously.
> This means that after you
> execute the initial request, you call another endpoint to get the result.
> See [Using APIs](/docs-portfolio/doc/getting-started/using-apis.html#asynchronous-operation) for more details.

### Step 1: Request Checkout Preview

Execute a PUT request to
the [Request Checkout Preview]()
endpoint,
passing the complete cart
and `fulfillmentDetails` returned from [fulfillment offerings](/docs-portfolio/doc/commerce/checkout/use-fulfillment-offerings.html)
for each item.

The API ensures that the products and fulfillment details for each item are valid based on pricing,
availability, and other factors.
You can also get product pricing, sales tax, fulfillment fees and tax,
"get by" dates, and checkout subtotals in the response.

#### SMS Checkout Preview (China Only)

SMS Checkout Preview allows both members and guests
to purchase products using a mobile phone number instead of an email address.
If the consumer is purchasing with an email address, you can skip this section.

> **Note**: SMS checkout is currently available in China only

**Member SMS Checkout Preview Requests**

In addition to the usual Checkout Preview request values, these are SMS-specific:

- Send the value '**SMS_ACCOUNT**' in `phoneNumber.type`
- Send the SMS phone number from the consumer's profile in`phoneNumber.subscriberNumber`, 1–13 digits
- Send the country code in`phoneNumber.countryCode`, 1–3 digits
- Send the member's profile ID in `phoneNumber.accountId`
- Do not send `email`

**Guest SMS Checkout Preview Requests**

Checkout Preview for guest SMS consumers requires a few extra steps to check that the SMS phone number is valid.

1. Send consumer a verification code to the SMS phone number they provide

   After capturing the guest consumer's phone number in your app or experience,
   call the [Identity Initiation]() endpoint
   at /identity/verify/contact_channel/initiation/v1.
   Send the guest consumer's SMS phone number in `contactChannel`.
   A successful 204 response sends the identity-generated verification code to the consumer at the SMS phone number
   provided.

2. The consumer submits the verification code

   Your app or experience provides a UI into which the consumer enters and submits the verification code from Step 1.

3. Get the validation token

   Once your UI captures the verification code,
   call the [Identity Completion]() endpoint
   at /identity/verify/contact_channel/completion/v1,
   sending:

    - SMS phone number in `contactChannel`
    - Verification code from Step 2 in `verificationCode`

   A successful 200 response returns a `validationToken` and `validationTimestamp`.

4. Call the Checkout Preview endpoint

   In addition to the usual Checkout Preview request values, these are SMS-specific:

    - Send the value '**SMS_VERIFY**' in `phoneNumber.type`
    - Send the SMS phone number in `phoneNumber.subscriberNumber`, 1–13 digits
    - Send the country code in `phoneNumber.countryCode`, 1–3 digits
    - Send the `validationToken` from Step 3 in `phoneNumber.verifyId`
    - Do not send `email`

> **Note**: Checkout Preview requests with both a `phoneNumber.subscriberNumber` and `email` will be rejected.

Sample
V3 [Request Checkout Preview]()
PUT request URI:

```
https://api.domain.com//buy/checkout_previews/v3/89rc115b-16e5-43b5-bcaf-dd6168c543u4
```

### Step 2: Retrieve Checkout Preview Job

After calling **Request a Checkout Preview** and receiving an HTTP 202 response,
execute a request to **Retrieve Checkout Preview Job**
using the same checkout ID to check the status of your job.

To know if the job is done, check the value of the **status** field in the response body as follows:

- `"status": "PENDING"`: job processing has not started
- `"status": "IN_PROGRESS"`: job processing is in progress
- `"status": "COMPLETED"`: job has completed

Once you receive a job status of COMPLETED, get the results of your job by parsing the data in the **response** object.

Sample
V3 [Retrieve Checkout Preview Job]()
request URI:

```
https://api.domain.com/buy/checkout_previews_jobs/v3/89rc115b-16e5-43b5-bcaf-dd6168c543u4
```

## Checkout Submit

<i class="g72-check"></i>&nbsp;&nbsp;**Submit a checkout for fulfillment**

Checkout Submit performs the final validations of the consumer's information,
requests payment authorization, and if everything succeeds, submits the checkout for fulfillment.

Checkout V3 is used in the [omnichannel](#omni-channel-def) shopping flow, and supports fulfillment offerings, including
Buy-Online-Pickup-In-Store (BOPIS).

### Step 1: Request Checkout Submit

Execute a PUT request to the **Request a Checkout Submit** endpoint,
passing the complete cart
and `fulfillmentDetails` returned from [fulfillment offerings](/docs-portfolio/doc/commerce/checkout/use-fulfillment-offerings.html)
for each item.

**SMS Checkout Submit (China Only)**

SMS Checkout Submit allows both members and guests
to purchase products using a mobile phone number instead of an email address.
If the consumer is purchasing with an email address, you can skip this section.

> **Note**: SMS checkout is currently available in China only

Follow the steps in [SMS Checkout Preview (China Only)](#sms-checkout-preview-china-only) to implement SMS Checkout
Submit in your app or experience.

Sample [Request Checkout Submit]()
PUT request URI:

```
https://api.domain.com/buy/checkouts/v3/61bc115b-16e5-43b5-bcaf-dd6168c543f8
```

> **TIPS:**
>- You must have previously called the Payment Preview API to collect the required payment information, most notably the
   mandatory Payment Preview **id**.
   See the [Adding Payment to Your Experience](/docs-portfolio/doc/commerce/payment/use-payment.html)
   for more info.
>- Optionally, for Japan only, send `GIFT_RECEIPT` in the **invoiceInfo** block, which prevents prices from being
   printed on the packing slip that is included with the product shipment.
>- Optionally, for China only, send `ELECTRONIC_FAPIAO` in **invoiceInfo** for Fapiao, which is a special tax invoice.
   If the consumer indicates a preference for Fapiao, they can enter a personal message to be used as a title for the
   invoice.
   For example:

```
"invoiceInfo": {
    "type": "ELECTRONIC_FAPIAO",
    "detail": "The consumer's personal title for the invoice"
}
```

### Step 2: Retrieve Checkout Submit Job

After calling the **Request Checkout Submit** endpoint and receiving an HTTP 202 response,
execute a request to
**Retrieve Checkout Submit Job** using the same checkout ID to check the status of your job.

The same job statuses apply to this endpoint as
for [Retrieve Checkout Preview Job](#step-2-retrieve-checkout-preview-job).
Once you observe a job status of COMPLETED, get the results of your job by parsing the data in the **response** object.

Sample
V3 [Retrieve Checkout Submit Job]()
GET request URI:

```
https://api.domain.com/buy/checkouts/v3/jobs/61bc115b-16e5-43b5-bcaf-dd6168c543f8
```

## API Quick Reference

**Cart Reviews**

V2:

- [Create a Job]()
- [Retrieve a Job Result]()

**Checkouts**

- Request Checkout
  Preview [V3]()
- Retrieve Checkout Preview
  Job [V3]()
- Request Checkout
  Submit [V3]()
- Retrieve Checkout Submit
  Job [V3]()
- Request Checkout Submit (
  Launch) [V2]()

## Best Practices

Here are some practices to consider adopting.

### User Types

The Checkout API supports three distinct user types:

- Member: user has logged in with their account credentials
- Guest: user has not logged in (anonymous user)
- Employee: user is an employee and has logged in with employee credentials

Depending on user type, certain aspects of the calls that you make to the Checkout API might need to be modified.
Also, consider that not all user types might apply to your app.
For example, your app might only support Members.

See the User Types section of the [Using APIs](/docs-portfolio/doc/getting-started/using-apis.html#user-types) guide for more
information.

### Request Headers

The following request headers are common to all the Cart & Checkout APIs:

###### Table 4: Common Request Headers for Checkout APIs

| Header Name       | Description                                                                                                    | Member | Guest | Employee |
|-------------------|----------------------------------------------------------------------------------------------------------------|--------|-------|----------|
| **Accept**        | Content type you will accept in response, application/json is only value allowed                               | X      | X     | X        |
| **Content-Type**  | Content type of the request, application/json is only value allowed                                            | X      | X     | X        |
| **Authorization** | Your access token in the format of `Bearer {token}` indicating the consumer is logged in                       | X      |       | X        |
| **x-visitorid**   | ID for the guest (i.e. not logged-in) consumer, validated by the Edge router and passed through to the service |        | X     |          |

> **TIP:** For the Authorization header, use the token for the consumer's login session that you obtained
> from [accounts.domain.com]()
> or [Unite/Identity](), prefixed
> by **Bearer ** (note the single space after Bearer).
> This is necessary to verify that you are authorized to
> perform the requested operation on behalf of the consumer.
### Idempotence

[Idempotence](https://restcookbook.com/HTTP%20Methods/idempotency/) means that the result of a
successful request is independent of the number of times it is executed.
What does that mean for the Checkout API?
Each PUT request to **Request a Checkout Preview** and **Request Checkout Submit** includes 1) a
client-generated UUID (checkout ID) in the URL and 2) an Entity in the request body.
There are four possible scenarios:

###### Table 5: Scenarios Illustrating Idempotence Behavior for Checkout Requests

| Scenario                                                    | Result                                                                                         |
|-------------------------------------------------------------|------------------------------------------------------------------------------------------------|
| UUID and Entity are new to the system (base use case)       | Client receives HTTP 202 response, request processed as new job                                |
| UUID and Entity match a prior request                       | Client receives the exact same HTTP 202 response from the prior request (no new job processed) |
| UUID used previously, Entity is new                         | Client receives HTTP 409 error response (no new job processed)                                 |
| UUID is new, Entity previously submitted under another UUID | Client receives HTTP 202 response, request processed as new job                                |

> **TIP:** For more, see the Idempotence Guarantee section of
> the [Using APIs](/docs-portfolio/doc/getting-started/using-apis.html#idempotence-guarantee) guide.

### Conditions for Retries

For retry information by Checkout endpoint,
visit [Retry Patterns for Checkout Clients]()
in Confluence.

For all Checkout APIs,
the general rule is that HTTP 4XX error codes (except for 429) should not be retried,
but HTTP 5XX errors can be retried.
For general information on error retry practices,
see [API Error Patterns]().

### Honor the ETAs for Best Performance

For async endpoints that return an ETA, that is the estimated time for the job to be completed,
it is important for your app to honor the ETA for the best performance.
For example, if the ETA is 2000 ms,
your app should wait 2000 ms
to start polling the /jobs endpoint to avoid consuming network and other resources unnecessarily.

### Test Scenarios

Here is an example list of test scenarios for a consumer experience that is integrated with the Checkout API.

- Single Product (non-customizable only) - Single Payment (Credit Card)
- Single Product (non-customizable only) - Single Payment (Gift Card)
- Single Product (non-customizable only) - Single Payment (PayPal)
- Multiple Products (non-customizable only) - Single Payment (Credit Card)
- Single Product (customizable only) - Single Payment (Credit Card)
- Single Product (customizable only) - Single Payment (PayPal)
- Single Product (non-customizable only) - Multiple Payment (Credit Card & Gift Card)
- Single Product (customizable only) - Multiple Payment (Credit Card & Gift Card)
- Multiple Products (customizable only) - Single Payment (Credit Card)
- Mixed Products (customizable & non-customizable) - Single Payment (Credit Card)\
- Mixed Products (customizable & non-customizable) - Single Payment (PayPal)
- Mixed Products (customizable & non-customizable) - Multiple Payment (Credit Card & Gift Card)

> **TIPS:**
>- While inspecting browser activity, you can change your shopping country with the flag icon at
   the upper right of the homepage.
>- You can place an order to observe all the checkout calls.
   Orders can be canceled via self-service within 30 minutes
   of submission, otherwise contact Consumer Services.

### Test Environment

Test low-volume requests using production Checkout endpoints rather test environment endpoints.
Test environment endpoint responses can be unpredictable due to the many downstream services these endpoints rely on
to simulate typical 'production-like' responses.

Keep in mind the following:

- Performance tests at high volumes should never be done in production
- Calling **Request a Checkout Submit** in production can result in actual orders being sent for fulfillment, and
  actual payment methods being authorized and/or charged.
  Proceed with caution

### Caching Data

None of the endpoints described in this document support caching.

### Error Handling: Which JSON Field Had The Error?

In error responses from APIs,
we use the [JSON Pointer](https://tools.ietf.org/html/rfc6901) standard to indicate which field of the request
JSON had the error.

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

- Use the general troubleshooting tips in
  the [Using APIs](/docs-portfolio/doc/getting-started/using-apis.html#troubleshooting) guide.
- Use a Splunk query (requires access) to check for issues with your request.
- Contact the Buy team on the [#order-integration]() Slack channel
  for assistance.

### Common Questions

**Is it okay to call Checkout APIs if my app is hosted in an Amazon Web Services VPC?**

Yes.
The APIs are exposed publicly, so it should not matter where you are calling from.
If you are calling repeatedly from a small set of IP addresses,
it might be possible that bot-mitigation tools could interfere with your ability to make calls.
If you are having issues, reach out to us for help.

**Why does my Checkout Submit job sometimes take a long time to complete?**

Checkout Submits initiate a lot of behind-the-scenes API calls, the duration of which is somewhat unpredictable.
Depending on the total volume of requests happening at the time your request was submitted,
combined with the payment method and shipping country selected by the consumer,
it may take several seconds to get a completed job.
The best case is about 5 seconds, while the worst case can be well over a minute.
If the job times out, you will get a 'completed with error' job status.

## Terms of Service

It is recommended
that you send a caller ID header in every request to this API to help troubleshoot unexpected responses.
See the Registration section of the [Using APIs](/docs-portfolio/doc/getting-started/using-apis.html#registration) guide
on how to create and register your caller ID.

### Authentication

#### Access Tokens

Most calls through the API gateway (api.domain.com) require an access token to be sent in the request header.
This allows us to verify that your app is authorized to perform the action on behalf of the consumer.
Access tokens are obtained by calling [accounts.domain.com]()
or [Unite/Identity]() prior to
calling the API which you ultimately want to reach.

See [Authorization](/docs-portfolio/doc/getting-started/using-apis.html#authorization) for more information
on how to call accounts.domain.com and Unite/Identity services.

#### JSON Web Token

Only one Buy API endpoint requires the additional authorization of a JSON Web Token (JWT), **Checkout Submit (Launch)**.
For more information,
see the JWT section of [Using APIs](/docs-portfolio/doc/getting-started/using-apis.html#authorization).

## Contacting the Team

Need to contact the Buy team?

|Slack|[#order-integration]()|
|Confluence|[Buy Domain]()|

## Document Change Log

| Summary            | Date       |
|--------------------|------------|
| Initial publish    | 05/01/2024 |

## Next Steps

You've learned how to add Checkout to your experience. Here are some related topics.

- [Fulfillment Offerings](/docs-portfolio/doc/commerce/checkout/use-fulfillment-offerings.html)
- [Using APIs](/docs-portfolio/doc/getting-started/using-apis.html)
- [Glossary](/docs-portfolio/doc/commerce/reference/glossary.html)