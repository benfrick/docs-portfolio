---
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="new-tab" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# NIKE PARTNERS - ADDING AUTHENTICATION TO YOUR EXPERIENCE <i class="g72-swoosh"></i><br>DRAFT

---

##### Last Updated: 01/21/2020

The Authentication process uses Nike's [Token API](#api-documentation) to:
- Allow your consumers to login into their Nike account or register for a new one from your app or experience
- Enable your consumers to permit your app/experience to connect to their Nike account
- Authorize your app/experience to call other Nike services on the behalf of your consumers

## Introduction

In this guide, we will step through how to add Nike Authentication to your app or experience.

![](/images/partner/authentication/partner-oauth-login-reg.png)

### What is Authentication?

When you ask consumers to prove their identify before accessing your app or experience, you ask them to authenticate. This is generally done by requiring consumers to provide their account username and password.

Nike Authentication uses OAuth to perform consumer authentication, which uses access tokens rather than passwords. That means that your app or experience does not have to deal with handling Nike consumer passwords securely.

After the consumer has successfully authenticated and given permission to your app to connect to their Nike account, you will get two tokens, an access token and a refresh token. You will pass the access token in subsequent calls to Nike APIs, which indicates that the consumer has given permission to your app or experience to make API calls on their behalf.

Access tokens expire periodically. When your access token is about to expire, you request a new access token using the refresh token.

Now let's go through some key terms related to Authentication.

## Key Terms

Here are some key terms used in this guide.

