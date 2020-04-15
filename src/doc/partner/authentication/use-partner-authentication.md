---
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="new-tab" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# NIKE PARTNERS: USING CONSUMER AUTHENTICATION

---

##### Last Updated: 04/14/2020

The Consumer Authentication process uses Nike's [Token API](#api-reference) to:

- Allow your consumers to login into their Nike account or register for a new one from your app or experience
- Enable your consumers to permit your app/experience to connect to their Nike account
- Authorize your app/experience to call other Nike services on behalf of your consumers

>**TIP**: Need server-to-server authentication instead? See the [S2S Authentication](/doc/partner/authentication/use-partner-auth-s2s.html) guide for details.

## Introduction

In this guide, we will step through how to add Nike Consumer Authentication to your app or experience.

![](/images/partner/authentication/partner-oauth-login-reg.png)

### What Is Consumer Authentication?

When you ask your consumers to prove their identify before accessing your app or experience, you ask them to authenticate. This is often done by requiring consumers to provide their account username and password.

Nike Consumer Authentication uses OAuth to perform consumer authentication to their accounts, which uses access tokens rather than passwords. That means that your app or experience does not have to deal with handling Nike consumer passwords securely.

After the consumer has successfully authenticated to their Nike account and given permission to your app to connect to their Nike account, you will get a temporary **consumer access token**.

As a last step in the authentication process, you will exchange the consumer access token for an **access token** and a **refresh token**. You will pass the access token in subsequent calls to Nike APIs, which indicates that the consumer has given permission to your app or experience to make API calls on their behalf.

>**TIP**: Access tokens expire periodically. When your access token is about to expire, you request a new access token using the refresh token.

Now let's go through some key terms related to Consumer Authentication.

## Key Terms

Here are some important terms used in this guide.

