---
id: use-wishlist
tags: pdf
category: b-use-case
position: 6
title: Wish Lists
url: /doc/commerce/checkout/use-wishlist.html
toc:
  - h2: Introduction
    url: /doc/commerce/checkout/use-wishlist.html#introduction
  - h2: Wish Lists
    url: /doc/commerce/checkout/use-wishlist.html#wish-lists
  - h2: API Quick Reference
    url: /doc/commerce/checkout/use-wishlist.html#api-quick-reference
  - h2: Troubleshooting
    url: /doc/commerce/checkout/use-wishlist.html#troubleshooting
  - h2: Contacting the Team
    url: /doc/commerce/checkout/use-wishlist.html#contacting-the-team
  - h2: Glossary
    url: /doc/commerce/checkout/use-wishlist.html#glossary
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn-secondary-grey guide-button"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# ADDING WISH LISTS TO YOUR EXPERIENCE

---

##### Last Updated: 06/20/2019

Help your consumers take their shopping skills to the next level by adding [Wish Lists](#wish-lists) to your experience.

>**TIPS**:
>- Before using this guide, read [Using NDe APIs](/doc/getting-started/using-nike-apis.html) and [Cart & Checkout Overview](/doc/commerce/checkout/overview-checkout.html).
>- Use this guide as a supplement to the API Reference for detailed use cases. See [API Quick Reference](#api-quick-reference) for links to all the API Reference docs discussed here.
>- The steps involving **Payment** are covered in [Adding Payment to Your Experience](/doc/commerce/payment/use-payment.html).

## Introduction

Sometimes consumers want to set aside items or services to buy at a later date. They can do this by creating a Wish List.

**How is a Wish List different from a Cart?**

Wish Lists offer a more flexible way of shopping than using the Cart alone. Here are some considerations:

- The consumer can have an unlimited number of Wish Lists, while they can have only one Cart.
- A Wish List can be given a name by the consumer, while a Cart cannot be named.
- Wish Lists cannot be used by guests (i.e. anonymous consumers), while a Cart can be used by guests.

**Summary: Wish Lists help your consumer organize their potential purchases better than Carts, but Wish Lists cannot be used by guests.**

## Wish Lists

<i class="g72-check"></i>&nbsp;&nbsp;**Manage a consumer's Wish Lists (member/employee only) of products and services**

Manage a Nike member/employee's Wish Lists using the [Wish Lists API](https://developer.niketech.com/docs/projects/Wishlist?tab=api){:target="new-tab"}.

Features:

- Store unlimited Wish Lists per consumer that consumers can name.
- Get product pricing and availability for products added to the list.
- Members and employees are supported only. **Guest consumers (non-members) cannot save Wish Lists**.

### Step 1: Create a Wish List

Execute a request to the [Create or Update a List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-create-or-update-a-list-put){:target="new-tab"} endpoint to create an empty Wish List. [Step 2](#step-2-modify-a-wish-list) explains how to add items to a Wish List.

- `name` must be unique for a user/country combination.
- You can only set a Wish List as the default for a country when creating it. You cannot update it as the default after the list has been created.
- When you create a new Wish List with `isDefault` set to true, the `isDefault` field will be set to false for the rest of a consumer's Wish Lists for the same country.
- If the `id` path parameter does not match the `id` of the Wish List, a new Wish List will be created.

>TIP: You need to generate the unique Wish List `id` in UUID format and pass it as a path parameter.

Listed below is a sample [Create or Update a List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-create-or-update-a-list-put){:target="new-tab"} PUT request URI that creates a new Wish List with `id` 93a333a2-907b-46f1-b9ac-469489909057. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057
```

### Step 2: Modify a Wish List

Now that you've created a Wish List for the consumer, allow them to add or remove items, delete the list, or rename it.

#### Add Item to List

To add a product or service to an existing Wish List, execute a request to the [Add Item to List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-add-item-to-list-put){:target="new-tab"} endpoint.

- Current product pricing is provided in the response.
- If you add a product that is already on the list, the product will be replaced.
- Only the product being added is included in the response, not all products in the list.
- The Wish List item `country` will override the Wish List `country` when looking up prices.
- Because this endpoint can replace items, the response includes `isCurrentPriceChanged` set to true when an item's `currentPrice` has changed since creation.
- The response contains an `isAvailable` flag indicating whether or not the product is purchasable. This value is determined by the [Availability service](https://developer.niketech.com/docs/projects/Availability?tab=api){:target="new-tab"}.

>TIP: You need to generate the unique Wish List item `id` in UUID format and pass it in the path parameter.

Listed below is a sample [Add Item to List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-add-item-to-list-put){:target="new-tab"} PUT request URI that creates a new Wish List item with `id` 93a333a2-907b-46f1-b9ac-469489909123. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/list_items/v1/93a333a2-907b-46f1-b9ac-469489909123
```

#### Add Multiple Items to List

To add more than one item at a time to one or more Wish Lists, execute a request to the [Add Item to List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-add-item-to-list-patch){:target="new-tab"} endpoint.

- Only adding new items is supported. Replacing existing items is not supported.
- Current product pricing is provided in the response.
- The Wish List item `country` will override the Wish List `country` when looking up prices.
- You can add items to different Wish Lists in the same call by supplying different `wishlistId`s in each value object in the PATCH request body.
- Unless you supply filter query parameters to restrict the result set, all newly-added items are returned in the response.
- The response contains an `isAvailable` flag indicating whether or not the product is purchasable. This value is determined by the [Availability service](https://developer.niketech.com/docs/projects/Availability?tab=api){:target="new-tab"}.

>TIP: You need to generate each unique Wish List item `id` in UUID format and pass them in the PATCH request body.

Listed below is a sample [Add Item to List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-add-item-to-list-patch){:target="new-tab"} PATCH request limiting the response to include only the added items from Wish Lists with 93a333a2-907b-46f1-b9ac-469489909057 and 93a333a2-907b-46f1-b9ac-469489909000 ids. This endpoint is not JWT-restricted.
```
http://api.nike.com/buy/list_items/v1?filter=wishlistId(93a333a2-907b-46f1-b9ac-469489909057,93a333a2-907b-46f1-b9ac-469489909000)
```

#### Remove Item from List

To delete a single item from a list, execute a request to the [Remove Item from List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-remove-item-from-list-delete){:target="new-tab"} endpoint passing the Wish List item `id` as a path parameter.

>TIP: You do not need to send the `wishlistId` in the DELETE request. You only need to send the Wish List item `id` you want to delete in the path parameter.

Listed below is a sample [Remove Item from List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-remove-item-from-list-delete){:target="new-tab"} DELETE request URI to delete Wish List item with `id` 93a333a2-907b-46f1-b9ac-469489909123. This endpoint is not JWT-restricted.

```
https://api.nike.com/buy/list_items/v1/93a333a2-907b-46f1-b9ac-469489909123
```
#### Remove Multiple Items from List

To delete several items from a Wish List, execute a request to the [Remove Items from List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-remove-items-from-list-delete){:target="new-tab"} endpoint passing the list of Wish List item ids as a filter query parameter.

>TIP: You do not need to send the `wishlistId` in the DELETE request. You only need to send the Wish List item `id` you want to delete in the filter query parameter.

Listed below is a sample [Remove Items from List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-remove-items-from-list-delete){:target="new-tab"} DELETE request to delete Wish List items with `id` 93a333a2-907b-46f1-b9ac-469489909057 and 93a333a2-907b-46f1-b9ac-469489909000. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/list_items/v1?filter=id(93a333a2-907b-46f1-b9ac-469489909057,93a333a2-907b-46f1-b9ac-469489909000)
```

#### Delete a List

To delete a Wish List, execute a request to the [Delete a List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-delete-a-list-delete){:target="new-tab"} endpoint passing the Wish List `id` a a path parameter. Note that **all of the items on the list will be removed**.

Listed below is a sample [Delete a List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-delete-a-list-delete){:target="new-tab"} DELETE request URI that deletes Wish List 93a333a2-907b-46f1-b9ac-469489909057 and all of its items. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057
```

#### Change the Name of the Wish List

Make a request to the [Create or Update a List](https://developer.niketech.com/docs/projects/Buy%20Lists?tab=api#list-operations-create-or-update-a-list-put){:target="new-tab"} endpoint to update the name of an existing Wish List.

- Pass the same `country` and `brand` values used when the Wish List was created while also passing an updated Wish List `name`.
- `name` must be unique for a user/country combination.
- Updating lists is limited to changing the list name only.
- If the `id` path parameter does not match the `id` of the Wish List, a new Wish List will be created.

>TIP: Use the same Wish List `id` as the one used to create it and pass it in as a path parameter.

Sample [Create or Update a List](https://developer.niketech.com/docs/projects/Buy%20Lists?tab=api#list-operations-create-or-update-a-list-put){:target="new-tab"} PUT request URI that updates the name of Wish List with `id` 93a333a2-907b-46f1-b9ac-469489909057. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057
```

### Step 3: Get a Wish List

Allow the consumer to view the **header info** of all their Wish Lists, or just one.

#### Retrieve Lists for Authenticated User

To retrieve **header info** for all lists for an authenticated consumer, execute a request to the [Retrieve Lists for Authenticated User](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-retrieve-lists-for-authenticated-user-get){:target="new-tab"} endpoint.

- The list items are **not** included in the response. To get the list items, execute a request to the [Retrieve Items by List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-items-by-list-get){:target="new-tab"} endpoint with the appropriate list identifier.
- You can use filter and field query parameters to restrict the result set.

Listed below is a sample [Retrieve Lists for Authenticated User](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-retrieve-lists-for-authenticated-user-get){:target="new-tab"} GET request URI that retrieves all of a consumer's Wish Lists for the US. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/lists/v1?filter=country(US)
```

#### Retrieve a List by ID

To retrieve **header info** for a single list, execute a request to the [Retrieve a List by ID](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-retrieve-a-list-by-id-get){:target="new-tab"} endpoint passing the Wish List `id` as a path parameter.

>**TIP:** The list items are **not** included in the response. To get the list items, execute a request to the *Retrieve Items by List* endpoint with the appropriate list identifier.

Listed below is a sample [Retrieve a List by ID](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-retrieve-a-list-by-id-get){:target="new-tab"} GET request URI for Wish List `id` 93a333a2-907b-46f1-b9ac-469489909057. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/lists/v1/93a333a2-907b-46f1-b9ac-469489909057
```

#### Retrieve Items by List

To retrieve all items in a consumer's Wish List, execute a request to the [Retrieve Items by List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-items-by-list-get){:target="new-tab"} endpoint.

You can use filter, anchor, count, fields, and sort query parameters to restrict the result set.

Listed below is a sample [Retrieve Items by List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-items-by-list-get){:target="new-tab"} GET request URI that returns all items in the Wish List with `id` 3ebf8798-2c86-4e29-a67b-7435ebad62af. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/list_items/v1?filter=wishlistId(3ebf8798-2c86-4e29-a67b-7435ebad62af)
```

#### Retrieve Item by ID

To retrieve a single list item, execute a request to the [Retrieve Item by ID](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-item-by-id-get){:target="new-tab"} endpoint, passing the client generated Wish List item `id` as a URL parameter.

You can use the fields query parameter to restrict the result set.

Listed below is a sample [Retrieve Item by ID](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-item-by-id-get){:target="new-tab"} GET request URI. This endpoint is not JWT-restricted.
```
https://api.nike.com/buy/list_items/v1/93a333a2-907b-46f1-b9ac-469489909057
```

### Step 4: Purchase from a Wish List

To allow consumers to purchase items on their Wish List, you'll need to:

1. Call [Retrieve Lists for Authenticated User](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-retrieve-lists-for-authenticated-user-get){:target="new-tab"} to get the Wish List id or call [Retrieve a List by id](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-retrieve-a-list-by-id-get){:target="new-tab"} if you already know the Wish List id.

2. Call [Retrieve Items by List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-items-by-list-get){:target="new-tab"} to get the item id or call [retrieve item by ID](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-item-by-id-get){:target="new-tab"} if you already know the Wish List item id.

3. Using the Wish List data from Step 1 and Wish List item data from Step 2, call [Create or Update a Cart](https://developer.niketech.com/docs/projects/Carts%20V2?tab=api#cart-operations-create-or-update-a-cart-by-cart-id-put){:target="new-tab"} to add the Wish List item to Cart.

4. Using the Wish List item `id` from Step 2, call [Remove Item from List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-remove-item-from-list-delete){:target="new-tab"}.

5. (Optional) If there are no items left in the Wish List, call [Delete a List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-delete-a-list-delete){:target="new-tab"}.

## API Quick Reference

**Wish Lists**
- [Create or Update a List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-create-or-update-a-list-put){:target="new-tab"}
- [Delete a List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-delete-a-list-delete){:target="new-tab"}
- [Retrieve a List by ID](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-retrieve-a-list-by-id-get){:target="new-tab"}
- [Retrieve Lists for Authenticated User](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-operations-retrieve-lists-for-authenticated-user-get){:target="new-tab"}
- [Add Item to List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-add-item-to-list-put){:target="new-tab"}
- [Add Item to List (PATCH)](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-add-item-to-list-patch){:target="new-tab"}
- [Remove Item from List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-remove-item-from-list-delete){:target="new-tab"}
- [Remove Items from List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-remove-items-from-list-delete){:target="new-tab"}
- [Retrieve Items by List](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-items-by-list-get){:target="new-tab"}
- [Retrieve Item by ID](https://developer.niketech.com/docs/projects/Wishlist?tab=api#list-item-operations-retrieve-item-by-id-get){:target="new-tab"}

## Troubleshooting

Listed below are ways to troubleshoot unexpected responses using this API.

### Use Troubleshooting Tools

- Use the general troubleshooting tips in the [Using NDe APIs](/doc/getting-started/using-nike-apis.html#troubleshooting) guide.

- Use a Splunk query (requires access) to check for issues with your request.

- Contact the Buy team on the [#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV){:target="new-tab"} Slack channel for assistance.

## Contacting the Team

Need to contact the Cart & Checkout team?

|Slack|[#cic-order-integration](https://nikedigital.slack.com/messages/C38BE20SV){:target="new-tab"}|
|Confluence Space|[CiC Order Capture](https://confluence.nike.com/pages/viewpage.action?pageId=163654070){:target="new-tab"}|
|Team Contacts|[Sree Krishna](mailto:sree.krishna@nike.com) (Carts and Wish Lists only)|

## Glossary

See the [Glossary](/doc/commerce/reference/glossary.html)

## Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|06/20/2019|Initial Draft|

## Next Steps

You've learned how to add Wish Lists to your experience. Here are some next steps.

[NDe Docs Home](/index.html)

[Get Started](/doc/getting-started/get-started.html)

[Supported Countries & Currencies](/doc/commerce/checkout/checkout-country-currency.html)