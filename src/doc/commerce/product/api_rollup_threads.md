---
---

# PRODUCT FEED ROLLUP THREADS V2 API <i class="g72-swoosh"></i><br>DEVELOPER'S GUIDE

##### Last Updated: 7/19/2018<br>Submit Feedback: Dev Portal Slack channel <a href="slack://channel?team=T0G3T5X2B&amp;id=C9Q1MNJ1J">#devportal</a>

---

If you've read [Using NDe APIs](/doc/getting-started/using_nike_apis.html) and the [Product Feeds Developer's Guide](/doc/commerce/product/api_product_feeds.html), this guide provides the details necessary to integrate with the Product Feed Rollup Threads v2 API.

## **In this guide:**

[API at a Glance](#api-at-a-glance)

[Terms of Service](#terms-of-service)

<span class="toc-pad">[Authorization](#authorization)

<span class="toc-pad">[Prerequisites](#prerequisites)

[Use Cases](#use-cases)

[API Endpoint Quick Reference](#api-endpoint-quick-reference)

[What is a Rollup Thread?](#what-is-a-rollup-thread)

[Making Your First API Request](#making-your-first-api-request)

[Using Product Feed Rollup Threads v2](#using-product-feed-rollup-threads-v2)

[Upgrading to the Latest Version](#upgrading-to-the-latest-version)

[Best Practices](#best-practices)

[Troubleshooting](#troubleshooting)

[Glossary](#glossary)

[Release Notes](#release-notes)

[Document Change Log](#document-change-log)

[Related Links](#related-links)

## <a name="api-at-a-glance"></a>API at a Glance

|Topic|Details|
|---|---|
|Use these APIs to|Display a product grid wall in a digital experience|
|Who calls this API?|Bootroom, Nike.com, Nike Running Club app (future)|
|Versions|v2|
|Supported Locales|See <a href="https://bitbucket.nike.com/projects/MOON/repos/language-tunnel-json/browse/localization.json" target="_blank">Language/Locale Mapping</a>|
|SLA|<li>Response time: 500ms <li>Requests per second: 5 max (via edge router constraint)|
|Domain|Commerce|
|Prerequisites|API Registration|
|Contact Info|Slack: <a href="https://nikedigital.slack.com/messages/CAPF62A66" target="_blank">#nde-product-feeds</a><br>Confluence: <a href="https://confluence.nike.com/display/DEN/Product+And+Feeds+API" target="_blank">Product and Feeds API</a><br>Product Owner: [Andy Sun](mailto:andy.sun@nike.com)<br>Apollo Product Owner: [Patricia Cousins](mailto:patricia.cousins@nike.com)|

## <a name="terms-of-service"></a>Terms of Service

It is recommended that you send a caller ID header in every request to this API to help troubleshoot unexpected responses. See the Registration section of [Using NDe APIs](/doc/getting-started/using_nike_apis.html#registration) on how to create and register your caller ID.

### <a name="authorization"></a>Authorization

No authentication or authorization is required to use this API.

### <a name="prerequisites"></a>Prerequisites

In order to use the Product Feed Rollup Threads v2 API, you need to:

- **Obtain a Consumer Channel ID -- REQUIRED**

  <a href="https://confluence.nike.com/display/G11N/Request+Form+for+a+new+Consumer+Channel" target="_blank">Fill out a request form</a> to define your needs for a Consumer Channel ID. Once submitted, this form will be used to assess whether an existing ID can be used or a new ID needs to be created. This is different from the Channel ID you may be using to call the Product Feeds endpoint. See [Consumer Channel ID and Channel ID](#comparing-ids) for a comparison between the two ID types.

- **Configure Custom Search Rules -- OPTIONAL**

  The default key used for rolling up Threads is **productInfo.merchProduct.productRollup.key**. If you require any custom search rules to refine how Threads are rolled up, you can work with the Search team to create them. Contact the [Apollo Product Owner](#api-at-a-glance) for assistance.

## <a name="use-cases"></a>Use Cases

|I want to...|API(s) to use|
|---|---|
|Display a Product Grid Wall|Product Feed Rollup Threads v2 API|

## <a name="api-endpoint-quick-reference"></a>API Endpoint Quick Reference

|HTTP Verb|Endpoint Name|Endpoint Description|URI Format|
|---|---|---|---|
|GET|Rollup Threads|Get a product Thread with related Threads nested within|`/product_feed/rollup_threads/v2{?filter,anchor,count,sort,searchTerms,rollupCount,rollupField,consumerChannelId}`|

## <a name="what-is-a-rollup-thread"></a>What is a Rollup Thread?

The endpoint of this API is closely related to the *Threads List* endpoint of the Product Feeds v2 API. First, read the [Product Feeds v2 Developer's Guide](/doc/commerce/product/api_product_feeds.html) to understand the basic concepts of working with Threads.

Next, let's talk about what this API offers that is unique: Rollup Threads. A Rollup Thread is a Thread that is related to, and nested within a parent Thread. For example, there might be seven Rollup Threads nested within a given parent Thread, representing the other colors of a particular Nike shoe. Using Rollup Threads makes it much simpler for you to build a product grid wall experience like this:

<br>

![](/images/commerce/product_feeds/gridwall.png)

### How Can I Control the Rollup?

By default, the relationship between the Rollup Thread(s) to the parent Thread is based upon a rollup type and rollup key defined in the Nike's Prodigy product information system. As the client of the API, you do not have direct control over those values.

Both of these fields are located in the API response in the **productInfo.merchProduct.productRollup** object, field names **type** and **key**.

- rollup **type**: a group of products related by something, e.g. colors associated with a style number, or shoes of the same width. Example values are "Standard", "WidthGroup", "NFL, or "NBA".
- rollup **key**: a specific instance of a rollup type, e.g. a value representing a particular style number rollup. Example value is "xqTPKlqE".

#### Custom Search Rules

You also have the ability to configure additional rules in the Apollo search administration tool that will **override the default rollup behavior described above, exclusively for your consumerChannelId**.

For example, if you wanted to rollup by something other than style number (i.e. "type": "Standard"), you could define that as one or more rules in Apollo. You could also, for example, create a rule in Apollo to exclude customized Nike ID products or gift cards from your results, if desired.

**Ultimately, Apollo is where you can control how the Rollup Threads are returned to you in the response from this API.**

>**TIP**: Reach out to the [Apollo Product Owner](#api-at-a-glance) for more information on how to use the Apollo tool.

### <a name="comparing-ids"></a>Consumer Channel ID and Channel ID

Your Consumer Channel ID is unique to your app and allows you to have custom search rules to return only the parent and Rollup Threads that you need. But how is Consumer Channel ID related to the Channel ID you might be using with Product Feeds v2 API?

Consumer Channel ID and Channel ID are not directly related and are not used together in either API. They serve a similar purpose in that they are unique IDs that help you to get only the data you need from each API.

**When calling the Product Feed Rollup Threads API, Consumer Channel ID is required and Channel ID is not allowed.**

>**NOTE**: Threads returned by the Product Feed Rollup Threads API are pre-filtered for the Nike.com Channel ID.

### I Already Use Product Feeds v2. How is This API Response Different?

The following diagram describes the how the structure of the response from the Rollup Threads API differs from Product Feeds v2:

<br>

![](/images/commerce/product_feeds/rollup_threads_response.png)

## <a name="making-your-first-api-request"></a>Making your first API request

For your first request, send a request to get all the Rollup Threads for a particular consumerChannelId, marketplace, and language combination. These are the minimum required query parameters for calling this API.

1. **Gather Data Needed for the Request**

    Study the <a href="https://bitbucket.nike.com/projects/PHYLPROD/repos/productfeedrollupsv2/browse/API.md" target="_blank">API.md</a> or the [Using Product Feed Rollup Threads v2](#using-product-feed-rollup-threads-v2) section of this document.

    - Only the HTTP GET method is supported, which means no request body is required
    - No request headers are required
    - The URL and query parameters required are as follows:

|HTTP Method|Endpoint URI|
|---|---|
|GET|https://api.nike.com/product_feed/rollup_threads/v2{?filter,anchor,count,sort,searchTerms,rollupCount,rollupField,consumerChannelId}|

|Query Parameter Name|Format/Value|
|---|---|
|**filter**|?filter=language(en)|
|**filter**|?filter=marketplace(US)|
|**consumerChannelId**|?consumerChannelId=d9a5bc42-4b9c-4976-858a-f159cf99c647|

>**TIP**: Don't have a consumerChannelId yet? Request that the [Product Owner](#api-at-a-glance) assign one for your app.

2. **Execute the Request**

    Putting together the pieces from Step 1, the full URL you will use is https://api.nike.com/product_feed/rollup_threads/v2?consumerChannelId=d9a5bc42-4b9c-4976-858a-f159cf99c647&filter=language(en)&filter=marketplace(US).

    Use your favorite REST client to send the request. Alternatively, execute the following cURL command:

    ```
    curl -X GET \
        'https://api.nike.com/product_feed/rollup_threads/v2?consumerChannelId=d9a5bc42-4b9c-4976-858a-f159cf99c647&filter=language%28en%29,marketplace%28US%29' \
        -H 'Cache-Control: no-cache'
    ```

3. **Parse the Response**

    See the output of the successful HTTP 200 response below. The response has been truncated for brevity, but shows one parent Thread with two nested Rollup Threads:

    ```
    {
      "pages": {
        "prev": "",
        "next": "/product_feed/rollup_threads/v2?filter=language%28en%29&filter=marketplace%28US%29&consumerChannelId=d9a5bc42-4b9c-4976-858a-f159cf99c647&anchor=10",
        "totalPages": 773,
        "totalResources": 7721
      },
      "objects": [
        {
          "id": "5fe3b5d9-fd9c-33c7-bc03-b98f35585fb3",
          "channelId": "d9a5bc42-4b9c-4976-858a-f159cf99c647",
          "channelName": "NIKE.COM",
          "marketplace": "US",
          "language": "en",
          "lastFetchTime": "2018-05-02T22:25:16.639Z",
          "active": true,
          "publishedContent": {
            "publishStartDate": "3000-01-01T08:00:00.000Z",
            "createdDateTime": "2018-03-06T16:49:05.702Z",
            "publishEndDate": "3000-01-01T19:00:00.000Z",
            "viewStartDate": "3000-01-01T08:00:00.000Z",
            "properties": {
              "productCard": {
                "transforms": [],
                "language": "en",
                "type": "card",
                "creationDate": "2018-03-06T16:49:03.647Z",
                "version": "1520354943647",
                "translate": {},
                "classifications": [],
                "targetLanguages": [],
                "modificationDate": "2018-03-06T16:49:03.647Z",
                "nodes": [],
                "subType": "image",
                "id": "b815f55c-2696-4e0c-8221-8f77fa23f8d3",
                "properties": {
                  "squarishURL": "https://c.static-nike.com/a/images/t_default/nqrpl3dacns1civdnpix/nikegrip-strike-cushioned-crew-soccer-socks-pNznrv.jpg",
                  "altText": "NikeGrip Strike Cushioned Crew",
                  "squarish": {
                    "id": "nqrpl3dacns1civdnpix",
                    "type": "product",
                    "url": "https://c.static-nike.com/a/images/t_default/nqrpl3dacns1civdnpix/nikegrip-strike-cushioned-crew-soccer-socks-pNznrv.jpg"
                  },
                  "squarishId": "nqrpl3dacns1civdnpix"
                }
              },
              "custom": {},
              "subtitle": "Soccer Socks",
              "publish": {
                "collectionGroups": [
                  "d9a5bc42-4b9c-4976-858a-f159cf99c647"
                ],
                "collections": [
                  "11a0e33d-fb1c-4595-be74-2455b7a11cff"
                ],
                "countries": [
                  "US"
                ]
              },
              "consumerLabels": [],
              "threadType": "soldier",
              "title": "NikeGrip Strike Cushioned Crew",
              "seo": {
                "slug": "nikegrip-strike-cushioned-crew-soccer-socks-pNznrv"
              },
              "products": [
                {
                  "productId": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                  "styleColor": "SX5090-014"
                }
              ]
            }
          },
          "productInfo": [
            {
              "merchProduct": {
                "id": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                "snapshotId": "ebfbd4f9-5f19-40d8-b605-c1570e402b31",
                "modificationDate": "2018-05-02T00:03:26.553Z",
                "status": "ACTIVE",
                "merchGroup": "US",
                "styleCode": "SX5090",
                "colorCode": "014",
                "styleColor": "SX5090-014",
                "pid": "11231271",
                "catalogId": "996366d0-271f-3370-9c78-37afb629785a",
                "productGroupId": "11619046",
                "brand": "Nike",
                "channels": [
                  "Nike.com",
                  ".com"
                ],
                "consumerChannels": [
                  {
                    "id": "d9a5bc42-4b9c-4976-858a-f159cf99c647",
                    "resourceType": "globalization/consumer_channels"
                  }
                ],
                "legacyCatalogIds": [
                  "100701"
                ],
                "genders": [
                  "KIDS",
                  "WOMEN",
                  "MEN",
                  "GIRLS",
                  "BOYS"
                ],
                "valueAddedServices": [
                  {
                    "id": "3d62c037-56f3-59d5-81d3-88ce17f7fb99"
                  }
                ],
                "sportTags": [
                  "Soccer/Football"
                ],
                "classificationConcepts": [],
                "taxonomyAttributes": [
                  {
                    "resourceType": "merch/taxonomy_attributes",
                    "ids": [
                      "219e4fa3-73ef-427b-8f93-9d8f51b93443",
                      "ce8f6431-b545-44b5-bb2d-6a2d7b5df3cc"
                    ]
                  }
                ],
                "commerceCountryInclusions": [],
                "commerceCountryExclusions": [],
                "productRollup": {
                  "type": "Standard",
                  "key": "pNznrv"
                },
                "quantityLimit": 10,
                "styleType": "INLINE",
                "productType": "EQUIPMENT",
                "mainColor": true,
                "exclusiveAccess": false,
                "commercePublishDate": "2018-04-14T00:00:16.000Z",
                "commerceStartDate": "2017-01-01T08:00:00.000Z",
                "resourceType": "merchProduct",
                "links": {
                  "self": {
                    "ref": "/merch/products/v2/10e46d2c-9a1d-58c2-b714-642154a109c2"
                  }
                }
              },
              "merchPrice": {
                "fullPrice": 28,
                "currentPrice": 19.97,
                "currency": "USD",
                "discounted": true,
                "resourceType": "merchPrice",
                "links": {
                  "self": {
                    "ref": "/merch/prices/v2/396aa89c-b007-5183-ab49-dc36376763eb"
                  }
                }
              },
              "availability": {
                "id": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                "productId": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                "resourceType": "availableProducts",
                "links": {
                  "self": {
                    "ref": "/deliver/available_products/v1/10e46d2c-9a1d-58c2-b714-642154a109c2"
                  }
                },
                "available": true
              },
              "productContent": {
                "title": "NikeGrip Strike Cushioned Crew",
                "subtitle": "Soccer Socks",
                "colors": [
                  {
                    "type": "SIMPLE",
                    "name": "Black",
                    "hex": "13161A"
                  },
                  {
                    "type": "PRIMARY",
                    "name": "Black",
                    "hex": "13161A"
                  },
                  {
                    "type": "LOGO",
                    "name": "White",
                    "hex": "FFFFFF"
                  }
                ]
              },
              "imageUrls": {
                "productImageUrl": "https://secure-images.nike.com/is/image/DotCom/SX5090_014"
              }
            }
          ],
          "resourceType": "thread",
          "rollup": {
            "totalThreads": 2,
            "threads": [
              {
                "id": "996366d0-271f-3370-9c78-37afb629785a",
                "channelId": "d9a5bc42-4b9c-4976-858a-f159cf99c647",
                "channelName": "NIKE.COM",
                "marketplace": "US",
                "language": "en",
                "lastFetchTime": "2018-05-02T01:32:34.02Z",
                "active": true,
                "publishedContent": {
                  "publishStartDate": "2017-01-01T08:00:00.000Z",
                  "createdDateTime": "2018-05-02T01:32:33.721Z",
                  "publishEndDate": "3000-01-01T19:00:00.000Z",
                  "viewStartDate": "2017-01-01T08:00:00.000Z",
                  "properties": {
                    "productCard": {
                      "transforms": [],
                      "language": "en",
                      "type": "card",
                      "creationDate": "2018-05-02T01:32:33.715Z",
                      "version": "1525224753715",
                      "translate": {},
                      "classifications": [],
                      "targetLanguages": [],
                      "modificationDate": "2018-05-02T01:32:33.715Z",
                      "nodes": [],
                      "subType": "image",
                      "id": "ee7b53be-6cc5-4a42-931e-333bee6b0914",
                      "properties": {
                        "squarishURL": "https://c.static-nike.com/a/images/t_default/nqrpl3dacns1civdnpix/nikegrip-strike-cushioned-crew-soccer-socks-pNznrv.jpg",
                        "altText": "NikeGrip Strike Cushioned Crew",
                        "squarish": {
                          "id": "nqrpl3dacns1civdnpix",
                          "type": "product",
                          "url": "https://c.static-nike.com/a/images/t_default/nqrpl3dacns1civdnpix/nikegrip-strike-cushioned-crew-soccer-socks-pNznrv.jpg"
                        },
                        "squarishId": "nqrpl3dacns1civdnpix"
                      }
                    },
                    "custom": {},
                    "subtitle": "Soccer Socks",
                    "publish": {
                      "collectionGroups": [
                        "d9a5bc42-4b9c-4976-858a-f159cf99c647"
                      ],
                      "collections": [
                        "11a0e33d-fb1c-4595-be74-2455b7a11cff"
                      ],
                      "countries": [
                        "US"
                      ]
                    },
                    "consumerLabels": [],
                    "threadType": "soldier",
                    "title": "NikeGrip Strike Cushioned Crew",
                    "seo": {
                      "slug": "nikegrip-strike-cushioned-crew-soccer-socks-pNznrv"
                    },
                    "products": [
                      {
                        "productId": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                        "styleColor": "SX5090-014"
                      }
                    ]
                  }
                },
                "productInfo": [
                  {
                    "merchProduct": {
                      "id": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                      "snapshotId": "ebfbd4f9-5f19-40d8-b605-c1570e402b31",
                      "modificationDate": "2018-05-02T00:03:26.553Z",
                      "status": "ACTIVE",
                      "merchGroup": "US",
                      "styleCode": "SX5090",
                      "colorCode": "014",
                      "styleColor": "SX5090-014",
                      "pid": "11231271",
                      "catalogId": "996366d0-271f-3370-9c78-37afb629785a",
                      "productGroupId": "11619046",
                      "brand": "Nike",
                      "channels": [
                        "Nike.com",
                        ".com"
                      ],
                      "consumerChannels": [
                        {
                          "id": "d9a5bc42-4b9c-4976-858a-f159cf99c647",
                          "resourceType": "globalization/consumer_channels"
                        }
                      ],
                      "legacyCatalogIds": [
                        "100701"
                      ],
                      "genders": [
                        "KIDS",
                        "WOMEN",
                        "MEN",
                        "GIRLS",
                        "BOYS"
                      ],
                      "valueAddedServices": [
                        {
                          "id": "3d62c037-56f3-59d5-81d3-88ce17f7fb99"
                        }
                      ],
                      "sportTags": [
                        "Soccer/Football"
                      ],
                      "classificationConcepts": [],
                      "taxonomyAttributes": [
                        {
                          "resourceType": "merch/taxonomy_attributes",
                          "ids": [
                            "219e4fa3-73ef-427b-8f93-9d8f51b93443",
                            "a2da685c-4187-4af8-8dda-c9d35bb8867f"
                          ]
                        }
                      ],
                      "commerceCountryInclusions": [],
                      "commerceCountryExclusions": [],
                      "productRollup": {
                        "type": "Standard",
                        "key": "pNznrv"
                      },
                      "quantityLimit": 10,
                      "styleType": "INLINE",
                      "productType": "EQUIPMENT",
                      "mainColor": true,
                      "exclusiveAccess": false,
                      "commercePublishDate": "2018-04-14T00:00:16.000Z",
                      "commerceStartDate": "2017-01-01T08:00:00.000Z",
                      "resourceType": "merchProduct",
                      "links": {
                        "self": {
                          "ref": "/merch/products/v2/10e46d2c-9a1d-58c2-b714-642154a109c2"
                        }
                      }
                    },
                    "merchPrice": {
                      "fullPrice": 28,
                      "currentPrice": 19.97,
                      "currency": "USD",
                      "discounted": true,
                      "resourceType": "merchPrice",
                      "links": {
                        "self": {
                          "ref": "/merch/prices/v2/396aa89c-b007-5183-ab49-dc36376763eb"
                        }
                      }
                    },
                    "availability": {
                      "id": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                      "productId": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                      "resourceType": "availableProducts",
                      "links": {
                        "self": {
                          "ref": "/deliver/available_products/v1/10e46d2c-9a1d-58c2-b714-642154a109c2"
                        }
                      },
                      "available": true
                    },
                    "productContent": {
                      "title": "NikeGrip Strike Cushioned Crew",
                      "subtitle": "Soccer Socks",
                      "colors": [
                        {
                          "type": "SIMPLE",
                          "name": "Black",
                          "hex": "13161A"
                        },
                        {
                          "type": "PRIMARY",
                          "name": "Black",
                          "hex": "13161A"
                        },
                        {
                          "type": "LOGO",
                          "name": "White",
                          "hex": "FFFFFF"
                        }
                      ]
                    },
                    "imageUrls": {
                      "productImageUrl": "https://secure-images.nike.com/is/image/DotCom/SX5090_014"
                    }
                  }
                ],
                "resourceType": "thread",
                "links": {
                  "self": {
                    "ref": "/product_feed/threads/v2/996366d0-271f-3370-9c78-37afb629785a?channelId=d9a5bc42-4b9c-4976-858a-f159cf99c647&marketplace=US&language=en"
                  }
                },
                "searchMetaData": {
                  "exclusiveAccess": false,
                  "effectiveInStockStartSellDate": "2017-01-01T08:00:00.000Z",
                  "effectiveInStockStopSellDate": "2099-12-31T00:00:00.000Z",
                  "availableSizes": [
                    "4-5.5",
                    "6-7.5",
                    "14-16"
                  ],
                  "availableLocalizedSizes": [
                    "W 5.5-7",
                    "W 7.5-9 / M 6-7.5",
                    "M 14-16"
                  ],
                  "gtins": [
                    "00659658090224",
                    "00659658090965",
                    "00659658090972",
                    "00659658090989",
                    "00659658090996",
                    "00659658091009"
                  ],
                  "publishedContent": {
                    "publishEndDate": "3000-01-01T19:00:00.000Z",
                    "publishStartDate": "2017-01-01T08:00:00.000Z",
                    "propertiesSeoSlug": "nikegrip-strike-cushioned-crew-soccer-socks-pNznrv",
                    "propertiesProductsStyleColor": [
                      "SX5090-014"
                    ],
                    "propertiesPublishCollections": [
                      "11a0e33d-fb1c-4595-be74-2455b7a11cff"
                    ],
                    "propertiesConsumerLabelsClassificationText": [],
                    "viewStartDate": "2017-01-01T08:00:00.000Z",
                    "threadType": "soldier"
                  },
                  "productInfo": [
                    {
                      "merchProduct": {
                        "id": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                        "status": "ACTIVE",
                        "styleCode": "SX5090",
                        "colorCode": "014",
                        "styleColor": "SX5090-014",
                        "channels": [
                          "Nike.com",
                          ".com"
                        ],
                        "consumerChannels": [
                          {
                            "id": "d9a5bc42-4b9c-4976-858a-f159cf99c647",
                            "resourceType": "globalization/consumer_channels"
                          }
                        ],
                        "genders": [
                          "KIDS",
                          "WOMEN",
                          "MEN",
                          "GIRLS",
                          "BOYS"
                        ],
                        "productRollup": {
                          "type": "Standard",
                          "key": "pNznrv"
                        },
                        "mainColor": true,
                        "commercePublishDate": "2018-04-14T00:00:16.000Z",
                        "commerceStartDate": "2017-01-01T08:00:00.000Z"
                      },
                      "merchPrice": {
                        "msrp": 28,
                        "fullPrice": 28,
                        "currentPrice": 19.97,
                        "employeePrice": 11.98,
                        "discounted": true
                      },
                      "productContent": {
                        "fullTitle": "NikeGrip Strike Cushioned Crew Soccer Socks",
                        "title": "NikeGrip Strike Cushioned Crew",
                        "subtitle": "Soccer Socks",
                        "bestFor": [],
                        "athletes": []
                      },
                      "available": true,
                      "skus": [
                        {
                          "id": "2852f714-361b-5ce4-a8bf-a33cb0a7240a"
                        },
                        {
                          "id": "2d6e40b0-956d-5b73-b2fa-5e1b3fcc2f6c"
                        },
                        {
                          "id": "2511ed77-9505-5a9e-b4b1-94acb6249014"
                        },
                        {
                          "id": "9eb9705a-ef13-5802-a283-3e355d980da8"
                        },
                        {
                          "id": "d4a9f2da-5339-5fc9-81a9-ebf6d1a8a310"
                        },
                        {
                          "id": "7cf5dc89-f5cb-5101-8292-d8fa4691f0c6"
                        }
                      ]
                    }
                  ],
                  "productRollup": {
                    "type": "Standard",
                    "key": "pNznrv"
                  },
                  "taxonomyAttributeValues": {
                    "a00f0bb2-648b-4853-9559-4cd943b7d6c6": [
                      "dadd7a2e-d974-499c-9e3e-88c0b19adfcc",
                      "7e0d88b7-b082-4fee-aa65-d8af260c158d",
                      "143d3eff-40cb-46cd-b579-14462aa828a3"
                    ],
                    "758f6b44-e5a7-46be-b288-bac9c3ebe83f": [
                      "05392778-fff6-4fa0-a375-2506d27f009e"
                    ]
                  },
                  "taxonomyAttributeSearchIds": [
                    "219e4fa3-73ef-427b-8f93-9d8f51b93443",
                    "6e7e4809-fccb-4e82-8a7b-047125398076"
                  ]
                }
              }
            ]
          },
          "links": {
            "self": {
              "ref": "/product_feed/threads/v2/5fe3b5d9-fd9c-33c7-bc03-b98f35585fb3?channelId=d9a5bc42-4b9c-4976-858a-f159cf99c647&marketplace=US&language=en"
            }
          },
          "searchMetaData": {
            "exclusiveAccess": false,
            "effectiveInStockStartSellDate": "2017-01-01T08:00:00.000Z",
            "effectiveInStockStopSellDate": "2099-12-31T00:00:00.000Z",
            "availableSizes": [
              "4-5.5",
              "6-7.5",
              "14-16"
            ],
            "availableLocalizedSizes": [
              "W 5.5-7",
              "W 7.5-9 / M 6-7.5",
              "M 14-16"
            ],
            "gtins": [
              "00659658090224",
              "00659658090965",
              "00659658090972",
              "00659658090989",
              "00659658090996",
              "00659658091009"
            ],
            "publishedContent": {
              "publishEndDate": "3000-01-01T19:00:00.000Z",
              "publishStartDate": "3000-01-01T08:00:00.000Z",
              "propertiesSeoSlug": "nikegrip-strike-cushioned-crew-soccer-socks-pNznrv",
              "propertiesProductsStyleColor": [
                "SX5090-014"
              ],
              "propertiesPublishCollections": [
                "11a0e33d-fb1c-4595-be74-2455b7a11cff"
              ],
              "propertiesConsumerLabelsClassificationText": [],
              "viewStartDate": "3000-01-01T08:00:00.000Z",
              "threadType": "soldier"
            },
            "productInfo": [
              {
                "merchProduct": {
                  "id": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                  "status": "ACTIVE",
                  "styleCode": "SX5090",
                  "colorCode": "014",
                  "styleColor": "SX5090-014",
                  "channels": [
                    "Nike.com",
                    ".com"
                  ],
                  "consumerChannels": [
                    {
                      "id": "d9a5bc42-4b9c-4976-858a-f159cf99c647",
                      "resourceType": "globalization/consumer_channels"
                    }
                  ],
                  "genders": [
                    "KIDS",
                    "WOMEN",
                    "MEN",
                    "GIRLS",
                    "BOYS"
                  ],
                  "productRollup": {
                    "type": "Standard",
                    "key": "pNznrv"
                  },
                  "mainColor": true,
                  "commercePublishDate": "2018-04-14T00:00:16.000Z",
                  "commerceStartDate": "2017-01-01T08:00:00.000Z"
                },
                "merchPrice": {
                  "msrp": 28,
                  "fullPrice": 28,
                  "currentPrice": 19.97,
                  "employeePrice": 11.98,
                  "discounted": true
                },
                "productContent": {
                  "fullTitle": "NikeGrip Strike Cushioned Crew Soccer Socks",
                  "title": "NikeGrip Strike Cushioned Crew",
                  "subtitle": "Soccer Socks",
                  "bestFor": [],
                  "athletes": []
                },
                "available": true,
                "skus": [
                  {
                    "id": "2852f714-361b-5ce4-a8bf-a33cb0a7240a"
                  },
                  {
                    "id": "2d6e40b0-956d-5b73-b2fa-5e1b3fcc2f6c"
                  },
                  {
                    "id": "2511ed77-9505-5a9e-b4b1-94acb6249014"
                  },
                  {
                    "id": "9eb9705a-ef13-5802-a283-3e355d980da8"
                  },
                  {
                    "id": "d4a9f2da-5339-5fc9-81a9-ebf6d1a8a310"
                  },
                  {
                    "id": "7cf5dc89-f5cb-5101-8292-d8fa4691f0c6"
                  }
                ]
              }
            ],
            "productRollup": {
              "type": "Standard",
              "key": "pNznrv"
            },
            "taxonomyAttributeValues": {
              "a00f0bb2-648b-4853-9559-4cd943b7d6c6": [
                "dadd7a2e-d974-499c-9e3e-88c0b19adfcc",
                "7e0d88b7-b082-4fee-aa65-d8af260c158d",
                "143d3eff-40cb-46cd-b579-14462aa828a3"
              ],
              "758f6b44-e5a7-46be-b288-bac9c3ebe83f": [
                "05392778-fff6-4fa0-a375-2506d27f009e"
              ]
            },
            "taxonomyAttributeSearchIds": [
              "219e4fa3-73ef-427b-8f93-9d8f51b93443",
              "6e7e4809-fccb-4e82-8a7b-047125398076"
            ]
          }
        }
      ]
    }
    ```

>**TIP:** For detailed information about the contents of the response, see the [Using Product Feed Rollup Threads v2](#using-product-feed-rollup-threads-v2) section.

## <a name="using-rollup-threads-v2"></a>Using Product Feed Rollup Threads v2

Use the Product Feed Rollup Threads v2 API to produce a grid wall of related products.

### <a name="rollup-threads"></a>Rollup Threads List

Get a list of product Threads with related Rollup Threads using the *Rollup Threads List* endpoint.

#### Endpoint Details

|HTTP Method|URI Path|JWT Restricted?|
|---|---|---|
|**GET**|`/product_feed/rollup_threads/v2{?filter,anchor,count,sort,searchTerms,rollupCount,rollupField,consumerChannelId}`|**No**|

#### Path & Query Parameters

|Parameter|Type|Description|Data Type|Required?|
|---|---|---|---|---|
|**filter**|Query|Restrict the response by one or more criteria, **language**, **marketplace** required|String|**Required**|
|**consumerChannelId**|Query|Consumer channel ID of the experience (UUID)|String|**Required**|
|**anchor**|Query|Return elements after this anchor|String|Optional|
|**count**|Query|Maximum number of objects to return. Default: 10, Max: 60|String|Optional|
|**sort**|Query|Field(s) by which the results are sorted. Default: **publishedContent.viewStartDateDesc**, then **id.keywordAsc**.|String|Optional|
|**rollupField**|Query|Field by which to rollup the results. Default, and only supported field is **productInfo.merchProduct.productRollup.key**|String|Optional|
|**rollupCount**|Query|Count of items that will be inside the **productRollup.rollups** list. Default: 10, Max: 25|String|Optional|
|**searchTerms**|Query|Search for threads by one or more keywords separated with spaces. Request exact match by enclosing in double quotes. Default: partial match|String|Optional|

##### Allowed Filter Parameters

The following is a list of scenarios that illustrate which **filter** parameters are supported:

>**TIP**: Filter parameters **language** and **marketplace** are always required.

|I Want to List|Sample Query|
|---|---|
|Threads for a taxonomy ID|https://api.nike.com/product_feed/rollup_threads/v2?consumerChannelId=d9a5bc42-4b9c-4976-858a-f159cf99c647&filter=marketplace(US)&filter=language(en)&filter=taxonomyIds(c2228131-f12b-4513-84cd-55ae15d6723d)|

##### Allowed Sort Parameters

The following are the allowed fields that can be sent in the **sort** query parameter:

|Sort Field|Description|
|---|---|
|**publishedContent.publishStartDateAsc**|By Content Publish Start Date, Ascending|
|**publishedContent.publishStartDateDesc**|By Content Publish Start Date, Descending|
|**productInfo.merchProduct.commerceStartDateAsc**|By Commerce Start Date, Ascending|
|**productInfo.merchProduct.commerceStartDateDesc**|By Commerce Start Date, Descending|
|**productInfo.merchPrice.currentPriceAsc**|By Current Price, Ascending|
|**productInfo.merchPrice.currentPriceDesc**|By Current Price, Descending|
|**productInfo.merchProduct.commercePublishDateAsc**|By Commerce Publish Date, Ascending|
|**productInfo.merchProduct.commercePublishDateDesc**|By Commerce Publish Date, Descending|
|**effectiveStartSellDateAsc**|By Effective Start Sell Date, Ascending|
|**effectiveStartSellDateDesc**|By Effective Start Sell Date, Descending|
|**lastFetchTimeAsc**|By Last Fetch Time, Ascending|
|**lastFetchTimeDesc**|By Last Fetch Time, Descending|

##### Using the Search Terms Parameter

Send one or more search keywords in the **searchTerms** query parameter to list only the threads that contain those keywords. In order for a thread to be returned in the response, all included keywords must be found in a searchable field within that thread.

The searchable fields are:

- productInfo.productContent.**fullTitle**
- productInfo.productContent.**title**
- productInfo.productContent.**subtitle**
- publishedContent.properties.consumerLabels.classification.**text**
- productInfo.merchProduct.**styleColor**
- productInfo.merchProduct.**styleCode**

Search Summaries are available when using the **searchTerms** parameter. If any search terms are corrected for spelling (or another reason), a **searchSummary** section will be added to the pages section of the response. Within that section, a field for **originalTerms** contains the original input, while a field for **correctedTerms** contains the corrections for the original terms.

For example, using `searchTerms=Chuck Taylor` would return any threads where the words 'Chuck' and 'Taylor' are found anywhere in a searchable field.

The default search behavior is *partial match*. Limiting the search to only *full string matches* can be done by enclosing the keywords in double quotes, like `searchTerms="Chuck Taylor"`. In this case, the thread must contain the exact full string 'Chuck Taylor' in a searchable field in order to be returned in the response.

#### Example Scenarios

Let's take a look at a few *Rollup Threads List* scenarios.

|I Want to List|Sample Query|
|---|---|
|Search all on Nike.com products in US by "Men's Jordan", sorted by newest first|https://api.nike.com/product_feed/rollup_threads/v2?consumerChannelId=d9a5bc42-4b9c-4976-858a-f159cf99c647&filter=language(en)&filter=marketplace(US)&searchTerms=Men's%20Jordan&sort=effectiveStartSellDateDesc|
|TBD|TBD|

#### <a name="rollup-threads-request-headers"></a>Request Headers

There are no required request headers.

#### <a name="rollup-threads-request-body"></a>Request Body

There is no request body required for a GET request.

Sample *Rollup Threads List* request URI:

```
https://api.nike.com/commerce/product_feed/rollup_threads/v2?consumerChannelId=d9a5bc42-4b9c-4976-858a-f159cf99c647&filter=language(en)&filter=marketplace(US)
```

#### <a name="rollup-threads-response-body"></a>Response Body

>Note: The **productInfo** array contains responses from up to 8 other APIs, and are formatted according to the same schema as the source APIs. Links are provided to the relevant API.md for you to find the corresponding response schema.

|Element Name|Type|Description|Required?|
|---|---|---|---|
|**pages**|object|Object at top level containing link to previous and next pages of results|Required|
|pages.**prev**|string|Link to previous page of results|Required|
|pages.**next**|string|Link to next page of results|Required|
|pages.**totalPages**|integer|Total number of pages|Optional|
|pages.**totalResources**|integer|Total number of resources|Optional|
|pages.**searchSummary**|object|Context for the user's keyword query and what was decomposed from it|Optional|
|pages.searchSummary.**originalTerms**|string|The original search terms input by the user|Optional|
|pages.searchSummary.**correctedTerms**|array|A list of key/value pairs, mapping individual, incorrect search terms from the user with the correct ones|Optional|
|pages.searchSummary.**synonymTerms**|object|A mapping of search terms that were successfully mapped to synonyms; the search term is the key, and the value is the list of synonyms|Optional|
|pages.searchSummary.**concepts**|array|A list of concepts that matched the user's searchTerms query|Optional|
|**objects**|object|Array at top level containing feed data|Required|
|objects.**id**|string|Unique identifier for the feed in UUID format|Required|
|objects.**channelId**|string|UUID for the channel (collectionGroupId)|Optional|
|objects.**channelName**|string|Human-readable name for the channel|Optional|
|objects.**marketplace**|string|ISO 3166 two-letter country code for the user's current location|Required|
|objects.**language**|string|BCP-47 language code|Required|
|objects.**lastFetchTime**|string|Time when the data was aggregated in ISO-8601 compliant format: `yyyy-MM-ddTHH:mm:ss.SSSZZ`|Required|
|objects.**active**|boolean|Indicator for whether or not this thread is currently available for general use|Optional|
|objects.**publishedContent**|object|<a href="https://developer.niketech.com/docs/projects/CMS%20Published%20Content%20API?tab=api" target="_blank">API.md link</a>|Required|
|objects.**productInfo**|array|Array of responses from other APIs with product info|Optional|
|objects.productInfo.**merchProduct**|object|<a href="https://developer.niketech.com/docs/projects/Merchandised%20Products%20Service%20API?tab=api" target="_blank">API.md link</a>|Required|
|objects.productInfo.**merchPrice**|object|<a href="https://developer.niketech.com/docs/projects/Merchandised%20Prices%20Service%20API?tab=api" target="_blank">API.md link</a>|Required|
|objects.productInfo.**skus**|object|<a href="https://developer.niketech.com/docs/projects/Merchandised%20SKUs%20Service%20API?tab=api" target="_blank">API.md link</a>|Optional|
|objects.productInfo.**availability**|object|<a href="https://developer.niketech.com/docs/projects/Availability?tab=api" target="_blank">API.md link</a>|Optional|
|objects.productInfo.**availableSkus**|object|<a href="https://developer.niketech.com/docs/projects/Availability?tab=api" target="_blank">API.md link</a>|Optional|
|objects.productInfo.**productContent**|object|<a href="https://developer.niketech.com/docs/projects/Product%20Content%20Service%20API?tab=api" target="_blank">API.md link</a>|Optional|
|objects.productInfo.**launchView**|object|<a href="https://developer.niketech.com/docs/projects/Launch%20Views?tab=api" target="_blank">API.md link</a>|Optional|
|objects.productInfo.**imageUrls**|object|Object containing product image URL|Optional|
|objects.productInfo.imageUrls.**productImageUrl**|string|URL for product image|Optional|
|objects.productInfo.**customizedPreBuild**|object|<a href="https://developer.niketech.com/docs/projects/Customization%20Designs%20and%20Prebuilds%20V1?tab=api" target="_blank">API.md link</a>|Optional|
|objects.**rollup**|object|Object containing rollup info|Optional|
|objects.rollup.**totalThreads**|integer|The total threads available in the rollup response including the master thread|Optional|
|objects.rollup.**threads**|array|Array of threads that are related by a rollup key|Optional|
|objects.**resourceType**|string|Type of resource being returned in the response|Required|
|objects.links.self.**ref**|string|Self-link to this resource|Required|

Sample *Rollup Threads* 200 response:
```
{
  "pages": {
    "prev": "",
    "next": "/product_feed/rollup_threads/v2?filter=language%28en%29&filter=marketplace%28US%29&consumerChannelId=d9a5bc42-4b9c-4976-858a-f159cf99c647&anchor=10",
    "totalPages": 773,
    "totalResources": 7721
  },
  "objects": [
    {
      "id": "5fe3b5d9-fd9c-33c7-bc03-b98f35585fb3",
      "channelId": "d9a5bc42-4b9c-4976-858a-f159cf99c647",
      "channelName": "NIKE.COM",
      "marketplace": "US",
      "language": "en",
      "lastFetchTime": "2018-05-02T22:25:16.639Z",
      "active": true,
      "publishedContent": {
        "publishStartDate": "3000-01-01T08:00:00.000Z",
        "createdDateTime": "2018-03-06T16:49:05.702Z",
        "publishEndDate": "3000-01-01T19:00:00.000Z",
        "viewStartDate": "3000-01-01T08:00:00.000Z",
        "properties": {
          "productCard": {
            "transforms": [],
            "language": "en",
            "type": "card",
            "creationDate": "2018-03-06T16:49:03.647Z",
            "version": "1520354943647",
            "translate": {},
            "classifications": [],
            "targetLanguages": [],
            "modificationDate": "2018-03-06T16:49:03.647Z",
            "nodes": [],
            "subType": "image",
            "id": "b815f55c-2696-4e0c-8221-8f77fa23f8d3",
            "properties": {
              "squarishURL": "https://c.static-nike.com/a/images/t_default/nqrpl3dacns1civdnpix/nikegrip-strike-cushioned-crew-soccer-socks-pNznrv.jpg",
              "altText": "NikeGrip Strike Cushioned Crew",
              "squarish": {
                "id": "nqrpl3dacns1civdnpix",
                "type": "product",
                "url": "https://c.static-nike.com/a/images/t_default/nqrpl3dacns1civdnpix/nikegrip-strike-cushioned-crew-soccer-socks-pNznrv.jpg"
              },
              "squarishId": "nqrpl3dacns1civdnpix"
            }
          },
          "custom": {},
          "subtitle": "Soccer Socks",
          "publish": {
            "collectionGroups": [
              "d9a5bc42-4b9c-4976-858a-f159cf99c647"
            ],
            "collections": [
              "11a0e33d-fb1c-4595-be74-2455b7a11cff"
            ],
            "countries": [
              "US"
            ]
          },
          "consumerLabels": [],
          "threadType": "soldier",
          "title": "NikeGrip Strike Cushioned Crew",
          "seo": {
            "slug": "nikegrip-strike-cushioned-crew-soccer-socks-pNznrv"
          },
          "products": [
            {
              "productId": "10e46d2c-9a1d-58c2-b714-642154a109c2",
              "styleColor": "SX5090-014"
            }
          ]
        }
      },
      "productInfo": [
        {
          "merchProduct": {
            "id": "10e46d2c-9a1d-58c2-b714-642154a109c2",
            "snapshotId": "ebfbd4f9-5f19-40d8-b605-c1570e402b31",
            "modificationDate": "2018-05-02T00:03:26.553Z",
            "status": "ACTIVE",
            "merchGroup": "US",
            "styleCode": "SX5090",
            "colorCode": "014",
            "styleColor": "SX5090-014",
            "pid": "11231271",
            "catalogId": "996366d0-271f-3370-9c78-37afb629785a",
            "productGroupId": "11619046",
            "brand": "Nike",
            "channels": [
              "Nike.com",
              ".com"
            ],
            "consumerChannels": [
              {
                "id": "d9a5bc42-4b9c-4976-858a-f159cf99c647",
                "resourceType": "globalization/consumer_channels"
              }
            ],
            "legacyCatalogIds": [
              "100701"
            ],
            "genders": [
              "KIDS",
              "WOMEN",
              "MEN",
              "GIRLS",
              "BOYS"
            ],
            "valueAddedServices": [
              {
                "id": "3d62c037-56f3-59d5-81d3-88ce17f7fb99"
              }
            ],
            "sportTags": [
              "Soccer/Football"
            ],
            "classificationConcepts": [],
            "taxonomyAttributes": [
              {
                "resourceType": "merch/taxonomy_attributes",
                "ids": [
                  "219e4fa3-73ef-427b-8f93-9d8f51b93443",
                  "a2da685c-4187-4af8-8dda-c9d35bb8867f"
                ]
              }
            ],
            "commerceCountryInclusions": [],
            "commerceCountryExclusions": [],
            "productRollup": {
              "type": "Standard",
              "key": "pNznrv"
            },
            "quantityLimit": 10,
            "styleType": "INLINE",
            "productType": "EQUIPMENT",
            "mainColor": true,
            "exclusiveAccess": false,
            "commercePublishDate": "2018-04-14T00:00:16.000Z",
            "commerceStartDate": "2017-01-01T08:00:00.000Z",
            "resourceType": "merchProduct",
            "links": {
              "self": {
                "ref": "/merch/products/v2/10e46d2c-9a1d-58c2-b714-642154a109c2"
              }
            }
          },
          "merchPrice": {
            "fullPrice": 28,
            "currentPrice": 19.97,
            "currency": "USD",
            "discounted": true,
            "resourceType": "merchPrice",
            "links": {
              "self": {
                "ref": "/merch/prices/v2/396aa89c-b007-5183-ab49-dc36376763eb"
              }
            }
          },
          "availability": {
            "id": "10e46d2c-9a1d-58c2-b714-642154a109c2",
            "productId": "10e46d2c-9a1d-58c2-b714-642154a109c2",
            "resourceType": "availableProducts",
            "links": {
              "self": {
                "ref": "/deliver/available_products/v1/10e46d2c-9a1d-58c2-b714-642154a109c2"
              }
            },
            "available": true
          },
          "productContent": {
            "title": "NikeGrip Strike Cushioned Crew",
            "subtitle": "Soccer Socks",
            "colors": [
              {
                "type": "SIMPLE",
                "name": "Black",
                "hex": "13161A"
              },
              {
                "type": "PRIMARY",
                "name": "Black",
                "hex": "13161A"
              },
              {
                "type": "LOGO",
                "name": "White",
                "hex": "FFFFFF"
              }
            ]
          },
          "imageUrls": {
            "productImageUrl": "https://secure-images.nike.com/is/image/DotCom/SX5090_014"
          }
        }
      ],
      "resourceType": "thread",
      "rollup": {
        "totalThreads": 2,
        "threads": [
          {
            "id": "996366d0-271f-3370-9c78-37afb629785a",
            "channelId": "d9a5bc42-4b9c-4976-858a-f159cf99c647",
            "channelName": "NIKE.COM",
            "marketplace": "US",
            "language": "en",
            "lastFetchTime": "2018-05-02T01:32:34.02Z",
            "active": true,
            "publishedContent": {
              "publishStartDate": "2017-01-01T08:00:00.000Z",
              "createdDateTime": "2018-05-02T01:32:33.721Z",
              "publishEndDate": "3000-01-01T19:00:00.000Z",
              "viewStartDate": "2017-01-01T08:00:00.000Z",
              "properties": {
                "productCard": {
                  "transforms": [],
                  "language": "en",
                  "type": "card",
                  "creationDate": "2018-05-02T01:32:33.715Z",
                  "version": "1525224753715",
                  "translate": {},
                  "classifications": [],
                  "targetLanguages": [],
                  "modificationDate": "2018-05-02T01:32:33.715Z",
                  "nodes": [],
                  "subType": "image",
                  "id": "ee7b53be-6cc5-4a42-931e-333bee6b0914",
                  "properties": {
                    "squarishURL": "https://c.static-nike.com/a/images/t_default/nqrpl3dacns1civdnpix/nikegrip-strike-cushioned-crew-soccer-socks-pNznrv.jpg",
                    "altText": "NikeGrip Strike Cushioned Crew",
                    "squarish": {
                      "id": "nqrpl3dacns1civdnpix",
                      "type": "product",
                      "url": "https://c.static-nike.com/a/images/t_default/nqrpl3dacns1civdnpix/nikegrip-strike-cushioned-crew-soccer-socks-pNznrv.jpg"
                    },
                    "squarishId": "nqrpl3dacns1civdnpix"
                  }
                },
                "custom": {},
                "subtitle": "Soccer Socks",
                "publish": {
                  "collectionGroups": [
                    "d9a5bc42-4b9c-4976-858a-f159cf99c647"
                  ],
                  "collections": [
                    "11a0e33d-fb1c-4595-be74-2455b7a11cff"
                  ],
                  "countries": [
                    "US"
                  ]
                },
                "consumerLabels": [],
                "threadType": "soldier",
                "title": "NikeGrip Strike Cushioned Crew",
                "seo": {
                  "slug": "nikegrip-strike-cushioned-crew-soccer-socks-pNznrv"
                },
                "products": [
                  {
                    "productId": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                    "styleColor": "SX5090-014"
                  }
                ]
              }
            },
            "productInfo": [
              {
                "merchProduct": {
                  "id": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                  "snapshotId": "ebfbd4f9-5f19-40d8-b605-c1570e402b31",
                  "modificationDate": "2018-05-02T00:03:26.553Z",
                  "status": "ACTIVE",
                  "merchGroup": "US",
                  "styleCode": "SX5090",
                  "colorCode": "014",
                  "styleColor": "SX5090-014",
                  "pid": "11231271",
                  "catalogId": "996366d0-271f-3370-9c78-37afb629785a",
                  "productGroupId": "11619046",
                  "brand": "Nike",
                  "channels": [
                    "Nike.com",
                    ".com"
                  ],
                  "consumerChannels": [
                    {
                      "id": "d9a5bc42-4b9c-4976-858a-f159cf99c647",
                      "resourceType": "globalization/consumer_channels"
                    }
                  ],
                  "legacyCatalogIds": [
                    "100701"
                  ],
                  "genders": [
                    "KIDS",
                    "WOMEN",
                    "MEN",
                    "GIRLS",
                    "BOYS"
                  ],
                  "valueAddedServices": [
                    {
                      "id": "3d62c037-56f3-59d5-81d3-88ce17f7fb99"
                    }
                  ],
                  "sportTags": [
                    "Soccer/Football"
                  ],
                  "classificationConcepts": [],
                  "taxonomyAttributes": [
                    {
                      "resourceType": "merch/taxonomy_attributes",
                      "ids": [
                        "219e4fa3-73ef-427b-8f93-9d8f51b93443",
                        "a2da685c-4187-4af8-8dda-c9d35bb8867f"
                      ]
                    }
                  ],
                  "commerceCountryInclusions": [],
                  "commerceCountryExclusions": [],
                  "productRollup": {
                    "type": "Standard",
                    "key": "pNznrv"
                  },
                  "quantityLimit": 10,
                  "styleType": "INLINE",
                  "productType": "EQUIPMENT",
                  "mainColor": true,
                  "exclusiveAccess": false,
                  "commercePublishDate": "2018-04-14T00:00:16.000Z",
                  "commerceStartDate": "2017-01-01T08:00:00.000Z",
                  "resourceType": "merchProduct",
                  "links": {
                    "self": {
                      "ref": "/merch/products/v2/10e46d2c-9a1d-58c2-b714-642154a109c2"
                    }
                  }
                },
                "merchPrice": {
                  "fullPrice": 28,
                  "currentPrice": 19.97,
                  "currency": "USD",
                  "discounted": true,
                  "resourceType": "merchPrice",
                  "links": {
                    "self": {
                      "ref": "/merch/prices/v2/396aa89c-b007-5183-ab49-dc36376763eb"
                    }
                  }
                },
                "availability": {
                  "id": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                  "productId": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                  "resourceType": "availableProducts",
                  "links": {
                    "self": {
                      "ref": "/deliver/available_products/v1/10e46d2c-9a1d-58c2-b714-642154a109c2"
                    }
                  },
                  "available": true
                },
                "productContent": {
                  "title": "NikeGrip Strike Cushioned Crew",
                  "subtitle": "Soccer Socks",
                  "colors": [
                    {
                      "type": "SIMPLE",
                      "name": "Black",
                      "hex": "13161A"
                    },
                    {
                      "type": "PRIMARY",
                      "name": "Black",
                      "hex": "13161A"
                    },
                    {
                      "type": "LOGO",
                      "name": "White",
                      "hex": "FFFFFF"
                    }
                  ]
                },
                "imageUrls": {
                  "productImageUrl": "https://secure-images.nike.com/is/image/DotCom/SX5090_014"
                }
              }
            ],
            "resourceType": "thread",
            "links": {
              "self": {
                "ref": "/product_feed/threads/v2/996366d0-271f-3370-9c78-37afb629785a?channelId=d9a5bc42-4b9c-4976-858a-f159cf99c647&marketplace=US&language=en"
              }
            },
            "searchMetaData": {
              "exclusiveAccess": false,
              "effectiveInStockStartSellDate": "2017-01-01T08:00:00.000Z",
              "effectiveInStockStopSellDate": "2099-12-31T00:00:00.000Z",
              "availableSizes": [
                "4-5.5",
                "6-7.5",
                "14-16"
              ],
              "availableLocalizedSizes": [
                "W 5.5-7",
                "W 7.5-9 / M 6-7.5",
                "M 14-16"
              ],
              "gtins": [
                "00659658090224",
                "00659658090965",
                "00659658090972",
                "00659658090989",
                "00659658090996",
                "00659658091009"
              ],
              "publishedContent": {
                "publishEndDate": "3000-01-01T19:00:00.000Z",
                "publishStartDate": "2017-01-01T08:00:00.000Z",
                "propertiesSeoSlug": "nikegrip-strike-cushioned-crew-soccer-socks-pNznrv",
                "propertiesProductsStyleColor": [
                  "SX5090-014"
                ],
                "propertiesPublishCollections": [
                  "11a0e33d-fb1c-4595-be74-2455b7a11cff"
                ],
                "propertiesConsumerLabelsClassificationText": [],
                "viewStartDate": "2017-01-01T08:00:00.000Z",
                "threadType": "soldier"
              },
              "productInfo": [
                {
                  "merchProduct": {
                    "id": "10e46d2c-9a1d-58c2-b714-642154a109c2",
                    "status": "ACTIVE",
                    "styleCode": "SX5090",
                    "colorCode": "014",
                    "styleColor": "SX5090-014",
                    "channels": [
                      "Nike.com",
                      ".com"
                    ],
                    "consumerChannels": [
                      {
                        "id": "d9a5bc42-4b9c-4976-858a-f159cf99c647",
                        "resourceType": "globalization/consumer_channels"
                      }
                    ],
                    "genders": [
                      "KIDS",
                      "WOMEN",
                      "MEN",
                      "GIRLS",
                      "BOYS"
                    ],
                    "productRollup": {
                      "type": "Standard",
                      "key": "pNznrv"
                    },
                    "mainColor": true,
                    "commercePublishDate": "2018-04-14T00:00:16.000Z",
                    "commerceStartDate": "2017-01-01T08:00:00.000Z"
                  },
                  "merchPrice": {
                    "msrp": 28,
                    "fullPrice": 28,
                    "currentPrice": 19.97,
                    "employeePrice": 11.98,
                    "discounted": true
                  },
                  "productContent": {
                    "fullTitle": "NikeGrip Strike Cushioned Crew Soccer Socks",
                    "title": "NikeGrip Strike Cushioned Crew",
                    "subtitle": "Soccer Socks",
                    "bestFor": [],
                    "athletes": []
                  },
                  "available": true,
                  "skus": [
                    {
                      "id": "2852f714-361b-5ce4-a8bf-a33cb0a7240a"
                    },
                    {
                      "id": "2d6e40b0-956d-5b73-b2fa-5e1b3fcc2f6c"
                    },
                    {
                      "id": "2511ed77-9505-5a9e-b4b1-94acb6249014"
                    },
                    {
                      "id": "9eb9705a-ef13-5802-a283-3e355d980da8"
                    },
                    {
                      "id": "d4a9f2da-5339-5fc9-81a9-ebf6d1a8a310"
                    },
                    {
                      "id": "7cf5dc89-f5cb-5101-8292-d8fa4691f0c6"
                    }
                  ]
                }
              ],
              "productRollup": {
                "type": "Standard",
                "key": "pNznrv"
              },
              "taxonomyAttributeValues": {
                "a00f0bb2-648b-4853-9559-4cd943b7d6c6": [
                  "dadd7a2e-d974-499c-9e3e-88c0b19adfcc",
                  "7e0d88b7-b082-4fee-aa65-d8af260c158d",
                  "143d3eff-40cb-46cd-b579-14462aa828a3"
                ],
                "758f6b44-e5a7-46be-b288-bac9c3ebe83f": [
                  "05392778-fff6-4fa0-a375-2506d27f009e"
                ]
              },
              "taxonomyAttributeSearchIds": [
                "219e4fa3-73ef-427b-8f93-9d8f51b93443",
                "6e7e4809-fccb-4e82-8a7b-047125398076"
              ]
            }
          }
        ]
      },
      "links": {
        "self": {
          "ref": "/product_feed/threads/v2/5fe3b5d9-fd9c-33c7-bc03-b98f35585fb3?channelId=d9a5bc42-4b9c-4976-858a-f159cf99c647&marketplace=US&language=en"
        }
      },
      "searchMetaData": {
        "exclusiveAccess": false,
        "effectiveInStockStartSellDate": "2017-01-01T08:00:00.000Z",
        "effectiveInStockStopSellDate": "2099-12-31T00:00:00.000Z",
        "availableSizes": [
          "4-5.5",
          "6-7.5",
          "14-16"
        ],
        "availableLocalizedSizes": [
          "W 5.5-7",
          "W 7.5-9 / M 6-7.5",
          "M 14-16"
        ],
        "gtins": [
          "00659658090224",
          "00659658090965",
          "00659658090972",
          "00659658090989",
          "00659658090996",
          "00659658091009"
        ],
        "publishedContent": {
          "publishEndDate": "3000-01-01T19:00:00.000Z",
          "publishStartDate": "3000-01-01T08:00:00.000Z",
          "propertiesSeoSlug": "nikegrip-strike-cushioned-crew-soccer-socks-pNznrv",
          "propertiesProductsStyleColor": [
            "SX5090-014"
          ],
          "propertiesPublishCollections": [
            "11a0e33d-fb1c-4595-be74-2455b7a11cff"
          ],
          "propertiesConsumerLabelsClassificationText": [],
          "viewStartDate": "3000-01-01T08:00:00.000Z",
          "threadType": "soldier"
        },
        "productInfo": [
          {
            "merchProduct": {
              "id": "10e46d2c-9a1d-58c2-b714-642154a109c2",
              "status": "ACTIVE",
              "styleCode": "SX5090",
              "colorCode": "014",
              "styleColor": "SX5090-014",
              "channels": [
                "Nike.com",
                ".com"
              ],
              "consumerChannels": [
                {
                  "id": "d9a5bc42-4b9c-4976-858a-f159cf99c647",
                  "resourceType": "globalization/consumer_channels"
                }
              ],
              "genders": [
                "KIDS",
                "WOMEN",
                "MEN",
                "GIRLS",
                "BOYS"
              ],
              "productRollup": {
                "type": "Standard",
                "key": "pNznrv"
              },
              "mainColor": true,
              "commercePublishDate": "2018-04-14T00:00:16.000Z",
              "commerceStartDate": "2017-01-01T08:00:00.000Z"
            },
            "merchPrice": {
              "msrp": 28,
              "fullPrice": 28,
              "currentPrice": 19.97,
              "employeePrice": 11.98,
              "discounted": true
            },
            "productContent": {
              "fullTitle": "NikeGrip Strike Cushioned Crew Soccer Socks",
              "title": "NikeGrip Strike Cushioned Crew",
              "subtitle": "Soccer Socks",
              "bestFor": [],
              "athletes": []
            },
            "available": true,
            "skus": [
              {
                "id": "2852f714-361b-5ce4-a8bf-a33cb0a7240a"
              },
              {
                "id": "2d6e40b0-956d-5b73-b2fa-5e1b3fcc2f6c"
              },
              {
                "id": "2511ed77-9505-5a9e-b4b1-94acb6249014"
              },
              {
                "id": "9eb9705a-ef13-5802-a283-3e355d980da8"
              },
              {
                "id": "d4a9f2da-5339-5fc9-81a9-ebf6d1a8a310"
              },
              {
                "id": "7cf5dc89-f5cb-5101-8292-d8fa4691f0c6"
              }
            ]
          }
        ],
        "productRollup": {
          "type": "Standard",
          "key": "pNznrv"
        },
        "taxonomyAttributeValues": {
          "a00f0bb2-648b-4853-9559-4cd943b7d6c6": [
            "dadd7a2e-d974-499c-9e3e-88c0b19adfcc",
            "7e0d88b7-b082-4fee-aa65-d8af260c158d",
            "143d3eff-40cb-46cd-b579-14462aa828a3"
          ],
          "758f6b44-e5a7-46be-b288-bac9c3ebe83f": [
            "05392778-fff6-4fa0-a375-2506d27f009e"
          ]
        },
        "taxonomyAttributeSearchIds": [
          "219e4fa3-73ef-427b-8f93-9d8f51b93443",
          "6e7e4809-fccb-4e82-8a7b-047125398076"
        ]
      }
    }
  ]
}
```

Sample *Rollup Threads* 400 response:
```
{
    "message": "Validation Failed",
    "errors": [
        {
            "code": "MISSING_REQUIRED",
            "field": "/consumerChannelId",
            "message": "Required field is missing"
        }
    ]
}
```

## <a name="upgrading-to-the-latest-version"></a>Upgrading to the latest version

Version 2 (v2) is the current and only version of this API.

## <a name="best-practices"></a>Best Practices

See the Best Practices section of the [Product Feeds Developer's Guide](/doc/commerce/product/api_product_feeds.html#best-practices).

## <a name="troubleshooting"></a>Troubleshooting

**I'm getting a 200 response, but the Thread data and/or Rollup Threads are not as expected**

- Check your Smart Search rules configuration in the Apollo application to ensure that the rules are correct.
- Check the rollup key & type from Prodigy for the Parent Thread is as expected.
- Reach out to Product Feeds team on Slack for assistance: <a href="https://nikedigital.slack.com/messages/CAPF62A66" target="_blank">#nde-product-feeds</a>

>TIP: See the Troubleshooting section of the [Product Feeds Developer's Guide](/doc/commerce/product/api_product_feeds.html#troubleshooting) for more general troubleshooting information.

## <a name="glossary"></a>Glossary

See the [Glossary](/doc/getting-started/glossary.html).

## <a name="release-notes"></a>Release Notes

There are no release notes at this time.

## <a name="document-change-log"></a>Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft|05/17/2018|Initial Draft|
|Update|07/19/2018|Updated how to obtain a consumerChannelId|

## <a name="related-links"></a>Related Links

[NDe Documentation Home](/index.html)

[Getting Started](/doc/portal/consuming.html)

[Business Guides](/doc/portal/biz-guides.html)

[Developer's Guides](/doc/portal/dev-guides.html)