|Term|Definition|
|---|---|
|**Access Token**|OAuth token used in API calls. Valid for one hour.|
|**Authentication**|Confirming the identity of someone or something, such as your consumers.|
|**Authorization**|Allowing someone or something to perform an action or to access a resource, such as consumers authorizing your app to access their Nike account.|
|**Client ID**|Unique ID assigned to you by Nike. Along with the Client Secret, use it to get an access token and refresh token so you can call other Nike APIs on behalf of the consumer. See the [Prerequisites](#prerequisites) section for details.|
|**Client Secret**|Unique value assigned to you by Nike. Along with the Client ID, use it to get an access token and refresh token so you can call other Nike APIs on behalf of the consumer. See the [Prerequisites](#prerequisites) section for details.|
|**Consumer Access Token**|Temporary token exchanged for an access token and refresh token.|
|[OAuth](https://oauth.net/2/){:target="new-tab"}|A secure way for consumers to grant apps/experiences access to their information by an exchange of tokens rather than passwords.|
|**Refresh Token**|Token used to get a new access token when it is about to expire. Valid for one year.|
|[Token API](#api-reference)|API that manages OAuth tokens.|
|**Token Experience Configuration**|Configuration that handles customization of the consumer Nike Account Connection page. See the [Prerequisites](#prerequisites) section for details.|

## Prerequisites

You need to complete the steps below before you can add Consumer Authentication to your app/experience.

#### 1. Pair Up With a Nike Account Manager (AM) And Technical Point Of Contact (TPC)

Your Nike Business Lead (NBL) will put you in touch with these two points of contact. These contacts help make your integration go smoothly by communicating with various internal Nike teams for you. Your AM handles privacy and legal details. Your TPC handles the technical details of your project.

#### 2. Gather Your Project Requirements

This is the step where you provide Nike with information about your project and your technical needs.

Your **AM** needs to know:

**Project Information**
- **Partner name:** What is the name of your company?
- **Project name:** What are you calling your project?
- **Project contacts:** Who are the business and technical contacts for your project?
- **Project goals:** What are the expected outcomes of your project? How does this project benefit your company? Providing URLs to your public-facing project documentation is helpful too.
- **Project timeline:** What are the dates of your project milestones e.g. integration testing, end-to-end testing, production go-live?
- **Contract status:** Where in the contract life cycle is your project? Has it been drafted by Nike, reviewed, and signed by both parties?

Your **TPC** needs to know:

**Technical Information**
- **List of Nike APIs:** Decide what Nike APIs you need to call to meet your project goals. Talk with your TPC to learn more about Nike APIs and how they can fulfill your business objectives.
- **Nike API usage:** What are the consumer interactions with Nike APIs? Where and how will Nike APIs be accessed in your project?
- **Data:** What partner data will be shared with Nike? What Nike data will be shared with you?
- **Location of your test and production environment:** We'll need to know your hosting platform, physical location, and consumer-facing URL. We will also need your test and production URLs to add to our list of approved redirects. Nike only redirects to URLs on the whitelist.
- **Site traffic requirements:** How many visitors do you expect over what time period? How many simultaneous visitors to you expect at peak times?
- **Links to your Terms of Service and Privacy Policy Pages**: Nike includes these links as part of your partner configuration. These links display on your customized Connect Your Nike Account page where the consumer gives your app/experience permission to connect to their Nike account. Note that your pages must be static and available in every language you support as Nike cannot pass locale parameters.

#### 3. Get Legal And Privacy Approval

Your NBL will make sure that your project contract is ready to go and that all the data exchanged between your app/experience and Nike is handled securely. This process generally takes 1 - 5 business days.

#### 4. Get Your OAuth Credentials

Once the above prerequisites are complete, your TPC will give you your OAuth credentials (**Client ID** and **Client Secret**) so you start calling the [Token API](#api-reference).

>**TIP**: Do not share your Client Secret and make sure you store it securely.

In addition to generating your OAuth credentials, Nike creates a special configuration for your project based on your Client ID. This configuration drives UI elements and behaviors on the Nike Account Connection page. This configuration is covered in the next section.

<!--
## SLA

**TODO: What is the SLA of the token API?**
-->

## Get an Access Token and Refresh Token

<i class="g72-check"></i>&nbsp;&nbsp;**Get your access token and refresh token, so you can make API calls on behalf of the consumer**

After completing all the action items in the [Prerequisites](#prerequisites) section, you are ready to add Nike Consumer Authentication to your app or experience. Let's walk through how a consumer authenticates and grants access to their Nike account from your app or experience.

### Step 1: Redirect the Consumer To the Nike Login Page

Provide a way in your app/experience for your consumers to navigate to the Nike Login page **https://unite.nike.com/oauth.html**. Registered Nike consumers log into their Nike account directly from this page. Guests register for a new Nike account by clicking the Join link at the bottom of the page.

Pass these URI parameters to the Login page:

|Parameter Name|Required|Description|Example|
|----|---|---|---|
|`client_id`|**Required**|Unique Client ID assigned to your project as an outcome of the [Prerequisites](#prerequisites) phase.|client_id=12345|
|`redirect_uri`|**Required**|Un-encoded URI to your app/experience to redirect the consumer to after successfully completing Nike authentication. **This URI must be added to Nike's redirect URI whitelist as part of the [Prerequisites](#prerequisites) phase**.|redirect_uri=https://partnersite.com|
|`response_type`|**Required**|Always `code`.|response_type=code|
|`state`|Optional|If supplied, this value is returned as a URI parameter when the consumer is redirected to your app/experience after successfully completing Nike authentication.|state=logged_in|
|`locale`|Optional|Consumer's two-letter, lowercase language code and two-letter, uppercase country code, separated by an underscore "_". Default locale is en_US.|locale=fr_FR|

>**TIP**: The `locale` URI parameter is used to display the login and registration pages in the proper language. Ask your TPC for a complete list of supported locales.

Listed below is a sample Login page URI for `client_id` 12345, redirecting to client `redirect_uri` https://partnersite.com/, `state` logged_in for locale fr_FR:

```
https://unite.nike.com/oauth.html?client_id=12345&redirect_uri=https://partnersite.com/&state=logged_in&locale=fr_FR
```

### Step 2: Authenticate the Consumer

Consumers log in or register to their Nike account and accept Nike's terms and conditions.

**Step 2a: Consumer Logs In To an Existing Or Registers a New Nike Account**

On the Nike Login or Registration page, consumers log into their existing Nike account or register a new one. Under the covers, the page uses three-legged OAuth to authenticate the consumer and generate a Nike Consumer Access Token discussed in **Step 3**. Consumers must also acknowledge Nike's Privacy Policy and Terms of Use.

Below are sample Login and Registration pages. This design is subject to change.

![](/images/partner/authentication/partner-oauth-login-reg.png)

When there is a login or registration error, the consumer is redirected to the Login or Registration page with an error message explaining what went wrong. After fixing the problem, consumers can try log in or registration again.

Below are sample Login and Registration pages with error messages indicated in red text. This design is subject to change.

![](/images/partner/authentication/partner-oauth-login-reg-error.png)

**Step 2b: Consumer Allows Your App/Experience To Connect Their Nike Account**

The consumer must approve connecting their Nike account to your app/experience before consumer authentication can be completed.

Consumers can review your Terms and Conditions and Privacy policy from this page. This page is customized for you with information you provided to Nike as part of the [Prerequisites](#prerequisites) phase. They can also check what Apps are connected to their Nike account from this page.

Below is a sample Connect Your Nike Account page. This design is subject to change.

![](/images/partner/authentication/partner-oauth-tandc.png)

### Step 3: Redirect To Your App/Experience

After the consumer successfully authenticates to their Nike account and agrees to connect their account to your app or experience, the consumer is redirected to the `redirect_uri` you passed in the request in **Step 1**, with a `code` URI parameter appended. The `code` is a temporary Consumer Access Token discussed in **Step 4**. If you passed the `state` URI parameter in **Step 1**, it is also appended as a URI parameter for your use.

### Step 4: Get Your Access Token and Refresh Token

In this step, you will exchange the temporary Consumer Access Token returned in **Step 3** for an access token  and refresh token by calling the [Get Access Token & Refresh Token](#get-access-token--refresh-token) endpoint. The access token allows you to make calls to other Nike APIs on behalf of the consumer.

>TIP: The token call must be server-to-server to securely transmit the data.

**Required Header Fields**:

`Content-Type: application/json`

**[Get Access Token & Refresh Token](#get-access-token--refresh-token) POST request URI**

`https://partners.nike.com/oauth/2.0/authorize`

Required POST request body fields:

|Field Name|Description|
|---|---|
|`grant_type`|Type of requested access, always `authorization_code`|
|`code`|Temporary Consumer Access Code from **Step 3**|
|`client_id`|Unique Client ID assigned to your project as an outcome of the [Prerequisites](#prerequisites) phase|
|`client_secret`|Unique Client Secret generated as an outcome of the [Prerequisites](#prerequisites) phase|

Sample token request body:

```
{
    "grant_type": "authorization_code",
    "code": <authorization code>,
    "client_id": 12345,
    "client_secret": <client secret>
}
```

A successful 200 response includes the consumer's Nike `user_id`, a new `access_token`, the same `refresh_token` passed in the request, the number of seconds until the access token expires, and the `token_type`, always "bearer".

Now that you have a valid access token, you can make calls to Nike APIs on the behalf of the authenticated consumer.

>**TIP**: You will need to keep track of when the access token is due to expire to know when to call [Refresh Access Token](#refresh-access-token).

## Refresh an Expiring Access Token

<i class="g72-check"></i>&nbsp;&nbsp;**Exchange an expiring access token for a valid one**

In this step, you will refresh an expiring access token by calling the [Refresh Access Token](#refresh-access-token) endpoint.

>**TIP**: The token call must be server-to-server to securely transmit the data.

The tokens returned in **Step 4** of the [Get Access Token & Refresh Token](#get-access-token--refresh-token) response expire at different rates. Access tokens are valid for 60 minutes and refresh tokens are valid for one year. The number of seconds until the access token expires is returned in the `expires_in` field. Keep track of when the access token is about to expire and call [Refresh Access Token](#refresh-access-token) when it is time to get a new one.

**Required Header Fields**:

`Content-Type: application/json`

**[Get Access Token & Refresh Token](#get-access-token--refresh-token) POST request URI**

`https://partners.nike.com/oauth/2.0/authorize`

**Required POST request body fields**:

|Field Name|Description|
|---|---|
|`grant_type`|Type of requested access, always `refresh_token`|
|`refresh_token`|Refresh token returned from a successful call to [Get Access Token & Refresh Token](#get-access-token--refresh-token)|
|`client_id`|Unique Client ID assigned to your project as an outcome of the [Prerequisites](#prerequisites) phase|

Sample token request body:

```
{
    "grant_type": "refresh_token",
    "code": <authorization code>,
    "client_id": 12345
}
```
A successful 200 response includes the consumer's Nike `user_id`, a new `access_token`, the same `refresh_token` passed in the request, the number of seconds until the access token expires, and the `token_type`, always "bearer".

## API Endpoint Quick Reference

**Token**

- [Get Access Token & Refresh Token](#get-access-token--refresh-token) **POST** https://partners.nike.com/oauth/2.0/authorize
- [Refresh Access Token](#refresh-access-token) **POST** https://partners.nike.com/oauth/2.0/token

## Troubleshooting

### Common Questions

**What if the refresh token expires?**

If your refresh token expires, you no longer have a connection to the consumer's Nike session. You will need the consumer to repeat the [Get an Access Token and Refresh Token](#get-an-access-token-and-refresh-token) steps to reconnect to the session.

## API Reference

### Token

#### Get Access Token & Refresh Token

Trade a temporary consumer access token for an access token and refresh token to be able to make Nike API requests on behalf of a logged in consumer.

**REQUEST**

**Endpoint**

POST https://partners.nike.com/oauth/2.0/authorize

**Request Headers**

`Content-Type:application/json`

**Arguments**

|Field Name|Description|
|---|---|
|`grant_type`|Type of requested access, always `authorization_code`.|
|`code`|Temporary Consumer Access Code returned after the consumer successfully authenticates to their Nike account and authorizes your app or experience to connect to their Nike account.|
|`client_id`|Unique Client ID assigned to your project as an outcome of the [Prerequisites](#prerequisites) phase.|
|`client_secret`|Unique Client Secret generated as an outcome of the [Prerequisites](#prerequisites) phase.|


**Request Body**

```
{
    "grant_type": "authorization_code",
    "code": <authorization code>,
    "client_id": <client id>,
    "client_secret": <client secret>
}
```

**RESPONSE**

**200 OK (Successful Request)**

```
{
    "user_id": <id>,
    "access_token": <access token>,
    "refresh_token": <refresh token>,
    "expires_in": <seconds until token expires>,
    "token_type": "bearer"
}
```

**400 Bad Request (Invalid or missing authorization code)**

```
{
    "error": "invalid_grant",
    "error_description": "Invalid Authorization Code",
    "error_uri": null
}
```

**401 Unauthorized (Invalid or missing client_id)**

```
{
    "fault": {
        "faultstring": "Invalid ApiKey",
        "detail": {
            "errorcode": "oauth.v2.InvalidApiKey"
        }
    }
}
```

**401 Unauthorized (Missing grant_type)**

```
{
  "error_description": "Unsupported Grant Type",
  "error": "unsupported_grant_type"
}
```

#### Refresh Access Token

Get a new access token using a valid refresh token.

Refresh tokens are valid for one year. Access tokens are valid for one hour. To keep your connection to the consumer's session, you will need to periodically refresh the access token using the unexpired refresh token.

**REQUEST**

**Endpoint**

POST https://partners.nike.com/oauth/2.0/token

**Headers**

`Content-Type:application/json`

**Arguments**

|Field Name|Description|
|---|---|
|`grant_type`|Type of requested access, always `refresh_token`|
|`refresh_token`|Refresh token returned from a successful call to [Get Access Token & Refresh Token](#get-access-token--refresh-token)|
|`client_id`|Unique Client ID assigned to your project as an outcome of the [Prerequisites](#prerequisites) phase|

**Request Body**

```
{
    "grant_type": "refresh_token",
    "refresh_token": <refresh token>,
    "client_id": <client id>
}
```

**RESPONSE**

**200 OK (Successful Request)**

```
{
    "user_id": <user id>,
    "access_token": <access token>,
    "refresh_token": <refresh token>,
    "expires_in": <seconds until token expires>,
    "token_type": "bearer"
}
```

**400 Bad Request (Invalid Refresh Token)**

```
Body:
{
    "error": "Refresh Token Invalid",
    "error_description": "The refreshToken is Invalid",
    "error_uri": null
}
```

**401 Unauthorized (Incorrect or invalid client id)**

```
{
    "errors": [
        {
            "code": 99001,
            "message": "Unauthorized Request - Failed Basic Authorization."
        }
    ]
}
```

**401 Unauthorized (Invalid refresh token)**

```
{
    "errors": [
        {
            "code": 99001,
            "message": "Unauthorized Request - Failed Basic Authorization."
        }
    ]
}
```

## Document Change Log

|Summary|Date|Description|
|---|---|---|
|Initial publish|03/02/2020|New document|
|Title rename|04/07/2020|Renamed to Nike Partners - Using Consumer Authentication|

<!--
## Next Steps

You've learned how to add Nike Consumer Authentication to your experience. Here are some next steps.

- [Adding Product Management to Your Experience]() (Not available yet)
-->