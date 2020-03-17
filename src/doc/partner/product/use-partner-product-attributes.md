---
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="new-tab" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# NIKE PARTNERS - ADDING PRODUCT ATTRIBUTES TO YOUR EXPERIENCE <i class="g72-swoosh"></i><br>DRAFT

---

##### Last Updated: 03/17/2020

**Get Nike product attributes like sizes, prices, features, marketing copy and more by using the [Product Attributes API](#api-reference).**

## Introduction

In this guide, we will step through how to use the Product Attributes API to get detailed product data into your app or experience.

This API provides **product data that is segmented by style-color, region, and season**.

Let's say that you have a list of Nike style-color codes and you want get more details about them for a particular region/season combination. Just execute a cURL command similar to this one:

```
curl --location --request GET 'https://product.api.nike.net/product/v1/USA/SP2020?productCodes=314193-117,654321-101' \
--header 'Authorization: Bearer {your token here}'
```

For each style-color that you send, you will get corresponding attributes, for example:

- Sizes (US, JP, KR, UK)
- Prices (Wholesale, Retail)
- Features (e.g. Reason to Buy)
- Gender
- Silhouette
- Athlete
- Offer Dates

## Key Terms

Here are some important terms that are used in this guide.

###### Table 1: List of Terms Related to Product Attributes

|Term|Definition|
|---|---|
|Product Attributes|The set of metadata for a given Nike product code, e.g. sizes, prices, gender, silhouette.|
|Product Code|The combined Nike style and color codes, e.g. 654321-101. Also known as style-color code.|
|Region|The Nike geographical region name associated with the product, e.g. CHINA.|
|Season|The Nike season year code associated with the product, e.g. SP2020 or FA2021. See [Table 4](#table-4--season-codes-with-descriptions)|
|Silhouette|The overall shape of the product, e.g. SHOE.|

## Prerequisites

**Authentication**

This API uses Okta authentication. Work with your Nike Account Manager (AM) And Technical Point Of Contact (TPC) to create your client credentials and to get the next steps for retrieving your access token.

## Get Product Attributes

<i class="g72-check"></i>&nbsp;&nbsp;**Get product attributes for one or more Nike product codes**

After completing all of the action items in the [Prerequisites](#prerequisites) section, you are ready to add Nike Product Attributes to your app or experience.

### Step 1: Gather the Required Data

The minimum required data you need to construct a valid request is:

- One or more product codes
- Region code
- Season year code

>**TIP**: See the [API Reference](#get-product-attributes-for-a-single-product) for more on which region and season year codes to use.

### Step 2: Make the API Request to Product Attributes

If only one product code, call the single endpoint with the product code, region, and season as path parameters:

```
curl --location --request GET 'https://product.api.nike.net/product/v1/AA2148-009/USA/SP2020' \
--header 'Authorization: Bearer {your token here}'
```

If more than one product code, call the multiple endpoint with the region and season as path parameters and a comma-separated list of `productCodes` as a query parameter:

```
curl --location --request GET 'https://product.api.nike.net/product/v1/USA/SP2020?productCodes=314193-117,654321-101' \
--header 'Authorization: Bearer {your token here}'
```

### Step 3: Parse the Response

Parse the response body to get the attributes that you need into your app/experience.

>**TIP**: See [API Reference](#api-reference) for details of the response body.

## API Endpoint Quick Reference

###### Table 2: Endpoints of the Product Attributes API

|Endpoint|Method|URI|
|---|---|---|
|[Get Product Attributes for a Single Product](#get-product-attributes-for-a-single-product)|`GET`|https://product.api.nike.net/product/v1/{productCode}/{region}/{season}|
|[Get Product Attributes for Multiple Products](#get-product-attributes-for-multiple-products)|`GET`|https://product.api.nike.net/products/v1/{region}/{season}|

<!--
## Troubleshooting

### Common Questions

**What if this bad thing happens?**
-->

## API Reference

### Product Attributes

#### Get Product Attributes for a Single Product

Retrieve product attributes for a single product, when you provide `productCode`, `region`, and `season` as path parameters.

**REQUEST**

**Endpoint**

GET https://product.api.nike.net/product/v1/{productCode}/{region}/{season}

**Request Headers**

`Content-Type:application/json`

**Path Parameters**

The following path parameters are all required in the request URI:

###### Table 3: Required Path Parameters (Single Product)
 
|Field Name|Description|Example|
|---|---|---|
|`productCode`|Nike product code|AA1837-400|
|`region`|Nike region name|CHINA|
|`season`|Nike season year code|SP2020|

**Possible Values for `region`**

```
GLOBAL
EUROPEAN UNION
USA
EUROPE
ASIA
AMERICAS
JAPAN
CANADA
EASTERN EUROPE DISTRIBUTORS
AFRICAN DISTRIBUTORS
CHINA
HONG KONG
EUROPEAN FREE TRADE ASSO.
THAILAND
SINGAPORE
PHILIPPINES
AFRICA - DUBAI
MALAYSIA
AUSTRALIA
NEW ZEALAND
REPUBLIC OF KOREA
TAIWAN
CHILE
MEXICO
UNITED STATES OF AMERICA
ARGENTINA
BRAZIL
CHINA
HONG KONG
THAILAND
SINGAPORE
PHILIPPINES
MALAYSIA
AUSTRALIA
NEW ZEALAND
EUROPE
REPUBLIC OF KOREA
TAIWAN
CHILE
MEXICO
ARGENTINA
BRAZIL
ICS AMERICA
ICS ASIA
INDIA
ASIA
ICS SOUTH AFRICA
SOUTH AFRICA
URUGUAY
SOUTHEAST ASIA
PACIFIC
SOUTHERN CONE SOCO
UNITED STATES
EUROPE PROCESSING
AMERICAS
INDONESIA
NIKE TRADING COMPANY, SINGAPOR
NIKE GLOBAL TRADING PTE LTD.
UMBRO CORPORATE
UMBRO AND LICENSEE
UMBRO HEADQUARTERS
UMBRO LICENSEE HQ
CANADA
NORTHERN AND CENTRAL EUROPE
SUB MEDITERRANEAN
AUST, GERM, SWIT, SLVN
UNITED KINGDOM AND IRELAND
CNTRL EUROPE, MID EAST, AFRICA
FRANCE AND ITALY
```

**Possible Values for `season`**

An accepted value for `season` is a concatenation of a valid two-digit season code and a four-digit year number.

First, take one of the possible season codes:

###### Table 4: Season Codes with Descriptions

|Season Code|Description|Date Range|
|---|---|---|
|`SP`|Spring|Jan-Mar|
|`SU`|Summer|Apr-Jun|
|`FA`|Fall|Jul-Sep|
|`HO`|Holiday|Oct-Dec|

Then, add the year: `SP` + `2022` = `SP2022`.

Example values for `season` (in no particular sequence):

- `FA2021`
- `HO2022`
- `SP2023`
- etc...

**RESPONSE**

**Response Body**

###### Table 5: Fields in the API Response

|Field|Description|Type|Example|
|---|---|---|---|
|season.`year`|Season year number (YYYY)|integer|2021|
|season.`name`|Season name|string|SPRING|
|`styleColorNumber`|Nike style-color code (same as `productCode`)|string|654321-101|
|`sizeRange`|Range of US size numbers for that style-color|string|7-12, 13, 14, 15|
|`styleNumber`|Nike six-digit style code|string|AA1837|
|color.`code`|Nike three-digit color code|string|101|
|color.longDescription.`lang`|Language code|string|EN|
|color.longDescription.`text`|Description of color|string|THUNDER BLUE/WHITE|
|`primaryColor`|Name of the closest primary color|string|BLUE|
|category.`desc`|Description of the product category|string|GOLF|
|categoryCoreFocus.`desc`|Description of the core focus of that product category|string|NIKE GOLF|
|silhouette.`desc`|Description of the product silhouette|string|LOW TOP|
|silhouetteType.`desc`|Type of product silhouette|string|SHOE|
|genderAge.`code`|Gender-age code|string|18|
|genderAge.`desc`|Gender-age description|string|MENS|
|unitOfMeasure.`code`|Unit of measure code|string|PR|
|unitOfMeasure.`desc`|Unit of measure description|string|PAIR|
|`sizes`|For each size, multiple size codes (US, JP, KR, UK format) and UPC code|array||
|sizes.`us`|US size code|string|11|
|sizes.`jp`|Japan size code|string|29|
|sizes.`kr`|Korea size code|string|290|
|sizes.`uk`|UK size code|string|10|
|sizes.`upc_gtin`|UPC/GTIN code|string|11|
|sizes.`sortOrder`|Sort position of array item|string|27|
|`prices`|Array of prices for this style-color|array||
|prices.wholesale.`currency`|Currency code|string|USD|
|prices.wholesale.`price`|Wholesale price|number|49|
|prices.wholesale.effectiveDates.`begin`|Start date of price|string|20210101|
|prices.retail.`currency`|Currency code|string|USD|
|prices.retail.`price`|Retail price|number|80|
|prices.retail.effectiveDates.`begin`|Start date of price|string|20210101|
|names.systemStyleName.`lang`|Language code|string|EN|
|names.systemStyleName.`text`|System style name|string|ROSHE G|
|names.consumerStyleName.`lang`|Language code|string|EN|
|names.consumerStyleName.`text`|Consumer style name|string|Men's Nike Roshe G Golf Shoe Secondary Tertiary|
|division`desc`|Description of product division|string|FOOTWEAR DIVISION|
|commercialCopy.reasonToBuy.`lang`|Language code|string|EN|
|commercialCopy.reasonToBuy.`text`|Reason to buy|string|ICONIC DESIGN. LASTING COMFORT.|
|commercialCopy.productSummary.`lang`|Language code|string|EN|
|commercialCopy.productSummary.`text`|Product summary|string|Men's Nike Roshe G Golf Shoe features a pressure-mapped outsole that provides traction in key zones. <br>Inspired by a Nike icon, the mesh upper offers breathability and a modern look, while the soft, flexible, <br>foam midsole cushions every step.|
|commercialCopy.fabricContent.`lang`|Language code|string|EN|
|commercialCopy.fabricContent.`text`|Fabric content|string||
|commercialCopy.features.`lang`|Language code|string|EN|
|commercialCopy.features.`text`|Features|string|Pressure-mapped outsole provides traction in key zones.|
|commercialCopy.allFeatures.`lang`|Language code|string|EN|
|commercialCopy.allFeatures.`text`|All features|string|Pressure-mapped outsole provides traction in key zones. Iconic mesh upper delivers breathability and style. <br>Injected midsole delivers soft, lightweight cushioning. Elastic gusset on the tongue helps keep out debris. Pull tabs on the heel and tongue offer easy on and off. <br>Cupsole-like design offers flexible, low-profile support and a stable feel.|
|athlete`firstName`|Athlete first name|string|Jane|
|athlete`lastName`|Athlete last name|string|Doe|
|offerDates.`productFirstOffer`|First offer date|string|20210101|
|offerDates.`productLastOffer`|Last offer date|string|20210101|
|offerDates.`productFutureLastOffer`|Future last offer date|string|20210101|
|marketingType.`desc`|Description of marketing type|string|IN-LINE|
|`carryOver`|Is it a carry-over product, Y or N|string|Y|
|launchData.`coordinatedDescription`|Description of coordinated launch|string|BRAND INITIATIVES|

**200 OK (Successful Request)**

```
{
  "season": {
    "year": 2018,
    "name": "SPRING"
  },
  "styleColorNumber": "AA1837-400",
  "sizeRange": "7-12, 13, 14, 15",
  "styleNumber": "AA1837",
  "color": {
    "code": 400,
    "longDescription": [
      {
        "lang": "EN",
        "text": "THUNDER BLUE/WHITE"
      }
    ]
  },
  "primaryColor": "BLUE",
  "category": {
    "desc": "GOLF"
  },
  "categoryCoreFocus": {
    "desc": "NIKE GOLF"
  },
  "silhouette": {
    "desc": "LOW TOP"
  },
  "silhouetteType": {
    "desc": "SHOE"
  },
  "genderAge": {
    "code": 18,
    "desc": "MENS"
  },
  "unitOfMeasure": {
    "code": "PR",
    "desc": "PAIR"
  },
  "sizes": [
    {
      "us": "11",
      "jp": "29",
      "kr": "290",
      "uk": "10",
      "upc_gtin": "00888411976097",
      "sortOrder": "23"
    },
    {
      "us": "9.5",
      "jp": "27.5",
      "kr": "275",
      "uk": "8.5",
      "upc_gtin": "00888411976066",
      "sortOrder": "20"
    },
    {
      "us": "12",
      "jp": "30",
      "kr": "300",
      "uk": "11",
      "upc_gtin": "00888411976110",
      "sortOrder": "25"
    },
    {
      "us": "13",
      "jp": "31",
      "kr": "310",
      "uk": "12",
      "upc_gtin": "00888411976127",
      "sortOrder": "27"
    },
    {
      "us": "14",
      "jp": "32",
      "kr": "320",
      "uk": "13",
      "upc_gtin": "00888411976134",
      "sortOrder": "29"
    },
    {
      "us": "15",
      "jp": "33",
      "kr": "330",
      "uk": "14",
      "upc_gtin": "00888411976141",
      "sortOrder": "31"
    },
    {
      "us": "11.5",
      "jp": "29.5",
      "kr": "295",
      "uk": "10.5",
      "upc_gtin": "00888411976103",
      "sortOrder": "24"
    },
    {
      "us": "10.5",
      "jp": "28.5",
      "kr": "285",
      "uk": "9.5",
      "upc_gtin": "00888411976080",
      "sortOrder": "22"
    },
    {
      "us": "7",
      "jp": "25",
      "kr": "250",
      "uk": "6",
      "upc_gtin": "00888411976011",
      "sortOrder": "15"
    },
    {
      "us": "8",
      "jp": "26",
      "kr": "260",
      "uk": "7",
      "upc_gtin": "00888411976035",
      "sortOrder": "17"
    },
    {
      "us": "9",
      "jp": "27",
      "kr": "270",
      "uk": "8",
      "upc_gtin": "00888411976059",
      "sortOrder": "19"
    },
    {
      "us": "7.5",
      "jp": "25.5",
      "kr": "255",
      "uk": "6.5",
      "upc_gtin": "00888411976028",
      "sortOrder": "16"
    },
    {
      "us": "10",
      "jp": "28",
      "kr": "280",
      "uk": "9",
      "upc_gtin": "00888411976073",
      "sortOrder": "21"
    },
    {
      "us": "8.5",
      "jp": "26.5",
      "kr": "265",
      "uk": "7.5",
      "upc_gtin": "00888411976042",
      "sortOrder": "18"
    }
  ],
  "prices": [
    {
      "wholesale": {
        "currency": "USD",
        "price": 49,
        "effectiveDates": {
          "begin": 20180101
        }
      },
      "retail": {
        "currency": "USD",
        "price": 80,
        "effectiveDates": {
          "begin": 20180101
        }
      }
    }
  ],
  "names": {
    "systemStyleName": {
      "lang": "EN",
      "text": "ROSHE G"
    },
    "consumerStyleName": {
      "lang": "EN",
      "text": "Men's Nike Roshe G Golf Shoe Secondary Tertiary"
    }
  },
  "division": {
    "desc": "FOOTWEAR DIVISION"
  },
  "commercialCopy": {
    "reasonToBuy": [
      {
        "lang": "EN",
        "text": "ICONIC DESIGN. LASTING COMFORT."
      }
    ],
    "productSummary": [
      {
        "lang": "EN",
        "text": "Men's Nike Roshe G Golf Shoe features a pressure-mapped outsole that provides traction in key zones. Inspired by a Nike icon, the mesh upper offers breathability and a modern look, while the soft, flexible, foam midsole cushions every step."
      }
    ],
    "fabricContent": [
      {
        "lang": "EN",
        "text": ""
      }
    ],
    "features": [
      {
        "lang": "EN",
        "text": "Pressure-mapped outsole provides traction in key zones."
      },
      {
        "lang": "EN",
        "text": "Iconic mesh upper delivers breathability and style."
      },
      {
        "lang": "EN",
        "text": "Injected midsole delivers soft, lightweight cushioning."
      },
      {
        "lang": "EN",
        "text": "Elastic gusset on the tongue helps keep out debris."
      },
      {
        "lang": "EN",
        "text": "Pull tabs on the heel and tongue offer easy on and off."
      },
      {
        "lang": "EN",
        "text": "Cupsole-like design offers flexible, low-profile support and a stable feel."
      }
    ],
    "allFeatures": [
      {
        "lang": "EN",
        "text": "Pressure-mapped outsole provides traction in key zones. Iconic mesh upper delivers breathability and style. Injected midsole delivers soft, lightweight cushioning. Elastic gusset on the tongue helps keep out debris. Pull tabs on the heel and tongue offer easy on and off. Cupsole-like design offers flexible, low-profile support and a stable feel."
      }
    ]
  },
  "athlete": {
    "firstName": "JANE",
    "lastName": "DOE"
  },
  "offerDates": {
    "productFirstOffer": 20180201,
    "productLastOffer": 20190331,
    "productFutureLastOffer": 20190319
  },
  "marketingType": {
    "desc": "IN-LINE"
  },
  "carryOver": "N",
  "launchData": {
    "coordinatedDescription": "BRAND INITIATIVES"
  }
}
```

**400 Bad Request (Invalid Season Code)**

```
{
  "code": "BAD REQUEST - Invalid Season",
  "message": "INVALID_SEASON"
}
```

**401 Unauthorized**

```
{
  "message": "Unauthorized"
}
```

**404 Not Found (Invalid Product Code)**

```
{
  "code": "NOT_FOUND",
  "message": "NOT FOUND"
}
```

#### Get Product Attributes for Multiple Products

Retrieve product attributes for multiple products, when you provide `region` and `season` as path parameters and `productCodes` as a query parameter.

**REQUEST**

**Endpoint**

GET https://product.api.nike.net/product/v1/{region}/{season}

**Headers**

`Content-Type:application/json`

**Path Parameters**

The following path parameters are required in the request URI:

###### Table 6: Required Path Parameters (Multiple Products)

|Field Name|Description|Example|
|---|---|---|
|`region`|Nike region name|CHINA|
|`season`|Nike season year|SP2020|

**Query Parameters**

The following query parameters are required in the request URI:

###### Table 7: Required Query Parameters (Multiple Products)

|Field Name|Description|Example|
|---|---|---|
|`productCodes`|Comma-separated list of Nike product codes|AA1837-400,654321-100|

**RESPONSE**

**200 OK (Successful Request)**

```
{
  "products": [
    {
      "season": {
        "year": 2018,
        "name": "SPRING"
      },
      "styleColorNumber": "AA1837-400",
      "sizeRange": "7-12, 13, 14, 15",
      "styleNumber": "AA1837",
      "color": {
        "code": 400,
        "longDescription": [
          {
            "lang": "EN",
            "text": "THUNDER BLUE/WHITE"
          }
        ]
      },
      "primaryColor": "BLUE",
      "category": {
        "desc": "GOLF"
      },
      "categoryCoreFocus": {
        "desc": "NIKE GOLF"
      },
      "silhouette": {
        "desc": "LOW TOP"
      },
      "silhouetteType": {
        "desc": "SHOE"
      },
      "genderAge": {
        "code": 18,
        "desc": "MENS"
      },
      "unitOfMeasure": {
        "code": "PR",
        "desc": "PAIR"
      },
      "sizes": [
        {
          "us": "11",
          "jp": "29",
          "kr": "290",
          "uk": "10",
          "upc_gtin": "00888411976097",
          "sortOrder": "23"
        },
        {
          "us": "9.5",
          "jp": "27.5",
          "kr": "275",
          "uk": "8.5",
          "upc_gtin": "00888411976066",
          "sortOrder": "20"
        },
        {
          "us": "12",
          "jp": "30",
          "kr": "300",
          "uk": "11",
          "upc_gtin": "00888411976110",
          "sortOrder": "25"
        },
        {
          "us": "13",
          "jp": "31",
          "kr": "310",
          "uk": "12",
          "upc_gtin": "00888411976127",
          "sortOrder": "27"
        },
        {
          "us": "14",
          "jp": "32",
          "kr": "320",
          "uk": "13",
          "upc_gtin": "00888411976134",
          "sortOrder": "29"
        },
        {
          "us": "15",
          "jp": "33",
          "kr": "330",
          "uk": "14",
          "upc_gtin": "00888411976141",
          "sortOrder": "31"
        },
        {
          "us": "11.5",
          "jp": "29.5",
          "kr": "295",
          "uk": "10.5",
          "upc_gtin": "00888411976103",
          "sortOrder": "24"
        },
        {
          "us": "10.5",
          "jp": "28.5",
          "kr": "285",
          "uk": "9.5",
          "upc_gtin": "00888411976080",
          "sortOrder": "22"
        },
        {
          "us": "7",
          "jp": "25",
          "kr": "250",
          "uk": "6",
          "upc_gtin": "00888411976011",
          "sortOrder": "15"
        },
        {
          "us": "8",
          "jp": "26",
          "kr": "260",
          "uk": "7",
          "upc_gtin": "00888411976035",
          "sortOrder": "17"
        },
        {
          "us": "9",
          "jp": "27",
          "kr": "270",
          "uk": "8",
          "upc_gtin": "00888411976059",
          "sortOrder": "19"
        },
        {
          "us": "7.5",
          "jp": "25.5",
          "kr": "255",
          "uk": "6.5",
          "upc_gtin": "00888411976028",
          "sortOrder": "16"
        },
        {
          "us": "10",
          "jp": "28",
          "kr": "280",
          "uk": "9",
          "upc_gtin": "00888411976073",
          "sortOrder": "21"
        },
        {
          "us": "8.5",
          "jp": "26.5",
          "kr": "265",
          "uk": "7.5",
          "upc_gtin": "00888411976042",
          "sortOrder": "18"
        }
      ],
      "prices": [
        {
          "wholesale": {
            "currency": "USD",
            "price": 49,
            "effectiveDates": {
              "begin": 20180101
            }
          },
          "retail": {
            "currency": "USD",
            "price": 80,
            "effectiveDates": {
              "begin": 20180101
            }
          }
        }
      ],
      "names": {
        "systemStyleName": {
          "lang": "EN",
          "text": "ROSHE G"
        },
        "consumerStyleName": {
          "lang": "EN",
          "text": "Men's Nike Roshe G Golf Shoe Secondary Tertiary"
        }
      },
      "division": {
        "desc": "FOOTWEAR DIVISION"
      },
      "commercialCopy": {
        "reasonToBuy": [
          {
            "lang": "EN",
            "text": "ICONIC DESIGN. LASTING COMFORT."
          }
        ],
        "productSummary": [
          {
            "lang": "EN",
            "text": "Men's Nike Roshe G Golf Shoe features a pressure-mapped outsole that provides traction in key zones. Inspired by a Nike icon, the mesh upper offers breathability and a modern look, while the soft, flexible, foam midsole cushions every step."
          }
        ],
        "fabricContent": [
          {
            "lang": "EN",
            "text": ""
          }
        ],
        "features": [
          {
            "lang": "EN",
            "text": "Pressure-mapped outsole provides traction in key zones."
          },
          {
            "lang": "EN",
            "text": "Iconic mesh upper delivers breathability and style."
          },
          {
            "lang": "EN",
            "text": "Injected midsole delivers soft, lightweight cushioning."
          },
          {
            "lang": "EN",
            "text": "Elastic gusset on the tongue helps keep out debris."
          },
          {
            "lang": "EN",
            "text": "Pull tabs on the heel and tongue offer easy on and off."
          },
          {
            "lang": "EN",
            "text": "Cupsole-like design offers flexible, low-profile support and a stable feel."
          }
        ],
        "allFeatures": [
          {
            "lang": "EN",
            "text": "Pressure-mapped outsole provides traction in key zones. Iconic mesh upper delivers breathability and style. Injected midsole delivers soft, lightweight cushioning. Elastic gusset on the tongue helps keep out debris. Pull tabs on the heel and tongue offer easy on and off. Cupsole-like design offers flexible, low-profile support and a stable feel."
          }
        ]
      },
      "athlete": {
        "firstName": "JANE",
        "lastName": "DOE"
      },
      "offerDates": {
        "productFirstOffer": 20180201,
        "productLastOffer": 20190331,
        "productFutureLastOffer": 20190319
      },
      "marketingType": {
        "desc": "IN-LINE"
      },
      "carryOver": "N",
      "launchData": {
        "coordinatedDescription": "BRAND INITIATIVES"
      }
    },
    {
      "season": {
        "year": 2018,
        "name": "SPRING"
      },
      "styleColorNumber": "AA1837-401",
      "sizeRange": "7-12, 13, 14, 15",
      "styleNumber": "AA1837",
      "primaryPlatform": "FOAM - INJECTION UNITSOLE",
      "color": {
        "code": 401,
        "longDescription": [
          {
            "lang": "EN",
            "text": "THUNDER RED/WHITE"
          }
        ]
      },
      "primaryColor": "RED",
      "category": {
        "desc": "GOLF"
      },
      "categoryCoreFocus": {
        "desc": "NIKE GOLF"
      },
      "silhouette": {
        "desc": "LOW TOP"
      },
      "silhouetteType": {
        "desc": "SHOE"
      },
      "genderAge": {
        "code": 18,
        "desc": "MENS"
      },
      "unitOfMeasure": {
        "code": "PR",
        "desc": "PAIR"
      },
      "sizes": [
        {
          "us": "8",
          "jp": "26",
          "kr": "260",
          "uk": "7",
          "upc_gtin": "00888411976035",
          "sortOrder": "17"
        },
        {
          "us": "11.5",
          "jp": "29.5",
          "kr": "295",
          "uk": "10.5",
          "upc_gtin": "00888411976103",
          "sortOrder": "24"
        },
        {
          "us": "7.5",
          "jp": "25.5",
          "kr": "255",
          "uk": "6.5",
          "upc_gtin": "00888411976028",
          "sortOrder": "16"
        },
        {
          "us": "11",
          "jp": "29",
          "kr": "290",
          "uk": "10",
          "upc_gtin": "00888411976097",
          "sortOrder": "23"
        },
        {
          "us": "7",
          "jp": "25",
          "kr": "250",
          "uk": "6",
          "upc_gtin": "00888411976011",
          "sortOrder": "15"
        },
        {
          "us": "10.5",
          "jp": "28.5",
          "kr": "285",
          "uk": "9.5",
          "upc_gtin": "00888411976080",
          "sortOrder": "22"
        },
        {
          "us": "10",
          "jp": "28",
          "kr": "280",
          "uk": "9",
          "upc_gtin": "00888411976073",
          "sortOrder": "21"
        },
        {
          "us": "14",
          "jp": "32",
          "kr": "320",
          "uk": "13",
          "upc_gtin": "00888411976134",
          "sortOrder": "29"
        },
        {
          "us": "9.5",
          "jp": "27.5",
          "kr": "275",
          "uk": "8.5",
          "upc_gtin": "00888411976066",
          "sortOrder": "20"
        },
        {
          "us": "13",
          "jp": "31",
          "kr": "310",
          "uk": "12",
          "upc_gtin": "00888411976127",
          "sortOrder": "27"
        },
        {
          "us": "9",
          "jp": "27",
          "kr": "270",
          "uk": "8",
          "upc_gtin": "00888411976059",
          "sortOrder": "19"
        },
        {
          "us": "12",
          "jp": "30",
          "kr": "300",
          "uk": "11",
          "upc_gtin": "00888411976110",
          "sortOrder": "25"
        },
        {
          "us": "8.5",
          "jp": "26.5",
          "kr": "265",
          "uk": "7.5",
          "upc_gtin": "00888411976042",
          "sortOrder": "18"
        }
      ],
      "prices": [
        {
          "wholesale": {
            "currency": "USD",
            "price": 49,
            "effectiveDates": {
              "begin": 20180101
            }
          },
          "retail": {
            "currency": "USD",
            "price": 80,
            "effectiveDates": {
              "begin": 20180101
            }
          }
        }
      ],
      "names": {
        "systemStyleName": {
          "lang": "EN",
          "text": "ROSHE G"
        },
        "consumerStyleName": {
          "lang": "EN",
          "text": "Men's Nike Roshe G Golf Shoe Secondary Tertiary"
        }
      },
      "division": {
        "desc": "FOOTWEAR DIVISION"
      },
      "commercialCopy": {
        "reasonToBuy": [
          {
            "lang": "EN",
            "text": "ICONIC DESIGN. LASTING COMFORT."
          }
        ],
        "productSummary": [
          {
            "lang": "EN",
            "text": "Men's Nike Roshe G Golf Shoe features a pressure-mapped outsole that provides traction in key zones. Inspired by a Nike icon, the mesh upper offers breathability and a modern look, while the soft, flexible, foam midsole cushions every step."
          }
        ],
        "fabricContent": [
          {
            "lang": "EN",
            "text": ""
          }
        ],
        "features": [
          [
            {
              "lang": "EN",
              "text": "Pressure-mapped outsole provides traction in key zones."
            }
          ],
          [
            {
              "lang": "EN",
              "text": "Iconic mesh upper delivers breathability and style."
            }
          ],
          [
            {
              "lang": "EN",
              "text": "Injected midsole delivers soft, lightweight cushioning."
            }
          ],
          [
            {
              "lang": "EN",
              "text": "Elastic gusset on the tongue helps keep out debris."
            }
          ],
          [
            {
              "lang": "EN",
              "text": "Pull tabs on the heel and tongue offer easy on and off."
            }
          ],
          [
            {
              "lang": "EN",
              "text": "Cupsole-like design offers flexible, low-profile support and a stable feel."
            }
          ]
        ],
        "allFeatures": [
          {
            "lang": "EN",
            "text": "Pressure-mapped outsole provides traction in key zones. Iconic mesh upper delivers breathability and style. Injected midsole delivers soft, lightweight cushioning. Elastic gusset on the tongue helps keep out debris. Pull tabs on the heel and tongue offer easy on and off. Cupsole-like design offers flexible, low-profile support and a stable feel."
          }
        ]
      },
      "athlete": {
        "firstName": "JANE",
        "lastName": "DOE"
      },
      "offerDates": {
        "productFirstOffer": 20180201,
        "productLastOffer": 20190331,
        "productFutureLastOffer": 20190319
      },
      "marketingType": {
        "desc": "IN-LINE"
      },
      "carryOver": "Y",
      "launchData": {
        "coordinatedDescription": "BRAND INITIATIVES"
      }
    }
  ],
  "errors": [
    {
      "code": "NOT_FOUND",
      "message": "The following product codes were not found:",
      "metadata": {
        "field": "productCodes",
        "value": [
          "AA1837-403",
          "AA1837-402"
        ]
      }
    }
  ]
}
```

**400 Bad Request (Invalid Season Code)**

```
{
  "code": "BAD REQUEST - Invalid Season",
  "message": "INVALID_SEASON"
}
```

**401 Unauthorized**

```
{
  "message": "Unauthorized"
}
```

**404 Not Found (Invalid Product Code)**

```
{
  "code": "NOT_FOUND",
  "message": "NOT FOUND"
}
```

## Document Change Log

|Summary|Date|
|---|---|
|Initial publish|03/11/2020|