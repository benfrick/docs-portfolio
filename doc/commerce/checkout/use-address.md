---
id: use-address
tags: pdf
category: b-use-case
position: 6
title: Address Tools
url: /doc/commerce/checkout/use-address.html
toc:
- h2: Introduction
  url: /doc/commerce/checkout/use-address.html#introduction
- h2: Address Validation
  url: /doc/commerce/checkout/use-address.html#address-validation
- h2: Address Geocoding
  url: /doc/commerce/checkout/use-address.html#address-geocoding
- h2: API Quick Reference
  url: /doc/commerce/checkout/use-address.html#api-quick-reference
- h2: Troubleshooting
  url: /doc/commerce/checkout/use-address.html#troubleshooting
- h2: Contacting the Team
  url: /doc/commerce/checkout/use-address.html#contacting-the-team
- h2: Document Change Log
  url: /doc/commerce/checkout/use-address.html#document-change-log
- h2: Next Steps
  url: /doc/commerce/checkout/use-address.html#next-steps
---
{% include dev-header.html %}

---

##### Last Updated: 04/19/2021

Read this guide to learn how to use address tools in your experience.

## Introduction

Nike's address tools provide valuable address management functionality. 

- Use the **Address Validation** service before the consumer places their order to ensure their packages will be shipped to a deliverable address.

- Call the **Address Geocoding** service to turn an address into longitude and latitude coordinates in order to call other Nike APIs that require geocodes, such as [Fulfillment Offerings](/doc/commerce/checkout/use-fulfillment-offerings.html).

## Address Validation

<i class="g72-check"></i>&nbsp;&nbsp;**Ensure a shipping address is deliverable**

<i class="g72-check"></i>&nbsp;&nbsp;**Ensure a billing address is valid**

