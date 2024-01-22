---
id: overview-payment
tags: pdf
category: a-overview
position: 7
title: Payment
url: /doc/commerce/payment/overview-payment.html
h1: Payment Overview
dev-guide: /doc/commerce/payment/use-payment.html
---
Learn how to use [Payment](/doc/commerce/payment/use-payment.html) to manage the purchase process for consumers purchasing Nike products and services.

#### Nike Payment gives consumers fast and easy ways to pay for purchases with support for popular payment methods across the globe
![SNKRS App Payment](/images/commerce/payment/snkrs_payment-md.png){:style="float:right;margin-left:20px;"}

<img style="display: inline-block; margin-right: 20px; width: 65px; height:38px; vertical-align: middle;"
     src="/images/icons/visa_logo.png" alt="Visa Logo"/>
<img style="display: inline-block; margin-right: 20px; width: 65px; height:38px; vertical-align: middle;"
     src="/images/icons/mastercard_logo.png" alt="MasterCard Logo"/>
<img style="display: inline-block; margin-right: 20px; width: 65px; height:30px; vertical-align: middle;"
     src="/images/icons/apple_pay_logo.svg" alt="ApplePay Logo"/>
<img style="display: inline-block; margin-right: 20px; width: 65px; height:19px; vertical-align: middle;"
     src="/images/icons/alipay_logo.png" alt="Alipay Logo"/>
<img style="display: inline-block; margin-right: 20px; width: 70px; height:26px; vertical-align: middle;"
     src="/images/icons/paypal_logo.png" alt="PayPal Logo"/>
<img style="display: inline-block; margin-right: 20px; width: 70px; height:26px; vertical-align: middle;"
     src="/images/icons/sofort_logo.png" alt="Sofort Logo"/>
<img style="display: inline-block; margin-right: 20px; width: 65px; height:24px; vertical-align: middle;"
     src="/images/icons/klarna_logo.png" alt="Klarna Logo"/>
<img style="display: inline-block; width: 65px; height:32px; vertical-align: middle;"
     src="/images/icons/ideal_logo.png" alt="iDeal Logo"/>

Nike payment is modular. Although certain payment steps are required, others are optional, and your app can determine the order in which to call them based on your app flow and the payment methods it supports.

With Nike payment, your app does not need to handle sensitive consumer payment data. Nike payment handles this for you by:
- Utilizing a secure capture mechanism that sends consumer payment information over HTTPS to a separate, PCI-compliant storage compartment
- Masking consumer-sensitive payment sent to the client
- Requiring clients to send a payment-generated ID in order to retrieve payment information rather than an account number or Nike UPMID

#### Use Cases

Step through the Use Cases below to incorporate Payment capabilities into your experience.

|---|
|<i class="g72-check"></i>&nbsp;&nbsp;[Get available payment options.](/doc/commerce/payment/use-payment.html#listing-and-validating-payment-options)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Manage a consumer's stored payments.](/doc/commerce/payment/use-payment.html#storing-payment)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Allocate amount owed across payment types.](/doc/commerce/payment/use-payment.html#payment-preview)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Initiate an Apple Pay transaction.](/doc/commerce/payment/use-payment.html#apple-pay-payment)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Initiate a wallet transaction for Paypal Express or PayPal Mark.](/doc/commerce/payment/use-payment.html#wallet-payment)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Initiate a deferred payment transaction like WeChat.](/doc/commerce/payment/use-payment.html#deferred-payment)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Initiate a ready payment for Korea payments](/doc/commerce/payment/use-payment.html#korea-payment)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Save and validate credit card information. Retrieve masked credit card information.](/doc/commerce/payment/use-payment.html#credit-card-payment)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Perform 3-D Secure authentication](/doc/commerce/payment/use-payment.html#3-d-secure-authentication)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Perform fraud check, validation and authorization/debit for all payment types on a consumer’s Checkout.](/doc/commerce/payment/use-payment.html#payment-approval)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Send payment notification to debit, credit, void or reauthorize a consumer's payment.](/doc/commerce/payment/use-payment.html#post-order-payment-processing)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Send third party payment notification to Nike.](/doc/commerce/payment/use-payment.html#third-party-payment-notification)|
{:max-width="85%"}

<aside class="note">
    <h5 style="text-align:center;">APIs:</h5>
    <ul>
        <li>
            <a href="https://console.platforms.nike.com/developer/docs/projects/Payment%20Options?tab=api" >
            Payment Options</a> <span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://console.platforms.nike.com/developer/docs/projects/Payment%20Stored%20Payments?tab=api" >
            Payment Stored Payments</a><span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://console.platforms.nike.com/developer/docs/projects/Payment%20Preview?tab=api" >
            Payment Preview</a> <span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://console.platforms.nike.com/developer/docs/projects/Payment%20ApplePay?tab=api" >
            Payment Apple Pay</a><span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://console.platforms.nike.com/developer/docs/projects/Payment%20Wallet?tab=api" >
            Payment Wallet</a> <span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://console.platforms.nike.com/developer/docs/projects/Payment%20Deferred%20Payment?tab=api" >
            Payment Deferred Payment</a> <span class="guide-details-li-text"></span>
        </li>
     <li>
            <a href="https://console.platforms.nike.com/developer/docs/projects/Payment%20Korea?tab=api" >
            Payment Korea Payment</a> <span class="guide-details-li-text"></span>
        </li>
     <li>
            <a href="https://console.platforms.nike.com/developer/docs/projects/Payment%20Credit%20Card%20Submit?tab=api" >
            Payment Credit Card Submit</a> <span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://console.platforms.nike.com/developer/docs/projects/Payment3DS?tab=api" >Payment 3DS Service</a><span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://console.platforms.nike.com/developer/doc/commerce/payment/use-payment.html#payment-approval" >Payment Approval</a><span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://console.platforms.nike.com/developer/docs/projects/Payment%20Gateway?tab=api" >
            Fulfillment Payment Notification</a> <span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://github.com/nike-internal/payment.service.paymentnotification/blob/master/API.md" >
            Third Party Payment Notification</a> <span class="guide-details-li-text"></span>
        </li>
    </ul>
</aside>

<h4>Related Information</h4>
            
* [Adding Cart & Checkout to Your Experience:](/doc/commerce/checkout/use-checkout.html) Learn how to add Cart & Checkout to your experience
* [Supported Countries:](/doc/commerce/reference/global.html) Refer to this guide for the list of supported country code, language, and currency code combinations allowed by Cart & Checkout.
* [Working with Circuit Breakers:](/doc/commerce/reference/caller-best-practices.html) Learn how to be a good client by following these best practices.
* [Glossary:](/doc/commerce/reference/glossary.html) Common terms explained.
* [Product Life Cycle:](/doc/commerce/reference/product-lifecycle.html) Discover how Nike products become available for purchase in an experience.

### Connect to the Docs Team

 We're here to help.&nbsp;&nbsp;&nbsp;<i class="g72-chat"></i> [Slack](slack://channel?team=T0G3T5X2B&id=C6A18NT7W)&nbsp;&nbsp;&nbsp;<i class="g72-email"></i> [Email](mailto:Lst-nde.docs@nike.com)