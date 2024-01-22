---
id: use-wishlists
tags: pdf
category: b-use-case
position: 5
title: Wishlists
url: /doc/commerce/checkout/use-wishlists.html
toc:
  - h2: Introduction
    url: /doc/commerce/checkout/use-wishlists.html#introduction
  - h2: Wishlists
    url: /doc/commerce/checkout/use-wishlists.html#wishlists
  - h2: API Quick Reference
    url: /doc/commerce/checkout/use-wishlists.html#api-quick-reference
  - h2: Troubleshooting
    url: /doc/commerce/checkout/use-wishlists.html#troubleshooting
  - h2: Contacting the Team
    url: /doc/commerce/checkout/use-wishlists.html#contacting-the-team
  - h2: Document Change Log
    url: /doc/commerce/checkout/use-wishlists.html#document-change-log
  - h2: Next Steps
    url: /doc/commerce/checkout/use-wishlists.html#next-steps
---
##### Last Updated: 04/28/2020

Help Nike members save their favorites for later purchase by adding [Wishlists](#wishlists) to your experience.

>**TIPS**:
>- Before using this guide, read [Using Nike APIs](/doc/getting-started/using-nike-apis.html) and [Cart & Checkout Overview](/doc/commerce/checkout/overview-checkout.html).
>- Use this guide as a supplement to the API Reference for detailed use cases. See [API Quick Reference](#api-quick-reference) for links to all the API Reference docs discussed here.

## Introduction

Sometimes consumers want to set aside items or services to buy at a later date. They can do this by creating a wishlist.

#### How is a Wishlist different from a Cart?

Wishlists provide consumers a more flexible way of organizing their future purchases than the cart can. Here are some considerations:

- Consumers can have an unlimited number of wishlists but only one cart.
- Consumers can name their wishlists but not their cart.
- All Nike consumers can use cart but only Nike members and employees can use wishlists.

## Wishlists

<i class="g72-check"></i>&nbsp;&nbsp;**Manage a Nike member's or an employee's wishlist of products and services**

### Step 1: Create a Wishlist

Execute a request to the [Create or Update a List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-create-or-update-a-list-put) endpoint to create an empty wishlist. [Step 2](#step-2-modify-a-wishlist) explains how to add items to a wishlist.

- Wishlist `name` must be unique for a user/country combination.
- Consumers can create wishlists for multiple countries but they can have only one default wishlist per country.
- A wishlist can only be set as the country default when it is created. This flag cannot be changed after the wishlist is created.
- When a consumer's wishlist is created with the `isDefault` flag set to true, this flag is set to false on the rest of the wishlists for the same country.
- If the `id` path parameter does not match the `id` of the wishlist, a new wishlist is created.

>TIP: You need to generate the unique **wishlist** `id` in UUID format and pass it as a path parameter.

Listed below is a sample [Create or Update a List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-create-or-update-a-list-put) PUT request URI that creates a new wishlist with `id` 93a333a2-907b-46f1-b9ac-469489909057. This endpoint is not JWT-restricted.

```
https://api.nike.com/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057
```

### Step 2: Modify a Wishlist

Now that you've created a wishlist for the consumer, allow them to add or remove items, delete the list, or rename it.

#### Add Item to List

To add a product or service to an existing wishlist, execute a request to the [Add Item to List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-add-item-to-list-put) endpoint.

- Current product pricing is provided in the response.
- If you add a product that is already on the list, the product will be replaced.
- Only the product being added is included in the response, not all products in the list.
- The **wishlist item** `country` will override the **wishlist** `country` when looking up prices.
- Because this endpoint can replace items, the response includes `isCurrentPriceChanged` set to true when an item's `currentPrice` has changed since creation.
- The response contains an `isAvailable` flag indicating whether or not the product is purchasable. This value is determined by the [Availability service](https://console.platforms.nike.com/developer/docs/projects/Availability?tab=api).

>TIP: You need to generate the unique **wishlist item** `id` in UUID format and pass it in the path parameter.

Listed below is a sample [Add Item to List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-add-item-to-list-put) PUT request URI that creates a new wishlist item with `id` 93a333a2-907b-46f1-b9ac-469489909123. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/list_items/v1/93a333a2-907b-46f1-b9ac-469489909123
```

#### Add Multiple Items to List

To add more than one item at a time to one or more wishlists, execute a request to the [Add Item to List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-add-item-to-list-patch) endpoint.

- You can add new items to the wishlist but not replace them.
- Current product pricing is provided in the response.
- The **wishlist item** `country` will override the **wishlist** `country` when looking up prices.
- You can add items to different wishlists in the same call by supplying different `wishlistId`s in each value object in the PATCH request body.
- Unless you supply filter query parameters to restrict the result set, all newly-added items are returned in the response.
- The response contains an `isAvailable` flag indicating whether or not the product is purchasable. This value is determined by the [Availability service](https://console.platforms.nike.com/developer/docs/projects/Availability?tab=api).

>TIP: You need to generate each unique wishlist item `id` in UUID format and pass them in the PATCH request body.

Listed below is a sample [Add Item to List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-add-item-to-list-patch) PATCH request limiting the response to include only the added items from wishlists with 93a333a2-907b-46f1-b9ac-469489909057 and 93a333a2-907b-46f1-b9ac-469489909000 IDs. This endpoint is not JWT-restricted.
```
http://api.nike.com/buy/list_items/v1?filter=wishlistId(93a333a2-907b-46f1-b9ac-469489909057,93a333a2-907b-46f1-b9ac-469489909000)
```

#### Remove Item from List

To delete a single item from a list, execute a request to the [Remove Item from List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-remove-item-from-list-delete) endpoint passing the **wishlist item** `id` as a path parameter.

>TIP: You do not need to send the `wishlistId` in the DELETE request. You only need to send the wishlist item `id` you want to delete in the path parameter.

Listed below is a sample [Remove Item from List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-remove-item-from-list-delete) DELETE request URI to delete wishlist item with `id` 93a333a2-907b-46f1-b9ac-469489909123. This endpoint is not JWT-restricted.

```
https://api.nike.com/buy/list_items/v1/93a333a2-907b-46f1-b9ac-469489909123
```
#### Remove Multiple Items from List

To delete several items from a wishlist, execute a request to the [Remove Items from List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-remove-items-from-list-delete) endpoint passing the list of **wishlist item** IDs as a filter query parameter.

>TIP: You do not need to send the `wishlistId` in the DELETE request. You only need to send the **wishlist item** `id` you want to delete in the filter query parameter.

Listed below is a sample [Remove Items from List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-remove-items-from-list-delete) DELETE request to delete wishlist items with `id` 93a333a2-907b-46f1-b9ac-469489909057 and 93a333a2-907b-46f1-b9ac-469489909000. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/list_items/v1?filter=id(93a333a2-907b-46f1-b9ac-469489909057,93a333a2-907b-46f1-b9ac-469489909000)
```

#### Delete a List

To delete a wishlist, execute a request to the [Delete a List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-delete-a-list-delete) endpoint passing the **wishlist** `id` as a path parameter. Note that **all of the items on the list will be removed**.

Listed below is a sample [Delete a List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-delete-a-list-delete) DELETE request URI that deletes wishlist 93a333a2-907b-46f1-b9ac-469489909057 and all of its items. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057
```

#### Change the Name of the Wishlist

Make a request to the [Create or Update a List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#wishlist-endpoints-list-operations-put) endpoint to update the name of an existing wishlist.

- Pass the same `country` and `brand` values used when the wishlist was created while also passing an updated wishlist `name`.
- `name` must be unique for a user/country combination.
- If the `id` path parameter does not match the `id` of the wishlist, a new wishlist will be created.

>TIP: Pass the same wishlist `id` as the one used to create it in the path parameter.

Sample [Create or Update a List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#wishlist-endpoints-list-operations-put) PUT request URI that updates the name of wishlist with `id` 93a333a2-907b-46f1-b9ac-469489909057. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057
```

### Step 3: Get a Wishlist

Allow the consumer to view the **header info** of all their wishlists, or just one.

#### Retrieve Lists for Authenticated User

To retrieve **header info** for all wishlists for an authenticated consumer, execute a request to the [Retrieve Lists for Authenticated User](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-retrieve-lists-for-authenticated-user-get) endpoint.

- The list items are **not** included in the response. To get the list items, execute a request to the [Retrieve Items by List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-items-by-list-get) endpoint with the appropriate list identifier.
- You can use filter and field query parameters to restrict the result set.

Listed below is a sample [Retrieve Lists for Authenticated User](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-retrieve-lists-for-authenticated-user-get) GET request URI that retrieves all of a consumer's wishlists for the US. This endpoint is not JWT-restricted.

```
https://api.nike.com/buy/lists/v1?filter=country(US)
```

#### Retrieve a List by ID

To retrieve **header info** for a single wishlist for an authenticated consumer, execute a request to the [Retrieve a List by ID](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-retrieve-a-list-by-id-get) endpoint passing the wishlist `id` as a path parameter.

Listed below is a sample [Retrieve a List by ID](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-retrieve-a-list-by-id-get) GET request URI for wishlist `id` 93a333a2-907b-46f1-b9ac-469489909057. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057
```

### Step 4: Get a Wishlist Item

Retrieve one or more wishlist items from one or more of a consumer's wishlists.

#### Retrieve Items in a List by ID

To retrieve the productIds and skuIds (if available) in a single wishlist, execute a request to the [Retrieve Items in a List by ID](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-retrieve-the-items-in-a-list-by-id-get) endpoint passing the wishlist `id` as a path parameter.

Listed below is a sample [Retrieve Items in a List by ID](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-retrieve-the-items-in-a-list-by-id-get) GET request URI. This endpoint is not JWT-restricted.

```
https://api.nike.com/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057/items
```

#### Retrieve Items by List

To retrieve all or a filtered set of items from all of a consumer's wishlists, execute a request to the [Retrieve Items by List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-items-by-list-get) endpoint. The response contains detailed information for each wishlist item.

You can use filter, anchor, count, fields, and sort query parameters to restrict the result set.

Listed below is a sample [Retrieve Items by List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-items-by-list-get) GET request URI that returns all items in the wishlist with `id` 3ebf8798-2c86-4e29-a67b-7435ebad62af. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/list_items/v1?filter=wishlistId(3ebf8798-2c86-4e29-a67b-7435ebad62af)
```

#### Retrieve Item by ID

To retrieve a single list item, execute a request to the [Retrieve Item by ID](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-item-by-id-get) endpoint, passing the client generated wishlist item `id` as a URL parameter. The response contains detailed information for the wishlist item.

You can use the fields query parameter to restrict the result set.

Listed below is a sample [Retrieve Item by ID](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-item-by-id-get) GET request URI. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/list_items/v1/93a333a2-907b-46f1-b9ac-469489909057
```

### Step 5: Purchase from a Wishlist

Follow the steps below to allow consumers to purchase items from their wishlist:

1. Call [Retrieve Lists for Authenticated User](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-retrieve-lists-for-authenticated-user-get) to get the wishlist ID or call [Retrieve a List by ID](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-retrieve-a-list-by-id-get) if you already know the wishlist ID.

2. Call [Retrieve Items by List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-items-by-list-get) to get the wishitem ID or call [Retrieve Item by ID](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-item-by-id-get) if you already know the wishlist item ID.

3. Using the wishlist data from **Step 1** and the wishlist item data from **Step 2**, call [Create or Update a Cart](https://console.platforms.nike.com/developer/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-cart-id-put) to add the wishlist item to Cart.

4. Using the wishlist item ID from **Step 2**, call [Remove Item from List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-remove-item-from-list-delete).

5. (Optional) If there are no items left in the wishlist, call [Delete a List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-delete-a-list-delete).

## API Quick Reference

**Wishlist endpoints**

- [Create or Update a List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-create-or-update-a-list-put)
- [Delete a List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-delete-a-list-delete)
- [Retrieve a List by ID](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-retrieve-a-list-by-id-get)
- [Retrieve Lists for Authenticated User](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-retrieve-lists-for-authenticated-user-get)

**Wishlist item endpoints**

- [Add Item to List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-add-item-to-list-put)
- [Add Item to List (PATCH)](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-add-item-to-list-patch)
- [Retrieve Items in a List by ID](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-operations-retrieve-the-items-in-a-list-by-id-get)
- [Retrieve Items by List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-items-by-list-get)
- [Retrieve Item by ID](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-item-by-id-get)
- [Remove Item from List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-remove-item-from-list-delete)
- [Remove Items from List](https://console.platforms.nike.com/developer/docs/projects/Wishlist?tab=api#list-item-operations-remove-items-from-list-delete)


## Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### Use Troubleshooting Tools

- Use the general troubleshooting tips in the [Using Nike APIs](/doc/getting-started/using-nike-apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) to check for issues with your request.

- Contact the Buy team on the [#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV) Slack channel for assistance.

## Contacting the Team

Need to contact the team?

|Slack|[#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV)|
|Confluence Space|[CiC Order Capture](https://confluence.nike.com/pages/viewpage.action?pageId=163654070)|
|Team Contacts|[Dan Robertson](mailto:dan.robertson@nike.com), [Saket Shrivastava](mailto:saket.shrivastava@nike.com)|

## Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|06/20/2019|Initial Draft|
|Converted to stand-alone guide|03/20/2019|Content moved from Cart & Checkout use-case guide|
|Revised Next Steps section links|04/28/2020|Updated links|

## Next Steps

You've learned how to add wishlists to your experience. Here are some related topics.

- [Cart & Cart Review](/doc/commerce/checkout/use-carts.html)
- [Checkout](/doc/commerce/checkout/use-checkout.html)
- [Fulfillment Offerings](/doc/commerce/checkout/use-fulfillment-offerings.html)
- [Payment](/doc/commerce/payment/use-payment.html)
- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)
- [Supported Countries](/doc/commerce/reference/global.html)