Validate a consumer-supplied address with the [Validate Address](https://developer.niketech.com/docs/projects/AddressValidator?tab=api){:target="new-tab"} service. This endpoint can validate any type of address such as shipping and billing addresses.

This service calls a third party vendor to validate the address passed in the request against an address database. The service response contains a `verficationCode`, `score`, and an address. Based on the quality of the address match, the service returns either the original address or a corrected one. See the table below to understand how the `verificationCode` and `score` work together to determine what actions the consumer needs to take next.

###### Table 1: Address Validator Verification Codes and Scores with Next Steps

|Verification Code|Score|Consumer needs to|
|---|---|---|
|**VERIFIED**|95 or greater|Address provided by the consumer is verified and is returned in the response. No further action is required by the consumer.|
|**VERIFIED**|less than 95|Address provided by the consumer is missing information and a recommended address is returned in the response. Consumer needs to review the recommended address and decide to accept it or retry with a different address.|
|**PARTIALLY_VERIFIED, UNVERIFIED, AMBIGUOUS, CONFLICT, REVERTED**|any|Address provided by the consumer could not be verified and is returned in the response. Consumer needs to correct the address and retry.|

>**TIP:** The third party address validation service has a 512 character limit restriction on each address field and a 1024 character limit for the entire address. The client should truncate characters in any address field exceeding the field limit or address limit before making the request.

See the [Address Validation Service](https://confluence.nike.com/pages/viewpage.action?pageId=270586569){:target="new-tab"} page for more information on request and response field mappings between the Address Validator API and the third party.

Listed below is a sample **Address Valdidate** POST request URI. This is a synchronous endpoint and is not JWT-protected:

```
https://api.nike.com/location/address_validator/v1
```

## Address Geocoding

<i class="g72-check"></i>&nbsp;&nbsp;**Turn an address into latitude and longitude coordinates**

<!--<i class="g72-check"></i>&nbsp;&nbsp;**Turn latitude and longitude coordinates into an address**-->

Need to call an API that requires the consumer's latitude and longitude location coordinates but you only have the consumer's address? Call the **Get Geocodes from Address API** passing address information as query parameters.

### Get geographic coordinates from an address

The [Geocoding API](https://developer.niketech.com/docs/projects/Geocoding?tab=api) allows you to exchange an address for latitude and longitude geo coordinates. This service is not JWT-protected.

###### Table 2: Request Query Parameters for the Get Geocodes from Address Endpoint

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

Sample [Get Geocodes from Address](https://developer.niketech.com/docs/projects/Geocoding?tab=api){:target="new-tab"} cURL GET request:
```
curl -X GET "https://api.nike.com/buy/geocodes/v1?filter=country(US)&filter=address1("1 Bowerman Drive")&filter=city("Beaverton")&filter=state(OR)&filter=postalCode(97005)" -H  "accept: application/json; charset=UTF-8"
```
A successful 200 response contains the `country` passed in the request, `latitude`, `longitude` and in some cases, `geoDistance`. `geoDistance` represents the accuracy radius in meters between the geocode coordinates and the physical location.

<!--

### Get an address from geographic coordinates

For the convenience of consumers, your experience may not want to require them to enter their postal code in order to perform a location search by [Fulfillment Offerings](#fulfillment-offerings). You can turn latitude and longitude geo coordinates into a physical address by calling the **Get Address from Geocodes API**.

### Step 1: Get the consumer's geographic coordinates (optional)

If you don't have the consumer's latitude and longitude coordinates, you can get them from the [browser](https://developer.mozilla.org/en-US/docs/Web/API/Geolocation_API) or through the operating system's location API on an [iPhone](https://developer.apple.com/documentation/corelocation/getting_the_user_s_location) or [Android](https://developer.android.com/training/location) mobile device.

> **Note**: You will need the consumer's permission to get their location.

### Step 2: Get the consumers' address

Once you have the geo coordinates, call the **Get Address from Geocodes API** to retrieve the consumer's full address. Send `country`,`latitude` and `longitude` number values as query parameters in the GET request. All query parameters are required.

Sample [Get Address from Geocodes](https://developer.niketech.com/docs/projects/Geocoding?tab=api){:target="new-tab"} cURL request:
```
curl -X GET "https://snkrs.prod.commerce.nikecloud.com/buy/reverse_geocodes/v1?filter=country(US)&filter=latitude(45.50696)&filter=longitude(-122.82701)" -H  "accept: application/json; charset=UTF-8"
```
A successful 200 response contains address information of the physical location matching the geocode coordinates passed in the request as well as latitude, longitude and geoDistance.

-->

## API Quick Reference

**Address Validator**
- [Validate Address](https://developer.niketech.com/docs/projects/AddressValidator?tab=api){:target="new-tab"}

**Address Geocoding**
- [Get Geocodes (coordinates) from Address](https://developer.niketech.com/docs/projects/Geocoding?tab=api){:target="new-tab"}
<!-- [Get Address from Geocodes](https://developer.niketech.com/docs/projects/Geocoding?tab=api)-->

## Contacting the Team

|Slack|Address Verification: [#cic-payment](https://nikedigital.slack.com/archives/C0Z9P2E5Q){:target="new-tab"}<br>Address Geocoding: [#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV){:target="new-tab"}|
|Confluence Space|Address Verification: [Payment](https://confluence.nike.com/display/PHYLON/Payment+Team+Playbook){:target="new-tab"}<br>Address Geocoding: [Buy](https://confluence.nike.com/display/BUY/Buy+Domain){:target="new-tab"}|
|Team Contacts|Address Verification: [Sree Krishna](mailto:sree.krishna@nike.com)<br>Address Geocoding: [Saket Shrivastava](mailto:saket.shrivastava@nike.com)|

## Document Change Log

|Summary |Date |
|---|---|
|Initial publish|04/19/2021|

## Next Steps

You've learned how to use address tools in your experience. Here are some related topics.

- [Wishlist](/doc/commerce/checkout/use-wishlists.html)
- [Checkout](/doc/commerce/checkout/use-checkout.html)
- [Fulfillment Offerings](/doc/commerce/checkout/use-fulfillment-offerings.html)
- [Payment](/doc/commerce/payment/use-payment.html)
- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)
- [Supported Countries & Currencies](/doc/commerce/checkout/checkout-country-currency.html)