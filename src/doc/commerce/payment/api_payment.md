---
tags: pdf
category: use-case
position: 6
title: Payment
url: /commerce/payment/api_payment.html
toc:
  - h2: API at a Glance
    url: /doc/commerce/payment/api_payment.html#api-at-a-glance
  - h2: Terms of Service
    url: /doc/commerce/payment/api_payment.html#terms-of-service
  - h2: Use Cases
    url: /doc/commerce/payment/api_payment.html#use-cases
  - h2: Endpoint Quick Reference
    url: /doc/commerce/payment/api_payment.html#api-endpoint-quick-reference
  - h2: Caching Data
    url: /doc/commerce/payment/api_payment.html#caching-data
  - h2: Making Your First Request
    url: /doc/commerce/payment/api_payment.html#making-your-first-api-request
  - h2: Using Payment Options
    url: /doc/commerce/payment/api_payment.html#using-payment-options
  - h2: Using Stored Payment
    url: /doc/commerce/payment/api_payment.html#using-stored-payment
  - h2: Using Payment Preview
    url: /doc/commerce/payment/api_payment.html#using-payment-preview
  - h2: Using Payment Approval
    url: /doc/commerce/payment/api_payment.html#using-payment-approval
  - h2: Using Credit Card Submit
    url: /doc/commerce/payment/api_payment.html#using-credit-card-submit
  - h2: Using Payment Apple Pay
    url: /doc/commerce/payment/api_payment.html#using-apple-pay
  - h2: Using Payment Wallet
    url: /doc/commerce/payment/api_payment.html#using-payment-wallet
  - h2: Using Deferred Payment
    url: /doc/commerce/payment/api_payment.html#using-deferred-payment
  - h2: Upgrading to the Latest Version
    url: /doc/commerce/payment/api_payment.html#upgrading-to-the-latest-version
  - h2: Best Practices
    url: /doc/commerce/payment/api_payment.html#best-practices
  - h2: Troubleshooting
    url: /doc/commerce/payment/api_payment.html#troubleshooting
  - h2: Glossary
    url: /doc/commerce/payment/api_payment.html#glossary
---

# PAYMENT DOMAIN <i class="g72-swoosh"></i><br>DEVELOPER'S GUIDE

##### Last Updated: 10/01/2018

---

Use the Payment API to allow customers to pay for Nike products.

If you've read [Using NDe APIs](/doc/getting-started/using_nike_apis.html) and [Payment Overview](/doc/commerce/payment/overview-payment.html), this guide provides the details necessary to integrate with the Nike Payment APIs.

## <a name="api-at-a-glance"></a>API at a Glance