|Term|Definition|
|---|---|
|Access Token|OAuth token used in API calls. Valid for one hour.|
|Authentication|Confirming the identity of your consumers.|
|Authorization|Allowing your consumers to perform an action or granting them access to a resource.|
|Client ID|Unique ID assigned to you by Nike. Along with the Client Secret, use it to get an access token and refresh token so you can call other Nike APIs on behalf of the consumer. See the [Prequisite](#prequisite) section for details.|
|Client Secret|Unique value assigned to you by Nike. Along with the Client ID, use it to get an access token and refresh token so you can call other Nike APIs on behalf of the consumer. See the [Prequisite](#prequisite) section for details.|
|Consumer Access Token|Temporary token exchanged for an access token and refresh token.|
|[OAuth](https://oauth.net/2/){:target="new-tab"}|A secure way for consumers to grant apps/experiences access to their information by an exchange of tokens rather than passwords.|
|Refresh Token|Token used to get a new access token when it is about to expire. Valid for one year.|
|[Token API](api-documentation)|API that manages OAuth tokens.|
|Token Experience Configuration|Configuration that handles customization of the consumer Nike Account Connection page. See the [Prequisite](#prequisite) section for details.|

## Prerequisites

You need to complete the steps below before you can add Authentication to your app/experience.

#### 1. Pair up with a Nike Account Manager (AM) and Technical Point of Contact (TPC)

Your Nike Business Lead (NBL) will put you in touch with these two points of contact. These contacts help make your integration go smoothly by communicating with various Nike internal teams for you. Your AM handles privacy and legal details. Your TPC handles the technical details of your project.

#### 2. Gather your project requirements
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
- **Location of your test and production environment:** We'll need to know your hosting platform, physical location, and consumer-facing URL. We will also need your test and production URLs in the case of our APIs returning consumers to your site/app. TODO: How to set up whitelisting consumer URIs?
- **Site traffic requirements:** How many visitors do you expect over what time period? How many simultaneous visitors to you expect at peak times?
- **Links to your Terms of Service and Privacy Policy Pages**: Nike includes these links as part of your partner configuration. These links display on your customized Connect Your Nike Account page where the consumer gives your app/experience permission to connect to their Nike account. Note that your pages must be static and available in every language you support as Nike cannot pass locale parameters.

#### 3. Get legal and privacy approval
Your NBL will make sure that your project contract is ready to go and that all of the data exchanged between you and Nike is handled securely. This process generally takes 1 - 5 business days.

#### 4. Get your credentials

Once the above prerequisites are complete, your TCM will give you what you need to make Nike API calls on behalf of your consumers:
- Client ID
- Client Secret

In addition to generating your credentials, Nike creates a special configuration for you based on your Client ID. This configuration drives UI elements and behaviors on the Nike Account Connection page discussed in detail in the next section. TODO: What are these?

## SLA

TODO: What is the SLA of the token API?

## Get an Access Token and Refresh Token

<i class="g72-check"></i>&nbsp;&nbsp;**Get your access token and refresh token so you can make API calls on behalf of the consumer**

After you have completed all of the action items in the [Prerequisites](#prerequistes) section, you are ready to add Nike Authentication to your app or experience. Let's walk through how a consumer authenticates and grants access to their Nike account from your app or experience.

### Step 1: Redirect the Consumer to the Nike Login/Registration Page

Provide a way for your consumers to login/register to their Nike account from your app/experience. This button or link should navigate to the  Nike login/registration page at **https://unite.nike.com/oauth.html**.

Pass these URI parameters to the Authentication page:

|Parameter Name|Required|Description|Example|
|----|---|---|---|
|**client_id**|**Required**|Unique Client ID assigned to your project as an outcome of the [Prerequisites](#prerequisites) phase.|client_id=12345|
|**redirect_uri**|**Required**|URI to your app/experience to redirect the consumer to after successful login/registration. **This URI must be whitelisted in your Token experience as part of the [Prerequisites](#prerequisites) phase**. TODO: Do URIs need to be encoded?|redirect_uri=https://partnersite.com|
|**response_type**|**Required**|TODO: what is this?|TODO: what is a sample value?|
|**state**|Optional|Client-supplied value returned in the `redirect_uri` URI parameter after the consumer has successfully logged in to an existing or registered a new Nike account.|state=logged_in|
|**locale**|Optional|Consumer's two-letter, lowercase language code and two-letter, uppercase country code, separated by an underscore "_". Default locale is en_US. TODO: is there a supported locale list?|locale=fr_FR|

Listed below is a sample Authentication page URI for `client_id` 12345, redirecting to client `redirect_uri` https://partnersite.com/, `state` logged_in for locale fr_FR:

```
https://unite.nike.com/oauth.html?client_id=12345&redirect_uri=https://partnersite.com/&state=logged_in&locale=fr_FR
```

### Step 2: Authenticate the Consumer

**Step 2a: Consumer logs in to an existing or registers a new Nike account**

On the Login or Registration page, the consumer logs into their existing Nike account or registers a new one. Under the covers, the page uses three-legged OAuth to authenticate the consumer and generate a Nike Consumer Access Token discussed in **Step 3**.

Below are sample Login and Registration pages. This design is subject to change.

![](/images/partner/authentication/partner-oauth-login-reg.png)

When there is a login or registration error, the consumer is redirected to the Login or Registration page with an error message explaining the problem. After the consumer fixes the problem, they can retry log in or registration.

Below are sample Login and Registration pages when a consumer-caused error occurs. This design is subject to change.

![](/images/partner/authentication/partner-oauth-login-reg-error.png)

**Step 2b: Consumer accepts connecting Nike account to your app/experience and reviews terms and conditions**

The consumer must approve connecting their Nike account to your app/experience and review your term's and conditions before consumer authentication can be completed.

Below is a sample Connect Your Nike Account page customized for you with the configuration information you provided to Nike in the [Prerequisites](#prerequisites) phase, such as Terms of Service and Privacy Policy links. This design is subject to change.

![](/images/partner/authentication/partner-oauth-tandc.png)

### Step 3: Redirect to Your App/Experience

After the consumer has successfully authenticated to their Nike account and agreed to connect their account to your app or experience, the consumer is redirected to the URI passed in `redirect_uri` URI parameter with `code` and `state` URI parameters appended. The `code` is a temporary Consumer Access Token discussed in **Step 4**. If you passed the `state` URI parameter into the authentication page, it is also appended as a URI parameter for your use.

### Step 4: Get Your Access Token and Refresh Token

In this step, you will get an access token and refresh token by calling the [Get Access Token & Refresh Token](#get-access-token--refresh-token) endpoint. The access token allows you to make calls to other Nike APIs on behalf of the consumer. You will pass the temporary Consumer Access Token returned in the URI parameter in **Step 3**.

>TIP: The token call must be server-to-server to securely transmit the data

**Required Header Fields**:

`Content-Type: application/json`

**[Get Access Token & Refresh Token](#get-access-token--refresh-token) POST request URI**

`https://api.nike.com/oauth/2.0/token`

Required POST request body fields:

|Field Name|Description|
|---|---|
|`grant_type`|Type of requested access, always `authorization_code`|
|`code`|Temporary Consumer Access Code from **Step 3**|
|`client_id`|Unique Client ID assigned to your project as an outcome of the [Prerequisites](#prerequisites) phase|
|`client_secret`|Unique Client Secret generated as an outcome of the [Prerequisites](#prerequisites) phase|

A sample token request body is listed below.

```
{
    "grant_type": "authorization_code",
    "code": <authorization code>,
    "client_id": 12345,
    "client_secret": <client secret>
}
```

A successful 200 response includes the consumer's `user_id` from their profile, a new `access_token`, the same `refresh_token` passed in the request, the number of seconds until the access token expires and the `token_type`, always "bearer".

Now that you have a valid access token, you can make calls to Nike APIs on the behalf of the authenticated consumer.

>TIP: You will need to keep track of when the access token is due to expire to know when to call [Refresh Access Token](#refresh-access-token).

## Refresh an Expiring Access Token

<i class="g72-check"></i>&nbsp;&nbsp;**Exchange an expiring access token for a valid one**

In this step, you will refresh an expiring access token by calling the [Refresh Access Token](#refresh-access-token) endpoint.

>TIP: The token call must be server-to-server to securely transmit the data

The two tokens returned in **Step 4** of the [Get Access Token & Refresh Token](#get-access-token--refresh-token) response expire at different rates. Access Tokens are valid for 60 minutes and Refresh Tokens are valid for one year. You will need to keep track of when the access token is about to expire.  When it is about to expire, make a call to [Refresh Access Token](#refresh-access-token) endpoint to get a new one.

TODO: explain how to know it is expiring

**Required Header Fields**:

`Content-Type: application/json`

**[Get Access Token & Refresh Token](#get-access-token--refresh-token) POST request URI**

`https://api.nike.com/oauth/2.0/token`

**Required POST request body fields**:

|Field Name|Description|
|---|---|
|`grant_type`|Type of requested access, always `refresh_token`|
|`refresh_token`|Refresh token returned from a successful call to either [Get Access Token & Refresh Token](#get-access-token--refresh-token) in **Step 4** or [Refresh Access Token](#refresh-access-token)|
|`client_id`|Unique Client ID assigned to your project as an outcome of the [Prerequisites](#prerequisites) phase|

A sample token request body is listed below.

```
{
    "grant_type": "refresh_token",
    "code": <authorization code>,
    "client_id": 12345
}
```
A successful 200 response includes the consumer's `user_id` from their profile, a new `access_token`, the same `refresh_token` passed in the request, the number of seconds until the access token expires and the `token_type`, always "bearer".

## API Endpoint Quick Reference

Token

- [Get Access Token & Refresh Token](#get-access-token--refresh-token)
- [Refresh Access Token](#refresh-access-token)

## Troubleshooting

### Common Questions

**What if the refresh token expires?**

If your refresh token expires, you no longer have a connection to the consumer's Nike session. You will need the consumer to repeat the [Authorization](#authorization) prcess to reconnect to the session.


## API Documentation

### Token

#### Get Access Token & Refresh Token

Trade a temporary consumer access token for an access token and refresh token to be able to make Nike API requests on behalf of a logged in consumer.

**REQUEST**

**Endpoint**

POST https://api.nike.com/oauth/2.0/token

**Request Headers**

`Content-Type:application/json`

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

**400 Bad Request (Invalid or missing authorization code)**ß

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

POST https://api.nike.com/oauth/2.0/token

**Headers**

`Content-Type:application/json`

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

Todo: isn't there a 400 response?

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

|Summary |Date |
|---|---|---|
|Initial publish|01/21/2020|

## Next Steps

You've learned how to add Nike Authentication to your experience. Here are some next steps.

- [Adding Product Management to Your Experience]() (Not available yet)
