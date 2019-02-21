---
id: overview-payment
tags: pdf
category: a-overview
position: 7
title: Payment
url: /doc/commerce/payment/overview-payment.html
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn ncss-brand guide-button pt2-sm pr5-sm pb2-sm pl5-sm"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a><a href="/doc/commerce/payment/use-payment.html" class="ncss-btn ncss-brand guide-button pt2-sm pr5-sm pb2-sm pl5-sm"><i class="fas fa-arrow-alt-circle-right"></i> DEV GUIDE</a>

# Payment Overview

---

Learn how to use [Payment](/doc/commerce/payment/use-payment.html) to manage the purchase process for customers purchasing Nike products and services.

#### Nike Payment gives customers fast and easy ways to pay for purchases, with support for popular payment methods across the globe.

<img style="display: inline-block; margin-right: 20px; width: 65px; height:38px; vertical-align: middle;"
     src="/images/icons/visa_logo.png" alt="Visa Logo"/>
<img style="display: inline-block; margin-right: 20px; width: 65px; height:38px; vertical-align: middle;"
     src="/images/icons/mastercard_logo.png" alt="MasterCard Logo"/>
<img style="display: inline-block; margin-right: 20px; width: 65px; height:30px; vertical-align: middle;"
     src="/images/icons/apple_pay_logo.png" alt="ApplePay Logo"/>
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

![SNKRS App Payment](/images/commerce/payment/snkrs_payment-md.png)

Nike payment is modular. Although certain payment steps are required, others are optional, and your app can determine the order in which to call them based on your app flow and the payment methods it supports.

With Nike payment, your app does not need to handle sensitive customer payment data. Nike payment handles this for you by:
- utilizing a secure capture mechanism that sends customer payment information over HTTPS to a separate, PCI-compliant storage compartment
- masking customer-sensitive payment sent to the client
- requiring clients to send a payment-generated ID in order to retrieve payment information rather than an account number or Nike UPMID

     
#### Use Cases

Step through the Use Cases below to incorporate Payment capabilities into your experience.

|---|
|<i class="g72-check"></i>&nbsp;&nbsp;[Get available payment options.](/doc/commerce/payment/use-payment.html#payment-options)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Manage a customer's stored payments.](/doc/commerce/payment/use-payment.html#storing-payment)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Allocate amount owed across payment types.](/doc/commerce/payment/use-payment.html#payment-preview)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Initiate an Apple Pay transaction.](/doc/commerce/payment/use-payment.html#apple-pay-payment)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Initiate a wallet transaction for Paypal Express or PayPal Mark.](/doc/commerce/payment/use-payment.html#wallet-payment)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Initiate a deferred payment transaction like WeChat.](/doc/commerce/payment/use-payment.html#deferred-payment)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Save and validate credit card information. Retrieve masked credit card information.](/doc/commerce/payment/use-payment.html#credit-card-payment)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Perform fraud check, validation and authorization/debit for all payment types on a customer’s Checkout.](/doc/commerce/payment/use-payment.html#payment-approval)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Send payment notification to debit, credit, void or reauthorize a customer's payment.](/doc/commerce/payment/use-payment.html#fulfillment-payment-notification)|
|<i class="g72-check"></i>&nbsp;&nbsp;[Send third party payment notification to Nike.](/doc/commerce/payment/use-payment.html#third-party-payment-notification)|
{:max-width="85%"}

<h4>Related Information</h4>
<aside class="note">
    <h5>APIs:</h5>
    <ul>
        <li>
            <a href="https://developer.niketech.com/docs/projects/Payment%20Options?tab=api" target="_blank">Payment Options</a> <span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://developer.niketech.com/docs/projects/Payment%20Preview?tab=api" target="_blank">Payment Preview</a> <span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://developer.niketech.com/docs/projects/Payment%20Stored%20Payments?tab=api" target="_blank">Payment Stored Payments</a> <span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://developer.niketech.com/docs/projects/Payment%20ApplePay?tab=api" target="_blank">Payment Apple Pay</a> <span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://developer.niketech.com/docs/projects/Payment%20Wallet?tab=api" target="_blank">Payment Wallet</a> <span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://developer.niketech.com/docs/projects/Payment%20Deferred%20Payment?tab=api" target="_blank">Payment Deferred Payment</a> <span class="guide-details-li-text"></span>
        </li>
        <li>
            <a href="https://developer.niketech.com/docs/projects/Payment%20Credit%20Card%20Submit?tab=api" target="_blank">Payment Credit Card Submit</a> <span class="guide-details-li-text"></span>
          <li>
            <a href="https://developer.niketech.com/docs/projects/Payment%20Gateway?tab=api" target="_blank">Fulfillment Payment Notification</a> <span class="guide-details-li-text"></span>
          </li>
          <li>
            <a href="https://bitbucket.nike.com/projects/PHYLPAY/repos/paymentnotification/browse/API.md" target="_blank">Third Party Payment Notification</a> <span class="guide-details-li-text"></span>
           </li>
        </li>
    </ul>
</aside>
            
* [Adding Cart & Checkout to Your Experience:](/doc/commerce/checkout/use-checkout.html) Learn how to add Cart & Checkout to your experience
* [Supported Countries and Currencies:](/doc/commerce/checkout/checkout-country-currency.html) Refer to this guide for the list of supported country code and currency code combinations allowed by Cart & Checkout.
* [Working with Circuit Breakers:](/doc/commerce/reference/caller-best-practices.html) Learn how to be a good client by following these best practices.
* [Glossary:](/doc/commerce/reference/glossary.html) Common terms explained.
* [Product Life Cycle:](/doc/commerce/reference/product-lifecycle.html) Discover how Nike products become available for purchase in an experience.

### Connect

 We're here to help.&nbsp;&nbsp;&nbsp;<i class="g72-chat"></i> [#Slack](https://nikedigital.slack.com/messages/C9Q1MNJ1J){:target="blank"}&nbsp;&nbsp;&nbsp;<i class="g72-email"></i> [Email](mailto:developer.relations@nike.com)