|Topic|Details|
|---|---|
|Use this API to|List payment options<br>Save payment methods<br>Initiate a PayPal Billing Agreement<br>Initiate an ApplePay payment<br>Allocate payment amount across payment types<br>Validate and authorize payment|
|Who calls this API|SNKRS app (Web/iOS/Android), Nike app (iOS/Android), Nike.com|
|Version|Payment ApplePay v2<br>Payment Approval v2<br>Payment Credit Card Submit v1<br>Payment Deferred Payment v1<br>Payment Options v2<br>Payment Preview v2<br>Stored Payment v1<br>Payment Wallet v1|
|SLA response time (rt) and requests per second (rps)|Payment Applepay rt: 350ms rps:40<br>Payment Approval rt: 250ms rps: 200<br>Payment Credit Card Submit ?ms<br>Payment Deferred Payment ?ms<br>Payment Options rt: 250ms rps:700<br>Payment Preview rt: 250ms rps:300<br>Stored Payment ?ms<br>Payment Wallet rt: 300ms rps: 200|
|Domain|Commerce|
|Prerequisites|[API Registration](/doc/getting-started/using_nike_apis.html#registration)|
|Contact Info|Slack #cic-payment<br>Confluence space: <a href="https://confluence.nike.com/display/PHYLON/Payment+Team+Playbook" target="_blank">CiC Payment</a><br><a name="product-owner"></a>Product Owner: [Sree Krishna](mailto:sree.krishna@nike.com)|

>**TIP:** SLAs vary per endpoint for the Payment APIs. In the figures listed above, the highest response time and lowest requests per second *for the API overall* were shown.

<br>

![](/images/commerce/payment/payment_flow.png)

## <a name="terms-of-service"></a>Terms of Service

It is recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#registration) guide on how to create and register your caller ID.

### <a name="authentication"></a>Authentication

#### Access Tokens

Most calls through the Nike API gateway (api.nike.com) require an access token be sent in the request header. This allows Nike to verify that your app is authorized to perform the action on behalf of the user.

Access tokens are obtained by calling Nike Unite services prior to calling the API which you ultimately want to reach.

To find out more on how to call Unite services to obtain access tokens, see the Authorization section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#authorization) guide.

#### JSON Web Token

A few of the endpoints in the Payment APIs require the additional authorization of a JSON Web Token (JWT). For more, see the JWT section of [Using NDe APIs](/doc/getting-started/using_nike_apis.html#jwt-json-web-token).

## <a name="use-cases"></a>Use Cases

|I want to...|API(s) to use|
|---|---|
|List payment options<br>List billing countries based on shipping country|Payment Options Service|
|List a customer's stored payments<br>Update a customer's Credit Card information<br>Add or delete a customer's stored payment<br>Change a customer's default payment method|Stored Payment Service|
|Allocate amount owed across payment types|Payment Preview Service|
|Validate and authorize payment|Payment Approval Service|
|Store and retrieve Credit Card information|Credit Card Submit Service|
|Pay by Apple Pay|Payment ApplePay Service|
|Pay by PayPal|Payment Wallet Service|
|Pay by a deferred payment method where payment is made after the order is placed|Deferred Payment Service|

### <a name="example-implementations"></a>Example Implementations

Payment API flows vary based on the payment method and the user experience. Listed below are a few examples of Payment API usage.

**Sample Credit Card Payment Flow**

In this Payment flow, the customer chooses to pay by Credit Card that is saved as a stored payment method. The customer must provide the CVV for validation because the shipping address passed into the call is either new or different from previous shipping addresses on past orders.

![Image](/images/commerce/payment/creditcard_seq_dgm.png)

**Sample PayPal Express flow**

In this flow, the customer is redirected to the PayPal site after choosing to pay by PayPal Express in the Nike experience. The customer selects the shipping and billing addresses on the PayPal site. Based on the PayPal token, the Payment Wallet service returns the shipping and billing addresses from PayPal for display on the order confirmation.

![Image](/images/commerce/payment/paypal_express_seq_dgm.png)

**Sample PayPal Mark flow**

In this flow, the customer chooses to pay by PayPal Mark and provides the shipping address in the Nike experience. From order review, the customer is redirected to the PayPal site to select the billing address and pay. Based on the PayPal token, the Payment Wallet service returns the shipping and billing addresses from PayPal for display on the order confirmation.

![Image](/images/commerce/payment/paypal_mark_seq_dgm.png)

**Sample Apple Pay flow**

In the example Payment API flow below, the customer chooses to pay by Apple Pay in a Safari web browser.

![Image](/images/commerce/payment/applepay_seq_dgm.png)

**Sample Deferred Payment flow**

In this flow, the customer chooses to pay by a payment method that will be authorized and captured after the Nike order has been placed. This is a typical flow for China payment methods such as WeChat and Alipay.

![Image](/images/commerce/payment/deferred_pmt_seq_dgm.png)

## <a name="api-endpoint-quick-reference"></a>API Endpoint Quick Reference

For source code, visit the <a href="https://bitbucket.nike.com/projects/PHYLPAY" target="_blank">PHYLON Payment Repository</a>.

### PAYMENT APPLEPAY

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|<a href="https://developer.niketech.com/docs/projects/Payment%20ApplePay?tab=api" target="_blank">START APPLE PAY SESSION</a>|/payment/applepay_sessions/v2/|POST|

### PAYMENT APPROVAL

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Approval?tab=api" target="_blank">SUBMIT ORDER PAYMENTS FOR APPROVAL</a>|/payment/approval/v2/|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Approval?tab=api" target="_blank">SUBMIT ORDER PAYMENTS FOR APPROVAL</a>|/payment/approval/v2/{id}|PUT|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Approval?tab=api" target="_blank">RETRIEVE PAYMENT APPROVAL JOB</a>|/payment/approval/v2/jobs/{id}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Approval?tab=api" target="_blank">ORDER PAYMENTS APPROVAL RESULT</a>|/payment/approval_results/v2/{id}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Approval?tab=api" target="_blank">VOID PAYMENT APPROVAL</a>|/payment/approval_results/v2/|DELETE|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Approval?tab=api" target="_blank">GET PAYMENT APPROVAL SUMMARY</a>|/payment/approval_summary/v1/{id}|GET|

### PAYMENT CREDIT CARD SUBMIT

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Credit%20Card%20Submit?tab=api" target="_blank">GET CREDIT CARD INFO WITH CVV</a>|/services/{id}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Credit%20Card%20Submit?tab=api" target="_blank">GET CREDIT CARD INFO WITHOUT CVV</a>|/services/add{?id, language}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Credit%20Card%20Submit?tab=api" target="_blank">GET CVV</a>|/services/cvv{?id}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Credit%20Card%20Submit?tab=api" target="_blank">GET EXPIRY DATE AND CVV</a>|/services/expcvv{?id}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Credit%20Card%20Submit?tab=api" target="_blank">VALIDATE CREDIT CARD PERSISTENCE</a>|/creditcardsubmit/{id}/isValid{?mode}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Credit%20Card%20Submit?tab=api" target="_blank">STORE CREDIT CARD INFO</a>|/creditcardsubmit/{id}/store|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Credit%20Card%20Submit?tab=api" target="_blank">GET CREDIT CARD INFO BY ID</a>|/creditcardsubmit/{id}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Credit%20Card%20Submit?tab=api" target="_blank">VALIDATE CREDIT CARD PERSISTENCE BY ID AND MODE</a>|/creditcardsubmit/{id}/isValidDate{?mode}|GET|

### PAYMENT DEFERRED PAYMENT

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Deferred%20Payment?tab=api" target="_blank">DEFERRED PAYMENT FOR WECHAT WITH CODE REQUIRED</a>|/payment/deferred_wechat_payments/v1|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Deferred%20Payment?tab=api" target="_blank">GET DEFERRED PAYMENT WECHAT JOB STATUS BY ID</a>|/payment/deferred_wechat_payments/v1/jobs/{id}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Deferred%20Payment?tab=api" target="_blank">DEFERRED PAYMENT FORM</a>|/payment/deferred_payment_forms/v1|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Deferred%20Payment?tab=api" target="_blank">DEFERRED PAYMENT FORM JOB STATUS BY ID</a>|/payment/deferred_payment_forms/v1/jobs/{id}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Deferred%20Payment?tab=api" target="_blank">DEFERRED PAYMENT STATUS</a>|/payment/deferred_payment_status/v1|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Deferred%20Payment?tab=api" target="_blank">DEFERRED PAYMENT STATUS JOB STATUS BY ID</a>|/payment/deferred_payment_status/v1/jobs/{id}|GET|

### PAYMENT OPTIONS

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Options?tab=api" target="_blank">GET PAYMENT OPTIONS FOR AN ORDER</a>|/payment/options/v2|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Options?tab=api" target="_blank">ALLOWABLE BILLING COUNTRIES FOR A SHIPPING COUNTRY</a>|/payment/options/v2/{shippingCountry}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Options?tab=api" target="_blank">VALIDATE PAYMENTS</a>|/payment/validate_payments/v2|POST|

### PAYMENT PREVIEW

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Preview?tab=api" target="_blank">PAYMENT PREVIEW</a>|/payment/preview/v2|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Preview?tab=api" target="_blank">PAYMENT PREVIEW RESULT BY ID</a>|/payment/preview_results/v2/{id}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Preview?tab=api" target="_blank">PAYMENT PREVIEW JOB STATUS BY ID</a>|/payment/preview/v2/jobs/{id}|GET|

### STORED PAYMENT

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Stored%20Payments?tab=api" target="_blank">INITIATE PAYPAL BILLING AGREEMENT</a>|/consumer/paypalagreement|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Stored%20Payments?tab=api" target="_blank">SAVE PAYMENT BY USER PROFILE</a>|/consumer/savepayment|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Stored%20Payments?tab=api" target="_blank">DELETE STORED PAYMENTS BY USER PROFILE</a>|/consumer/storedpayments|DELETE|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Stored%20Payments?tab=api" target="_blank">FETCH STORED PAYMENTS BY USER PROFILE</a>|/consumer/storedpayments|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Stored%20Payments?tab=api" target="_blank">UPDATE CREDIT CARD DETAILS</a>|/consumer/storedpayments/{payment_id}|PUT|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Stored%20Payments?tab=api" target="_blank">DELETE PAYMENT BY ID</a>|/consumer/storedpayments/{payment_id}|DELETE|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Stored%20Payments?tab=api" target="_blank">FETCH STORED PAYMENT BY ID</a>|/consumer/storedpayments/{payment_id}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Stored%20Payments?tab=api" target="_blank">VALIDATE CVV FOR SHIPPING ADDRESS</a>|/consumer/storedpayments/{payment_id}|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Stored%20Payments?tab=api" target="_blank">FETCH GIFT CARD BY ID</a>|/consumer/storedpayments/giftcard/{payment_id}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Stored%20Payments?tab=api" target="_blank">CREATE/UPDATE ATG PAYMENT</a>|/consumer/storedpayments/synch|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Stored%20Payments?tab=api" target="_blank">DELETE ATG PAYMENT</a>|/consumer/storedpayments/synch/{payment_token}|DELETE|

### PAYMENT WALLET

|Endpoint Name|Path|HTTP Method|
|---|---|---|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Wallet?tab=api" target="_blank">PAYPAL DETAILS</a>|/payment/paypal_details/v1|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Wallet?tab=api" target="_blank">PAYPAL DETAIL JOB STATUS BY ID</a>|/payment/paypal_details/v1/jobs/{id}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Wallet?tab=api" target="_blank">PAYPAL EXPRESS</a>|/payment/paypal_express/v1|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Wallet?tab=api" target="_blank">PAYPAL EXPRESS JOB STATUS BY ID</a>|/payment/paypal_express/v1/jobs/{v1}|GET|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Wallet?tab=api" target="_blank">PAYPAL MARK</a>|/payment/paypal_mark/v1|POST|
|<a href="https://developer.niketech.com/docs/projects/Payment%20Wallet?tab=api" target="_blank">PAYPAL MARK JOB STATUS BY ID</a>|/payment/paypal_mark/v1/jobs/{id}|GET|

## <a name="caching-data"></a>Caching Data

The Payment API makes use of data caching to optimize service SLAs. The first time data is fetched or when the cache expires, the Payment service makes a call to get the latest data and adds it to the cache.

The PaymentWallet, PaymentPreview, PaymentApproval and StoredPayments services handle gift card balances. Retrieving the balance of a gift card requires a call to a third-party gift card provider, which can slow down the Payment service's response, especially in high volume traffic. To avoid this scenario, the private gift card Service, which is responsible for retrieving gift card data and is called by the PaymentWallet, PaymentPreview, PaymentApproval and StoredPayments services, caches the gift card balance after retrieval. The cache time varies based on the balance. If the gift card has a positive balance, the gift card service caches the balance for 5 minutes; If the gift card has a 0 balance, the gift card service caches the balance for 30 minutes.

The PaymentOptions, PaymentWallet, PaymentPreview and PaymentApproval services use product and SKU data as part of validation. For performance reasons, these services cache product and SKU data for 30 minutes in order to reduce the amount of calls to the [Merchandised Products API](/doc/commerce/product/api_merch_product.html) to get the latest data.

## <a name="making-your-first-api-request"></a>Making Your First API request

For your first API request, send a POST request to the *Get Payment Options for an Order* endpoint of the Payment API to list the valid payment options for the country of Denmark with a Checkout total of 266.98 Euro.

**1. Gather Data Needed for the Request**

|Header Name|Header Value|
|---|---|
|Content-Type|application/json; charset=UTF-8|
|Accept|application/json; charset=UTF-8|
|Authorization|See the Authorization section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#authorization) guide on how to get this value|

|HTTP Method|Endpoint URI|
|---|---|
|POST|https://api.nike.com/payment/options/v2|

Body:
```
{ 
    "country": "DE", 
    "billingCountry": "DE", 
    "currency": "EUR", 
    "total": 266.98
}
```

**2. Execute the request**

Using the values gathered in step 1, here is the resulting cURL command:

```
curl -X POST --header 'Content-Type: application/json; charset=UTF-8' --header 'Accept: application/json' --header 'upmid: 14546445000' --header 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6ImU3OWQ4ZjU1LTExN2ItNGUxMy04OTU3LTc5YzQ2Y2FmNjY2ZHNpZyJ9.eyJpYXQiOjE1MDM0MjQ0MzQsImV4cCI6MTUwMzQyODAzNCwiaXNzIjoib2F1dGgyYWNjIiwianRpIjoiNGFhZDBiYzktOTE5YS00NjA1LTkzMzgtZGQ3NzkxYWRmYzExIiwibGF0IjoxNTAzNDI0NDM0LCJhdWQiOiJjb20ubmlrZS5kaWdpdGFsIiwic3ViIjoiY29tLm5pa2UuY29tbWVyY2Uub21lZ2EuZHJvaWQiLCJzYnQiOiJuaWtlOmFwcCIsIm9yZyI6InByb2QiLCJzY3AiOlsiY29tbWVyY2UiXSwicHJuIjoiMTIxNDY0NDQwODIiLCJwcnQiOiJuaWtlOnBsdXMifQ.WImaAMp22gsRzenNfdKz7AeOIUEezT7jD-9pBABK-eL337DwVQn-JFrjLksnI-0Pfnz2k_ncL_LSOvWyXijKHgOhsOv7wcvWa7mMsr4L5WmNN2apAeH_EIHhSFxM67dCy3uPYQg8SukhtUpaTN4aUghoqBuCR6fouWNq-REoUeLEbcY95KG7_gV3LA1viGgo4WA6GkDoFlYTX030wE3YLbPxDy3W_xRGsM6xIRwCJykJO0_FOjIHa1dOKxAvTq-zV2GWlBC8SeZNFOPVvM_bcoXuBek8PEqQEaRvi1Mt_5DwxgIyiLiM30xJz4auNLTtmryQ1B04CDYxIaJLyMYAhA' -d '{ \ 
               "country": "DE", \ 
               "billingCountry": "DE", \ 
               "currency": "EUR", \ 
               "total": 266.98 \ 
             }' 'https://api.nike.com/payment/options/v2?access_token=eyJhbGciOiJSUzI1NiIsImtpZCI6ImU3OWQ4ZjU1LTExN2ItNGUxMy04OTU3LTc5YzQ2Y2FmNjY2ZHNpZyJ9.eyJpYXQiOjE1MDM0MjQ0MzQsImV4cCI6MTUwMzQyODAzNCwiaXNzIjoib2F1dGgyYWNjIiwianRpIjoiNGFhZDBiYzktOTE5YS00NjA1LTkzMzgtZGQ3NzkxYWRmYzExIiwibGF0IjoxNTAzNDI0NDM0LCJhdWQiOiJjb20ubmlrZS5kaWdpdGFsIiwic3ViIjoiY29tLm5pa2UuY29tbWVyY2Uub21lZ2EuZHJvaWQiLCJzYnQiOiJuaWtlOmFwcCIsIm9yZyI6InByb2QiLCJzY3AiOlsiY29tbWVyY2UiXSwicHJuIjoiMTIxNDY0NDQwODIiLCJwcnQiOiJuaWtlOnBsdXMifQ.WImaAMp22gsRzenNfdKz7AeOIUEezT7jD-9pBABK-eL337DwVQn-JFrjLksnI-0Pfnz2k_ncL_LSOvWyXijKHgOhsOv7wcvWa7mMsr4L5WmNN2apAeH_EIHhSFxM67dCy3uPYQg8SukhtUpaTN4aUghoqBuCR6fouWNq-REoUeLEbcY95KG7_gV3LA1viGgo4WA6GkDoFlYTX030wE3YLbPxDy3W_xRGsM6xIRwCJykJO0_FOjIHa1dOKxAvTq-zV2GWlBC8SeZNFOPVvM_bcoXuBek8PEqQEaRvi1Mt_5DwxgIyiLiM30xJz4auNLTtmryQ1B04CDYxIaJLyMYAhA'
```

**3. Parse the Response**

Assuming no errors, you will receive a response body similar to the following:

```
{
    "country": "DE",
    "billingCountry": "DE",
    "paymentOptions": [
        {
            "name": "Klarna",
            "displayName": "Klarna"
        },
        {
            "name": "Paypal",
            "displayName": "PayPal"
        },
        {
            "name": "CreditCard",
            "displayName": "Credit Card",
            "types": [
                {
                    "name": "Visa",
                    "displayName": "Visa"
                },
                {
                    "name": "MasterCard",
                    "displayName": "MasterCard"
                },
                {
                    "name": "AmericanExpress",
                    "displayName": "American Express"
                },
                {
                    "name": "InternationalMaestro",
                    "displayName": "Maestro (International)"
                }
            ]
        },
        {
            "name": "Sofort",
            "displayName": "Sofort"
        },
        {
            "name": "GiftCard",
            "displayName": "GiftCard"
        }
    ]
}
```

Listed in the response are the the `country` and `billingCountry` passed in the request, as well as the `name` and `displayName` of each payment method valid for your Nike UPMID, shopping in country and billing country. Your user experience would display the `displayName` to the customer and pass the payment's `name` to endpoint requests requiring a payment type.

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentoptions/browse/API.md#!/default/post_payment_options_v2" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

## <a name="using-payment-options"></a>Using Payment Options

---

- [Get Payment Options for an Order](#get-payment-options-for-an-order)
- [Allowable Billing Countries for a Shipping Country](#allowable-billing-countries-for-a-shipping-country)
- [Validate Payments](#validate-payments)


### Payment Options Overview

Use the Payment Options service to list valid payment options or list valid billing countries based on a shipping country. Valid payment options are calculated based on [Nike UPMID](/doc/getting-started/using_nike_apis.html#authorization), shopping country, billing country, currency, (product) items and value-added services. See the [Buy Domain Developer's Guide](/doc/commerce/checkout/api_checkout.html#using-checkouts) for more information on items in Checkout.

All endpoints of this service are synchronous.

### <a name="get-payment-options-for-an-order"></a>Get Payment Options for an Order

- Lists valid payment options
- Calculates results based on calling application, shipping country, billing country, user type, items and value-added services
- Sorts results according to business rules

The Payment Options for an Order endpoint validates all products matching the UUID items passed in the request body. The endpoint has a product cache that expires every 15 minutes. If the product is not found in cache, it contacts the Merchandised Products API to get the latest product data. If the call is successful, Payment Options for an Order adds the product to its product cache and performs validation. If the Merchandised Product service is unreachable, Payment Options for an Order defaults the product type to "INLINE" and continues validating the product. In this way, Payment Options for an Order is not adversely affected by other services that are unavailable and minimizes calls to external services through caching.

Even though items is an optional request field, it is recommended that you pass it if available so product validation is performed as early as possible in the purchase flow.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**POST**|`/paymentoptions/options/v2`|no|

#### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.
>
><i class="mr2-sm g72-check"></i> It is a best practice to send all optional request headers, if the data is available, to avoid unexpected responses.

#### Request Body

|Element Name|Type|Description|Required?|
|---|---|---|
|**country**|string|ISO2 country code of customer's shopping country e.g. US|Required|
|**billingCountry**|string|ISO2 country code of customer's billing country e.g US|Required|
|**currency**|string|Currency code the customer will pay for Checkout in e.g. USD. [Supported currency codes](/doc/commerce/checkout/checkout_country_currency.html).|Required|
|**clientBrowser**|string|Browser used by client, WECHAT or null|Optional|
|**clickAndCollect**|boolean|True indicates this is a "click and collect" order, default is false|Optional|
|**total**|number|Order total e.g. 1999.0 (double)|Optional|
|**items**|array|Array of product ids in the customer's Checkout items, UUID format|Optional|
|**shippingMethods**|array|List of shipping methods, e.g. NEXT_DAY, STANDARD|Optional|

>**TIP:** It is a best practice to send all of the optional request body fields, if the data is available, to avoid unexpected responses.

Sample *Get Payment Options for an Order* Request Body
```
{
  "country": "GR",
  "billingCountry": "GR",
  "currency": "EUR",
  "total": 266.98,
  "clickAndCollect": "false",
  "items": [
    "e8791c09-cd7e-5b72-bab3-5d3490c2bd06",
    "e484acd3-259f-5624-bc65-e10231e4628d"
  ]
}
```
#### Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**country**|string|ISO2 country code of customer's shopping country e.g. US|Required|
|**billingCountry**|string|ISO2 country code of customer's billing country e.g US|Required|
|**paymentOptions**|array|Array of valid payment options|Required|
|paymentOptions.**name**|string|Internal payment option name e.g. CreditCard|Required|
|paymentOptions.**displayName**|string|Display payment option name e.g. Credit Card|Required|
|paymentOptions.**excludes**|string|List of excluded payment types based on this payment type|Optional|
|paymentOptions.**types**|array|List of sub-types for a payment option|Optional|
|paymentOptions.types.**name**|string|Sub-type internal name of payment option, e.g. MasterCard|Optional|
|paymentOptions.types.**displayName**|string|Sub-type display name of payment option, e.g. Master Card|Optional|
|paymentOptions.**charge**|object|Object containing info about the charge|Optional|
|paymentOptions.charge.**amount**|number|The amount of the charge|Required|
|paymentOptions.charge.**currency**|string|The currencey of the charge|Required|
|**message**|string|Top-level error message|Optional|
|**errors**|array|Array of error objects|Optional|
|errors.**field**|string|JSON field name causing error|Optional|
|errors.**code**|string|Error code|Optional|
|errors.**message**|string|Error message|Optional|


Sample *Get Payment Options for an Order* 200 Successful Response
```

{
  "country": "GR",
  "billingCountry": "GR",
  "paymentOptions": [
    {
      "name": "CreditCard",
      "displayName": "Credit Card",
      "types": [
        {
          "name": "Visa",
          "displayName": "Visa"
        },
        {
          "name": "MasterCard",
          "displayName": "MasterCard"
        },
        {
          "name": "AmericanExpress",
          "displayName": "American Express"
        },
        {
          "name": "VisaElectron",
          "displayName": "Visa Electron"
        },
        {
          "name": "InternationalMaestro",
          "displayName": "Maestro (International)"
        }
      ]
    },
    {
      "name": "Paypal",
      "displayName": "PayPal"
    },
    {
      "name": "GiftCard",
      "displayName": "GiftCard",
      "excludes": [
        "COD"
      ]
    }
  ]
}
```
Sample *Get Payment Options for an Order* 400 Error Response
```
{
  "message": "Validation Failed",
  "errors": [    
    {
      "field": "currency",
      "code": "MISSING_REQUIRED",
      "message": "Required field"
    },
    {
      "field": "total",
      "code": "INVALID_NUMBER",
      "message": "Order total is invalid"
    },
    {
      "field": "items",
      "code": "INVALID_PRODUCT",
      "message": "One or more product ids are invalid"
    }
  ]
}
```

#### Error Codes

|Code|Description|
|---|---|
|INVALID_REQUEST|returned when the request contains invalid information|
|MISSING_REQUIRED|returned when the request does not contain required information|
|INVALID_PRODUCT|returned when one or more item ids is invalid|
|INVALID_NUMBER|returned when amount is not in a valid number format|

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentoptions/browse/API.md#!/default/post_payment_options_v2" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="allowable-billing-countries-for-a-shipping-country"></a>Allowable Billing Countries for a Shipping Country

---
- Lists supported billing countries for a shipping country
- Results are unsorted

>**TIP:** The customer's billing address country must be in the billing country result list in order to purchase.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**GET**|`/paymentoptions/options/v2/{shippingCountry}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required|
|---|---|---|---|---|
|**shippingCountry**|Path|ISO2 country code customer is shopping in e.g. IE|Required|

Let's take a look at some *Allowable Billing Countries for a Shipping Country* scenarios.

|I Want to List|Sample Query|
|---|---|
|allowed billing countries for shipping country IE|http://api.nike.com/payment/options/v2/IE|

#### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### Request Body
There is no request body for GET requests.

#### Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**shippingCountry**|string|ISO2 country code customer is shopping in|Required|
|**billingCountries**|array|Array of allowed billing countries for a shipping country|Required|
|billingCountries.**country**|string|ISO2 country code|Required|
|**httpStatus**|string|Status code present when service returns in error|Optional|
|**timestamp**|string|Timestamp present when service returns in error|Optional|
|**message**|string|Top-level error message present when service returns in error|Optional|
|**errors**|string|Array of error objects present when service returns in error|Optional|
|errors.**field**|string|JSON field name causing error|Optional|
|errors.**code**|string|Error code|Optional|
|errors.**message**|string|Error message|Optional|

Sample *Allowable Billing Countries for a Shipping Country*  200 Success Response
```
{
  "shippingCountry": "IE",
  "billingCountries": [
    {
      "country": "DE"
    },
    {
      "country": "NO"
    },
    {
      "country": "BE"
    },
    {
      "country": "FI"
    },
    {
      "country": "PT"
    },
    {
      "country": "DK"
    },
    {
      "country": "LU"
    },
    {
      "country": "FR"
    },
    {
      "country": "HU"
    },
    {
      "country": "BR"
    },
    {
      "country": "SE"
    },
    {
      "country": "SI"
    },
    {
      "country": "GB"
    },
    {
      "country": "IE"
    },
    {
      "country": "US"
    },
    {
      "country": "CA"
    },
    {
      "country": "CH"
    },
    {
      "country": "GR"
    },
    {
      "country": "IT"
    },
    {
      "country": "ES"
    },
    {
      "country": "AT"
    },
    {
      "country": "AU"
    },
    {
      "country": "CZ"
    },
    {
      "country": "PL"
    },
    {
      "country": "NL"
    }
  ]
}
```
Sample *Allowable Billing Countries for a Shipping Country* 400 Error response
```
{
  "httpStatus": 400,
  "timestamp": 1499973327248,
  "message": "Validation Failed",
  "errors": [
    {
      "code": "INVALID_COUNTRY",
      "field": "shippingCountry",
      "message": "Shipping country is not recognized or invalid."
    }
  ]
}
```

#### Error Codes

|Code|Description|
|---|---|
|INVALID_COUNTRY|Returned when the request URI country parameter contains invalid country|

### <a name="validate-payments"></a>Validate Payments

---

Use this endpoint to validate a list of payment options for a given shipping country.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**POST**|`/payment/validate_payments/v2`|no|

#### Request Headers

|Header Name|Required?|Description|
|---|---|---|
|**Accept**|Required|Content type accepted in response, application/json is only value allowed|
|**Content-Type**|Required|Content type of the request, application/json is only value allowed|
|**Authorization**|Required|Your access token in the format of Bearer {token}|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.
>
><i class="mr2-sm g72-check"></i>It is a best practice to send all optional request headers, if the data is available, to avoid unexpected responses.

#### Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**country**|string|ISO2 country code of customer's shipping country e.g. US|Required|
|**payments**|array|Array of payment objects to validate|Required|
|payments.**id**|string|Payment ID generated by client|Required|
|payments.**billingCountry**|string|Billing country code|Required|
|payments.**type**|string|type of payment, one of CreditCard, ApplePay, GiftCard, PayPal|Required|
|payments.**cardType**|string|type of credit card, e.g. Visa|Optional|

>**TIP:** It is a best practice to send all of the optional request body fields, if the data is available, to avoid unexpected responses.

Sample *Validate Payments* Request Body
```
{
  "country": "US",
  "payments": [
    {
      "id": "1",
      "billingCountry": "US",
      "type": "CreditCard",
      "cardType": "Visa"
    },
    {
      "id": "2",
      "billingCountry": "DE",
      "type": "CreditCard",
      "cardType": "Visa"
    },
    {
      "id": "3",
      "billingCountry": "GB",
      "type": "CreditCard",
      "cardType": "Maestro"
    },
    {
      "id": "4",
      "billingCountry": "IT",
      "type": "CreditCard",
      "cardType": "CarteSi"
    },
    {
      "id": "5",
      "billingCountry": "FR",
      "type": "PayPal"
    }
  ]
}
```
#### Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**country**|string|ISO2 country code of customer's shopping country e.g. US|Required|
|**payments**|array|Array of validated payments|Required|
|payments.**id**|string|Payment ID generated by client|Required|
|payments.**billingCountry**|string|Billing country code|Required|
|payments.**type**|string|Type of payment, one of CreditCard, ApplePay, GiftCard, PayPal|Required|
|payments.**cardType**|string|Type of credit card, e.g. Visa|Optional|
|payments.**valid**|boolean|True if shopping in country and payment information are valid, false if not|Required|


Sample *Validate Payments* 200 Successful Response
```
{
  "country": "US",
  "payments": [
    {
      "id": "1",
      "billingCountry": "US",
      "type": "CreditCard",
      "cardType": "Visa",
      "valid": true
    },
    {
      "id": "2",
      "billingCountry": "DE",
      "type": "CreditCard",
      "cardType": "Visa",
      "valid": true
    },
    {
      "id": "3",
      "billingCountry": "GB",
      "type": "CreditCard",
      "cardType": "Maestro",
      "valid": false
    },
    {
      "id": "4",
      "billingCountry": "IT",
      "type": "CreditCard",
      "cardType": "CarteSi",
      "valid": false
    },
    {
      "id": "5",
      "billingCountry": "FR",
      "type": "PayPal",
      "valid": true
    }
  ]
}
```
Sample *Validate Payments* 400 Error Response
```
{
  "message": "Validation Failed",
  "errors": [
    {
      "field": "country",
      "code": "MISSING_REQUIRED",
      "message": "Required field"
    },
    {
      "field": "payments/billingCountry",
      "code": "MISSING_REQUIRED",
      "message": "Required field"
    }
  ]
}
```

#### Error Codes

|Code|Description|
|---|---|
|INVALID_REQUEST|returned when the request contains invalid information|
|MISSING_REQUIRED|returned when the request does not contain required information|

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentoptions/browse/API.md#!/default/post_payment_validate_payments_v2" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

## <a name="using-stored-payment"></a>Using Stored Payment

---

- [Initiate PayPal Billing Agreement](#initiate-paypal-billing-agreement)
- [Save Payment by User Profile](#save-payment-for-user-profile)
- [Delete All Stored Payments by User Profile](#delete-all-stored-payments-for-user-profile)
- [List Stored Payments by User Profile](#list-stored-payments-by-user-profile)
- [Update Stored Payment by ID](#update-stored-payment-by-id)
- [Delete Stored Payment by ID](#delete-stored-payment-by-id)
- [List Stored Payment by ID](#list-stored-payment-by-payment-id)
- [Validate CVV by Shipping Address](#validate-credit-card-cvv-by-shipping-address)
- [Update Default Stored Payment](#update-default-stored-payment-by-user-profile)
- [List Saved Gift Card Payment by ID](#list-gift-card-by-payment-id)

### Stored Payments Overview

The Stored Payment service is used to administer (add/update/delete/list) a customer's stored payments. A customer must register and log in as a Nike member to use Stored Payment. Guest customers are not supported. In a shopping flow, this service can be used to display the customer's stored payments to allow the customer to choose a payment method to pay for their order, change their default payment method, and add or delete a payment method. This service also handles initiating a PayPal Billing Agreement so a customer can pre-authorize PayPal payments.

All endpoints of this service are synchronous.

### <a name="initiate-paypal-billing-agreement"></a>Initiate PayPal Billing Agreement

Use this endpoint as a first step in creating a PayPal billing agreement for the PayPal payment type. For instance, the Nike Web Launch experience calls this endpoint when a customer adds PayPal as a stored payment type in Payment Settings. A PayPal Billing Agreement preauthorizes Nike to charge the customer's PayPal account for a purchase without requiring the customer to visit the PayPal site to manually authorize the purchase. Once a customer accepts the PayPal Billing Agreement and stores it, the customer does not need to authorize each payment before submitting a Nike order. Use the requestToken and redirectURL in the response to redirect the customer to the appropriate PayPal experience to accept the PayPal Billing Agreement. It eases the barrier to purchase by avoiding redirecting the customer to PayPal during the purchase process.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**GET**|`/consumer/paypalagreement{?returnUrl,cancelUrl,onlytoken,design,locale,currency}`|no|

#### Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**returnUrl**|Query|URL to redirect to after the customer accepts the billing agreement|String|Required|
|**cancelUrl**|Query|URL to redirect to after the customer cancels accepting the billing agreement|String|Required|
|**onlytoken**|Query|flag indicating to return only the paypalToken. '1' returns only the PayPal token field. '0' or null returns all fields|String|Optional|
|**design**|Query|determines the redirectURL to PayPal. `inContext` displays a PayPal Express window as an overlay on the Nike experience. `mobile` redirects from the Nike experience to PayPal's mobile-optimized experience. `default` redirects from the Nike experience to PayPal's web experience. `default` is the default value|String|Optional|
|**locale**|Query|locale of shopping in country. defaults to en_US|String|Optional|
|**currency**|Query|shopping in currency. defaults to USD|String|Optional|

Let's take a look at some *Initiate PayPal Billing Agreement* scenarios

|I want to|Sample Query|
|---|---|
|Initiate a PayPal Billing agreement on a Mobile device|https://api.nike.com/commerce/storedpayments/consumer/paypalagreement?returnUrl=http://nike.com/SNKRS/PayPalAuthenticationSucceeded&cancelUrl=http://nike.com/SNKRS/PayPalAuthenticationDidNotSucceed&design=mobile|
|Initiate a PayPal Billing agreement for EURO currency, locale en_GB, and display PayPal window as an overlay|https://api.nike.com/commerce/storedpayments/consumer/paypalagreement?returnUrl=http://nike.com/SNKRS/PayPalAuthenticationSucceeded&cancelUrl=http://nike.com/SNKRS/PayPalAuthenticationDidNotSucceed&design=inContext&locale=en_GB&currency=EUR|

#### Request Body
There is no request body for a GET request.

#### Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**requestSuccess**|boolean|True if request succeeded, false if error|Optional|
|**transactionTimestamp**|string|Transaction timestamp in ms, 2017-08-23T14:59:57.700+0000|Optional|
|**responseCode**|integer|0 indicates success, 98 indicates failure|Optional|
|**referenceCode**|string|Service name initiating billing agreement call, e.g. `storedpayment**|Optional|
|**account**|string|PayPal account. USD, EUR or GBP|Required|
|**currency**|string|Currency used to look up the PayPal account. USD, EUR, GBP, DKK, SEK or PLN|Required|
|**requestToken**|string|Good for 15 minutes and is used to request a permanent access token (paypalToken)|Required|
|**paypalToken**|string|Permanent access token used to generate a signature and timestamp to make authorized PayPal API calls|Required|
|**correlationId**|string|Unique id for PayPal response. used to query transaction in PayPal|Optional|
|**redirectURL**|string|PayPal URL to redirect the customer to to initiate a PayPal Billing Agreement|Required|
|**requestId**|string|UUID of the request|Required|

Sample  *Initiate PayPal Billing Agreement* 200 success response
```
{
  "requestSuccess" : true,
  "responseCode" : 0,
  "referenceCode" : "storedpayment",
  "transactionTimestamp" : "2017-08-23T14:59:57.700+0000",
  "account" : "USD",
  "currency" : "USD",
  "requestToken" : "e8e69e64-6ff3-4692-9f09-19cadf7d762e",
  "paypalToken" : "EC-2ML17569H9664211U",
  "correlationId" : "3df6ee6834412",
  "redirectURL" : "https://www.paypal.com/cgibin/webscr?cmd=_express-checkout&token=EC-2ML17569H9664211U",
  "requestId" : "e8e69e64-6ff3-4692-9f09-19cadf7d762e"
}
```

Next, you need to get customer approval by redirecting the customer to the PayPal redirectURL returned in the response. At PayPal, the customer provides payment details and both approves and subscribes to the Billing Agreement. Once the customer accepts the PayPal Billing Agreement, PayPal redirects to the returnURL provided in the call. If the customer cancels the transaction, PayPal redirects the customer to the cancelURL provided in the call.

The next Stored Payment endpoints you might want to call for the PayPal Billing Agreement flow are `savepayment` to store the PayPal payment method once the customer authorizes the Billing Agreement, and `storedpayment` to display all of the customer's saved payment methods.

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/storedpayments/browse/API.md#!/default/get_consumer_paypalagreement" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="save-payment-for-user-profile"></a>Save Payment for User Profile

---

Use this endpoint to save a payment type for a Nike UPMID. See [Supported Stored Payment Types](#supported-stored-payment-types) to view types and storage limits. The request body varies depending upon the payment type and whether the endpoint is called pre-authorization or post-authorization. The typical flow for saving a Credit Card for user profile is:
1. [`Store Credit Card Info`](#store-credit-card-info) to securely transmit credit card information to the PCI-certified Credit Cards submit service, passing a new UUID as the creditCardInfoId
2. [`Validate Credit Card Info`](#validate-credit-card-info) to check that the credit card information was received
3. [`Save Payment for User Profile`](#save-payment-for-user-profile), passing the creditCardInfoId to look up the credit card information and save it to long term storage
4. [`List Stored Payment by Payment Id`](#list-stored-payment-by-payment-id) to return masked credit card information to display to the customer and confirm that the credit card was securely stored

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**POST**|`/consumer/savepayment`|no|

#### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### Request Body

The request body varies depending upon the type of payment being saved. The table below lists all possible request fields regardless of payment type.

**Credit Card**

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**type**|string|Type of payment method|Required|
|**creditCardInfoId**|string|Id returned from the Payment Service's [Credit Card Submit](#using-credit-card-submit) endpoint. used as common id between Nike and third-party systems.|Required|
|**isDefault**|boolean|Flag indicating this saved payment method is the default|Optional|
|**currency**|string|Credit Card currency. [Supported currency codes](/doc/commerce/checkout/checkout_country_currency.html).|Optional|
|**cybersourceRequestId**|string|CyberSource-generated requestId number returned from [Payment Approval Service](#using-payment-approval), required post-auth|Optional|
|**cybersourceRequestToken**|string|CyberSource-generated token returned from [Payment Approval Service](#using-payment-approval), required post-auth|Optional|
|**referenceId**|string|CyberSource-generated reference number returned from [Payment Approval Service](#using-payment-approval)|Optional|
|**accountName**|string|Returned from [Payment Approval Service](#using-payment-approval)|Optional|
|**billingAddress**|object|Billing address object, required for CreditCard type|Optional|
|billingAddress.**firstName**|string|Billing first name|Required|
|billingAddress.**lastName**|string|Billing last name|Required|
|billingAddress.**address1**|string|Billing address line 1|Required|
|billingAddress.**address2**|string|Billing address line 2|Optional|
|billingAddress.**address3**|string|Billing address line 3|Optional|
|billingAddress.**city**|string|Billing city|Required|
|billingAddress.**postalCode**|string|Billing postal code|Optional|
|billingAddress.**state**|string|Billing state|Optional|
|billingAddress.**country**|string|Billing country|Required|
|billingAddress.**phoneNumber**|string|Billing phone number|Optional|
|billingAddress.**email**|Optional|string|Billing email address|Optional|

This is a sample *Save Payment for User Profile* POST request to save a Credit Card before it has been authorized, which requires creditCardInfoId, currency and account be passed in the request.
```
https://api.nike.com/commerce/storedpayments/consumer/savepayment
```

```
{
  "type": "CreditCard",
  "creditCardInfoId": "724928394823492374982374932840239402394e0Z0961",
  "isDefault": false,
  "currency": "USD",
  "cybersourceRequestId": "",
  "cybersourceRequestToken": "",
  "referenceId": "",
  "account": "",
  "billingAddress": {
    "firstName": "William",
    "lastName": "Bowerman",
    "address1": "One Bowerman Drive",
    "address2": "",
    "address3": "",
    "city": "Beaverton",
    "postalCode": "97005",
    "state": "OR",
    "country": "US",
    "phoneNumber": "781-555-1212",
    "email": "test@nike.com"
  }
}
```

This is a sample *Save Payment for User Profile* POST request to save a Credit Card after it has been authorized, which requires `cybersourceRequestId`, `cybersourceRequestToken`, `currency` and `account` to be passed in the request.
```
{
  "type": "CreditCard",
  "creditCardInfoId": "724928394823492374982374932840239402394e0Z0961",
  "isDefault": false,
  "currency": "USD",
  "cybersourceRequestId": "222",
  "cybersourceRequestToken": "233322",
  "referenceId": "",
  "account": "",
  "billingAddress": {
    "firstName": "William",
    "lastName": "Bowerman",
    "address1": "One Bowerman Drive",
    "address2": "",
    "address3": "",
    "city": "Beaverton",
    "postalCode": "97005",
    "state": "OR",
    "country": "US",
    "phoneNumber": "781-555-1212",
    "email": "test@nike.com"
  }
}
```

**Gift Card Request Body**

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**type**|string|Type of payment method, always 'GiftCard'|Required|
|**accountNumber**|string|gift card/CyberSource voucher account number|Required|
|**pin**|string|Gift card personal identification number|Optional|
|**gcExpiryDate**|string|Gift card expiration date|Optional|
|**currency**|string|Gift card currency. [Supported currency codes](/doc/commerce/checkout/checkout_country_currency.html).|Optional|
|**isDefault**|boolean|True if this is the default saved payment method, false if not|Optional|

This is a sample *Save Payment for User Profile* POST request to save a gift card, which requires accountNumber be passed in the request.

```
 { 
   "type": "GiftCard",  
   "accountNumber": "1234567890123456",  
   "pin": "434343",  
   "gcExpiryDate": "2099-12-31T08:00:56.305+0000", 
   "currency": "USD",  
   "isDefault": true  
 }'
 ```

**PayPal Request Body**

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**type**|string|Type of payment method, always 'PayPal'|Required|
|**paypalToken**|string|PayPal token returned from the Billing Agreement|Required|
|**currency**|string|PayPal currency. See a list of [supported currency codes](/doc/commerce/checkout/checkout_country_currency.html).|Optional|
|**isDefault**|boolean|True if this is the default saved payment method, false if not|Optional|

This is a sample *Save Payment for User Profile* POST request to save PayPal as a stored payment, which requires paypalToken be passed in the request.

```
{  
   "type":"Paypal",
   "paypalToken":"EC-4F8459024C476322H",
   "currency":"USD",
   "isDefault":true
}

```

**Deferred Payment Request Body**

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**type**|string|Type of deferred payment method|Required|
|**bankName**|string|Name of bank taking deferred payment|Optional|
|**isDefault**|boolean|True if this is the default saved payment method, false if not|Optional|

This is a sample *Save Payment for User Profile* POST request to save Alipay Deferred Payment as a stored payment, which requires the Alipay type be passed in the request.

```
{  
   "type":"Alipay",
   "bankName":"First Bank of China",
   "isDefault":true
}
```
#### Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**status**|string|Success when request completed without error|Optional|
|**httpStatus**|integer|Status code present when service returns in error|Optional|
|**timestamp**|integer|Timestamp present when service returns in error|Optional|
|**message**|string|Error message present when service returns in error|Optional|
|**service**|string|Name of service, always storedpayments|Optional|
|**code**|string|Error code|Optional|

**Sample *Save Payment for User Profile* 201 success response**
```
{
  "status": "success"
}
```
**Sample *Save Payment for User Profile* 400 Error Response**

```
{
  "httpStatus": 400,
  "code": "99154",
  "timestamp": 1427304058885,
  "service": "storedpayments",
  "message": "One or more required parameters missing.."
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/storedpayments/browse/API.md#default_post_consumer_savepayment" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="delete-all-stored-payments-for-user-profile"></a>Delete All Stored Payments for User Profile

---

Use this endpoint to delete all Stored Payments for a Nike UPMID. This is a synchronous endpoint that is restricted.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**DELETE**|`/consumer/storedpayments`|yes|

#### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|
|**X-Nike-AppId**|Client application id calling this service (as listed in Eureka) used to verify endpoint access|Required|
|**X-Nike-Authorization**|JWT signed by client application|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### Request Body

There is no request body for a DELETE request.

Sample *Delete All Stored Payments for User Profile* DELETE request

```
  https://api.nike.com/consumer/storedpayments
```

#### Response Body

There is no content returned for a successful response.

**This endpoint is unavailable to Try It Out because it is JWT-restricted**

### <a name="list-stored-payments-by-user-profile"></a>List Stored Payments by User Profile

---

Use this endpoint to list the stored payment types for a Nike UPMID. Account numbers are masked in the response.

If the request does not contain a shipping address or the shipping address sent does not match a shipping address in a previously placed order, the validateCVV key will be set to true in the response for Credit Card payment types. This flag indicates that the Credit Card's CVV must be provided and validated before the customer can pay for their order using the credit card in the checkout flow.

If not filtering by the `type` URI parameter, all stored payment types are returned.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**POST**|`/consumer/storedpayments{?currency,type,includebalance,validateshipping}`|no|

#### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### Query & Path Parameters

|Header Name|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**type**|Query|type of payment method used to filter results, one of CreditCard,GiftCard,Paypal|String|Optional|
|**currency**|Query|currency code of the payment type [Supported currency codes](/doc/commerce/checkout/checkout_country_currency.html)|String|Optional|
|**includebalance**|Query|flag indicating to return the balance on gift card stored payment types. default is true.|Boolean|Optional|
|**validateshipping**|Query|flag indicating to validate billing and shipping country combination for stored payment|Boolean|Optional|

Let's take a look at some *List Stored Payments by User Profile* scenarios.

|I want to list all of a customer's...|Sample Query|
|---|---|
|gift card stored payments and return the balance in Euro|https://api.nike.com/consumer/storedpayments?currency=EUR&type=GiftCard&includebalance=true|
|stored payments|https://api.nike.com/consumer/storedpayments|
|stored payments and validate the shipping country is valid for the billing country|https://api.nike.com/consumer/storedpayments?validateshipping=true|

#### Request Body

No request body is required. If shippingAddress is sent in the request body, the required fields are indicated below.

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**address1**|string|Shipping address line 1|Required|
|**address2**|string|Billing address line 2|Optional|
|**address3**|string|Billing address line 3|Optional|
|**city**|string|Billing city|Required|
|**postalCode**|string|Billing postal code|Optional|
|**state**|string|Billing state|Optional|
|**country**|string|Billing country|Required|

Sample *List Stored Payments by User Profile* request for credit card

`https://api.nike.com/consumer/storedpayments?currency=USD`

```
{
  "address1": "One Bowerman Drive",
  "address2": "",
  "address3": "",
  "city": "Beaverton",
  "state": "OR",
  "postalCode": "97005",
  "country": "US"
}
```

Sample *List Stored Payments by User Profile* request for non-credit card payment types such as PayPal or gift card:

```
{}
```

#### Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**payments**|array|Array of stored payments|Required|
|**type**|string|Type of stored payment, either GiftCard or CreditCard|Required|
|**paymentId**|string|Unique ID for legacy system|Required|
|**cardType**|string|Type of credit card, e.g. MasterCard|Optional|
|**balance**|number|Remaining GiftCard balance, present for GiftCard type|Optional|
|**accountNumber**|string|Masked GiftCard or CreditCard account number with last 4 digits|Required|
|**expiryYear**|string|Year credit card expires, present for CreditCard|Optional|
|**expiryMonth**|string|Month credit card expires, present for CreditCard|Optional|
|**isExpired**|boolean|True if payment method is expired, false if not|Optional|
|**isDefault**|boolean|True if this is the default payment method, false if not|Required|
|**name**|string|Customer-supplied nickname for payment type|Optional|
|**validateCVV**|boolean|True indicates CVV needs to be validated before purchase, present for CreditCard|Optional|
|**pin**|string|Gift card PIN, present for GiftCard payment type|Optional|
|**gcExpiryDate**|string|Gift card expiration date, present for GiftCard|Optional|
|**currency**|string|ISO currency code used to display GiftCard balance|Optional|
|**status**|string|Status of gift card, present for GiftCard|Optional|
|**payer**|string|PayPal email address of customer, present for PayPal|Optional|
|**payerId**|string|Customer's PayPal ID, present for PayPal|Optional|
|**validForShippingCountry**|boolean|True if billing/shipping country combination is valid, false if not|Optional|
|**billingAddress**|object|Billing address of customer, required for CreditCard|Optional|
|billingAddress.**firstName**|string|Billing first name|Required|
|billingAddress.**lastName**|string|Billing last name|Required|
|billingAddress.**address1**|string|Billing address line 1|Required|
|billingAddress.**address2**|string|Billing address line 2|Optional|
|billingAddress.**address3**|string|Billing address line 3|Optional|
|billingAddress.**city**|string|Billing city|Required|
|billingAddress.**postalCode**|string|Billing postal code|Optional|
|billingAddress.**state**|string|Billing state|Optional|
|billingAddress.**country**|string|Billing country|Required|
|billingAddress.**phoneNumber**|string|Billing phone number|Optional|
|billingAddress.**email**|string|Billing email address|Optional|
|**httpStatus**|integer|Status code present when service returns in error|Optional|
|**timestamp**|integers|Timestamp present when service returns in error|Optional|
|**message**|string|Error message present when service returns in error|Optional|
|**service**|string|Name of service, always storedpayments|Optional|
|**code**|string|Error code|Optional|

The sample *List Stored Payments by User Profile* 200 response below returns a customer's stored credit card, gift card and PayPal payment types.

```
{
  "payments": [
    {
      "paymentId": "1686062b-4246-4c3b-ac96-e82a0efae7a0",
      "type": "CreditCard",
      "cardType": "Visa",
      "accountNumber": "XXXXXXXXXXXX9765",
      "expiryYear": "2018",
      "expiryMonth": "06",
      "validateCVV": true,
      "isExpired": false,
      "isDefault": false,
      "name": "my Visa",
      "billingAddress": {
        "firstName": "William",
        "lastName": "Bowerman",
        "address1": "One Bowerman Drive",
        "city": "Beaverton",
        "postalCode": "97005",
        "state": "OR",
        "country": "US",
        "phoneNumber": "413-555-1234",
        "email": "test@nike.com"
      }
    },
    {
      "type": "GiftCard",
      "accountNumber": "XXXXXXXXXXXXXXX2346",
      "isDefault": "true",
      "balance": 100.0,
      "status": "valid",
      "pin": "123456"
    },
    {
      "paymentId": "661aea5d-31b6-4ac4-8830-1d61d2c7b043",
      "type": "Paypal",
      "isDefault": false,
      "payer": "xxxx.here@tothere.com",
      "payerId": "XXXXH9Q76ZT28"
    }
  ]
}
```

The sample *List Stored Payments by User Profile* 200 success response is returned when the customer has no stored payments.
```
{}
```

The sample *List Stored Payments by User Profile* 200 success response below is returned when the customer has a gift card as a stored payment and no gift card balance was requested.
```
{
  "payments": [
    {
      "paymentId": "pid6dfa0847-282a-4d9e-aa6a-3e509aeb6ce1",
      "type": "GiftCard",
      "accountNumber": "XXXXXXXXXXXXXXX3532",
      "isDefault": false,
      "gcExpiryDate": "2099-12-31T08:00:56.305+0000"
    },
    {
      "paymentId": "pidd4c99e1e-3a89-40aa-9d1a-88b26e74d959",
      "type": "GiftCard",
      "accountNumber": "XXXXXXXXXXXXXXX4307",
      "isDefault": false,
      "gcExpiryDate": "2099-12-31T08:00:56.305+0000"
    },
    {
      "paymentId": "pid68f5cbd6-1646-4c2e-a085-bbe4097b45d3",
      "type": "GiftCard",
      "accountNumber": "XXXXXXXXXXXXXXX4319",
      "isDefault": false,
      "gcExpiryDate": "2099-12-31T08:00:56.305+0000"
    },
    {
      "paymentId": "piddeb9f14b-63bc-4637-be28-35107be9d0e1",
      "type": "GiftCard",
      "accountNumber": "XXXXXXXXXXXXXXX4323",
      "isDefault": false,
      "gcExpiryDate": "2099-12-31T08:00:56.305+0000"
    },
    {
      "paymentId": "pid657457e8-9041-4f20-890c-42e2f3ad9a81",
      "type": "GiftCard",
      "accountNumber": "XXXXXXXXXXXXXXX4342",
      "isDefault": false,
      "gcExpiryDate": "2099-12-31T08:00:56.305+0000"
    },
    {
      "paymentId": "pid38ea1414-306b-4138-b3b5-c3b6bad0cbd5",
      "type": "GiftCard",
      "accountNumber": "XXXXXXXXXXXXXXX4362",
      "isDefault": false,
      "gcExpiryDate": "2099-12-31T08:00:56.305+0000"
    },
    {
      "paymentId": "pid037a6ddc-73d0-49fd-9403-dedf7e16e583",
      "type": "GiftCard",
      "accountNumber": "XXXXXXXXXXXXXXX4381",
      "isDefault": false,
      "gcExpiryDate": "2099-12-31T08:00:56.305+0000"
    }
  ]
}
```
The sample *List Stored Payments by User Profile* 200 success response below is returned when the customer has AliPay as a stored payment.
```
{
  "type": "Alipay",
  "isDefault": true,
  "paymentId": "pid83080432049320943204",
  "bankName": "First Bank of China"
}
```

The sample *List Stored Payments by User Profile* 400 Error Response is returned when there is a 4xx status code error.
```
{
  "httpStatus": 400,
  "code": "99154",
  "timestamp": 1427304058885,
  "service": "storedpayments",
  "message": "One or more required parameters missing.."
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/storedpayments/browse/API.md#!/default/post_consumer_storedpayments" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="list-stored-payment-by-payment-id"></a>List Stored Payment by Payment ID

---

Use this endpoint to list stored payment details for a paymentId. This endpoint is primarily for gift cards but it can be called for any type of stored payment. When listing a gift card payment type and you don't need the balance, pass includebalance=false as a URI parameter for a quicker response. Setting this parameter to false prevents the Stored Payments service from making a balance call to the gift card provider. Because this endpoint returns sensitive information, it requires the JWT `X-Nike-Authorization` and `X-Nike-AppId` headers. It is a synchronous endpoint.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**GET**|`/consumer/storedpayments/{payment_id}{?includebalance}`|yes|

#### <a name="list-stored-payment-by-payment-id-request-headers"></a>Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|
|**X-Nike-AppId**|Client application id calling this service (as listed in Eureka) used to verify endpoint access|Required|
|**X-Nike-Authorization**|JWT signed by client application|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="list-stored-payment-by-payment-id-request-parameters"></a>Query & Path Parameters

|Header Name|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**payment_id**|Path|Id of the stored payment. If unknown, get a list of all stored payments for a Nike UPMID by calling the `/consumer/storedpayments{?currency,type,includebalance}` endpoint. The payment_id for each saved payment type is returned in the response.|String|Required|
|**includebalance**|Query|True returns the gift card balance, false does not. Defaults to true|Boolean|Optional|

#### <a name="list-stored-payment-by-payment-id-request-body"></a>Request Body
There is no body in a GET request.

Let's take a look at some *List Stored Payment by Payment ID* scenarios.

|I want to|Sample Query|
|---|---|
|List the stored payment for ID|https://api.nike.com/consumer/storedpayments/pid79847893284923483924|
|List the gift card stored payment for ID and do not include the balance|https://api.nike.com/consumer/storedpayments/pid794873294382948324823042?includebalance=false|
|List the gift card stored payment for ID and include the balance|https://api.nike.com/consumer/storedpayments/pid794873294382948324823042|

Sample *List Stored Payment by Payment ID* request
```
https://api.nike.com/consumer/storedpayments/79847893284923483924
```
#### <a name="list-stored-payment-by-payment-id-response-body"></a>Response Body
For credit cards, the credit card account number is not returned. The `paymentToken` from CyberSource is returned instead which is used to look up the credit card information in CyberSource as well as in Stored Payment. Following are descriptions of the important fields in the response body:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**type**|string|Payment type e.g. CreditCard|Required|
|**paymentToken**|string|Subscription id assigned to this payment by CyberSource for credit card type; PayPal billing agreement id for PayPal type; random UUID for GiftCard type|Required|
|**cardType**|string|Type of credit card, required for CreditCard type|Required|
|**accountNumber**|string|Unmasked credit card or gift card account number|Required|
|**expiryYear**|string|Year credit card expires, required for CreditCard type|Required|
|**expiryMonth**|string|Month credit card expires, required for CreditCard type|Required|
|**name**|string|Customer's nickname for this Stored Payment|Required|
|**isDefault**|boolean|True if this is the default Stored Payment, false if not. Defaults to false.|Required|
|**billingAddress**|object|Billing address of customer, required for CreditCard|Optional|
|billingAddress.**firstName**|string|Billing first name|Required|
|billingAddress.**lastName**|string|Billing last name|Required|
|billingAddress.**address1**|string|Billing address line 1|Required|
|billingAddress.**address2**|string|Billing address line 2|Optional|
|billingAddress.**address3**|string|Billing address line 3|Optional|
|billingAddress.**city**|string|Billing city|Required|
|billingAddress.**postalCode**|string|Billing postal code|Optional|
|billingAddress.**state**|string|Billing state|Optional|
|billingAddress.**country**|string|Billing country|Required|
|billingAddress.**phoneNumber**|string|Billing phone number|Optional|
|billingAddress.**email**|string|Billing email address|Optional|
|**paymentId**|string|UUID passed in as a path parameter|Optional|
|**balance**|number|Gift card balance for GiftCard payment type. Not returned if includebalance query parameter is false|Optional|
|**pin**|string|Gift card PIN number for GiftCard payment type|Optional|
|**gcExpiryDate**|string|Gift card expiration date in milliseconds|Optional|
|**currency**|string|Checkout currency ISO code. Defaults to USD.|Optional|
|**payer**|string|Customer's PayPal email address|Optional|
|**payerId**|string|PayPal generated unique id|Optional|
|**bankName**|string|Bank name for China payments|Optional|

Sample *List Stored Payment by ID* CreditCard type response body:
```
{
  "paymentId": "440aea5d-31b6-4ac4-8830-1d61d2c7b234",
  "type":"CreditCard",
  "cardType": "VISA",
  "accountNumber":"4111647583926789",
  "name":"My Visa";
  "expiryYear": "2018",
  "expiryMonth": "6",
  "isDefault":"false",
  "billingAddress": {
    "email": "test@nike.com",
    "firstName": "William",
    "lastName": "Bowerman",
    "address1": "One Bowerman Drive",
    "city": "Beaverton",
    "state": "OR",
    "postalCode": "97005",
    "country": "US",
    "phoneNumber": "4131231234"
  }
   "isExpired": false,
   "validateCVV": true
}
```

Sample *List Stored Payment by ID* GiftCard type response body:
```
{
  "paymentId": "770aea5d31b64ac488301d61d2c7b052",
  "type":"GiftCard",
  "accountNumber":"6758395874622415",
  "isDefault":"true",
  "paymentToken": "482d7398-501d-40bb-a7b1-2990c631d8d5",
  "balance":45.00,
  "gcExpiryDate":"2020-10-10T00:00:00.000+0000",
  "pin":"123456",
  "currency":"USD"
}
```

Sample *List Stored Payment by ID* PayPal type response body:
```
{  
  "paymentId": "7661aea5d-31b6-4ac4-8830-1d61d2c7b043",
  "type":"PayPal",
  "isDefault":"false",
  "payer":"test@nike.com",
  "payerId":"FUCTH9Q76ZT2832323",
  "paymentToken": "EC-80547893284923483970"
}
```

Sample *List Stored Payment by ID* Alipay type response body:
```
{
  "paymentId": "79847893284923483924",
  "type":"Alipay",
  "bankName":"First Bank of China",
  "isDefault":"yes"
}
```

**This endpoint is unavailable to Try It Out because it is JWT-restricted**

### <a name="list-gift-card-by-payment-id"></a>List Gift Card by Payment Id

---

Use this endpoint to list a details for a customer's saved gift card. This is a synchronous service.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/consumer/storedpayments/giftcard/{payment_id}{?currency}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**payment_id**|Path|Unique identifier (<a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a>)|String|Required|
|**currency**|Query|ISO currency code|String|Optional|

#### <a name="list-giftcard-stored-payment-by-id-request-headers"></a>Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="list-giftcard-stored-payment-by-id-response-body"></a>Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**paymentId**|string|UUID passed in as a path parameter|Optional|
|**type**|string|Payment type, GiftCard only|Required|
|**balance**|number|Gift card balance for GiftCard payment type. Not returned if includebalance query parameter is false|Optional|
|**status**|string|One of valid or invalid|Optional|
|**paymentToken**|string|Payment token|Required|
|**accountNumber**|string|Masked gift card account number, last 4 digits are returned|Optional|
|**isExpired**|boolean|True indicates gift card is expired, false if not|Optional|
|**isDefault**|boolean|True if this is the default Stored Payment, false if not, defaults to false|Optional|
|**pin**|string|PIN for gift card|Optional|
|**gcExpiryDate**|string|Optional|gift card expiration date in milliseconds|
|**currency**|string|Currency ISO code, defaults to USD|Optional|
|**httpStatus**|string|Status code present when service returns in error|Optional|
|**timestamp**|string|Timestamp present when service returns in error|Optional|
|**message**|string|Error message present when service returns in error|Optional|
|**service**|string|Name of service, always storedpayments|Optional|
|**code**|string|Error code|Optional|

Sample *List Gift Card by Payment Id* 200 success response:

```
{
    "paymentId": "pid3798fdd8-6e0d-4f88-bddb-5ad25eefda18",
    "type": "GiftCard",
    "balance": 100.0,
    "status": "valid",
    "accountNumber": "XXXXXXXXXXXXXXX4373",
    "isDefault": false,
    "currency": "USD",
    "gcExpiryDate": "2099-12-31T08:00:38.261+0000"
}

```

Sample *List Gift Card by Payment Id* 400 error response:

```
{
  "httpStatus": 400,
  "code": "99154",
  "timestamp": 1427304058885,
  "service": "storedpayments",
  "message": "One or more required parameters missing.."
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/storedpayments/browse/API.md#!/default/get_consumer_storedpayments_giftcard_payment_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="update-stored-payment-by-id"></a>Update Stored Payment by ID

---

Use this endpoint to update a customer's CreditCard or GiftCard type Stored Payment. No other payment types can be updated using this endpoint. You can update the credit card expiration month, expiration year, billing address and default payment type flag. The credit card account number cannot be changed.

You can update the default payment flag for a gift card.

This is a synchronous service.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PUT**|`/consumer/storedpayments/{payment_id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**payment_id**|Path|Unique identifier (<a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a>)|String|Required|

#### <a name="update-credit-card-stored-payment-request-headers"></a>Request Headers

|Name|Description|
|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|
|**Content-Type**|Content type of the request, application/json is only value allowed|
|**Authorization**|Your access token in the format of Bearer {token}|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

Let's take a look at some *Update Credit Card by User Profile Details* scenarios:

|I want to update a customer's|Sample Query|
|---|---|
|Credit card with payment ID 1686062b-4246-4c3b-ac96-e82a0efae7a0|https://api.nike.com/consumer/storedpayments/1686062b-4246-4c3b-ac96-e82a0efae7a0|
|Gift card with payment ID pid3798fdd8-6e0d-4f88-bddb-5ad25eefda18|https://api.nike.com/consumer/storedpayments/pid3798fdd8-6e0d-4f88-bddb-5ad25eefda18|

#### <a name="update-credit-card-stored-payment-request-body"></a>Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**type**|string|Payment type|Required|
|**cardType**|string|Type of credit card|Optional|
|**accountNumber**|string|Obfuscated credit card or gift card number|Optional|
|**expiryYear**|string|Year that credit card expires YYYY format|Optional|
|**expiryMonth**|string|Month that credit card expires MM format|Optional|
|**name**|string|Customer's nickname for this Stored Payment|Optional|
|**isDefault**|boolean|True makes this payment the default and sets all other stored payments to false. Defaults to false|Optional|
|**billingAddress**|object|Billing address of customer, required for CreditCard|Optional|
|billingAddress.**firstName**|string|Billing first name|Required|
|billingAddress.**lastName**|string|Billing last name|Required|
|billingAddress.**address1**|string|Billing address line 1|Required|
|billingAddress.**address2**|string|Billing address line 2|Optional|
|billingAddress.**address3**|string|Billing address line 3|Optional|
|billingAddress.**city**|string|Billing city|Required|
|billingAddress.**postalCode**|string|Billing postal code|Optional|
|billingAddress.**state**|string|Billing state|Optional|
|billingAddress.**country**|string|Billing country|Required|
|billingAddress.**phoneNumber**|string|Billing phone number|Optional|
|billingAddress.**email**|string|Billing email address|Optional|


Sample *Update Credit Card by User Profile* credit card request body:

```
{
  "type": "CreditCard",
  "cardType": "Visa",
  "accountNumber" : "",ß
  "expiryYear": "2018",
  "expiryMonth": "06",
  "name": "My Visa Credit Card",
  "isDefault": false,
  "billingAddress": {
    "email": "test@nike.com",
    "firstName": "William",
    "lastName": "Bowerman",
    "address1": "One Bowerman Drive",
    "city": "Beaverton",
    "state": "OR",
    "postalCode": "97005",
    "country": "US",
    "phoneNumber": "4131231234"
  }
}
```

Sample *Update Credit Card by User Profile* gift card request body:

```
{
  "type": "GiftCard",
  "accountNumber": "",
  "isDefault": true
}
```

#### <a name="update-credit-card-stored-payment-response-body"></a>Response Body
The HTTP 202 response from *Update Credit Card by User Profile* contains the results because this is a synchronous endpoint. Following are descriptions of the important fields in the response body:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**status**|string|"success" present when information was updated successfully|Optional|
|**httpStatus**|integer|Status code present when service returns in error and httpStatus is not 202|Optional|
|**timestamp**|integer|Timestamp present when service returns in error|Optional|
|**message**|string|Error message present when service returns in error|Optional|
|**service**|string|Name of service, always storedpayments|Optional|
|**code**|string|Error code|Optional|

Sample 202 success *Update Credit Card by User Profile* response body:

```
{
  "status": "success"
}
```

Sample 404 error *Update Credit Card by User Profile* response body:

```
{
  "httpStatus": 404,
  "code": "99152",
  "timestamp": 1427304058885,
  "service": "storedpayments",
  "message": "No payment found for id 99051"
}
```
<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/storedpayments/browse/API.md#!/default/put_consumer_storedpayments_payment_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

#### <a name="update-default-stored-payment-by-user-profile"></a>Update Default Stored Payment by User Profile

---

Use this endpoint to set a Stored Payment to the default payment. It removes the default flag on the current default Saved Payment and adds it to the Saved Payment matching the payment_id path parameter. The default payment type is typically used by the client to pre-select a payment method in the shopping flow.

This is a synchronous endpoint.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PUT**|`/consumer/storedpayments/{payment_id}/default`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**payment_id**|Path|Unique identifier <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> of Stored Payment to make default|String|Required|

#### <a name="update-default-stored-payment-by-user-profile-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="update-default-stored-payment-by-user-profile-request-body"></a>Request Body

No body is required.

Sample *Update Default Stored Payment by User Profile* request URI:

```
http://api.nike.com/consumer/storedpayments/7661aea5d-31b6-4ac4-8830-1d61d2c7b043/default
```

#### <a name="update-default-stored-payment-by-user-profile-response-body"></a>Response Body

The HTTP 202 response from *Update Default Stored Payment by User Profile* contains the results. Following are descriptions of the important fields in the response body:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**status**|string|"success" present when information was updated successfully|Optional|
|**httpStatus**|integer|Status code present when service returns in error and httpStatus is not 202|Optional|
|**timestamp**|integer|Timestamp present when service returns in error|Optional|
|**message**|string|Error message present when service returns in error|Optional|
|**service**|string|Name of service, always storedpayments|Optional|
|**code**|string|Error code|Optional|

Sample 202 success *Update Default Stored Payment by User Profile* response body:

```
{
  "status": "success"
}
```
Sample 404 error *Update Default Stored Payment by User Profile* response body:

```
{
  "httpStatus": 404,
  "code": "99152",
  "timestamp": 1427304058885,
  "service": "storedpayments",
  "message": "No payment found for id 99051"
}
```
<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/storedpayments/browse/API.md#!/default/put_consumer_storedpayments_payment_id_default" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

#### <a name="delete-stored-payment-by-id"></a>Delete Stored Payment by ID

---

Use this endpoint to delete a stored payment by id. For example, this endpoint would be called when the customer deletes a stored payment when managing their payment information in the experience.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**DELETE**|`/consumer/storedpayments/{payment_id}`|no|

#### Path & Query Parameters

|Parameter|Description|Data Type|Required?|
|---|---|---|---|
|**payment_id**|Unique identifier <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> of the Stored Payment to delete|String|Required|

#### <a name="delete-all-stored-payments-for-user-profile-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="delete-all-stored-payments-for-user-profile-request-body"></a>Request Body

No request body required.

Sample *Delete Stored Payment by ID* URI request:

```
https://api.nike.com/consumer/storedpayments/pid3798fdd8-6e0d-4f88-bddb-5ad25eefda18
```

#### <a name="delete-all-stored-payments-for-user-profile-response-body"></a>Response Body

The HTTP 204 response from *Delete Stored Payment by ID* returns no content.

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**httpStatus**|integer|Status code present when service returns in error and httpStatus is not 202|Optional|
|**timestamp**|integer|Timestamp present when service returns in error|Optional|
|**message**|string|Error message present when service returns in error|Optional|
|**service**|string|Name of service, always storedpayments|Optional|
|**code**|string|Error code|Optional|

Sample 400 error response:
```
{
  "httpStatus": 400,
  "code": "99154",
  "timestamp": 1427304058885,
  "service": "storedpayments",
  "message": "One or more required parameters missing.."
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/storedpayments/browse/API.md#!/default/delete_consumer_storedpayments_payment_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

#### <a name="validate-credit-card-cvv-by-shipping-address"></a>Validate Credit Card CVV by Shipping Address

---

This endpoint validates a CVV based on the request shipping address. If the shipping address does not match a shipping address on a past order or is not sent, the response indicates that the CVV needs to be validated. Note that billing address is returned.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**POST**|`/consumer/storedpayments/{payment_id}`|yes|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**payment_id**|Path|Unique identifier <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> for this Stored Payment|String|Required|

#### <a name="validate-credit-card-cvv-by-shipping-address-request-headers"></a>Request Headers

|HeaderName|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|
|**X-Nike-AppId**|Client application id calling this service (as listed in Eureka) used to verify endpoint access|Required|
|**X-Nike-Authorization**|JWT signed by client application|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="validate-credit-card-cvv-by-shipping-address-request-body"></a>Request Body

Shipping address is optional but if sent, the required and optional fields are listed below.

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**address1**|string|Shipping address line 1|Required|
|**address2**|string|shipping address line 2|Optional|
|**address3**|string|Shipping address line 3|Optional|
|**city**|string|Shipping address city|Required|
|**state**|string|shipping address state|Optional|
|**postalCode**|string|Shipping address postal code|Optional|
|**country**|type|Shipping address country|Required|

Sample *Validate Credit Card CVV by Shipping Address* request body:
```
{
  "address1": "One Bowerman Drive",
  "address2": "",
  "address3": "",
  "city": "Beaverton",
  "state": "OR",
  "postalCode": "97005",
  "country": "US"
}
```

##### <a name="validate-credit-card-cvv-by-shipping-address-response-body"></a>Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**paymentId**|string|UUID payment ID|Optional|
|**type**|string|Payment type CreditCard, ApplePay etc.|Required|
|**cardType**|string|Type of credit card, e.g. Visa|Optional|
|**balance**|number|Balance of gift card|Optional|
|**accountNumber**|string|Masked account number|Required|
|**expiryYear**|string|Year credit card expires|Optional|
|**expiryMonth**|string|Month credit card expires|Optional|
|**isDefault**|boolean|True indicates this payment method is the default|Optional|
|**paymentToken**|string|Token common to different systems such as CyberSource|Required|
|**name**|string|Nickname for the stored payment|Optional|
|**validateCVV**|boolean|True indicates the customer needs to revalidate the credit card CVV before purchase|Optional|
|**pin**|string|Gift card PIN|Optional|
|**gcExpiryDate**|string|Gift card expiration date|Optional|
|**currency**|string|ISO currency code for gift card|Optional|
|**status**|string|Status of gift card, one of valid or invalid|Optional|
|**billingAddress**|object|Customer's billing address object|Optional|
|billingAddress.**firstName**|string|Billing first name|Required|
|billingAddress.**lastName**|string|Billing last name|Required|
|billingAddress.**address1**|string|Billing address line 1|Required|
|billingAddress.**address2**|string|Billing address line 2|Optional|
|billingAddress.**address3**|string|Billing address line 3|Optional|
|billingAddress.**city**|string|Billing city|Required|
|billingAddress.**postalCode**|string|Billing postal code|Optional|
|billingAddress.**state**|string|Billing state|Optional|
|billingAddress.**country**|string|Billing country|Required|
|billingAddress.**phoneNumber**|string|Billing phone number|Optional|
|billingAddress.**email**|string|Billing email address|Optional|
|**httpStatus**|integer|Status code present when service returns in error and httpStatus is not 200|Optional|
|**timestamp**|integer|Timestamp present when service returns in error|Optional|
|**message**|string|Error message present when service returns in error|Optional|
|**service**|string|Name of service, always storedpayments|Optional|
|**code**|string|Error code|Optional|

Sample *Validate Credit Card CVV by Shipping Address* 200 response body for credit card:
```
{
  "type": "CreditCard",
  "cardType": "VISA",
  "accountNumber": "XXXXXXXXXXXX1111",
  "expiryYear": "2018",
  "expiryMonth": "3",
  "isExpired": false,
  "isDefault": true,
  "paymentToken": "4383642751515000001516",
  "validateCVV": true,
  "billingAddress": {
    "email": "fromhere@tother.com",
    "firstName": "William",
    "lastName": "Bowerman",
    "address1": "One Bowerman Drive",
    "city": "Springifield",
    "state": "OR",
    "postalCode": "97005",
    "country": "US"
  }
}
```

**This endpoint is unavailable to Try It Out because it is JWT-restricted**

## <a name="using-payment-preview"></a>Using Payment Preview

---

- [Payment Preview](#payment-preview)
- [Payment Preview Job Status by ID](#payment-preview-job-status-by-id)
- [Payment Preview Result by ID](#payment-preview-result-by-id)

This service is used to preview the allocation of payment amounts across one or more payment methods selected by the customer.

### Payment Preview Overview

Nike customers can pay by one or more gift cards/Vouchers and another payment type such as PayPal or credit card. The Payment Preview service allocates payment to the gift card/Voucher with the highest balance first and then to the rest of the gift cards on Checkout in ascending balance order. If the total balance of all gift cards/Vouchers is less than the order amount, the service allocates the balance of the order to a second payment type.

### <a name="payment-preview"></a>Payment Preview

The paymentPreviewId returned by this service is a required key when calling [Request Checkout Submit](/doc/commerce/checkout/api_checkout.html#request-checkout-submit) in the BUY API to validate and authorize/debit payment before submitting a Checkout to Nike for fulfillment.

This endpoint operates **asynchronously** which means that there are extra steps to retrieve the results of your request. Read the Asynchronous Operation section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#asynchronous-operation) guide to learn more about working with asynchronous Nike APIs.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**POST**|`/payment/preview/v2{?fields}`|no|

#### Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### Path & Query Parameters

|Element Name|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**fields**|Parameter|Comma-separated list of keys to return in response e.g. `fields=total,currency`|string|Optional|

#### Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**checkoutId**|string|Checkout <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> payments are associated to. Typically generated by [Using Checkouts](/doc/commerce/checkout/api_checkout.html#using-checkouts).|Required|
|**total**|double|Checkout total amount|Required|
|**currency**|string|See [supported currency codes](/doc/commerce/checkout/checkout_country_currency.html)|Required|
|**country**|string|See <a href="https://confluence.nike.com/pages/viewpage.action?pageId=162870810" target="_blank">supported country codes</a>|Required|
|**clientBrowser**|string|Browser request was made from, `WECHAT` required for WeChat type, otherwise null|Optional|
|**walletId**|string|`paymentToken` returned from [PayPal Mark](#paypal-mark) endpoint,required for PayPal Mark|Optional|
|**items**|array|Array of Checkout `items`. Each of the `items` has a UUID `productId` and `shippingAddress` object|Required|
|items.**productId**|string|Product UUID of item|Required|
|items.**shippingAddress**|object|Shipping address of customer|Required|
|items.shippingAddress.**address1**|string|Shipping address line 1|Required|
|items.shippingAddress.**address2**|string|Shipping address line 2|Optional|
|items.shippingAddress.**address3**|string|Shipping address line 3|Optional|
|items.shippingAddress.**city**|string|Shipping address city|Required|
|items.shippingAddress.**state**|string|Shipping address state|Optional|
|items.shippingAddress.**postalCode**|string|Shipping address postal code|Optional|
|items.shippingAddress.**country**|string|Shipping address country ISO code|Required|
|items.shippingAddress.**county**|string|Shipping address county, holds non-US regional data, required in CN and JP|Optional|
|**paymentInfo**|array|Array of `paymentInfo`, one for each Checkout payment type, required except for [PayPal Mark](#paypal-mark) flow|Required|
|paymentInfo.**id**|string|UUID payment id generated by the caller|Required|
|paymentInfo.**paymentId**|string|`paymentId` returned from Stored Payment service if this is a non-GiftCard Stored Payment, required for payment that is stored in Stored Payment|Optional|
|paymentInfo.**type**|string|See [Supported Payment Types](#supported-stored-payment-types)|Required|
|paymentInfo.**cardType**|string|Type of credit card, e.g. MasterCard|Optional|
|paymentInfo.**creditCardInfoId**|string|UUID token used to look up credit card data, required for CreditCard type that is not stored|Optional|
|paymentInfo.**paymentData**|string|Encrypted clob signature returned from ApplePay Service, required for ApplePay type|Optional|
|paymentInfo.**accountNumber**|string|Gift card number or masked credit card number|Optional|
|paymentInfo.**giftCardPin**|string|PIN number for gift card|Optional|
|paymentInfo.**bankName**|string|Bank name for deferred payment type, required for iDeal type; optional for Alipay, Tenpay, Unionpay|Optional|
|paymentInfo.**paypalToken**|string|PayPal-assigned Token, required for PayPal Mark and Express flows|Optional|
|paymentInfo.**dateOfBirth**|string|Customer's date of birth, required for Klarna payment type in AT, DE, NL billing countries|Optional|
|paymentInfo.**gender**|string|Customer's gender, required for Klarna payment type in AT, DE, NL billing countries, one of MALE, FEMALE, UNKNOWN|Optional|
|paymentInfo.**personalId**|string|Customer's personal ID number, required for Klarna payment type in some billing countries|Optional|
|paymentInfo.**returnURL**|string|Nike URL to return to after customer successfully pays for an order at a third party site, required for Sofort and iDeal|Optional|
|paymentInfo.**cancelURL**|string|Nike URL to return to after customer cancels paying for an order at a third party site, required for Sofort and iDeal|Optional|
|paymentInfo.**businessName**|string|Business name where customer pays for order in person, required for Konbini, one of SevenEleven, Kmart, FamilyMart, Payease, Lawson, CircleKSuncus, Ministop|Optional|
|paymentInfo.**billingInfo**|object|Object containing `name`, `address`, `contactInfo` objects|required for all payment methods except PayPal|Required|
|paymentInfo.billingInfo.**name**|string|Billing name information|Required|
|paymentInfo.billingInfo.name.**firstName**|string|Billing first name|Required|
|paymentInfo.billingInfo.name.**altFirstName**|string|Billing alternate first name|Optional|
|paymentInfo.billingInfo.name.**lastName**|string|Billing last name|Required|
|paymentInfo.billingInfo.name.**altLastName**|string|Billing alternate last name|Optional|
|paymentInfo.billingInfo.name.**middleName**|string|Billing middle name|Optional|
|paymentInfo.billingInfo.**address**|object|Billing address information|Required|
|paymentInfo.billingInfo.address.**address1**|string|Billing address line 1|Required|
|paymentInfo.billingInfo.address.**address2**|string|Billing address line 2|Optional|
|paymentInfo.billingInfo.address.**address3**|string|Billing address line 3|Optional|
|paymentInfo.billingInfo.address.**city**|string|Billing address city|Required|
|paymentInfo.billingInfo.address.**state**|string|Billing address state|Optional|
|paymentInfo.billingInfo.address.**postalCode**|string|Billing address postalCode|Optional|
|paymentInfo.billingInfo.address.**country**|string|Billing address country|Required|
|paymentInfo.billingInfo.**contactInfo**|object|Billing contact information|Required|
|paymentInfo.billingInfo.contactInfo.**phoneNumber**|string|Billing contact phone number|Required|
|paymentInfo.billingInfo.contactInfo.**email**|string|Billing contact email address|Required|

PaymentInfo for CreditCard type has a required creditCardInfoId generated from the *Stored CreditCard Info* service if payment is not stored in Stored Payment. This is a PCI-required token used to look up credit card information.

Sample *Payment Preview* request for one gift card and one credit card that is not stored:

```
{
    "checkoutId": "15611769-e81b-45dd-b28c-ca0effb272de34",
    "total": 350.75,
    "currency": "USD",
    "country": "US",
    "items": [
      {
        "productId": "15611769-e81b-45dd-b28c-ca0effb272de",
        "shippingAddress": {
          "address1": "One Bowerman Drive",
          "address2": "",
          "address3": "",
          "city": "Beaverton",
          "state": "OR",
          "postalCode": "97005",
          "country": "US",
          "county": "Hampden"
        }
      }
    ],
    "paymentInfo": [
      {
        "id": "15611769-e81b-45dd-b28c-ca0effb272de88",
        "type": "GiftCard",
        "paymentId": "15611769-e81b-45dd-b28c-ca0effb272de212",
        "billingInfo": {
          "name": {
            "firstName": "Theordore",
            "altFirstName": "",
            "lastName": "Bowerman",
            "altLastName": "",
            "middleName": ""
          },
          "address": {
            "address1": "One Bowerman Drive",
            "address2": "",
            "address3": "",
            "city": "Beaverton",
            "state": "OR",
            "postalCode": "97005",
            "country": "US"
          },
          "contactInfo": {
            "phoneNumber": "413-555-1234",
            "email": "test@nike.com"
          }
        }
      },
      {
        "id": "15611769-e81b-45dd-b28c-ca0effb272de94032",
        "type": "CreditCard",
        "paymentId": "15611769-e81b-45dd-b28c-ca0effb272de342",
        "creditCardInfoId": "15611769-e81b-45dd-b28c-ca0effb272de4302948",
        "billingInfo": {
          "name": {
            "firstName": "William",
            "altFirstName": "",
            "lastName": "Bowerman",
            "altLastName": "",
            "middleName": ""
          },
          "address": {
            "address1": "One Bowerman Drive",
            "address2": "",
            "address3": "",
            "city": "Beaverton",
            "state": "OR",
            "postalCode": "97005",
            "country": "US"
          },
          "contactInfo": {
            "phoneNumber": "413-555-1234",
            "email": "test@nike.com"
          }
        }
      }
    ]
  }
  ```

Sample PayPal Mark *Payment Preview* request:

>**TIP:** Request must include `walletId` and not include `paymentInfo`

```
{
  "checkoutId": "05830580385038953405-r34-5r",
  "total": 266.98,
  "currency": "USD",
  "country": "US",
  "walletId": "EC-1234567ABC",
  "items": [
    {
      "productId": "15611769-e81b-45dd-b28c-ca0effb272de",
      "shippingAddress": {
        "address1": "One Bowerman Drive",
        "address2": "",
        "address3": "",
        "city": "Beaverton",
        "state": "OR",
        "postalCode": "97005",
        "country": "US",
        "county": "Hampden"
      }
    }
  ]
}
```

Sample PayPal Express *Payment Preview* request:

>**TIP:** Request must not include `walletId` and include `paymentInfo`

```
{
  "checkoutId": "4424253",
  "total": 300.00,
  "currency": "USD",
  "country": "US",
  "items": [
    {
      "productId": "e8791c09-cd7e-5b72-bab3-5d3490c2bd06",
      "shippingAddress": {
        "address1": "One Bowerman Drive",
        "address2": "",
        "address3": "",
        "city": "Beaverton",
        "state": "OR",
        "postalCode": "97005",
        "country": "US",
        "county": "Hampden"
      }
    }
  ],
  "paymentInfo": [
    {
      "id": "101",
      "type": "Paypal",
      "paypalToken": "EC-72492839482349237498",
      "billingInfo": {
        "name": {
          "firstName":"William",
          "altFirstName": "Theo",
          "lastName":"Bowerman",
          "altLastName":"",
          "middleName":""
        },
        "address": {
          "address1":"One Bowerman Drive",
          "address2":"",
          "address3":"",
          "city":"Beaverton",
          "state":"OR",
          "postalCode":"97005",
          "country":"US"
        },
        "contactInfo": {
          "phoneNumber":"503-555-1234",
          "email":"test@nike.com"
        }
      }
    }
  ]
}
```

Sample Apple Pay *Payment Preview* request|

>**TIP:** Request must include encrypted `paymentData`

```
{
  "checkoutId": "05830580385038953405-r34-5r",
  "total": 266.98,
  "currency": "USD",
  "country": "US",
  "items": [
    {
      "productId": "15611769-e81b-45dd-b28c-ca0effb272de",
      "shippingAddress": {
            "address1": "One Bowerman Drive",
            "address2": "",
            "address3": "",
            "city": "Beaverton",
            "state": "OR",
            "postalCode": "97005",
            "country": "US",
            "county": "Hampden"
      }
    }
  ],
  "paymentInfo": [
    {
      "id": "900281409857-8180234802395",
      "paymentId": "13290498923403275",
      "type": "ApplePay",
      "cardType": "Visa",
      "accountNumber": "xxxxxxxxxxxx1234",
      "paymentData": "someEncryptedClob",
      "billingInfo": {
        "name": {
          "firstName":"William",
          "altFirstName": "Theo",
          "lastName":"Bowerman",
          "altLastName":"",
          "middleName":""
        },
        "address": {
            "address1": "One Bowerman Drive",
            "address2": "",
            "address3": "",
            "city": "Beaverton",
            "state": "OR",
            "postalCode": "97005",
            "country": "US"
        },
        "contactInfo": {
          "phoneNumber":"503-555-1234", 
          "email":"test@nike.com"
        }
      }
    }
  ]
}
```

Sample WeChat *Payment Preview* request:

>**TIP:** Request must include "WECHAT" in `clientBrowser`

```
{
  "checkoutId": "05830580385038953405-r34-5r",
  "total": 266.98,
  "currency": "CNY",
  "country": "CN",
  "clientBrowser": "WECHAT",
  "items": [
    {
      "productId": "15611769-e81b-45dd-b28c-ca0effb272de",
      "shippingAddress": {
        "address1":"Wangfujing St",
        "address2":"B1层B130-B135COSTA新东安店",
        "address3":"新东安广场1层130-131",
        "city":"Dongchehng",
        "state":"Beijing",
        "country":"CN"
      }
    }
  ],
  "paymentInfo": [
    {
      "id": "284621849629347214e82",
      "type": "Alipay",
      "paymentId": "9085329583043242325",
      "billingInfo": {
        "name": {
          "firstName":"耐克专卖店",
          "altFirstName": "",
          "lastName":"北京",
          "altLastName":"",
          "middleName":""
        },
        "address": {
          "address1":"Wangfujing St",
          "address2":"B1层B130-B135COSTA新东安店",
          "address3":"新东安广场1层130-131",
          "city":"Dongchehng",
          "state":"Beijing",
          "country":"CN"
        },
        "contactInfo": {
          "phoneNumber":"+86 10 8518 6164",
          "email":"email@nike.com"
        }
      }
    }
  ]
}
```

Sample Klarna *Payment Preview* request:

```
{
  "checkoutId": "4424253",
  "total": 220.00,
  "currency": "ATS",
  "country": "AT",
  "items": [
    {
      "productId": "e8791c09-cd7e-5b72-bab3-5d3490c2bd06",
      "shippingAddress": {
        "address1": "1000 NW Alps Ave",
        "address2": "",
        "address3": "",
        "city": "Rafing",
        "state": "Holla",
        "postalCode": "7081",
        "country": "AT",
        "county": "Wallafred"
      }
    }
  ],
  "paymentInfo": [
    {
      "id": "101",
      "type": "Klarna",
      "dateOfBirth": "1988-01-01",
      "gender": "MALE",
      "personalId": "112233",

      "billingInfo": {
        "name": {
          "firstName": "Hans",
          "altFirstName": "",
          "lastName": "Hauferman",
          "altLastName": "",
          "middleName": ""
        },
        "address": {
          "address1": "1000 NW Alps Ave",
          "address2": "RG-2092",
          "address3": "#123",
          "city": "Rafing",
          "state": "Holla",
          "postalCode": "7081",
          "country": "AT"
        },
        "contactInfo": {
          "phoneNumber": "998-555-1234",
          "email": "email@nike.com"
        }
      }
    }
  ]
}
```

#### <a name="payment-preview-response-body"></a>Response Body

The HTTP 200 response from *Payment Preview* contains information about how to retrieve the results of your job via the *Payment Preview Job* endpoint. Listed below are the response body fields.

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|UUID job ID generated by the endpoint, used to look up the job status|Required|
|**status**|string|Status of the job. one of "PENDING", "IN_PROGRESS", "COMPLETED"|Required|
|**eta**|integer|Time in milliseconds to wait before polling the jobs endpoint to get your results, present when status is not "COMPLETED"|Required|
|**resourceType**|string|Enum always payment/preview/jobs|Required|
|**links**|string|Relative URL path to poll the jobs endpoint (see nested `ref` field)|Required|
|**response**|object|Populated when job is in "COMPLETED" status, this object gives details of your payment preview result|Optional|
|response.**id**|string|UUID of preview results|Required|
|response.**resourceType**|string|Enum, always payment/preview_results|Required|
|response.**total**|number|Total amount|Required|
|response.**currency**|string|Currency of total amount|Required|
|response.**payments**|array|Array of payment objects|Required|
|response.payments.**id**|string|ID of this payment method|Required|
|response.payments.**type**|string|One of "CreditCard", "GiftCard", "Paypal", "ApplePay", "Sofort", "iDeal", "Klarna", "COD", "Alipay", "Tenpay", "UnionPay", "WeChat", "Konbini", "Promotion", "AndroidPay"|Required|
|response.payments.**amount**|number|Amount allocated to this payment method|Required|
|response.payments.**bankName**|string|Bank name for this payment method for AliPay, TenPay and UnionPay|Optional|
|response.payments.**businessName**|string|Business name for this payment method for Konbini, enum one of "SevenEleven", "Kmart", "FamilyMart", "Payease", "Lawson", "CircleKSuncus", "Ministop"|Optional|
|response.payments.**charge**|number|Additional amount charged for using this payment type|Optional|
|**error**|object|Error object containing details of the cause(s) of error, present when service returns in error|Optional|
|error.**httpStatus**|integer|Status code present when service returns in error|Optional|
|error.**message**|string|Top level error message present when service returns in error|Optional|
|error.**code**|string|Enum of JOB_TIME or SYSTEM_ERROR|Optional|
|error.**id**|string|Error id|Optional|
|**errors**|array|Array of error objects present when service returns in error|Optional|
|error.errors.**field**|string|JSON field name causing error|Required|
|error.errors.**code**|string|Enum of error codes, one of "MISSING_REQUIRED","INVALID_FIELD","INVALID_JSON","INVALID_PAYMENT_TYPE"|Required|
|error.errors.**message**|string|Error message|Required|

>**TIP:** `Promotion` is an indicator that the entire order is allocated to a promotion.

Sample *Payment Preview* 202 response with an IN_PROGRESS status:

```
{
   "id":"4dbe5dc7-6b0d-41fe-b276-b17393a3yrtd",
   "status":"IN_PROGRESS",
   "resourceType":"job",
   "links":{
      "result":{
         "ref":"/payment/preview_results/v2/4dbe5dc7-6b0d-41fe-b276-b17393a3yrtd"
      },
      "self":{
         "ref":"/payment/preview/v2/jobs/4dbe5dc7-6b0d-41fe-b276-b17393a3yrtd"
      }
   }
}
```

Sample *Payment Preview* 400 error response:

```
{
    "message": "Validation Failed",
    "errors": [
      {
        "field": "total",
        "code": "INVALID_FIELD",
        "message": "Invalid value."
      },
      {
        "field": "checkoutId",
        "code": "MISSING_REQUIRED",
        "message": "Required field"
      },
      {
        "field": "paymentInfo[1].type",
        "code": "INVALID_PAYMENT_TYPE",
        "message": "Not supported payment method."
      }
    ]
  }
```

Sample *Payment Preview* request with "COMPLETED" status with the amount allocated across two gift cards and one credit card. Because the job is complete, the response does not contain an eta field.

```
{
  "id": "2722be3a-0341-11e6-b512-3e1d05defe783424",
  "resourceType": "payment/preview/jobs",
  "status": "COMPLETED",
  "links": {
    "self": {
      "ref": "/payment/preview/v2/jobs/2722be3a-0341-11e6-b512-3e1d05defe78432"
    }
  },
  "response": {
    "resourceType": "payment/preview_results",
    "id": "5803485039503495",
    "total": 305.99,
    "currency": "USD",
    "payments": [
      {
        "id": "48204830259030503850935",
        "type": "GiftCard",
        "amount": 100.95
      },
      {
        "id": "9804823040234902",
        "type": "GiftCard",
        "amount": 99.05
      },
      {
        "id": "48204830259034230",
        "type": "CreditCard",
        "amount": 105.99
      }
    ],
    "links": {
      "self": {
        "ref": "/payment/preview_results/v2/2722be3a-0341-11e6-b512-3e1d05defe783424"
      }
    }
  }
}
```

|Error Code|Description|
|---|---|
|INVALID_FIELD|Returned when request contains an invalid field value|
|MISSING_REQUIRED|Returned when request is missing a required field value|
|INVALID_PAYMENT_TYPE|Returned when request contains an invalid payment type|

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentpreview/browse/API.md#!/Payment_Preview/post_payment_preview_v2" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="payment-preview-job-status-by-id"></a>Payment Preview Job Status by ID

---

Use this endpoint to check the status of the *Payment Preview* job. After receiving a HTTP 202 from the *Payment Preview* call and waiting the duration of the **eta** time, call *Payment Preview Job Status by ID* using the same UUID to check the status of your job. If the status is not COMPLETED, continue the cycle of waiting the eta period and checking the job status.

To know if the job is done, check the value of the status field in the response body as follows:
- "status": "PENDING": job processing has not started
- "status": "IN_PROGRESS": job processing in progress
- "status": "COMPLETED": job has completed

Once you receive a job status of "COMPLETED", get the results of your job by parsing the data in the response object from this endpoint. Alternatively, follow the link to the *Payment Preview Job Status by ID* endpoint which is provided in the links object response body.

>**TIP:** Parsing the "COMPLETED" job result directly is a best practice because it eliminates making another service call.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**GET**|`/payment/preview/v2/jobs/{id}{?fields}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique identifier <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> for the job|String|Required|
|**fields**|Query|comma-separated list of fields to return from the response body for a job in the COMPLETED status. If null, all response fields are returned|String|Optional|

#### <a name="payment-preview-job-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.
>
><i class="mr2-sm g72-check"></i>Get the {id} path parameter from the `id` job UUID in the *Payment Preview* response.

Sample *Payment Preview Job by ID* request URI:

```
https://api.nike.com/payment/preview/v2/jobs/2722be3a-0341-11e6-b512-3e1d05defe783424
```

#### <a name="payment-preview-job-response-body"></a>Response Body

The *Payment Preview Job Status by ID* response is identical to the [Payment Preview Response Body](#payment-preview-response-body) except that the resource type value is payment/preview/jobs.

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentpreview/browse/API.md#!/Payment_Preview/get_payment_preview_v2_jobs_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="payment-preview-result-by-id-by-id"></a>Payment Preview Result by ID

---

After calling the *Payment Preview* to start the job and *Payment Preview Job* to check that the status of the job is "COMPLETED", you can optionally call the *Payment Preview Result by ID* endpoint to retrieve the result of the Payment Preview job. It is optional because the Payment Preview result is also returned in the *Payment Preview Job* when it is in "COMPLETED" status.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**GET**|`/payment/preview_results/v2/{id}{?fields}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique identifier <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> for the job|String|Required|
|**fields**|Query|comma-separated list of fields to return from the response body for a job in the COMPLETED status. If null, all response fields are returned|String|Optional|

#### <a name="payment-preview-job-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.
>
><i class="mr2-sm g72-check"></i>Get the {id} path parameter from the `id` job UUID in the *Payment Preview* response.

Sample Payment Preview Results request:
https://api.nike.com/payment/preview_results/v2/2722be3a-0341-11e6-b512-3e1d05defe783424

#### Response Body

The HTTP 200 response from *Payment Preview Job Results* contains information about the results of your job. Listed below are the response body fields.

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**resourceType**|string|Enum always payment/preview_results|Required|
|**id**|string|UUID of preview results|Required|
|**total**|number|Total amount|Required|
|**currency**|string|Currency of total amount|Required|
|**payments**|array|Array of payment objects|Required|
|payments.**id**|string|Id for this payment|Required|
|payments.**type**|string|Enum one of "CreditCard", "GiftCard", "Paypal", "ApplePay", "Sofort", "iDeal", "Klarna", "COD", "Alipay", "Tenpay", "UnionPay", "WeChat", "Konbini", "Promotion", "AndroidPay"|Required|
|payments.**amount**|number|Amount allocated to this payment method|Required|
|payments.**bankName**|string|Bank name for this payment method for AliPay, TenPay and UnionPay|Optional|
|payments.**businessName**|string|Business name for this payment method for Konbini, enum one of "SevenEleven", "Kmart", "FamilyMart", "Payease", "Lawson", "CircleKSuncus", "Ministop"|Optional|
|payments.**charge**|number|Additional amount charged for using this payment type|Optional|
|**links**|string|Relative URL path to poll the jobs endpoint (see nested `ref` field)|Required|

>**TIP:** `Promotion` is an indicator that the entire order is allocated to a promotion.

Sample Payment Preview Results response for two gift cards and a credit card:
```
{
  "resourceType": "payment/preview_results",
  "id": "2722be3a-0341-11e6-b512-3e1d05defe783424",
  "total": 305.99,
  "currency": "USD",
  "payments": [
    {
      "id": "48204830259030503850935",
      "type": "GiftCard",
      "amount": 100.95
    },
    {
      "id": "9804823040234902",
      "type": "GiftCard",
      "amount": 99.05
    },
    {
      "id": "48204830259034230",
      "type": "CreditCard",
      "amount": 105.99
    }
  ],
  "links": {
    "self": {
      "ref": "/payment/preview_results/v2/2722be3a-0341-11e6-b512-3e1d05defe783424"
    }
  }
}
```
<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentpreview/browse/API.md#!/Payment_Preview/get_payment_preview_results_v2_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

## <a name="using-payment-approval"></a>Using Payment Approval

---

- [Submit Order Payments for Approval](#submit-order-payments-for-approval-post)
- [Submit Order Payments for Approval](#submit-order-payments-for-approval-put)
- [Retrieve Payment Approval Job](#retrieve-payment-approval-job)
- [Order Payments Approval Result](#order-payments-approval-result)
- [Void Payment Approval](#void-payment-approval)
- [Get Payment Approval Summary](#get-payment-approval-summary)

### Payment Approval Overview
This service performs fraud check, validation and authorization/debit for all payment types on a customer's Checkout. It must be called after Payment Preview so order allocation is already calculated and the paymentPreviewId is assigned. This service uses the paymentPreviewId to look up the Checkout payment methods so it does not require that the payments be passed in on the request. This service also voids a previous authorization/debit.

This endpoint operates **asynchronously** which means that there are extra steps to retrieve the results of your request. Read the Asynchronous Operation section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#asynchronous-operation) guide to learn more about working with asynchronous Nike APIs.

### <a name="submit-order-payments-for-approval-post"></a>Submit Order Payments for Approval (POST)

---

This service validates the payment allocation performed by the Payment Preview service, recalculating if necessary, and evaluates that the selected payment methods and items on Checkout are valid. If one or more payment type validations fail, all payment type authorizations (in the case of credit cards and PayPal)/debits (in the case of gift cards) are rolled back. There is no need to pass in the Checkout payment types in the body as the service looks them up using the checkoutId and paymentPreviewId in the request body.

>**TIP:** This endpoint is intended to be a service-to-service call. [Request Checkout Submit](/doc/commerce/checkout/api_checkout.html#request-checkout-submit) calls the PaymentApproval endpoint as a last step in the order flow to validate and authorize/debit payment before submitting a Checkout to Nike for fulfillment. A client should not call this service directly.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**POST**|`/payment/approval/v2`|yes|

#### Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|
|**X-Nike-AppId**|Client application id calling this service (as listed in Eureka) used to verify endpoint access|Required|
|**X-Nike-Authorization**|JWT signed by client application|Required|

>**TIP:** When calling this endpoint through the public router, the **upmid** (for logged in customers), **appId** and **usertype** headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**priority**|string|HIGH priority results go into a separate queue and are processed before DEFAULT requests, one of HIGH or DEFAULT. defaults to DEFAULT|Optional|
|**request**|object|Object containing payment approval information|Required|
|request.**checkoutId**|string|UUID generated by the client identifying the Checkout|Required|
|request.**paymentPreviewId**|string|Id returned from Payment Preview service for this Checkout|Required|
|request.**orderNumber**|string|Order number generated by the calling service|Required|
|request.**currency**|string|Shopping currency code. Defaults to USD|Required|
|request.**locale**|string|Locale of shopping country. Defaults to en_US|Optional|
|request.**clientBrowser**|string|Required for WeChat payment type, "WECHAT" or null|Optional|
|request.**organizationCode**|string|Organization code for the business unit. Also referred to as enterpriseCode e.g. NIKEUS|Optional|
|request.**country**|string|ISO code for shopping country|Required|
|request.**priceInfo**|object|Object containing total amount of Checkout|Required|
|request.priceInfo.**price**|number|Net amount of Checkout minus applied discounts|Required|
|request.priceInfo.**discount**|number|Net amount of discounts applied|Optional|
|request.priceInfo.**total**|number|Checkout total amount before discount|Required|
|request.priceInfo.**taxTotal**|number|Total tax amount|Required|
|request.**shippingCost**|object|Object containing total amount of shipping costs|Required|
|request.shippingCost.**price**|number|Net shipping cost|Required|
|request.shippingCost.**discount**|number|Discount applied to shipping cost|Optional|
|request.shippingCost.**total**|number|Total shipping cost|Required|
|request.shippingCost.**taxTotal**|number|Shipping cost tax|Required|
|request.**shippingAddresses**|array|Array of recipient, shippingAddress, contactInfo and shippingMethod objects|Required|
|request.shippingAddresses.**recipient**|object|recipient object|Required|
|request.shippingAddresses.recipient.**firstName**|string|Shipping address first name|Required|
|request.shippingAddresses.recipient.**altFirstName**|string|Shipping address alternate first name|Optional|
|request.shippingAddresses.recipient.**lastName**|string|Shipping address last name|Required|
|request.shippingAddresses.recipient.**altLastName**|string|Shipping address alternate last name|Optional|
|request.shippingAddresses.recipient.**middleName**|string|Shipping address middle name|Optional|
|request.shippingAddresses.**shippingAddress**|object|Shipping address object|Required|
|request.shippingAddresses.shippingAddress.**address1**|string|Shipping address line 1|Required|
|request.shippingAddresses.shippingAddress.**address2**|string|Shipping address line 2|Optional|
|request.shippingAddresses.shippingAddress.**address3**|string|Shipping address line 3|Optional|
|request.shippingAddresses.shippingAddress.**city**|string|Shipping address city|Required|
|request.shippingAddresses.shippingAddress.**state**|string|Shipping address state|Optional|
|request.shippingAddresses.shippingAddress.**postalCode**|string|Shipping address postalCode|Optional|
|request.shippingAddresses.shippingAddress.**country**|string|Shipping address country|Required|
|request.shippingAddresses.shippingAddress.**county**|string|Shipping address county, holds non-US regional data, required in CN and JP|Optional|
|request.shippingAddresses.**contactInfo**|object|Shipping address contact info object|Required|
|request.shippingAddresses.contactInfo.**phoneNumber**|string|Shipping address contact info phone number|Required|
|request.shippingAddresses.contactInfo.**email**|string|Shipping address contact info email address|Required|
|**request.shippingAddresses.**shippingMethod**|object|Shipping method object|Required|
|request.shippingAddresses.shippingMethod.**id**|string|Shipping method identifier|Required|
|request.shippingAddresses.shippingMethod.**cost**|number|Cost of shipping method|Required|
|request.shippingAddresses.shippingMethod.**daysToArrive**|integer|Number of days it takes the inventory to travel from warehouse to customer|Required|
|request.shippingAddresses.shippingMethod.**estimatedDelivery**|string|Estimated date of arrival at customer shipping address, in milliseconds|Required|
|request.shippingAddresses.**promotionDetails**|array|Array of promotion details|Optional|
|request.shippingAddresses.promotionDetails.**displayName**|string|Promotion display name|Required|
|request.**items**|array|Array of Checkout items|Required|
|request.items.**quantity**|integer|Amount of this item|Required|
|request.items.**skuId**|string|Stock keeping unit of this item|Required|
|request.items.**priceInfo**|array|Array of priceInfo objects, one for each item in Checkout|Required|
|request.items.priceInfo.**price**|number|Net price of item/service|Required|
|request.items.priceInfo.**discount**|number|Discount applied to item/service|Optional|
|request.items.priceInfo.**total**|number|Total price for item/service (price - discount)|Required|
|request.items.priceInfo.**taxTotal**|number|Tax due for item/service|Required|
|request.items.**promotionDetails**|array|Array of promotion objects applied to each item/service|Optional|
|request.items.promotionDetails.**promotionId**|string|Id of promotion|Required|
|request.items.promotionDetails.**couponCode**|string|Coupon code of promotion|Optional|
|request.items.promotionDetails.**displayName**|string|Display name of promotion|Required|
|request.**clientInfo**|object|Contains information about client making the Payment Approval request|Required|
|request.clientInfo.**deviceId**|string|'Fingerprint' of the device making the request|Optional|
|request.clientInfo.**ipAddress**|string|IP address of the client making the request|Optional|

Sample *Submit Order Payments for Approval* request body:
```
{
  "priority": "HIGH",
  "request": {
    "checkoutId": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
    "paymentPreviewId": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
    "orderNumber": "C000000123456",
    "currency": "USD",
    "locale": "en_US",
    "organizationCode": "NIKEUS",
    "country": "US",
    "priceInfo": {
      "price": 208,
      "discount": 0,
      "total": 228.8,
      "taxTotal": 20.8
    },
    "shippingCost": {
      "price": 8,
      "discount": 0,
      "total": 8,
      "taxTotal": 0.8
    },
    "shippingAddresses": [
      {
        "recipient": {
          "firstName": "William",
          "altFirstName": "Dr.",
          "lastName": "Bowerman",
          "altLastName": "Suess",
          "middleName": ""
        },
        "shippingAddress": {
          "address1": "One Bowerman Drive",
          "address2": "",
          "address3": "",
          "city": "Beaverton",
          "state": "OR",
          "postalCode": "97005",
          "country": "US"
        },
        "contactInfo": {
          "phoneNumber": "781-555-1212",
          "email": "test@nike.com"
        },
        "shippingMethod": {
          "id": "STANDARD",
          "cost": 8,
          "daysToArrive": 5,
          "estimatedDelivery": "2016-02-09T00:00:00.000Z"
        },
        "promotionDetails": [
          {
            "promotionId": "1",
            "couponCode": "1",
            "displayName": "Free Ship"
          }
        ]
      }
    ],
    "items": [
      {
        "quantity": 1,
        "skuId": "15611769-e81b-45dd-b28c-ca0effb272de",
        "priceInfo": {
          "price": 200,
          "discount": 0,
          "total": 220,
          "taxTotal": 20
        },
        "promotionDetails": [
          {
            "promotionId": "1",
            "couponCode": "1",
            "displayName": "10% Off Jordan"
          }
        ]
      }
    ],
    "clientInfo": {
      "deviceId": "deviceFingerprintGeneratedByToolSuchAsIOVation",
      "ipAddress": "127.0.0.1"
    }
  }
}
```

#### <a name="submit-order-payments-for-approval-response-body"></a>Response Body

The HTTP 202 response from *Submit Order Payments for Approval* contains information about how to retrieve the results of your job via the *Retrieval Payment Approval Job* endpoint. The response body fields are listed below.

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|UUID job ID generated by the endpoint, used to look up the job status|Required|
|**status**|string|Status of the job. one of "PENDING", "IN_PROGRESS", "COMPLETED"|Required|
|**eta**|integer|Time in milliseconds to wait before polling the jobs endpoint to get your results, present when status is not "COMPLETED"|Required|
|**resourceType**|string|Enum, always "job"|Required|
|**links**|string|Relative URL path to poll the jobs endpoint (see nested `ref` field)|Required|
|**response**|object|Populated when job is in "COMPLETED" status, this object gives details of your payment preview result|Optional|
|response.**id**|string|UUID of approval results|Required|
|response.**orderNumber**|string|Order number generated by the calling service|Required|
|response.**fraudDecision**|string|Results of fraud check, enum of "approve", "decline", "review", "unknown"|Required|
|response.**status**|string|Result of payment approval request. if fraudDecision is "decline", status is "REJECT". enum of "ACCEPT", "PENDING_PAYMENT", "REJECT"|Required|
|response.**payments**|array|Array of payments objects for the payment approval request|Required|
|response.payments.**authId**|string|UUID for the payment authorization|Required|
|response.payments.**paymentId**|string|UUID for the payment on this order|Required|
|response.payments.**account**|string|Merchant account used for the transaction|Optional|
|response.payments.**currency**|string|ISO currency code used for the transaction|Optional|
|response.payments.**requestId**|string|Vendor-provided request ID|Optional|
|response.payments.**requestToken**|string|Vendor-provided request token|Optional|
|response.payments.**balance**|number|Gift card balance|Optional|
|response.payments.**debitAmount**|number|Amount of the transaction|Optional|
|response.payments.**pin**|string|Gift card PIN|Optional|
|response.payments.**reconciliationId**|string|Vendor-provided reconciliationId|Optional|
|response.payments.**accountNumber**|string|Account number or gift card number|Optional|
|response.payments.**expirationDate**|string|Gift card expiration date|Optional|
|response.payments.**cvCode**|string|Credit card CVV validation code|Optional|
|response.payments.**subscriptionId**|string|Vendor-supplied subscriptionId for credit card|Optional|
|response.payments.**cardNumber**|string|Masked credit card number|Optional|
|response.payments.**cardType**|string|Type of credit card, e.g. MasterCard|Optional|
|response.payments.**expirationMonth**|string|Month credit card expires|Optional|
|response.payments.**expirationYear**|string|Year credit card expires|Optional|
|response.payments.**responseType**|string|Third party vendor-supplied responseType|Optional|
|response.payments.**authorizationAmount**|number|Amount authorized for the transaction|Optional|
|response.payments.**authorizationExpiration**|string|Date authorization expires after which payment approval must be requested again|Optional|
|response.payments.**transactionTimestamp**|string|Timestamp of transaction|Optional|
|response.payments.**authorizationCode**|string|Authorization code of transaction|Optional|
|response.payments.**avsCode**|string|Vendor-supplied address verification code for transaction|Optional|
|response.payments.**referenceCode**|string|PayPal-supplied reference code|Optional|
|response.payments.**createSubscription**|boolean|True indicates subscription id will be created for this transaction|Optional|
|response.payments.**billingAgreementId**|string|PayPal-supplied billing agreement id|Optional|
|response.payments.**createBillingAgreement**|boolean|True indicates PayPal billing agreement will be created for this transaction|Optional|
|response.payments.**payer**|string|Customer's email address for PayPal|Optional|
|response.payments.**payerId**|string|PayPal-supplied payerId|Optional|
|response.payments.**payerStatus**|string|PayPal payer status|Optional|
|response.payments.**paypalOrderId**|string|PayPal-supplied order ID|Optional|
|response.payments.**paypalToken**|string|PayPal-supplied token|Optional|
|response.payments.**billingInfo**|object|object containing name, address, and contactInfo objects|Optional|
|response.payments.billingInfo.**name**|object|Object containing customer's name information|Required|
|response.payments.billingInfo.name.**firstName**|string|Shipping address first name|Required|
|response.payments.billingInfo.name.**altFirstName**|string|Shipping address alternate first name|Optional|
|response.payments.billingInfo.name.**lastName**|string|Shipping address last name|Required|
|response.payments.billingInfo.name.**altLastName**|string|Shipping address alternate last name|Optional|
|response.payments.billingInfo.name.**middleName**|string|Shipping address middle name|Optional|
|response.payments.billingInfo.**address**|object|Object containing customer's address information|Required|
|response.payments.billingInfo.address.**address1**|string|Shipping address line 1|Required|
|response.payments.billingInfo.address.**address2**|string|Shipping address line 2|Optional|
|response.payments.billingInfo.address.**address3**|string|Shipping address line 3|Optional|
|response.payments.billingInfo.address.**city**|string|Shipping address city|Required|
|response.payments.billingInfo.address.**state**|string|Shipping address state|Optional|
|response.payments.billingInfo.address.**postalCode**|string|Shipping address postalCode|Optional|
|response.payments.billingInfo.address.**country**|string|Shipping address country|Required|
|response.payments.billingInfo.**contactInfo**|object|Object containing customer's contact information|Required|
|response.payments.billingInfo.contactInfo.**phoneNumber**|string|Shipping address contact info phone number|Required|
|response.payments.billingInfo.contactInfo.**email**|string|Shipping address contact info email address|Required|
|**error**|object|Error object containing details of the cause(s) of error, present when service returns in error|Optional|
|error.**httpStatus**|integer|Status code present when service returns in error|Optional|
|error.**message**|string|Top level error message present when service returns in error|Optional|
|error.**code**|string|Enum of JOB_TIME or SYSTEM_ERROR|Optional|
|error.**id**|string|Error id|Optional|
|**errors**|array|Array of error objects present when service returns in error|Optional|
|error.errors.**field**|string|JSON field name causing error|Required|
|error.errors.**code**|string|Enum of error codes, one of "MISSING_REQUIRED","INVALID_FIELD","INVALID_JSON","INVALID_PAYMENT_TYPE"|Required|
|error.errors.**message**|string|Error message|Required|

Sample **Submit Order Payments for Approval** 202 response with an IN_PROGRESS status:

```
{
  "id": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
  "status": "IN_PROGRESS",
  "eta": 5000,
  "resourceType": "job",
  "links": {
    "self": {
      "ref": "/payment/approval/v2/jobs/ae6575a7-8c0e-44ef-b91b-440bdaf2070b"
    }
  }
}
```

Sample **Submit Order Payments for Approval** 400 error response:

```
{
  "message": "Validation Failed",
  "errors": [
    {
      "field": "request.orderNumber",
      "code": "MISSING_REQUIRED",
      "message": "request.orderNumber is a required field"
    },
    {
      "field": "request.priceInfo.price",
      "code": "INVALID_FIELD",
      "message": "request.priceInfo.price is invalid"
    },
    {
      "field": "request.paymentPreviewId",
      "code": "INVALID_FIELD",
      "message": "request.paymentPreviewId is invalid"
    },
    {
      "field": "request.currency",
      "code": "INVALID_FIELD",
      "message": "request.currency is invalid"
    }
  ]
}
```

Sample **Submit Order Payments for Approval** response with "COMPLETED" status with the amount allocated across one gift card and a credit card. Because the job is complete, the response does not contain an **eta** field.

```
{
  "id": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
  "resourceType": "job",
  "status": "COMPLETED",
  "links": {
    "self": {
      "ref": "/payment/approval/v2/jobs/ae6575a7-8c0e-44ef-b91b-440bdaf2070b"
    },
    "result": {
      "ref": "/payment/approval_results/v2/ae6575a7-8c0e-44ef-b91b-440bdaf2070b"
    }
  },
  "response": {
    "id": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
    "orderNumber": "C000033239876",
    "fraudDecision": "approve",
    "status": "ACCEPT",
    "payments": [
      {
        "authId": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
        "paymentId": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
        "type": "GiftCard",
        "account": "usgivex",
        "currency": "USD",
        "requestId": "122933",
        "requestToken": "122933",
        "balance": 184.5,
        "debitAmount": 10,
        "pin": "160375",
        "reconciliationId": "122933",
        "accountNumber": "6060101121022400640",
        "transactionTimestamp": "2016-06-04T00:47:44.554Z",
        "expirationDate": "2016-06-11T00:30:20.000Z"
      },
      {
        "authId": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
        "paymentId": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
        "type": "CreditCard",
        "account": "nikeemeagc",
        "currency": "USD",
        "requestId": "4290333907755000001516",
        "requestToken": "Ahj/7wSR0Siv6+E8m+fYGCmLBi1YNW7VqyT+DUqHUQBT+DUqHUTSB0IEn4QyaSX+gWx7SzAnI6JRX9fCeTfPsAAAwR5B",
        "cvCode": "M",
        "subscriptionId": "4290333907755000001516",
        "cardNumber": "XXXXXXXXXXXXXXXXX5859",
        "cardType": "Visa",
        "expirationMonth": "04",
        "expirationYear": "2017",
        "responseType": "AUTH",
        "authorizationAmount": 84.5,
        "transactionTimestamp": "2016-06-04T00:47:44.554Z",
        "authorizationExpiration": "2016-06-11T00:30:20.000Z",
        "authorizationCode": "390775500",
        "reconciliationId": "122933",
        "avsCode": "X",
        "billingInfo": {
          "name": {
            "firstName": "William",
            "altFirstName": "",
            "lastName": "Bowerman",
            "altLastName": "",
            "middleName": ""
          },
          "address": {
            "address1": "One Bowerman Drive",
            "address2": "Terra T/C",
            "address3": "#123",
            "city": "Beaverton",
            "state": "OR",
            "postalCode": "97005",
            "country": "US"
          },
          "contactInfo": {
            "phoneNumber": "503-555-1234",
            "email": "email@nike.com"
          }
        }
      }
    ],
    "links": {
      "self": {
        "ref": "/payment/approval_results/v2/ae6575a7-8c0e-44ef-b91b-440bdaf2070b"
      }
    }
  }
}
```

Sample PayPal **Submit Order Payments for Approval** response body with "COMPLETED" status:

```
{
  "id": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
  "resourceType": "job",
  "status": "COMPLETED",
  "links": {
    "self": {
      "ref": "/payment/approval/v2/jobs/ae6575a7-8c0e-44ef-b91b-440bdaf2070b"
    },
    "result": {
      "ref": "/payment/approval_results/v2/ae6575a7-8c0e-44ef-b91b-440bdaf2070b"
    }
  },
  "response": {
    "id": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
    "orderNumber": "C000033239876",
    "fraudDecision": "approve",
    "status": "ACCEPT",
    "payments": [
      {
        "authId": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
        "paymentId": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
        "type": "Paypal",
        "account": "USD",
        "authorizationAmount": 30,
        "referenceCode": "test123",
        "createSubscription": false,
        "billingAgreementId": "B-4VA40851C6219744E",
        "createBillingAgreement": false,
        "transactionTimestamp": "2016-06-04T00:47:44.554Z",
        "authorizationExpiration": "2016-06-11T00:30:20.000Z",
        "authorizationCode": "75H976675W4903900",
        "payer": "testuser@example.com",
        "payerId": "PKXXRRCMNCH7W",
        "payerStatus": "verified",
        "paypalOrderId": "O-82T97001MR966554L",
        "paypalToken": "EC-82T97001MR966554L",
        "requestId": "75H976675W4903900",
        "requestToken": "75H976675W4903900",
        "reconciliationId": "dff689224d550",
        "billingInfo": {
          "name": {
            "firstName": "William",
            "altFirstName": "",
            "lastName": "Bowerman",
            "altLastName": "",
            "middleName": ""
          },
          "address": {
            "address1": "One Bowerman Drive",
            "address2": "Terra T/C",
            "address3": "#123",
            "city": "Beaverton",
            "state": "OR",
            "postalCode": "97005",
            "country": "US"
          },
          "contactInfo": {
            "phoneNumber": "503-555-1234",
            "email": "email@nike.com"
          }
        }
      }
    ],
    "links": {
      "self": {
        "ref": "/payment/approval_results/v2/ae6575a7-8c0e-44ef-b91b-440bdaf2070b"
      }
    }
  }
}
```

**This endpoint is unavailable to Try It Out because it is JWT-restricted**

### <a name="submit-order-payments-for-approval-put"></a>Submit Order Payments for Approval (PUT)

---

This service is identical to the [Submit Order Payments for Approval (POST)](#submit-order-payments-for-approval-post) endpoint except that it allows the calling service to determine the Payment Approval id to be passed in as a path parameter. This is helpful if the Payment Approval response times out and the calling service needs to call [Void Payment Approval](#void-payment-approval) endpoint with the paymentApprovalId to reverse the Payment Approval request.

>**TIP:** This endpoint is intended to be a service-to-service call. [Checkout Submit](/doc/commerce/checkout/api_checkout.html#request-checkout-submit) calls the PaymentApproval endpoint as a last step in the order flow to validate and authorize/debit payment before submitting a Checkout to Nike for fulfillment. A client should not call this service directly.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**PUT**|`/payment/approval/v2/{id}`|yes|

#### Path & Query Parameters

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|
|**X-Nike-AppId**|Client application id calling this service (as listed in Eureka) used to verify endpoint access|Required|
|**X-Nike-Authorization**|JWT signed by client application|Required|

#### Request and Response

See the [Submit Checkouts Payment for Approval (POST)](#submit-order-payments-for-approval-post) for request and response details.

**This endpoint is unavailable to Try It Out because it is JWT-restricted**

### <a name="retrieve-payment-approval-job"></a>Retrieve Payment Approval Job

---

Use this endpoint to check the status of the *Submit Checkouts Payment for Approval* job. After receiving a HTTP 202 from the *Submit Checkouts Payment for Approval* call and waiting the duration of the eta time, call *Retrieval Payment Approval Job* endpoint using the same UUID to check the status of your job. If the status is not COMPLETED, continue the cycle of waiting the eta period and checking the job status.

To know if the job is done, check the value of the status field in the response body as follows:
- "status": "PENDING": job processing has not started
- "status": "IN_PROGRESS": job processing in progress
- "status": "COMPLETED": job has completed

Once you receive a job status of "COMPLETED", get the results of your job by parsing the data in the response object from this endpoint. Alternatively, follow the link to the *Retrieval Payment Approval Job* endpoint which is provided in the links object response body.

>**TIP:** Parsing the "COMPLETED" job result directly is a best practice because it eliminates making another service call.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**GET**|`/payment/approval/v2/jobs/{id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique identifier <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> for the job|String|Required|

#### <a name="retrieve-payment-approval-job-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.
>
><i class="mr2-sm g72-check"></i>Get the {id} path parameter from the `id` job UUID in the *Submit Checkouts Payment for Approval* response.

Sample *Retrieval Payment Approval Job* request URI:

```
https://api.nike.com/payment/preview/v2/jobs/2722be3a-0341-11e6-b512-3e1d05defe783424
```

#### <a name="retrieve-payment-approval-job-response-body"></a>Response Body

The *Retrieval Payment Approval Job* response is identical to the [Submit Order Payments for Approval Response Body](#submit-order-payments-for-approval-response-body).

Sample *Retrieval Payment Approval Job* response body with "IN_PROGRESS" status:

```
{
  "id": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
  "resourceType": "job",
  "status": "IN_PROGRESS",
  "links": {
    "self": {
      "ref": "/payment/approval/v2/jobs/ae6575a7-8c0e-44ef-b91b-440bdaf2070b"
    },
    "result": {
      "ref": "/payment/approval_results/v2/ae6575a7-8c0e-44ef-b91b-440bdaf2070b"
    }
  }
}
```
<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentapproval/browse/API.md#!/Payment_Approval/get_payment_approval_v2_jobs_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="order-payments-approval-result"></a>Order Payments Approval Result

---

After calling *Submit Checkouts Payment for Approval* to start the job and *Retrieve Payment Approval Job* to verify the status of the job is "COMPLETED", you can optionally call this endpoint to retrieve the result of your Payment Approval job. This step is optional because the Payment Approval result is also returned in the *Retrieve Payment Approval Job* when it is in `COMPLETED` status. The Document Order Management System (DOMS) is currently the only service that calls this endpoint.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/payment/approval_results/v2/{id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Unique identifier (<a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a>)|String|Required|

#### <a name="order-payments-approval-result-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="order-payments-approval-result-request-body"></a>Request URI

Sample *Order Payments Approval Result* request URI:

```
https://api.nike.com/payment/approval_results/v2/ae6575a7-8c0e-44ef-b91b-440bdaf2070b
```

#### Response Body

The response is identical to the *Retrieval Payment Approval Job* endpoint except that the results are not wrapped in a response object.

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|UUID of approval results|Required|
|**orderNumber**|string|Order number generated by the calling service|Required|
|**fraudDecision**|string|Results of fraud check, enum of "approve", "decline", "review", "unknown"|Required|
|**status**|string|Result of payment approval request. if fraudDecision is "decline", status is "REJECT". enum of "ACCEPT", "PENDING_PAYMENT", "REJECT"|Required|
|**payments**|array|Array of payments objects for the payment approval request|Required|
|payments.**authId**|string|UUID for the payment authorization|Required|
|payments.**paymentId**|string|UUID for the payment on this order|Required|
|payments.**account**|string|Merchant account used for the transaction|Optional|
|payments.**currency**|string|ISO currency code used for the transaction|Optional|
|payments.**requestId**|string|Vendor-provided request ID|Optional|
|payments.**requestToken**|string|Vendor-provided request token|Optional|
|payments.**balance**|number|Gift card balance|Optional|
|payments.**debitAmount**|number|Amount of the transaction|Optional|
|payments.**pin**|string|Gift card PIN|Optional|
|payments.**reconciliationId**|string|Vendor-provided reconciliationId|Optional|
|payments.**accountNumber**|string|Account number or gift card number|Optional|
|payments.**expirationDate**|string|Gift card expiration date|Optional|
|payments.**cvCode**|string|Credit card CVV validation code|Optional|
|payments.**subscriptionId**|string|Vendor-supplied subscriptionId for credit card|Optional|
|payments.**cardNumber**|string|Masked credit card number|Optional|
|payments.**cardType**|string|Type of credit card, e.g. MasterCard|Optional|
|payments.**expirationMonth**|string|Month credit card expires|Optional|
|payments.**expirationYear**|string|Year credit card expires|Optional|
|payments.**responseType**|string|Third party vendor-supplied responseType|Optional|
|payments.**authorizationAmount**|number|Amount authorized for the transaction|Optional|
|payments.**authorizationExpiration**|string|Date authorization expires after which payment approval must be requested again|Optional|
|payments.**transactionTimestamp**|string|Timestamp of transaction|Optional|
|payments.**authorizationCode**|string|Authorization code of transaction|Optional|
|payments.**avsCode**|string|Vendor-supplied address verification code for transaction|Optional|
|payments.**referenceCode**|string|PayPal-supplied reference code|Optional|
|payments.**createSubscription**|boolean|True indicates subscription id will be created for this transaction|Optional|
|payments.**billingAgreementId**|string|PayPal-supplied billing agreement id|Optional|
|payments.**createBillingAgreement**|boolean|True indicates PayPal billing agreement will be created for this transaction|Optional|
|payments.**payer**|string|Customer's email address for PayPal|Optional|
|payments.**payerId**|string|PayPal-supplied payerId|Optional|
|payments.**payerStatus**|string|PayPal payer status|Optional|
|payments.**paypalOrderId**|string|PayPal-supplied order ID|Optional|
|payments.**paypalToken**|string|PayPal-supplied token|Optional|
|payments.**billingInfo**|object|Object containing name, address, and contactInfo objects|Optional|
|payments.billingInfo.**name**|object|Object containing customer's name information|Required|
|payments.billingInfo.name.**firstName**|string|Shipping address first name|Required|
|payments.billingInfo.name.**altFirstName**|string|Shipping address alternate first name|Optional|
|payments.billingInfo.name.**lastName**|string|Shipping address last name|Required|
|payments.billingInfo.name.**altLastName**|string|Shipping address alternate last name|Optional|
|payments.billingInfo.name.**middleName**|string|Shipping address middle name|Optional|
|payments.billingInfo.**address**|object|Object containing customer's address information|Required|
|payments.billingInfo.address.**address1**|string|Shipping address line 1|Required|
|payments.billingInfo.address.**address2**|string|Shipping address line 2|Optional|
|payments.billingInfo.address.**address3**|string|Shipping address line 3|Optional|
|payments.billingInfo.address.**city**|string|Shipping address city|Required|
|payments.billingInfo.address.**state**|string|Shipping address state|Optional|
|payments.billingInfo.address.**postalCode**|string|Shipping address postalCode|Optional|
|payments.billingInfo.address.**country**|string|Shipping address country|Required|
|payments.billingInfo.**contactInfo**|object|Object containing customer's contact information|Required|
|payments.billingInfo.contactInfo.**phoneNumber**|string|Shipping address contact info phone number|Required|
|payments.billingInfo.contactInfo.**email**|string|Shipping address contact info email address|Required|
|links.self.**ref**|string|Link to this resource|Required|
|**error**|object|Error object containing details of the cause(s) of error, present when service returns in error|Optional|
|error.**httpStatus**|integer|Status code present when service returns in error|Optional|
|error.**message**|string|Top level error message present when service returns in error|Optional|
|error.**code**|string|Enum of JOB_TIME or SYSTEM_ERROR|Optional|
|error.**id**|string|Error id|Optional|
|**errors**|array|Array of error objects present when service returns in error|Optional|
|error.errors.**field**|string|JSON field name causing error|Required|
|error.errors.**code**|string|Enum of error codes, one of "MISSING_REQUIRED","INVALID_FIELD","INVALID_JSON","INVALID_PAYMENT_TYPE"|Required|
|error.errors.**message**|string|Error message|Required|

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentapproval/browse/API.md#!/Payment_Approval/get_payment_approval_results_v2_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="void-payment-approval"></a>Void Payment Approval

---

This endpoint voids a Payment Approval request. If a credit card was used in the original Payment Approval request, this endpoint reverses the authorization. If a gift card was used in the original Payment Approval request, it reverses the debit.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**DELETE**|`/payment/approval_results/v2/{id}`|yes|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|payment approval Unique identifier (<a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a>)|String|Required|

#### <a name="void-payment-approval-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|
|**X-Nike-AppId**|Client application id calling this service (as listed in Eureka) used to verify endpoint access|Required|
|**X-Nike-Authorization**|JWT signed by client application|Required|

>**TIP:** When calling this endpoint through the public router, the **upmid** (for logged in customers), **appId** and **usertype** headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="void-payment-approval-request-body"></a>Request Body

There is no request body for the Void Payment Approval endpoint.

Sample *Void Payment Approval* request URI:

```
https://api.nike.com/payment/approval_results/v2/ae6575a7-8c0e-44ef-b91b-440bdaf2070b
```

#### <a name="void-payment-approval-response-body"></a>Response Body

The HTTP 204 response from *Void Payment Approval* has no response body.

**This endpoint is not available to Try It Out because it is JWT-restricted**

### <a name="payment-approval-summary"></a>Get Payment Approval Summary

---

Use this endpoint to retrieve a summary of a Payment Approval call that completed successfully. It returns masked account numbers and is available for 30 minutes. Unlike the [Payment Approval](#using-payment-approval) endpoint, this endpoint can be called by either a client or another service. The results of this endpoint can be used to display payment approval results on an order confirmation page.

It is a synchronous endpoint so the results are returned in the response and does not require polling a separate endpoint.

If the Payment Approval result is not either in `ACCEPT` or `PENDING_PAYMENT` status, a 404 response is returned.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/payment/approval_summary/v1/{id}`|no|

#### Request Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|payment approval Unique identifier (<a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a>)|String|Required|

#### <a name="payment-approval-summary-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the **upmid** (for logged in customers), **appId** and **usertype** headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="payment-approval-summary-request-body"></a>Request Body

This is a GET request so there is no request body.

Sample *Payment Approval Summary* request URI:

```
https://api.nike.com/payment/approval_summary/v1/ae6575a7-8c0e-44ef-b91b-440bdaf2070b
```

>**TIP:** Note that this is a v1 service

#### <a name="payment-approval-summary-response-body"></a>Response Body

The HTTP 200 response from *Payment Approval Summary* contains the results. Following are descriptions of the important fields in the response body:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|UUID of approval results|Required|
|**orderNumber**|string|Order number generated by the calling service|Required|
|**status**|string|Result of payment approval request. if fraudDecision is "decline", status is "REJECT". enum of "ACCEPT", "PENDING_PAYMENT", "REJECT"|Required|
|**payments**|array|Array of payments objects for the payment approval request|Required|
|payments.**type**|string|Type of payment|Required|
|payments.**currency**|string|ISO currency code used for the transaction|Optional|
|payments.**amount**|number|Amount of the transaction|Optional|
|payments.**accountNumber**|string|Account number or gift card number|Optional|
|payments.**cardType**|string|Type of credit card, e.g. MasterCard|Optional|
|payments.**expirationMonth**|string|Month credit card expires|Optional|
|payments.**expirationYear**|string|Year credit card expires|Optional|
|payments.**payer**|string|Customer's email address for PayPal|Optional|
|payments.**bankName**|string|Bank name for deferred payment vendors, e.g. Alipay|Optional|
|payments.**billingInfo**|object|Object containing name, address, and contactInfo objects|Optional|
|payments.billingInfo.**name**|object|Object containing customer's name information|Required|
|payments.billingInfo.name.**firstName**|string|Shipping address first name|Required|
|payments.billingInfo.name.**altFirstName**|string|Shipping address alternate first name|Optional|
|payments.billingInfo.name.**lastName**|string|Shipping address last name|Required|
|payments.billingInfo.name.**altLastName**|string|Shipping address alternate last name|Optional|
|payments.billingInfo.name.**middleName**|string|Shipping address middle name|Optional|
|payments.billingInfo.**address**|object|Object containing customer's address information|Required|
|payments.billingInfo.address.**address1**|string|Shipping address line 1|Required|
|payments.billingInfo.address.**address2**|string|Shipping address line 2|Optional|
|payments.billingInfo.address.**address3**|string|Shipping address line 3|Optional|
|payments.billingInfo.address.**city**|string|Shipping address city|Required|
|payments.billingInfo.address.**state**|string|Shipping address state|Optional|
|payments.billingInfo.address.**postalCode**|string|Shipping address postalCode|Optional|
|payments.billingInfo.address.**country**|string|Shipping address country|Required|
|payments.billingInfo.**contactInfo**|object|Object containing customer's contact information|Required|
|payments.billingInfo.contactInfo.**phoneNumber**|string|Shipping address contact info phone number|Required|
|payments.billingInfo.contactInfo.**email**|string|Shipping address contact info email address|Required|
|links.self.**ref**|string|Link to this resource|Required|

Below is a sample response body for a *Payment Approval Summary* request. It contains masked payment information for GiftCard and CreditCard payment types:

```
{
  "id": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
  "orderNumber": "C000098769876",
  "status": "ACCEPT",
  "payments": [
    {
      "type": "GiftCard",
      "currency": "USD",
      "amount": 10,
      "accountNumber": "60*************0640",
      "billingInfo": {
        "name": {
          "firstName": "William",
          "altFirstName": "",
          "lastName": "Bowerman",
          "altLastName": "",
          "middleName": ""
        },
        "address": {
          "address1": "One Bowerman Drive",
          "address2": "",
          "address3": "",
          "city": "Beaverton",
          "state": "OR",
          "postalCode": "97005",
          "country": "US"
        },
        "contactInfo": {
          "phoneNumber": "415-555-1234",
          "email": "test@nike.com"
        }
      }
    },
    {
      "type": "GiftCard",
      "currency": "USD",
      "amount": 19.58,
      "accountNumber": "60*************0236",
      "billingInfo": {
        "name": {
          "firstName": "William",
          "altFirstName": "",
          "lastName": "Bowerman",
          "altLastName": "",
          "middleName": ""
        },
        "address": {
          "address1": "One Bowerman Drive",
          "address2": "",
          "address3": "",
          "city": "Beaverton",
          "state": "OR",
          "postalCode": "97005",
          "country": "US"
        },
        "contactInfo": {
          "phoneNumber": "415-555-1234",
          "email": "test@nike.com"
        }
      }
    },
    {
      "type": "CreditCard",
      "currency": "USD",
      "accountNumber": "XXXXXXXXXXXXXXXXX5859",
      "cardType": "Visa",
      "expirationMonth": "04",
      "expirationYear": "2017",
      "amount": 84.5,
      "billingInfo": {
        "name": {
          "firstName": "William",
          "altFirstName": "",
          "lastName": "Bowerman",
          "altLastName": "",
          "middleName": ""
        },
        "address": {
          "address1": "One Bowerman Drive",
          "address2": "",
          "address3": "",
          "city": "Beaverton",
          "state": "OR",
          "postalCode": "97005",
          "country": "US"
        },
        "contactInfo": {
          "phoneNumber": "415-555-1234",
          "email": "test@nike.com"
        }
      }
    }
  ],
  "links": {
    "self": {
      "ref": "/payment/approval_summary/v1/ae6575a7-8c0e-44ef-b91b-440bdaf2070b"
    }
  }
}
```

Below is a sample *Payment Approval Summary* response for the PayPal payment type:

```
{
  "id": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
  "orderNumber": "C000098769876",
  "status": "ACCEPT",
  "payments": [    
    {
      "type": "Paypal",
      "account": "USD",
      "amount": 30,
      "payer": "test@nike.com",
      "billingInfo": {
        "name": {
          "firstName": "William",
          "altFirstName": "",
          "lastName": "Bowerman",
          "altLastName": "",
          "middleName": ""
        },
        "address": {
          "address1": "One Bowerman Drive",
          "address2": "",
          "address3": "",
          "city": "Beaverton",
          "state": "OR",
          "postalCode": "97005",
          "country": "US"
        },
        "contactInfo": {
          "phoneNumber": "415-555-1234",
          "email": "test@nike.com"
        }
      }
    }
  ],
  "links": {
    "self": {
      "ref": "/payment/approval_summary/v1/ae6575a7-8c0e-44ef-b91b-440bdaf2070b"
    }
  }
}
```

#### Error Codes

Listed below are the error codes returned from Payment Approval service:

Error Code                           | Error Message                                                                                      |
|--------------------------------------|----------------------------------------------------------------------------------------------------|
| INVALID_FIELD                        | Invalid field in the request                                                                       |
| AUTH_FAILURE                         | Authorization failed for a payment                                                                 |
| INSUFFICIENT_FUNDS                   | Not enough funds on the gift card or in PayPal                                                     |
| JOB_TIMEOUT                          | Unable to complete the approval request in 30 secs                                                 |
| SYSTEM_ERROR                         | Error occurred processing the approval request                                                     |
| FRAUD_REJECT                         | Fraud vendor rejected the request based on the order detail                                        |
| QUANTITY_LIMIT                       | Consumer has reached the max quantity limit for the product                                        |
| INTERNATIONAL_BIN                    | The credit card number is from a country that is not supported                                     |
| INVALID_PAYMENT_TYPE                 | The selected payment type is invalid for the order                                                 |
| INVALID_SHIPPING_BILLING_COMBINATION | The shipping and billing country combination is supported                                          |
| UNSUPPORTED_PAYMENT_FOR_COUNTRY      | The selected payment type is not supported in the selected billing country. (Ex. PayPal in Poland) |
| INVALID_CVV                          | The security code is invalid.                                                                     |
| INVALID_CREDIT_CARD_NUMBER           | The credit card number is invalid                                                                  |
| INVALID_BANK_COUNTRY                 | Check the billing country value to make sure they are set to the correct country                   |
| MORE_PAYMENT_REQUIRED                | Unable to allocate the order total across all payment types. Need more payment.                  |
| PAYPAL_AUTH_FAILURE_10411            | Inform the customer that the Express Checkout transaction has expired and they need to restart the transaction |
| PAYPAL_AUTH_FAILURE_10417            | Instruct the customer to retry the transaction using an alternative payment method from the customers PayPal wallet. The transaction did not complete with the customers selected payment method. |
| PAYPAL_AUTH_FAILURE_10422            | Instruct the customer to use a different funding source                                            |
| PAYPAL_AUTH_FAILURE_10445            | Inform the customer an error occurred and to retry the transaction                                 |
| PAYPAL_AUTH_FAILURE_10486            | Redirect the customer back to PayPal to select a different funding source or to add a new funding source. |
| PAYPAL_AUTH_FAILURE_11084            | Inform the customer that PayPal declined the transaction and to contact PayPal Customer Service    |
| PAYPAL_AUTH_FAILURE_13113            | Inform the buyer that PayPal declined the transaction and to contact PayPal Customer Service       |
| PAYMENT_AUTH_FAILURE_236             | Wait a few minutes and resend the request.                                                        |
| INVALID_GC_OR_PIN                    | Inform the customer the gift card and/or PIN is not valid. |
| GC_EXPIRED                           | Inform the customer the gift card is expired. |
| GC_BALANCE_EXCEEDED                  | Inform the customer the gift card balance has been exceeded. |
|KLARNA_ERROR_2102|AMOUNT. Inform the customer to choose an alternative payment method.|
|KLARNA_ERROR_2105|UNPAID_BILLS. Inform the customer to pay their unpaid Klarna invoices before shopping with Klarna|
|KLARNA_ERROR_2201|PNO. Inform the customer that the personal number they entered is not the correct format|
|KLARNA_ERROR_2205|UNDER_AGED. Inform the customer that he/she must be 18 years old or older to pay with Klarna|
|KLARNA_ERROR_3107|ADDRESS. Inform the customer that the address could not be verified. Edit the address and try again.|
|KLARNA_ERROR_3111|ZIP. Inform the customer that the postal code they entered is not in the correct format. Edit the postal code and try again.|
|KLARNA_ERROR_3201|CELLNO. Inform the customer that the mobile phone number they entered is not in the correct format. Edit the mobile phone number and try again.|
|KLARNA_ERROR_3203|EMAIL. Inform the customer that the email address they entered is not in the correct format. Edit the email address and try again.|
|KLARNA_ERROR_3205|CITY. Inform the customer that the city is incorrect. Edit the city and try again.|
|KLARNA_ERROR_3215|DATE_OF_BIRTH. Inform the customer that the date of birth is not in the correct format. Edit the date of birth and try again. |
|KLARNA_ERROR_3218|HOUSE_NUMBER. Inform the customer that the house number is incorrect. Edit the house number and try again.|
|KLARNA_ERROR_3302|BAD_LAST_NAME. Inform the customer that the last name is incorrect. Edit the last name and try again.|
|KLARNA_ERROR_3303|BAD_FIRST_NAME. Inform the customer that the first name is incorrect. Edit the first name and try again.|
|KLARNA_ERROR_9109|RESERVATION NUMBER DOES NOT EXIST. Inform the customer that the reservation number does not exist.|
|KLARNA_ERROR_9119|TIMEOUT. Inform the customer of that a system error occurred and to either try again or choose an alternative payment method.|

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentapproval/browse/API.md#!/Payment_Approval/get_payment_approval_summary_v1_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

## <a name="using-credit-card-submit"></a>Using Credit Card Submit

---

- [Add Credit Card Info with CVV](#add-credit-card-info-with-cvv)
- [Add Credit Card Info without CVV](#add-credit-card-info-without-cvv)
- [Add CVV](#add-cvv-information)
- [Add CVV and Expiration Date](#add-cvv-and-expiration-date)
- [Validate Credit Card Info](#validate-credit-card-info)
- [Store Credit Card Info](#store-credit-card-info)
- [List Credit Card Info](#list-credit-card-info)
- [List Credit Card Info and Validate Status](#list-credit-card-info-and-validate-status)

### Credit Card Submit Overview

This service lists, modifies, deletes and stores a customer's credit card and Apple Pay information. This service accommodates both PCI-certified and non-PCI-certified experiences. Endpoints for non-PCI-certified experiences render an iFrame to collect and retrieve credit card and Apple Pay information. For PCI-certified experiences, it offers endpoints to manage a customer's credit card and Apple Pay information directly.

### <a name="add-credit-card-info-with-cvv"></a>Add Credit Card Info with CVV

---

This endpoint is intended to be called by experiences that are not [PCI-certified](#glossary). This endpoint renders an iFrame with the masked credit card number, expiration date, and CVV matching the creditCardInfoId passed in the path parameter. If the creditCardInfoId is not found, the iFrame renders blank credit card number, date and CVV fields for editing. When each field has a value, the iFrame calls the [Store Credit Card Info](#store-credit-card-info) endpoint and temporarily stores new or updated values. As a last step, the iFrame calls the [Validate Credit Card Info](#validate-credit-card-info) endpoint to validate the new or updated credit card data.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/services{?id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Query|creditCardInfoId in <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> format generated by the client|String|Required|

#### <a name="add-credit-card-info-with-cvv-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the **upmid** (for logged in customers), **appId** and **usertype** headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

Sample request URI:

```
https://paymentcc.nike.com/services?id=24afd5dc-b523-491c-8282-8bed57cd2029&ctx=checkout&language=en
```

#### <a name="add-credit-card-info-with-cvv-response-body"></a>Response Body

The response body of this endpoint is the iFrame with editable credit card number, expiration date and CVV editable fields pre-populated with values looked up based on the creditCardInfoId `id` path parameter.

![Image](/images/commerce/payment/number_expdate_cvv.png)

### <a name="add-credit-card-info-without-cvv"></a>Add Credit Card Info without CVV

---

This endpoint is intended to be called by experiences that are not [PCI-certified](#glossary). This endpoint renders an iFrame with the masked credit card number and expiration date matching the creditCardInfoId passed in the path parameter. If the creditCardInfoId is not found, the iFrame renders blank credit card number and date fields for editing. When each field has a value, the iFrame calls the [Store Credit Card Info](#store-credit-card-info) endpoint and temporarily stores new or updated values. As a last step, the iFrame calls the [Validate Credit Card Info](#validate-credit-card-info) endpoint to validate the new or updated credit card data.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/services/add{?id,language}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Query|creditCardInfoId in <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> format generated by the client|String|Required|
|**language**|Query|BCP 47 language-country tag associated with this Checkout, en-IE|String|Optional|

#### <a name="add-credit-card-info-without-cvv-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the **upmid** (for logged in customers), **appId** and **usertype** headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

Sample request URI:

```
https://paymentcc.nike.com/services/add?id=0e13e71d-e952-46af-b3f5-e476befd43ce&language=en
```

#### <a name="add-credit-card-info-without-cvv-response-body"></a>Response Body

The response body of this endpoint is the iFrame with editable credit card number and expiration date fields pre-populated with values looked up based on the creditCardInfoId `id` path parameter.

![Image](/images/commerce/payment/number_expdate.png)

### <a name="add-cvv-information"></a>Add CVV Information

---

This endpoint is intended to be called by experiences that are not [PCI-certified](#glossary). This endpoint renders an iFrame with an editable CVV field. When the customer provides a CVV value, the iFrame calls the [Store Credit Card Info](#store-credit-card-info) endpoint and temporarily stores the CVV if it found a credit card matching the credit card Info id path parameter. As a last step, the iFrame calls the [Validate Credit Card Info](#validate-credit-card-info) endpoint to validate the updated CVV.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/services/cvv{?id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Query|creditCardInfoId in <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> format generated by the client|String|Required|

#### <a name="add-credit-card-info-with-cvv-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

Sample request URI:

```
https://paymentcc.nike.com/services/cvv?id=0e13e71d-e952-46af-b3f5-e476befd43ce&language=en
```

#### <a name="add-credit-card-info-with-cvv-response-body"></a>Response Body

The response body of this endpoint is the iFrame with an editable CVV field.

![Image](/images/commerce/payment/cvv.png)

### <a name="add-cvv-and-expiration-date"></a>Add CVV and Expiration Date

---

This endpoint is intended to be called by experiences that are not [PCI-certified](#glossary). This endpoint renders an iFrame with an editable credit card expiration date and CVV fields. When the customer provides the appropriate values, the iFrame calls the [Store Credit Card Info](#store-credit-card-info) endpoint and temporarily stores the data if it found a credit card matching the credit card Info id path parameter. As a last step, the iFrame calls the [Validate credit card Info](#validate-credit-card-info) endpoint to validate the updated expiration date and CVV values.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/services/expcvv{?id}`|no|

#### <a name="add-cvv-and-expiration-date-query-parameters"></a>Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Query|creditCardInfoId in <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> format generated by the client|String|Required|

#### <a name="add-cvv-and-expiration-date-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

Sample request URI:

```
https://paymentcc.nike.com/services/expcvv?id=0e13e71d-e952-46af-b3f5-e476befd43ce&language=en
```

#### <a name="add-cvv-and-expiration-date-response-body"></a>Response Body

The response body of this endpoint is the iFrame with editable expiration date and CVV fields prepopulated with values looked up based on the creditCardInfoId `id` path parameter.

![Image](/images/commerce/payment/expdate_cvv.png)

### <a name="validate-credit-card-info"></a>Validate Credit Card Info

---

This endpoint is typically called immediately after the [Store Credit Card Info](#store-credit-card-info) endpoint to validate credit card information. The mode query parameter determines which credit card values to validate. It is a synchronous endpoint.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/creditcardsubmit/{id}/isValid{?mode}`|no|

#### <a name="validate-credit-card-info-query-parameters"></a>Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|creditCardInfoId in <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> format generated by the client|String|Required|
|**mode**|Query|flag indicating which credit card fields to validate. default is 1<br>1 = credit card number, expiration month and year, cvv<br>2 = credit card number, expiration month and year<br>3 = cvv<br>4 = expiration month and year, cvv|String|Optional|

#### Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

Sample *Validate Credit Card Info* URI:

```
https://paymentcc.nike.com/creditcardsubmit/24afd5dc-b523-491c-8282-8bed57cd2029/isValid?mode=3
```

#### <a name="validate-credit-card-info-response-body"></a>Response Body

Each field in the response body is flagged either true or false. True indicates the value is valid; false indicates invalid. The fields returned in the body are:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**exp**|boolean|True indicates expiration month and year are valid, false if not|Optional|
|**cc**|boolean|True indicates credit card number is valid, false if not|Optional|
|**cvv**|boolean|True indicates CVV is valid, false if not|Optional|
|**isValid**|boolean|True indicates credit card is valid, false if not|Optional|

Sample *Validate Credit Card Info* response body for mode=1:

```
{
  "exp": true,
  "cc": true,
  "cvv": true,
  "isValid": true
}
```

Sample *Validate Credit Card Info* response body for mode=2:

```
{
  "exp": true,
  "cc": true,
  "isValid": true
}
```

Sample *Validate Credit Card Info* response body for mode=3:

```
{
  "cvv": true,
  "isValid": true
}

```
Sample *Validate Credit Card Info* response body for mode=4:
```

{
  "exp": true,
  "cvv": true,
  "isValid": true
}
```

### <a name="store-credit-card-info"></a>Store Credit Card Info

---

This endpoint temporarily stores credit card information for validation and purchase.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**POST**|`/creditcardsubmit/{id}/store`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|creditCardInfoId in <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> format generated by the client|String|Required|

#### Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

#### <a name="store-creditcard-info-request-body"></a>Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**paymentInfoId**|string|Id under which data is stored|Optional|
|**accountNumber**|string|Masked credit card number|Optional|
|**cardType**|string|Type of credit card e.g. VISA, defaults to UNKNOWN|Optional|
|**cvNumber**|string|Masked cvv number|Optional|
|**startMonth**|string|Credit card start month|Optional|
|**startYear**|string|Credit card start year|Optional|
|**expirationMonth**|string|Month credit card expires|Optional|
|**expirationYear**|string|Year credit card expires|Optional|
|**creditCardInfoId**|string|UUID by which credit card data is stored. This is generated by the client when storing a new credit card.|Optional|
|**paymentType**|string|Credit card type (market) for Apple Pay only|Optional|
|**paymentData**|string|Encrypted payment data, for Apple Pay only|Optional|

Sample *Credit Card Submit Store* Request headers and body:

https://paymentcc.nike.com/services/creditcardsubmit/0e13e71d-e952-46af-b3f5-e476befd43ce/store

```
{
    accountNumber:"4111111111111111",
    cardType:"VISA",
    creditCardInfoId:"bb3360c5-82c3-4d00-b806-a8bf3876f5ae",
    cvNumber:"123",
    expirationMonth:"12",
    expirationYear:"2020"
}
```

#### Response Body

This endpoint returns no response body.

### <a name="list-credit-card-info"></a>List Credit Card Info

---

This endpoint updates and retrieves masked credit card information for a creditCardInfoId.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/creditcardsubmit/{id}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|creditCardInfoId in <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> format generated by the client|String|Required|

#### Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

Sample request URI:
https://paymentcc.nike.com/creditcardsubmit/bb3360c5-82c3-4d00-b806-a8bf3875555

#### <a name="ccinfo2-response-body"></a>Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**paymentInfoId**|string|Id under which payment is stored, typically same as **creditCardInfoId**|Optional|
|**paymentInfoType**|string|Type of payment, CreditCard or ApplePay|Optional|
|**accountNumber**|string|Masked credit card number|Optional|
|**cardType**|string|Type of credit card, required when not paying by Apple Pay|Optional|
|**cvNumber**|string|Masked credit card CVV number|Optional|
|**startMonth**|string|Month that credit card begins|Optional|
|**startYear**|string|Year that credit card begins|Optional|
|**expirationMonth**|string|Month that credit card expires|Optional|
|**expirationYear**|string|Year that credit card expires|Optional|
|**creditCardInfoId**|string|**creditCardInfoId** used to call the [Store Credit Card Info](#store-credit-card-info) endpoint to temporarily store the customer's credit card information|Optional|
|**paymentType**|string|Credit card type stored in Apple Pay, required when paying by Apple Pay|Optional|

Sample *List Credit Card Info* credit card response body:

```
{
  "paymentInfoId": "CCTESTINFOID-ABCDEFG-HIJKLMNOP",
  "paymentInfoType": "CreditCard",
  "accountNumber": "41XXXXXXXXXX1111",
  "cardType": "Visa",
  "cvNumber": "XXX",
  "issueNumber": null,
  "startMonth": null,
  "startYear": null,
  "expirationMonth": "2",
  "expirationYear": "2017",
  "subscriptionId": null,
  "creditCardInfoId": "CCTESTINFOID-ABCDEFG-HIJKLMNOP",
  "paymentType": null
}
```

Sample *List Credit Card Info* Apple Pay response body:

```
{
  "paymentInfoId": "APPLEPAYTESTINFOID-ABCDEFG-HIJKLMNOP",
  "paymentInfoType": "ApplePay",
  "accountNumber": "XXXXXXXXXXXX1111",
  "creditCardInfoId": "CCTESTINFOID-ABCDEFG-HIJKLMNOP",
  "paymentType": "visa"
}
```

### <a name="list-credit-card-info-and-validate-status"></a>List Credit Card Info and Validate Status

---

This endpoint retrieves masked credit card information and validation status of individual credit card fields for a creditCardInfoId.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/creditcardsubmit/{id}/isValidData{?mode}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|creditCardInfoId in <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> format generated by the client|String|Required|
|mode|Query|flag indicating which credit card fields to validate. default is 1<br>1 = credit card number, expiration month and year, cvv<br>2 = credit card number, expiration month and year<br>3 = cvv<br>4 = expiration month and year, cvv|String|Optional|

#### <a name="ccinfo2-request-headers"></a>Request URI

Sample request URI:
https://paymentcc.nike.com/creditcardsubmit/bb3360c5-82c3-4d00-b806-a8bf3875555/isValidData?mode=3

#### <a name="list-ccinfo-validate-response-body"></a>Response Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**paymentInfoId**|string|Id payment is stored under, typically same as `creditCardInfoId**|Optional|
|**accountNumber**|string|Masked credit card number|Optional|
|**cardType**|string|Type of credit card, required when not paying by Apple Pay|Optional|
|**cvNumber**|string|Masked credit card CVV number|Optional|
|**startMonth**|string|Month credit card begins|Optional|
|**startYear**|string|Year credit card begins|Optional|
|**expirationMonth**|string|Month credit card expires|Optional|
|**expirationYear**|string|Year credit card expires|Optional|
|**creditCardInfoId**|string|Id used to call the [Store credit card Info](#store-credit-card-info) endpoint to temporarily store the customer's credit card information|Optional|
|**paymentType**|string|Credit card type stored in Apple Pay, required when paying by Apple Pay|Optional|
|**cc**|boolean|Indicates if credit card number is valid or not, one of true or false|Optional|
|**cvv**|boolean|Indicates if CVV is valid or not, one of true or false|Optional|
|**isValid**|boolean|Indicates payment method as a whole is valid or not, one of true or false|Optional|

Sample *List Credit Card Info and Validate Status* credit card response body:

```
{
"paymentInfoId": "CCTESTINFOID-ABCDEFG-HIJKLMNOP",
"paymentInfoType": "CreditCard",
"accountNumber": "41XXXXXXXXXX1111",
"cardType": "Visa",
"cvNumber": "XXX",
"issueNumber": null,
"startMonth": null,
"startYear": null,
"expirationMonth": "02",
"expirationYear": "2017",
"subscriptionId": null,
"creditCardInfoId"|"CCTESTINFOID-ABCDEFG-HIJKLMNOP",
"paymentType": null,
"exp": true,
"cc": true,
"cvv": true,
"isValid": true
}
```

Sample *List Credit Card Info and Validate Status* Apple Pay response body:

```
{
  "paymentInfoId": "APPLEPAYTESTINFOID-ABCDEFG-HIJKLMNOP",
  "paymentInfoType": "ApplePay",
  "accountNumber": "XXXXXXXXXXXX1111",
   "creditCardInfoId": "CCTESTINFOID-ABCDEFG-HIJKLMNOP",
   "paymentType": "visa"
}
```

|Error Code|Description|
|---|---|
|INTERNAL_ERROR|Returned when there was an unspecified error processing the request|
|UNABLE_TO_SAVE_CCINFO|Returned when the credit card was not saved successfully|
|NOT_FOUND|Returned when there is no credit card with credit card info id passed in the request|
|CARD_NUMBER_HAS_INVALID_CHARS|Returned when the credit card number in the request has invalid characters|
|CARD_NUMBER_DOESNT_MATCH_TYPE|Returned when the credit card number does not match the credit card type|
|CARD_LENGTH_NOT_VALID|Returned when the credit card number length is invalid|
|CARD_NUMBER_NOT_VALIDV|Returned when the credit card number is not valid|
|CARD_EXPIRED|Returned when the credit card number has expired|
|CVV_NUMBER_HAS_INVALID_CHARS|Returned when the credit card CVV has invalid characters|
|CVV_NUMBER_LENGTH_INVALID|Returned when the credit card CVV length is invalid|
|CARD_EXPIRY_HAS_INVALID_MONTH|Returned when the credit card expiration month is invalid|
|CARD_EXPIRY_HAS_INVALID_YEAR|Returned when the credit card expiration year is invalid|
|PAYMENT_DATA_NOT_VALID|Returned when the ApplePay payment data length is invalid|

## <a name="using-apple-pay"></a>Using Apple Pay

---

- [Start Apple Pay Session](#start-apple-pay-session)

### <a name="start-apple-pay-session-overview"></a>Apple Pay Overview

When paying with Apple Pay on a Safari Web browser, this service initializes an Apple Pay payment session through the Apple gateway. When you pass in a validationURL to the *Start Apple Pay Session* endpoint, the service provides the necessary information to Apple Pay to identify Nike as a merchant that accepts Apple Pay payments, and starts a new Apple Pay session.

For example, the SNKRs Web experience calls this endpoint after calling Apple Pay's Javascript library to verify that the Apple Pay button can be displayed as a payment type. SNKRs Web sends the encrypted response data from this endpoint to Apple. Apple in turn notifies the customer on their iPhone, iWatch or iPad to verify their purchase on that device. Once the customer verifies the payment on the device, the purchase process flow continues very similarly to the credit card flow.

Prerequisites for the customer who wishes to pay by ApplePay on a Safari Web Browser assumes the customer has:

<br>access to a Mac and either an iPhone, iWatch, or iPad
<br>installed latest macOS Sierra on Mac
<br>installed iOS 10 on iPhone, iWatch, or iPad
<br>set up Apple Pay on iPhone, iWatch, or iPad
<br>logged into the same iCloud account on their Mac as on their iPhone, iWatch, or iPad

The customer must complete this checklist in order for the Pay with Apple Pay button to display on SNKRs Web in Safari.

### <a name="start-apple-pay-session"></a>Start Apple Pay Session

Use this endpoint to initiate an ApplePay session.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**POST**|`/payment/applepay_sessions/v2`|no|

#### <a name="start-applepay-session-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="start-applepay-session-request-body"></a>Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**valididationURL**|string|URL to call to validate you as a merchant and initiate an Apple Pay payment session|Required|

>**TIP:** See the Apple Pay Developer's site for the list of supported domain names for Apple Test and Production environments for the <a href="https://developer.apple.com/documentation/applepayjs#2539292" target="_blank">validationURL</a>

Sample *Start Apple Pay Session* request body:

```
{
  "validationURL":"https://apple-pay-gateway-pr-pod1.apple.com/paymentservices/startSession"
}
```

#### <a name="start-applepay-session-response-body"></a>Response Body

The HTTP 200 response from *Start Apple Pay Session* contains the merchant session object with key/value pairs needed by Apple Pay to complete the customer's Apple Pay purchase. Following are descriptions of the important fields in the response body:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**epochTimestamp**|string|Timestamp of transaction|Optional|
|**merchantSessionIdentifier**|string|Apple Pay session identifier to be used in each Apple Pay transaction|Required|
|**nonce**|string|One-time-use only string|Optional|
|**merchantIdentifier**|string|Unique ID identifying to Apple that you can accept Apple Pay payments|Optional|
|**domainName**|string|Domain name associated with your Apple Pay Payment Processing Certificate|Required|
|**displayName**|string|Name of the experience|Required|
|**signature**|string|Encrypted signature|Optional|

Sample *Start Apple Pay Session* response body:

```
{
  "epochTimestamp":1502822443275,  
  "merchantSessionIdentifier ":"BDC4DE12845D49C5B363AAAD4EC7E899_2101F68F6980DFE07DEFE987B1CAF2961766C119C8FDCBB33566B1A97F33C9C3",
  "nonce":"d08a43fc",
  "merchantIdentifier":"EDBF308EB4D295BD3BC54C16B0D4732AF96CEB76A847498AD81C0674A35FAF37",
  "domainName":"www.nike.com",
  "displayName":"Nike Apple Pay Prod",
  "signature":"020101310f300d06096086480165030402010500308006092a864886f70d0107010000a080308203e23"
}

```

|Error Code|Description|
|---|---|
|MISSING_REQUIRED|returned when the request is missing a required field value|
|INVALID_FIELD|returned when the request contains an invalid field value|
|INVALID_JSON|returned when the request is not valid JSON|

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentapplepay/browse/API.md#!/Payment_AppleyPay/post_payment_applepay_sessions_v2" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

## <a name="using-payment-wallet"></a>Using Payment Wallet

---

- [PayPal Express](#paypal-express)
- [PayPal Express Job Status by ID](#paypal-express-job-by-id)
- [PayPal Mark](#paypal-mark)
- [PayPal Mark Job Status by ID](#paypal-mark-job-by-id)
- [PayPal Details](#paypal-details)
- [PayPal Details Job Status by ID](#paypal-details-job-by-id)

### <a name="paypal-wallet-overview"></a>Payment Wallet Overview

When paying with PayPal, this service initializes a PayPal session and generates a PayPal redirect URL and token. It also retrieves and validates PayPal meta data. There is an endpoint for PayPal Express and a separate endpoint for PayPal Mark flows. The PayPal Express flow allows the customer to choose a saved or add a new shipping and billing address at the PayPal site rather than in the Nike experience. The PayPal Mark flow allows the customer to choose an existing or add a new shipping address in the Nike experience and choose a saved or add a new billing address at the PayPal site.

This endpoint operates **asynchronously** which means that there are extra steps to retrieve the results of your request. Read the Asynchronous Operation section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#asynchronous-operation) guide to learn more about working with asynchronous Nike APIs.

### <a name="paypal-express"></a>PayPal Express

---

This endpoint passes in Checkout information including totals, items, pricing and other information so a session can be initiated at PayPal. The service returns a paypalToken and redirectURL in the response. When the customer is ready to Pay, the experience redirects to the PayPal redirectURL passing the paypalToken. PayPal uses the token to look up the session and permits the customer to pay. When the customer successfully pays or cancels the payment on the PayPal site, PayPal redirects the customer to either the returnURL or cancelURL passed in the request body.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**PUT**|`/payment/paypal_express/v1{?fields}`|no|

#### Path & Query Parameters

|Parameter|Description|Data Type|Required?|
|---|---|---|---|
|**fields**|comma-separated list of fields to return in response. If null, all fields are returned.|String|Optional|

#### <a name="paypalexpress-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="paypalexpress-request-body"></a>Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**request**|array|Array of objects|Required|
|request.**currency**|string|ISO currency code of shopping in country. defaults to USD|Required|
|request.**locale**|string|Locale of shopping in country. defaults to en_US|Required|
|request.**country**|string|ISO2 shopping in country code. defaults to en_US|Required|
|request.**returnURL**|string|Nike URL to return to after customer successfully pays for an order at the PayPal site|Required|
|request.**cancelURL**|string|Nike URL to return to after customer successfully cancels an order at the PayPal site|Required|
|request.**priceInfo**|string|Object containing Checkout pricing information|Required|
|request.priceInfo.**price**|number|Net amount of Checkout minus applied discounts|Required|
|request.priceInfo.**discount**|number|Net amount of discounts applied|Optional|
|request.priceInfo.**total**|number|Checkout total amount before discount|Required|
|request.priceInfo.**taxTotal**|number|Total tax amount|Required|
|request.**paymentInfo**|array|Array of objects containing payment information|Optional|
|request.paymentInfo.**id**|string|UUID generated by client for this payment|Required|
|request.paymentInfo.**type**|string|Only value allowed is "GiftCard"|Required|
|request.paymentInfo.**paymentId**|string|**paymentId** from Stored Payments service, required if this is a stored payment|Optional|
|request.paymentInfo.**accountNumber**|string|Gift card number, required for GiftCard type|Optional|
|request.paymentInfo.**giftCardPin**|string|Gift card PIN number, required for GiftCard type|Optional|
|request.**shippingInfo**|object|Object of shipping information|Optional|
|request.shippingInfo.**cost**|object|Object of shipping cost information|Optional|
|request.shippingInfo.cost.**price**|number|Net shipping amount (double)|Required|
|request.shippingInfo.cost.**discount**|number|Discount on net shipping amount (double), such as a promotion|Optional|
|request.shippingInfo.cost.**total**|number|Total shipping amount (double)|Required|
|request.shippingInfo.cost.**taxTotal**|number|Total tax on net shipping amount (double)|Required|
|request.**items**|array|Array of Checkout items/services|Required|
|request.items.**quantity**|integer|Quantity of Checkout item|Required|
|request.items.**skuId**|string|Stock keeping unit id of Checkout item, UUID format, from Merchandising service|Required|
|request.items.**priceInfo**|object|Object containing price information for this Checkout item|Required|
|request.items.priceInfo.**price**|number|Net price of Checkout item/service minus applied discounts|Required|
|request.items.priceInfo.**employeePrice**|number|Net employee price of item/service|Optional|
|request.items.priceInfo.**discount**|number|Discount applied to net price of Checkout item/service, such as a promotion|Optional|
|request.items.priceInfo.**total**|number|Total item/service price after discount is applied (price - discount)|Required|
|request.items.priceInfo.**taxTotal**|number|Total tax amount item/service|Required|

Sample *PayPal Express* request body:

```
{
  "request": {
    "currency": "USD",
    "locale": "en_US",
    "country": "US",
    "returnURL": "http://www.nike.com/snkrs/thread/return/863e7283-abe1-4a4b-bb55-200340b35044",
    "cancelURL": "http://www.nike.com/snkrs/thread/cancel/863e7283-abe1-4a4b-bb55-200340b35044",
    "priceInfo": {
      "price": 208.1,
      "discount": 0.1,
      "total": 228.8,
      "taxTotal": 20.8
    },
    "paymentInfo": [
      {
        "id": "15611769-e81b-45dd-b28c-ca0effb272de88",
        "type": "GiftCard",
        "paymentId": "15611769-e81b-45dd-b28c-ca0effb272de212"
      }
    ],
    "items": [
      {
        "quantity": 1,
        "skuId": "15611769-e81b-45dd-b28c-ca0effb272de",
        "priceInfo": {
          "price": 200.1,
          "discount": 0.1,
          "total": 200,
          "taxTotal": 20.1
        }
      }
    ]
  }
}
```

#### <a name="paypalexpress-response-body"></a>Response Body

The HTTP 202 response from *PayPal Express* contains information about how to retrieve the results of your job via the *PayPal Express Job by ID* endpoint. Following are descriptions of the important fields in the response body:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|UUID job ID generated by the endpoint used to look up the job status|Required|
|**status**|string|Status of the job. one of "PENDING", "IN_PROGRESS", "COMPLETED"|Required|
|**eta**|integer|If status is not COMPLETED, estimated wait time in milliseconds before polling the jobs endpoint to get results|Optional|
|**links**|string|Relative URL path to poll the jobs endpoint (see nested `ref` field)|Optional|
|**resourceType**|string|Resource type, always payment/paypal_express/jobs|Required|
|links.self.**ref**|string|Relative link to job|Required|
|**error**|object|Error object containing details of the cause(s) of error, present when service returns in error|Optional|
|error.**httpStatus**|integer|Status code present when service returns in error|Optional|
|error.**message**|string|Top level error message present when service returns in error|Optional|
|error.**code**|string|Enum of JOB_TIME or SYSTEM_ERROR|Optional|
|error.**id**|string|Error id|Optional|
|**errors**|array|Array of error objects present when service returns in error|Optional|
|error.errors.**field**|string|JSON field name causing error|Required|
|error.errors.**code**|string|Enum of error codes, one of "MISSING_REQUIRED","INVALID_FIELD","INVALID_JSON","INVALID_PAYMENT_TYPE"|Required|
|error.errors.**message**|string|Error message|Required|
|**response**|object|If status is COMPLETED, response object is present|Optional|
|response.**resourceType**|string|Resource type, always payment/paypal_express|Required|
|response.**paypalToken**|string|PayPal express token|Required|
|response.**redirectURL**|string|PayPal redirect URL customer follows to pay|Required|

Sample *PayPal Express* response body:

```
{
  "id": "2722be3a-0341-11e6-b512-3e1d05defe78",
  "status": "PENDING",
  "eta": 2000,
  "resourceType": "payment/paypal_express/jobs",
  "links": {
    "self": {
      "ref": "/payment/paypal_express/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78"
    }
  }
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentwallet/browse/API.md#!/Paypal_express_service/post_payment_paypal_express_v1" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="paypal-express-job-by-id"></a>PayPal Express Job by ID

---

Use this endpoint to check the status of the *PayPal Express* job. After receiving a HTTP 202 from the *PayPal Express* call and waiting the duration of the eta time, call this endpoint using the same UUID to check the status of your job. If the status is not COMPLETED, continue the cycle of waiting the eta period and checking the job status.

To know if the job is done, check the value of the status field in the response body as follows:

- "status": "PENDING": job processing has not started
- "status": "IN_PROGRESS": job processing in progress
- "status": "COMPLETED": job has completed

Once you receive a job status of "COMPLETED", get the results of your job by parsing the data in the response object from this endpoint.

>**TIP:** Parsing the "COMPLETED" job result directly is a best practice because it eliminates making another service call.

####  Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**GET**|`/payment/paypal_express/v1/jobs/{id}{?fields}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|creditCardInfoId in <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> format generated by the client|String|Required|
|**fields**|Query|comma-separated list of fields to return from the response body for a job in the COMPLETED status. If null, all response fields are returned||Optional|

#### <a name="paypalexpressjob-request-headers"></a>Request Headers

|Header Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.
>
><i class="mr2-sm g72-check"></i>Get the {id} path parameter from the `id` job UUID in the PayPal Express response.

Sample *PayPal Express Job by ID* request URI

```
https://api.nike.com/payment/paypal_express/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe783424
```

#### <a name="paypalexpressjob-response-body"></a>Response Body

The HTTP 200 response from *PayPal Express* contains information about how to retrieve the results of your job via the 'PayPal Express Job' endpoint. Following are descriptions of the important fields in the response body:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|Job UUID same as the one returned from *PayPal Express* endpoint|Required|
|**resourceType**|string|Enum, always payment/paypal_express/jobs|Required|
|**status**|string|Enum one of "PENDING", "IN_PROGRESS", "COMPLETED"|Required|
|**eta**|integer|Present when status is not "COMPLETED," caller should wait this time in ms before polling the job|Optional|
|links.self.**ref**|string|Relative link to job|Required|
|**error**|object|Error object containing details of the cause(s) of error, present when service returns in error|Optional|
|error.**httpStatus**|integer|Status code present when service returns in error|Optional|
|error.**message**|string|Top level error message present when service returns in error|Optional|
|error.**code**|string|Enum of JOB_TIME or SYSTEM_ERROR|Optional|
|error.**id**|string|Error id|Optional|
|**errors**|array|Array of error objects present when service returns in error|Optional|
|error.errors.**field**|string|JSON field name causing error|Required|
|error.errors.**code**|string|Enum of error codes, one of "MISSING_REQUIRED","INVALID_FIELD","INVALID_JSON","INVALID_PAYMENT_TYPE"|Required|
|error.errors.**message**|string|Error message|Required|
|**response**|object|Present when status is "COMPLETED" and gives detailed job results|Optional|
|response.**resourceType**|string|Enum always payment/paypal_express|Required|
|response.**paypalToken**|string|PayPal-generated token|Required|
|response.**redirectURL**|string|Redirect URL to the PayPal site|Required|

Sample *PayPal Express Job by ID* response body:

```
{
  "id": "2722be3a-0341-11e6-b512-3e1d05defe783424",
  "resourceType": "payment/paypal_express/jobs",
  "status": "COMPLETED",
  "links": {
    "self": {
      "ref": "/payment/paypal_express/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe783424"
    }
  },
  "response": {
    "resourceType": "payment/paypal_express",
    "paypalToken": "EC-7U206006SF029170Y",
    "redirectURL": "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-7U206006SF029170Y"
  }
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentwallet/browse/API.md#!/Paypal_express_service/get_payment_paypal_express_v1_jobs_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="paypal-mark"></a>PayPal Mark

---

Similar to the [PayPal Express](#paypal-express) endpoint, the PayPal Mark endpoint passes in Checkout information including totals, items, pricing, shipping address and other information so a Mark session can be initiated at PayPal. The service returns a paypalToken and redirectURL in the response. When the customer is ready to Pay, the experience redirects to the PayPal redirectURL passing the paypalToken. PayPal uses the token to look up the session and permits the customer to pay. When the customer successfully pays or cancels the payment on the PayPal site, PayPal redirects the customer to either the returnURL or cancelURL passed in the request body.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**POST**|`/payment/paypal_mark/v1{?fields}`|no|

#### Path & Query Parameters

|Name|Description|Required?|
|---|---|---|
|**fields**|comma-separated list of fields to return from the response body for a job in the COMPLETED status. If null, all response fields are returned|Optional|

#### <a name="paypal-mark-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="paypal-mark-request-body"></a>Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**request**|array|Array of objects|Required|
|request.**currency**|string|ISO currency code of shopping in country. defaults to USD|Required|
|request.**locale**|string|Locale of shopping in country. defaults to en_US|Required|
|request.**country**|string|ISO code of shopping in country. defaults to en_US|Required|
|request.**returnURL**|string|Nike URL to return to after customer successfully pays for an order at the PayPal site|Required|
|request.**cancelURL**|string|Nike URL to return to after customer successfully cancels an order at the PayPal site|Required|
|request.**priceInfo**|object|Object containing Checkout pricing information|Required|
|request.priceInfo.**price**|number|Net amount of Checkout minus applied discounts|Required|
|request.priceInfo.**discount**|number|Net amount of discounts applied|Optional|
|request.priceInfo.**total**|number|Checkout total amount before discount|Required|
|request.priceInfo.**taxTotal**|number|Total tax amount|Required|
|request.**paymentInfo**|array|Array of objects containing payment information|Optional|
|request.paymentInfo.**id**|string|UUID generated by client for this payment|Required|
|request.paymentInfo.**type**|string|GiftCard|Required|
|request.paymentInfo.**paymentId**|string|**paymentId** from Stored Payments service, required if this is a stored payment|Optional|
|request.paymentInfo.**accountNumber**|string|Gift card number, required for GiftCard type|Optional|
|request.paymentInfo.**giftCardPin**|string|Gift card PIN number, required for GiftCard type|Optional|
|request.**shippingInfo**|object|Object containing `recipient` ,`address`,`contactInfo` and `cost` objects|Required|
|request.shippingInfo.**recipient**|object|Object containing customer shipping contact information|Required|
|request.shippingInfo.recipient.**firstName**|string|Billing first name|Required|
|request.shippingInfo.recipient.**altFirstName**|string|Billing alternate first name|Optional|
|request.shippingInfo.recipient.**lastName**|string|Billing last name|Required|
|request.shippingInfo.recipient.**altLastName**|string|Billing alternate last name|Optional|
|request.shippingInfo.recipient.**middleName**|string|Billing middle name|Optional|
|request.shippingInfo.**address**|object|Object containing customer shipping address information|Required|
|request.shippingInfo.address.**address1**|string|Billing address line 1|Required|
|request.shippingInfo.address.**address2**|string|Billing address line 2|Optional|
|request.shippingInfo.address.**address3**|string|Billing address line 3|Optional|
|request.shippingInfo.address.**city**|string|Billing address city|Required|
|request.shippingInfo.address.**state**|string|Billing address state|Optional|
|request.shippingInfo.address.**postalCode**|string|Billing address postalCode|Optional|
|request.shippingInfo.address.**country**|string|Billing address country|Required|
|request.shippingInfo.**contactInfo**|object|Object containing customer email address and phone number|Required|
|request.shippingInfo.address.contactInfo.**phoneNumber**|string|Customer's billing phone number|Required|
|request.shippingInfo.address.contactInfo.**email**|string|Customer's email address|Required|
|request.shippingInfo.address.**cost**|object|Shipping cost information|Required|
|request.shippingInfo.address.cost.**price**|number|Net shipping amount|Required|
|request.shippingInfo.address.cost.**discount**|number|Discount on net shipping amount|Optional|
|request.shippingInfo.address.cost.**total**|number|Total shipping amount|Required|
|request.shippingInfo.address.cost.**taxTotal**|number|Tax total on net shipping amount|Required|
|request.**items**|array|Array of objects containing Checkout items|Required|
|request.items.**quantity**|integer|Quantity of Checkout item|Required|
|request.items.**skuId**|string|Stock keeping unit id of Checkout item, UUID format, from Merchandising service|Required|
|request.items.**priceInfo**|object|Object containing price information for this Checkout item|Required|
|request.items.priceInfo.**price**|number|Net price of Checkout item (double)|Required|
|request.items.priceInfo.**employeePrice**|number|Net employee price of item/service (double)|Required|
|request.items.priceInfo.**discount**|number|Discount applied to net price|Optional|
|request.items.priceInfo.**total**|number|Total price for item/service (price-discount)|Required|
|request.items.priceInfo.**taxTotal**|number|Total tax amount for item/service|Required|

Sample *PayPal Mark* request body:

```
{
  "request": {
    "currency": "USD",
    "locale": "en_US",
    "country": "US",
    "returnURL": "http://www.nike.com/snkrs/thread/return/863e7283-abe1-4a4b-bb55-200340b35044",
    "cancelURL": "http://www.nike.com/snkrs/thread/cancel/863e7283-abe1-4a4b-bb55-200340b35044",
    "priceInfo": {
      "price": 208.1,
      "discount": 0.1,
      "total": 228.9,
      "taxTotal": 20.9
    },
    "paymentInfo": [
      {
        "id": "15611769-e81b-45dd-b28c-ca0effb272de88",
        "type": "GiftCard",
        "paymentId": "15611769-e81b-45dd-b28c-ca0effb272de212"
      }
    ],
    "shippingInfo": {
      "recipient": {
        "firstName": "William",
        "altFirstName": "",
        "lastName": "Bowerman",
        "altLastName": "",
        "middleName": ""
      },
      "address": {
        "address1": "1 Bowerman Dr",
        "address2": "RG-2092",
        "address3": "#123",
        "city": "Beaverton",
        "state": "OR",
        "postalCode": "97005",
        "country": "US"
      },
      "contactInfo": {
        "phoneNumber": "503-555-1234",
        "email": "email@nike.com"
      },
      "cost": {
        "price": 8.1,
        "discount": 0.1,
        "total": 8,
        "taxTotal": 0.8
      }
    },
    "items": [
      {
        "quantity": 1,
        "skuId": "15611769-e81b-45dd-b28c-ca0effb272de",
        "priceInfo": {
          "price": 200.1,
          "discount": 0.1,
          "total": 200,
          "taxTotal": 20.1
        }
      }
    ]
  }
}
```

#### <a name="paypal-mark-response-body"></a>Response Body

The HTTP 202 response from *PayPal Mark* contains information about how to retrieve the results of your job via the *PayPal Express Job by ID* endpoint. Following are descriptions of the important fields in the response body:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|UUID job ID generated by the endpoint used to look up the job status|Required|
|**status**|string|Status of the job. one of "PENDING", "IN_PROGRESS", "COMPLETED"|Required|
|**eta**|integer|If status is not COMPLETED, estimated wait time in milliseconds before polling the jobs endpoint to get results|Optional|
|**links**|string|Relative URL path to poll the jobs endpoint (see nested `ref` field)|Optional|
|**resourceType**|string|Resource type, always payment/paypal_express/jobs|Required|
|links.self.**ref**|string|Relative link to job|Required|
|**error**|object|Error object containing details of the cause(s) of error, present when service returns in error|Optional|
|error.**httpStatus**|integer|Status code present when service returns in error|Optional|
|error.**message**|string|Top level error message present when service returns in error|Optional|
|error.**code**|string|Enum of JOB_TIME or SYSTEM_ERROR|Optional|
|error.**id**|string|Error id|Optional|
|**errors**|array|Array of error objects present when service returns in error|Optional|
|error.errors.**field**|string|JSON field name causing error|Required|
|error.errors.**code**|string|Enum of error codes, one of "MISSING_REQUIRED","INVALID_FIELD","INVALID_JSON","INVALID_PAYMENT_TYPE"|Required|
|error.errors.**message**|string|Error message|Required|
|**response**|object|If status is COMPLETED, response object is present|Optional|
|response.**resourceType**|string|Resource type, always payment/paypal_express|Required|
|response.**paypalToken**|string|PayPal express token|Required|
|response.**redirectURL**|string|PayPal redirect URL customer follows to pay|Required|

Sample *PayPal Mark* response body in "PENDING" status:

```
{
  "id": "2722be3a-0341-11e6-b512-3e1d05defe78",
  "status": "PENDING",
  "eta": 2000,
  "resourceType": "payment/paypal_mark/jobs",
  "links": {
    "self": {
      "ref": "/payment/paypal_mark/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78"
    }
  }
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentwallet/browse/API.md#!/Paypal_mark_service/post_payment_paypal_mark_v1" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="paypal-mark-job-by-id"></a>PayPal Mark Job by ID

---

Use this endpoint to check the status of the *PayPal Mark* job. After receiving a HTTP 202 from the *PayPal Mark* call and waiting the duration of the eta time, call this endpoint using the same UUID to check the status of your job. If the status is not COMPLETED, continue the cycle of waiting the eta period and checking the job status.

#### Endpoint Details

To know if the job is done, check the value of the status field in the response body as follows:
- "status": "PENDING": job processing has not started
- "status": "IN_PROGRESS": job processing in progress
- "status": "COMPLETED": job has completed

Once you receive a job status of "COMPLETED", get the results of your job by parsing the data in the response object from this endpoint.

>**TIP:** Parsing the "COMPLETED" job result directly is a best practice because it eliminates making another service call.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**GET**|`/payment/paypal_mark/v1/jobs/{id}{?fields}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|creditCardInfoId in <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> format generated by the client|String|Required|
|**fields**|Query|comma-separated list of fields to return from the response body for a job in the COMPLETED status. If null, all response fields are returned||Optional|

#### <a name="paypal-mark-job-by-id-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.
>
><i class="mr2-sm g72-check"></i>Get the {id} path parameter from the `id` job UUID in the PayPal Mark response.

Sample PayPal Mark Job by ID request URI:

```
https://api.nike.com/payment/paypal_mark/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78
```
#### <a name="paypal-mark-job-by-id-response-body"></a>Response Body

The HTTP 200 response from *PayPal Mark* contains information about how to retrieve the results of your job via the *PayPal Mark Job by ID* endpoint. Following are descriptions of the important fields in the response body:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|UUID job ID generated by the endpoint used to look up the job status|Required|
|**status**|string|Status of the job. one of "PENDING", "IN_PROGRESS", "COMPLETED"|Required|
|**eta**|integer|If status is not COMPLETED, estimated wait time in milliseconds before polling the jobs endpoint to get results|Optional|
|**links**|string|Relative URL path to poll the jobs endpoint (see nested `ref` field)|Optional|
|**resourceType**|string|Resource type, always payment/paypal_express/jobs|Required|
|links.self.**ref**|string|Relative link to job|Required|
|**error**|object|Error object containing details of the cause(s) of error, present when service returns in error|Optional|
|error.**httpStatus**|integer|Status code present when service returns in error|Optional|
|error.**message**|string|Top level error message present when service returns in error|Optional|
|error.**code**|string|Enum of JOB_TIME or SYSTEM_ERROR|Optional|
|error.**id**|string|Error id|Optional|
|**errors**|array|Array of error objects present when service returns in error|Optional|
|error.errors.**field**|string|JSON field name causing error|Required|
|error.errors.**code**|string|Enum of error codes, one of "MISSING_REQUIRED","INVALID_FIELD","INVALID_JSON","INVALID_PAYMENT_TYPE"|Required|
|error.errors.**message**|string|Error message|Required|
|**response**|object|If status is COMPLETED, response object is present|Optional|
|response.**resourceType**|string|Resource type, always payment/paypal_express|Required|
|response.**paypalToken**|string|PayPal express token|Required|
|response.**redirectURL**|string|PayPal redirect URL customer follows to pay|Required|

Sample *PayPal Mark Job by ID* response body:
```
{
  "id": "2722be3a-0341-11e6-b512-3e1d05defe78",
  "resourceType": "payment/paypal_mark/jobs",
  "status": "COMPLETED",
  "links": {
    "self": {
      "ref": "/payment/paypal_mark/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78"
    }
  },
  "response": {
    "resourceType": "payment/paypal_mark",
    "paypalToken": "EC-7U206006SF029170Y",
    "redirectURL": "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-7U206006SF029170Y"
  }
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentwallet/browse/API.md#!/Paypal_mark_service/get_payment_paypal_mark_v1_jobs_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="paypal-details"></a>PayPal Details

---

This endpoint retrieves and validates PayPal data, including shipping and billing information and the PayPal token. Call this endpoint after calling either the *PayPal Mark* or *PayPal Express* endpoint.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**POST**|`/payment/paypal_details/v1{?fields}`|no|

#### Request Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**fields**|Query|comma-separated list of fields to return from the response body for a job in the COMPLETED status. If null, all response fields are returned||Optional|

#### <a name="paypal-details-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="paypal-details-request-body"></a>Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**request**|object|Request object|Required|
|request.**paypalToken**|string|PayPal-assigned token returned from either the *PayPal Mark* or *PayPal Express* endpoints|Required|
|request.**shoppingCountry**|string|Shopping country. Defaults to en_US|Required|

Sample *PayPal Details* request body:

```
{
  "request": {
    "paypalToken": "EC-7U206006SF029170Y",
    "shoppingCountry": "US"
  }
}
```

#### <a name="paypal-details-response-body"></a>Response Body

The HTTP 202 response from *PayPal Details* contains information about how to retrieve the results of your job via the *PayPal Details Job by ID* endpoint. Following are descriptions of the important fields in the response body:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|UUID job ID generated by the endpoint used to look up the job status|Required|
|**status**|string|Status of the job. one of "PENDING", "IN_PROGRESS", "COMPLETED"|Required|
|**eta**|integer|If status is not COMPLETED, estimated wait time in milliseconds before polling the jobs endpoint to get results|Optional|
|**resourceType**|string|Resource type, always payment/paypal_details|Required|
|links.self.**ref**|string|Relative link to job to poll the jobs endpoint|Required|
|**error**|object|Error object containing details of the cause(s) of error, present when service returns in error|Optional|
|error.**httpStatus**|integer|Status code present when service returns in error|Optional|
|error.**message**|string|Top level error message present when service returns in error|Optional|
|error.**code**|string|Enum of JOB_TIME or SYSTEM_ERROR|Optional|
|error.**id**|string|Error id|Optional|
|**errors**|array|Array of error objects present when service returns in error|Optional|
|error.errors.**field**|string|JSON field name causing error|Required|
|error.errors.**code**|string|Enum of error codes, one of "MISSING_REQUIRED","INVALID_FIELD","INVALID_JSON","INVALID_PAYMENT_TYPE"|Required|
|error.errors.**message**|string|Error message|Required|
|**response**|object|If status is COMPLETED, response object is present|Optional|
|response.**resourceType**|string|Resource type, always payment/paypal_details|Required|
|response.**paypalToken**|string|PayPal express token|Required|
|response.**shippingInfo**|string|Object containing `recipient` ,`address`,`contactInfo` objects|Required|
|response.shippingInfo.**recipient**|object|Object containing customer shipping contact information|Required|
|response.shippingInfo.recipient.**firstName**|string|Billing first name|Required|
|response.shippingInfo.recipient.**altFirstName**|string|Billing alternate first name|Optional|
|response.shippingInfo.recipient.**lastName**|string|Billing last name|Required|
|response.shippingInfo.recipient.**altLastName**|string|Billing alternate last name|Optional|
|response.shippingInfo.recipient.**middleName**|string|Billing middle name|Optional|
|response.shippingInfo.**address**|object|Object containing customer shipping address information|Required|
|response.shippingInfo.address.**address1**|string|Billing address line 1|Required|
|response.shippingInfo.address.**address2**|string|Billing address line 2|Optional|
|response.shippingInfo.address.**address3**|string|Billing address line 3|Optional|
|response.shippingInfo.address.**city**|string|Billing address city|Required|
|response.shippingInfo.address.**state**|string|Billing address state|Optional|
|response.shippingInfo.address.**postalCode**|string|Billing address postalCode|Optional|
|response.shippingInfo.address.**country**|string|Billing address country|Required|
|response.shippingInfo.**contactInfo**|object|Object containing customer email address and phone number|Required|
|response.shippingInfo.contactInfo.**phoneNumber**|string|Customer's billing phone number|Required|
|response.shippingInfo.contactInfo.**email**|string|Customer's email address|Required|
|response.**billingInfo**|object|Object containing name, address, and contactInfo objects|Required|
|response.billingInfo.**name**|object|Object containing customer's name information|Required|
|response.billingInfo.name.**firstName**|string|Shipping address first name|Required|
|response.billingInfo.name.**altFirstName**|string|Shipping address alternate first name|Optional|
|response.billingInfo.name.**lastName**|string|Shipping address last name|Required|
|response.billingInfo.name.**altLastName**|string|Shipping address alternate last name|Optional|
|response.billingInfo.name.**middleName**|string|Shipping address middle name|Optional|
|response.billingInfo.**address**|object|Object containing customer's address information|Required|
|response.billingInfo.address.**address1**|string|Shipping address line 1|Required|
|response.billingInfo.address.**address2**|string|Shipping address line 2|Optional|
|response.billingInfo.address.**address3**|string|Shipping address line 3|Optional|
|response.billingInfo.address.**city**|string|Shipping address city|Required|
|response.billingInfo.address.**state**|string|Shipping address state|Optional|
|response.billingInfo.address.**postalCode**|string|Shipping address postalCode|Optional|
|response.billingInfo.address.**country**|string|Shipping address country|Required|
|response.billingInfo.**contactInfo**|object|Object containing customer's contact information|Required|
|response.billingInfo.contactInfo.**phoneNumber**|string|Shipping address contact info phone number|Required|
|response.billingInfo.contactInfo.**email**|string|Shipping address contact info email address|Required|

Sample *PayPal Details* 202 response body in "PENDING" status:

```
{
  "id": "2722be3a-0341-11e6-b512-3e1d05defe78",
  "status": "PENDING",
  "eta": 2000,
  "resourceType": "payment/paypal_details/jobs",
  "links": {
    "self": {
      "ref": "/payment/paypal_details/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78"
    }
  }
}
```

Sample *PayPal Details* 400 response body:

```
{
  "message": "Validation Failed",
  "errors": [
    {
      "field": "/request/shoppingCountry",
      "code": "INVALID_FIELD",
      "message": "Invalid value."
    },
    {
      "field": "/request/paypalToken",
      "code": "MISSING_REQUIRED",
      "message": "Missing value."
    }
  ]
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentwallet/browse/API.md#!/Paypal_Details_service/post_payment_paypal_details_v1" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

#### <a name="paypal-details-job-by-id"></a>PayPal Details Job by ID

---

Use this endpoint to check the status of the *PayPal Details* job. After receiving a HTTP 202 from the *PayPal Details* call and waiting the duration of the eta time, call this endpoint using the same UUID to check the status of your job. If the status is not COMPLETED, continue the cycle of waiting the eta period and checking the job status.

#### Endpoint Details

To know if the job is done, check the value of the status field in the response body as follows:

- "status": "PENDING": job processing has not started
- "status": "IN_PROGRESS": job processing in progress
- "status": "COMPLETED": job has completed

Once you receive a job status of "COMPLETED", get the results of your job by parsing the data in the response object from this endpoint.

>**TIP:** Parsing the "COMPLETED" job result directly is a best practice because it eliminates making another service call.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**GET**|`/payment/paypal_details/v1/jobs/{id}{?fields}`|no|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**id**|Path|Job ID in <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> format generated by the client|String|Required|
|**fields**|Query|comma-separated list of fields to return from the response body for a job in the COMPLETED status. If null, all response fields are returned|String|Optional|

##### <a name="paypal-details-job-by-id-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.
>
><i class="mr2-sm g72-check"></i>Get the {id} path parameter from the `id` job UUID in the *PayPal Details* response.

Sample PayPal Details Job by ID request URI

```
https://api.nike.com/payment/paypal_details/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78
```

#### <a name="paypal-mark-job-by-id-response-body"></a>Response Body

The response body is the same as is returned in the *PayPal Details* response body. See the detailed response field list in the [PayPal Details Response Body](#paypal-details-response-body)

The HTTP 200 response from *PayPal Details* contains information about how to retrieve the results of your job via the 'PayPal Details Job' endpoint. Following are descriptions of the important fields in the response body:

Sample *PayPal Details Job by ID* 200 response body in "COMPLETED" status:

```
{
  "id": "2722be3a-0341-11e6-b512-3e1d05defe783424",
  "resourceType": "payment/paypal_details/jobs",
  "status": "COMPLETED",
  "links": {
    "self": {
      "ref": "/payment/paypal_details/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78432"
    }
  },
  "response": {
    "resourceType": "payment/paypal_details",
    "paypalToken": "EC-7U206006SF029170Y",
    "shippingInfo": {
      "recipient": {
        "firstName": "William",
        "altFirstName": "",
        "lastName": "Bowerman",
        "altLastName": "",
        "middleName": ""
      },
      "address": {
        "address1": "1 Bowerman Dr",
        "address2": "RG-2092",
        "address3": "#123",
        "city": "Beaverton",
        "state": "OR",
        "postalCode": "97005",
        "country": "US"
      },
      "contactInfo": {
        "phoneNumber": "503-555-1234",
        "email": "email@nike.com"
      }
    },
    "billingInfo": {
      "recipient": {
        "firstName": "William",
        "altFirstName": "",
        "lastName": "Bowerman",
        "altLastName": "",
        "middleName": ""
      },
      "address": {
        "address1": "1 Bowerman Dr",
        "address2": "RG-2092",
        "address3": "#123",
        "city": "Beaverton",
        "state": "OR",
        "postalCode": "97005",
        "country": "US"
      },
      "contactInfo": {
        "phoneNumber": "503-555-1234",
        "email": "email@nike.com"
      }
    }
  }
}
```

|Error Code|Description|
|---|---|
|MISSING_REQUIRED|returned when the request is missing a required field value|
|INVALID_FIELD|returned when the request contains an invalid field value|
|INVALID_JSON|returned when the request is not valid JSON|

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentwallet/browse/API.md#!/Paypal_Details_service/get_payment_paypal_details_v1_jobs_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->



## <a name="using-deferred-payment"></a>Using Deferred Payment

---

- [Deferred Payment Form](#deferred-payment-form)
- [Deferred Payment Form Job](#deferred-payment-form-job-status-by-id)
- [Deferred Payment Status](#deferred-payment-status)
- [Deferred Payment Status Job](#deferred-payment-status-job-status-by-id)
- [Deferred Payment WeChat](#deferred-payment-wechat)
- [Deferred Payment WeChat Job](#deferred-wechat-payment-job-status-by-id)

### Deferred Payment Overview

When paying for a Nike Checkout through a third-party vendor, this service generates the values needed to open and pay at a third-party website or app. This service is used for experiences that support the iDeal, Sofort and/or China payment types. The Payment API supported China payment types are Alipay, Tenpay, UnionPay and WeChat.

This endpoint operates **asynchronously** which means that there are extra steps to retrieve the results of your request. Read the Asynchronous Operation section of the [Using NDe APIs](/doc/getting-started/using_nike_apis.html#asynchronous-operation) guide to learn more about working with asynchronous Nike APIs.

### <a name="deferred-payment-form"></a>Deferred Payment Form

---

Use this endpoint to generate a signed link used to redirect the customer to pay at a third-party site or app. In the case of WeChat, see the [Deferred Payment WeChat](#deferred-payment-wechat) endpoint.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**POST**|`/payment/deferred_payment_forms/v1{?fields}`|no|

#### <a name="deferred-payment-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="deferred-payment-request-body"></a>Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**request**|object|Object containing `approvalId`, `orderNumber`, `returnURL`, `experienceType`|Required|
|**approvalId**|string|UUID approvalId returned by the Payment Approval service|Required|
|**orderNumber**|string|Checkout order number|Required|
|**returnURL**|string|URL to redirect to after successful payment is made at the third-party site|Required|
|**experienceType**|string|One of `DESKTOP`,`MOBILE`,`APP`|Required|

Sample *Deferred Payment Form* request:

```
  {
    "request": {
      "approvalId": "2722be3a-0341-11e6-b512-3e1d05defe783424",
      "orderNumber": "CA0000001234",
      "returnURL": "https://www.nike.com/snkrs/thread/dac5cabbf257a14c275289931f0f2121041df12b",
      "experienceType": "DESKTOP"
    }
  }
```

#### <a name="deferred-payment-response-body"></a>Response Body

The HTTP 202 response from *Deferred Payment Form* contains information about how to retrieve the results of your job via the 'Deferred Payment Form Job' endpoint. Listed below are the response body fields.

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|UUID job ID generated by the endpoint used to look up the job status|Required|
|**status**|string|Status of the job. one of "PENDING", "IN_PROGRESS", "COMPLETED"|Required|
|**eta**|integer|If status is not COMPLETED, estimated wait time in milliseconds before polling the jobs endpoint to get results|Optional|
|**resourceType**|string|Resource type, always payment/deferred_payment_forms|Required|
|links.self.**ref**|string|Relative link to job to poll the jobs endpoint|Required|
|**error**|object|Error object containing details of the cause(s) of error, present when service returns in error|Optional|
|error.**httpStatus**|integer|Status code present when service returns in error|Optional|
|error.**message**|string|Top level error message present when service returns in error|Optional|
|error.**code**|string|Enum of JOB_TIME or SYSTEM_ERROR|Optional|
|error.**id**|string|Error id|Optional|
|**errors**|array|Array of error objects present when service returns in error|Optional|
|error.errors.**field**|string|JSON field name causing error|Required|
|error.errors.**code**|string|Enum of error codes, one of "MISSING_REQUIRED","INVALID_FIELD","INVALID_JSON","INVALID_PAYMENT_TYPE"|Required|
|error.errors.**message**|string|Error message|Required|
|**response**|object|If status is COMPLETED, response object is present|Optional|
|response.**qrCodeURL**|string|URL that generates a QR code that the customer can use to open the third party app or website|Optional|
|response.**resourceType**|string|Enum always payment/deferred_payment_forms|Required|
|response.**form**|object|Form object|Optional|
|response.form.**action**|string|Form action URL with query parameters, for GET form method|Required|
|response.form.**method**|string|Form HTTP method, one of GET, POST|Required|
|response.form.**fields**|array|Vendor-specific array of form fields when the method is POST|Optional|
|response.form.fields.**name**|string|Form field name|Optional|
|response.form.fields.**value**|string|Form field value|Optional|

Sample *Deferred Payment Form* 202 response in "PENDING" status:

```
{
    "id": "2722be3a-0341-11e6-b512-3e1d05defe78",
    "status": "PENDING",
    "eta": 300,
    "resourceType": "payment/deferred_payment_forms/jobs",
    "links": {
      "self": {
        "ref": "/payment/deferred_payment_forms/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78"
      }
    }
  }
```

Sample *Deferred Payment Form* 400 response:

```
{
  "message": "Validation Failed",
  "errors": [
    {
      "field": "/request/experienceType",
      "code": "INVALID_FIELD",
      "message": "Invalid value."
    },
    {
      "field": "/request/returnURL",
      "code": "MISSING_REQUIRED",
      "message": "Required field"
    }
  ]
}
```

|Error Code|Description|
|---|---|
|MISSING_REQUIRED|returned when the request is missing a required field value|
|INVALID_FIELD|returned when the request contains an invalid field value|
|INVALID_JSON|returned when the request is not valid JSON|

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/pendingpayment/browse/API.md#!/Deferred_Payment_Form/post_payment_deferred_payment_forms_v1" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="deferred-payment-form-job-status-by-id"></a>Deferred Payment Form Job Status by Id

---

Use this endpoint to check the status of the *Deferred Payment Form* job. After receiving a HTTP 202 from the *Deferred Payment Form* call and waiting the duration of the eta time, call *Deferred Payment Form Job Status by Id* using the same UUID to check the status of your job. If the status is not COMPLETED, continue the cycle of waiting the eta period and checking the job status. In the case of WeChat, see the [Deferred Payment WeChat](#deferred-payment-wechat) endpoint.

To know if the job is done, check the value of the `status` field in the response body as follows:

- `"status": "PENDING"`: job processing has not started
- `"status": "IN_PROGRESS"`: job processing in progress
- `"status": "COMPLETED"`: job has completed

Once you receive a job status of COMPLETED, get the results of your job by parsing the data in the `response` object from this endpoint. Alternatively, follow the link to the *Deferred Payment Form Job* endpoint which is provided in the `links` object response body.

>**TIP:** Parsing the 'COMPLETED' job result directly is a best practice because it eliminates making another service call.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**GET**|`/payment/deferred_payment_forms/v1/jobs/{id}?{fields}`|no|

#### Path & Query Parameters

|Parameter|Description|Data Type|Required?|
|---|---|---|---|
|**id**|Unique identifier <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> for the job|String|Required|
|**fields**|comma-separated list of fields to return from the response body for a job in the COMPLETED status. If null, all response fields are returned.|String|**Optional**|

#### <a name="deferred-payment-job-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.
>
><i class="mr2-sm g72-check"></i>Get the {id} path parameter from the `id` job UUID in the Deferred Payment Form response.

Sample *Deferred Payment Form Job* request URI:

```
https://api.nike.com/payment/deferred_payment_forms/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78
```

#### <a name="deferred-payment-job-response-body"></a>Response Body

The HTTP 202 response from *Deferred Payment Form Job* contains information about how to retrieve the results of your job via the 'Deferred Payment Form Job' endpoint. The response body is the same as is returned in the [Deferred Payment Form](#deferred-payment-response-body) except that the resourceType is payment/deferred_payment_forms.

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/pendingpayment/browse/API.md#!/Deferred_Payment_Form/get_payment_deferred_payment_forms_v1_jobs_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="deferred-payment-status"></a>Deferred Payment Status

---

Use this endpoint to validate the Deferred Payment with the third-party Vendor.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**POST**|`/payment/deferred_payment_status/v1{?fields}`|no|

#### Path & Query Parameters

|Parameter|Description|Data Type|Required?|
|---|---|---|---|
|**fields**|comma-separated list of fields to return from the response body for a job in the COMPLETED status. If null, all response fields are returned.|String|Optional|

#### <a name="deferred-payment-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="deferred-payment-request-body"></a>Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**request**|object|Object containing `approvalId`, `VendorData**|Required|
|request.**approvalId**|string|UUID approvalId returned by the Payment Approval service|Required|
|request.**vendorData**|object|Object containing key/value pairs coming from the vendor redirect|Required|
|request.vendorData.**parameters**|object|Data returned form the payment vendor redirect|Required|
|request.vendorData.parameters.**name**|string|Request parameter name|Optional|
|request.vendorData.parameters.**value**|string|Request parameter value|Optional|

Sample *Deferred Payment Status* request:

```
{
  "request": {
    "approvalId": "2722be3a-0341-11e6-b512-3e1d05defe783424",
    "vendorData": {
      "parameters": [
        {
          "name": "out_trade_no",
          "value": "AO1234556"
        },
        {
          "name": "trade_no",
          "value": "T1234556"
        },
        {
          "name": "signature",
          "value": "83503850340kg045345-0934-590359-30535"
        }
      ]
    }
  }
}
```

#### <a name="deferred-payment-job-response-body"></a>Response Body

The HTTP 200 response from *Deferred Payment Status* contains information about how to retrieve the results of your job via the *Deferred Payment Status Job* endpoint. Listed below are the response body fields:

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|UUID job ID generated by the endpoint used to look up the job status|Required|
|**status**|string|Status of the job. one of "PENDING", "IN_PROGRESS", "COMPLETED"|Required|
|**eta**|integer|If status is not COMPLETED, estimated wait time in milliseconds before polling the jobs endpoint to get results|Optional|
|**resourceType**|string|Resource type, always payment/deferred_payment_status|Required|
|links.self.**ref**|string|Relative link to job to poll the jobs endpoint|Required|
|**error**|object|Error object containing details of the cause(s) of error, present when service returns in error|Optional|
|error.**httpStatus**|integer|Status code present when service returns in error|Optional|
|error.**message**|string|Top level error message present when service returns in error|Optional|
|error.**code**|string|Enum of JOB_TIME or SYSTEM_ERROR|Optional|
|error.**id**|string|Error id|Optional|
|**errors**|array|Array of error objects present when service returns in error|Optional|
|error.errors.**field**|string|JSON field name causing error|Required|
|error.errors.**code**|string|Enum of error codes, one of "MISSING_REQUIRED","INVALID_FIELD","INVALID_JSON","INVALID_PAYMENT_TYPE"|Required|
|error.errors.**message**|string|Error message|Required|
|**response**|object|If status is COMPLETED, response object is present|Optional|
|response.**resourceType**|string|Enum always payment/deferred_payment_status|Required|
|response.**status**|string|Payment status in third-party system, enum one of "UNKNOWN", "PAYMENT_SUCCESSFUL", "PAYMENT_PENDING", "PAYMENT_FAILED", "PAYMENT_REFUNDED", "PAYMENT_REFUND_FAILED", "PAYMENT_CANCELLED"|Required|
|response.**amount**|number|Amount paid|Required|

Sample *Deferred Payment Status* response in "PENDING" status:

```
{
  "id": "2722be3a-0341-11e6-b512-3e1d05defe78",
  "status": "PENDING",
  "resourceType": "payment/deferred_payment_status",
  "eta": 300,
  "links": {
    "self": {
      "ref": "/payment/deferred_payment_status/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78"
    }
  }
}
```

|Error Code|Description|
|---|---|
|MISSING_REQUIRED|returned when the request is missing a required field value|
|INVALID_FIELD|returned when the request contains an invalid field value|
|INVALID_JSON|returned when the request is not valid JSON|

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/pendingpayment/browse/API.md#!/Deferred_Payment_Status/post_payment_deferred_payment_status_v1" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="deferred-payment-status-job-status-by-id"></a>Deferred Payment Status Job Status by Id

---

Use this endpoint to check the status of the *Deferred Payment Status* job. After receiving a HTTP 202 from the *Deferred Payment Status* call and waiting the duration of the eta time, call this endpoint using the same UUID to check the status of your job. If the status is not COMPLETED, continue the cycle of waiting the eta period and checking the job status.

#### Endpoint Details

To know if the job is done, check the value of the status field in the response body as follows:

- "status": "PENDING": job processing has not started
- "status": "IN_PROGRESS": job processing in progress
- "status": "COMPLETED": job has completed

Once you receive a job status of "COMPLETED", get the results of your job by parsing the data in the response object from this endpoint.

>**TIP:** Parsing the "COMPLETED" job result directly is a best practice because it eliminates making another service call.

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**GET**|`/payment/deferred_payment_status/v1/jobs/{id}?{fields}`|no|

#### Path & Query Parameters

|Parameter|Description|Data Type|Required?|
|---|---|---|---|
|**id**|Unique identifier <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> for the job|String|Required|
|**fields**|comma-separated list of fields to return from the response body for a job in the COMPLETED status. If null, all response fields are returned.|String|**Optional**|

#### <a name="deferred-payment-status-job-status-by-id-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.
>
><i class="mr2-sm g72-check"></i>Get the {id} path parameter from the `id` job UUID in the Deferred Payment Status response.

Sample Deferred Payment Status Job request URI:

```
https://api.nike.com/payment/deferred_payment_status/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78
```

#### <a name="deferred-payment-status-job-status-by-id-response-body"></a>Response Body

The HTTP 200 response from *Deferred Payment Status Job* contains information about how to retrieve the results of your job via the 'Deferred Payment Status Job' endpoint. The fields in the response are the same as those returned from the [Deferred Payment Status](#deferred-payment-job-response-body) except the resourceType is payment/deferred_payment_status/jobs.

Sample Deferred Payment Status Job response in "IN_PROGRESS" status with header:

```
{
  "id": "2722be3a-0341-11e6-b512-3e1d05defe783424",
  "status": "IN_PROGRESS",
  "resourceType": "payment/deferred_payment_status/jobs",
  "links": {
    "self": {
      "ref": "/payment/deferred_payment_status/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe783424"
    }
  }
}
```

Sample *Deferred Payment Status Job* response in "COMPLETED" status:

```
{
  "id": "2722be3a-0341-11e6-b512-3e1d05defe783424",
  "status": "COMPLETED",
  "resourceType": "payment/deferred_payment_status/jobs",
  "links": {
    "self": {
      "ref": "/payment/deferred_payment_status/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe783424"
    }
  },
  "response": {
    "resourceType": "payment/deferred_payment_status",
    "status": "PAYMENT_SUCCESSFUL",
    "amount": 7283.64
  }
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/pendingpayment/browse/API.md#!/Deferred_Payment_Status/get_payment_deferred_payment_status_v1_jobs_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->

### <a name="deferred-payment-wechat"></a>Deferred Payment WeChat

---

Use this endpoint to generate the necessary values to initiate a session in the WeChat Pay Browser Phone App from the browser. See <a href="https://confluence.nike.com/display/ocp/jsapi+wechat+browser" target="_blank">JSAPI WeChat Browser</a> and <a href="http://mp.weixin.qq.com/wiki/17/c0f37d5704f0b64713d5d2c37b468d75.html" target="_blank">WeChat Documentation</a> for JavaScript implementation details. Note that this endpoint should be used for the Mobile Web or Desktop/WeChat flows only. The Mobile Web flow opens the WeChat Payment app directly when it is time to pay for the Nike Checkout; the Desktop flow generates a QR code when it is time to pay for the Nike Checkout that when followed, opens the WeChat Payment App on the customer's Mobile device.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**POST**|`/payment/deferred_wechat_payments/v1{?fields}`|no|

#### Path & Query Parameters

|Parameter|Description|Data Type|Required?|
|---|---|---|---|
|**fields**|comma-separated list of fields to return from the response body for a job in the COMPLETED status. If null, all response fields are returned.|String|**Optional**|

#### <a name="deferred-wechat-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIP:** When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.

#### <a name="deferred-payment-request-body"></a>Request Body

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**request**|object|Request object|Required|
|request.**approvalId**|string|UUID approvalId returned by the Payment Approval service|Required|
|request.**orderNumber**|string|Checkout order number|Required|
|request.**code**|string|Code returned by the [Payment Approval](#using-payment-approval) service|Required|

Sample *Deferred Payment WeChat* Request:

```
{
  "request": {
    "approvalId": "2722be3a-0341-11e6-b512-3e1d05defe783424",
    "orderNumber": "CA0000001234",
    "code": "041MaL7k2zfjRH0q6q7k29dJ7k2MaL75"
  }
}
```

#### <a name="deferred-payment-response-body"></a> Response Body

The HTTP 200 response from *Deferred Payment WeChat* contains information about how to retrieve the results of your job via the *Deferred Payment WeChat Job* endpoint. The response body fields are listed below.

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**id**|string|UUID job ID generated by the endpoint used to look up the job status|Required|
|**status**|string|Status of the job. one of "PENDING", "IN_PROGRESS", "COMPLETED"|Required|
|**eta**|integer|If status is not COMPLETED, estimated wait time in milliseconds before polling the jobs endpoint to get results|Optional|
|**resourceType**|string|Resource type, always payment/deferred_wechat_payments|Required|
|links.self.**ref**|string|Relative link to job to poll the jobs endpoint|Required|
|**error**|object|Present when service throws 5xx error and cannot complete the request|Optional|
|error.**httpStatus**|integer|Status code present when service returns in error|Optional|
|error.**message**|string|Top level error message present when service returns in error|Optional|
|error.**code**|string|Enum of JOB_TIME or SYSTEM_ERROR|Optional|
|error.**id**|string|Error id|Optional|
|**errors**|array|Array of error objects present when service returns in error|Optional|
|error.errors.**field**|string|JSON field name causing error|Required|
|error.errors.**code**|string|Enum of error codes, one of "MISSING_REQUIRED","INVALID_FIELD","INVALID_JSON","INVALID_PAYMENT_TYPE"|Required|
|error.errors.**message**|string|Error message|Required|
|**response**|object|Response object|Optional|
|response.**resourceType**|string|Only "payment/deferred_wechat_payments" is allowed|Required|
|response.**appId**|string|Nike application id assigned by WeChat|Required|
|response.**signType**|string|Type of signature scheme used MD5|Required|
|response.**paySign**|string|Signature proving the request came from Nike|Required|
|response.**nonceStr**|string|One-time-use only generated string|Required|
|response.**package**|string|WeChat-generated prepay id assigned to this transaction|Required|
|response.**timestamp**|string|Timestamp of transaction|Required|

Sample *Deferred Payment WeChat* response in "PENDING" status:

```
{
  "id": "2722be3a-0341-11e6-b512-3e1d05defe78",
  "status": "PENDING",
  "resourceType": "payment/deferred_wechat_payments/jobs",
  "eta": 300,
  "links": {
    "self": {
      "ref": "/payment/deferred_wechat_payments/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78"
    }
  }
}
```

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/pendingpayment/browse/API.md#!/Deferred_Payment_for_Wechat_with_Code_required/post_payment_deferred_wechat_payments_v1" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->



### <a name="deferred-wechat-payment-job-status-by-id"></a>Deferred WeChat Payment Job Status by Id

---

Use this endpoint to check the status of the *Deferred WeChat Payment* job. After receiving a HTTP 202 from the *Deferred WeChat Payment* call and waiting the duration of the eta time, call this endpoint using the same UUID to check the status of your job. If the status is not COMPLETED, continue the cycle of waiting the eta period and checking the job status.

#### Endpoint Details

To know if the job is done, check the value of the status field in the response body as follows:

- "status": "PENDING": job processing has not started
- "status": "IN_PROGRESS": job processing in progress
- "status": "COMPLETED": job has completed

Once you receive a job status of "COMPLETED", get the results of your job by parsing the data in the response object from this endpoint.

>**TIP:** Parsing the "COMPLETED" job result directly is a best practice because it eliminates making another service call.

|HTTP Method|URI Path|JWT Restricted|
|---|---|---|
|**GET**|`/payment/deferred_wechat_payments/v1/jobs/{id}?{fields}`|no|

#### Path & Query Parameters

|Parameter|Description|Data Type|Required?|
|---|---|---|---|
|**id**|Unique identifier <a href="https://en.wikipedia.org/wiki/Universally_unique_identifier" target="_blank">UUID</a> for the job|String|Required|
|**fields**|comma-separated list of fields to return from the response body for a job in the COMPLETED status. If null, all response fields are returned.|String|**Optional**|

#### <a name="deferred-wechat-payment-job-request-headers"></a>Request Headers

|Name|Description|Required?|
|---|---|---|
|**Accept**|Content type accepted in response, application/json is only value allowed|Required|
|**Content-Type**|Content type of the request, application/json is only value allowed|Required|
|**Authorization**|Your access token in the format of Bearer {token}|Required|

>**TIPS:**
>
><i class="mr2-sm g72-check"></i>When calling this endpoint through the public router, the `upmid` (for logged in customers), `appId` and `usertype` headers are automatically added by the Nike Edge Router based on the access token in the Authorization header populated by Nike Unite.
>
><i class="mr2-sm g72-check"></i>Get the {id} path parameter from the `id` job UUID in the Deferred Payment Form response.

Sample Deferred WeChat Payment Job request URI:

```
https://api.nike.com/payment/deferred_wechat_payments/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78
```

#### <a name="deferred-payment-job-response-body"></a>Response Body

The HTTP 200 response from *Deferred WeChat Payment Job* contains information about how to retrieve the results of your job via the 'Deferred WeChat Payment Job' endpoint. The response body fields are the same as those returned in the [Deferred Payment WeChat](#deferred-payment-response-body) response except the resourceType is payment/deferred_wechat_payments/jobs.

Sample *Deferred Payment Form Job* response in "IN_PROGRESS" status:

```
{
  "id": "2722be3a-0341-11e6-b512-3e1d05defe78",
  "resourceType": "payment/deferred_payment_forms/jobs",
  "status": "IN_PROGRESS",
  "links": {
    "self": {
      "ref": "/payment/deferred_wechat_payments/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe78"
    }
  }
}
```

Sample *Deferred WeChat Payment Job* response in "COMPLETED" status:

```
{
  "id": "2722be3a-0341-11e6-b512-3e1d05defe783424",
  "resourceType": "payment/deferred_wechat_payments/jobs",
  "status": "COMPLETED",
  "links": {
    "self": {
      "ref": "/payment/deferred_wechat_payments/v1/jobs/2722be3a-0341-11e6-b512-3e1d05defe783424"
    }
  },
  "response": {
    "resourceType": "payment/deferred_wechat_payments",
    "appId": "wx2421b1c4370ec43b",
    "signType": "MD5",
    "paySign": "70EA570631E4BB79628FBCA90534C63FF7FADD89",
    "nonceStr": "e61463f8efa94090b1f366cccfbbb444",
    "package": "prepay_id=u802345jgfjsdfgsdg888",
    "timeStamp": " 1395712654"
  }
}
```

|Error Code|Description|
|---|---|
|MISSING_REQUIRED|returned when the request is missing a required field value|
|INVALID_JSON|returned when the request is not valid JSON|

<!-- <a href="http://developer.nikedev.com/?apib=https://bitbucket.nike.com/projects/PHYLPAY/repos/pendingpayment/browse/API.md#!/Deferred_Payment_for_Wechat_with_Code_required/get_payment_deferred_wechat_payments_v1_jobs_id" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-border-dark-grey">TRY IT OUT</a> -->



## <a name="upgrading-to-the-latest-version"></a>Upgrading to the latest version

All experiences are using the versions listed in the [API at a Glance](#api-at-a-glance) section above. There are no upgrade instructions at this time.

## <a name="best-practices"></a>Best Practices

### Polling

To avoid excessive job polling of asynchronous endpoints, wait the number of milliseconds returned in the job request eta before checking the job status.

### Retry Conditions

For all Payment APIs, the general rule is that requests resulting in a HTTP 4XX response should not be retried without modification to the request data, but HTTP 5XX errors can be retried as is. For general information on Nike error retry practices, see <a href="https://confluence.nike.com/pages/viewpage.action?spaceKey=DAHP&title=API+-+Error+Patterns#API-ErrorPatterns-RetrylogicbasedonHTTPstatuscode" target="_blank">API Error Patterns</a> on Confluence.

The exception to the 4xx response rule is the 429 response, indicating that there are too many requests coming in for the service to handle. When a service returns a 429, the call should be retried a maximum of two times, using the value returned in the `Retry-After` header to determine when to make the follow-up call.

## <a name="troubleshooting"></a>Troubleshooting

Listed below are some techniques to troubleshoot problems using the Payment API.

### Query Splunk With a Trace ID

In order to abide by PCI-compliance rules, payment logging requires special Splunk access. As a result, you can not query Splunk by Trace ID as a trouble-shooting tool to track down why a payment request failed. If need help from the Payment Team, post your problem to the <a href="https://confluence.nike.com/display/PHYLON/Payment+Team+Playbook" target="_blank">CiC Payment</a> Slack channel with details such as:

- experience in which you encountered the error, iOS SNKRS app, nike.com web, Android SNKRS app, direct endpoint call etc.
- time request failed
- Trace ID
- request URI and body (if not GET request)
- error codes and error messages

### Inspect Browser Activity in a Live Experience

Try using your browser's built-in tools for inspecting web service calls made from a live Nike experience such as <a href="http://www.nike.com/launch" target="_blank">SNKRS Web</a>. Or, set up Charles and your favorite device to proxy service calls made from the Nike SNKRS or Nike+ Apps. Sometimes seeing what other experiences are doing might address your question or concern.

>**TIP:** While inspecting http://www.nike.com/launch, you can change your shopping country with the flag icon at the upper right of the homepage to test different locales. Place orders in different countries with different payment methods to view the Payment call flow with other CiC services. Orders can be cancelled via self-service within 30 minutes of submission, otherwise contact Nike Customer Service.

## <a name="glossary"></a>Glossary

|Term|Definition|
|---|---|
|Authorization (of payment)|Temporary hold on funds in a customer's account for a future charge|
|Deferred Payment|Third-party bank through which a customer pays for their Nike order after it is placed|
|<a href="https://www.pcisecuritystandards.org/pci_security/" target="_blank">PCI-DSS</a>|Payment Card Industry Data Security Standard provides secure standards for handling credit card data. All Nike CiC payment services are PCI-DSS compliant.|
|Void (of payment)|reverses a successful Authorization|

**<a name="supported-stored-payment-types"></a>Supported Stored Payment Types**

The Stored Payment Service supports storing these types of payment:

|Payment Type Description|Value|Storage Limit|
|---|---|---|
|Alipay|**AliPay**|1|
|Apple Pay|**ApplePay**|1|
|Credit Card|**CreditCard**|4|
|Gift Card|**GiftCard**|10|
|PayPal|**PayPal**|1|
|Tenpay|**TenPay**|1|
|UnionPay|**UnionPay**|1|
|WeChat|**WeChat**|1|

**<a name="pay-options-by-country"></a>Payment Options by Country**

See the <a href="https://confluence.nike.com/pages/viewpage.action?pageId=162870810" target="_blank">Global Payment Options</a> for a list of supported payment types by shipping and billing country.

## <a name="document-change-log"></a>Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|01/08/2018|Initial Draft|
|Layout changes|02/13/2018|Updated doc layout per new API Doc standard|
|Updated links|03/20/2018|Updated links to point to new dev portal|
|Updated external links|04/03/2018|Updated external links to open in new browser window|
|Updated API.md links|05/14/2018|Updated API.md links to point to new dev portal|
|Updated request/response tables|07/01/2018|Normalized formatting of request/response tables|
|Updated TOC|10/01/2018|Removed 'In this guide', replaced with sidebar TOC|

## <a name="related-links"></a>Related Links

[NDe Docs Home](/index.html)

[Get Started](/doc/getting-started/get-started.html)