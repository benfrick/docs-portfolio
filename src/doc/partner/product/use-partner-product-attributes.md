---
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="new-tab" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# NIKE PARTNERS - ADDING PRODUCT ATTRIBUTES TO YOUR EXPERIENCE <i class="g72-swoosh"></i><br>DRAFT

---

##### Last Updated: 03/05/2020

Get Nike product attributes like sizes, prices, features, marketing copy and more by using the [Product Attributes API](#api-reference).

## Introduction

In this guide, we will step through how to use the Product Attributes API to get detailed product data into your app or experience.

[(Screenshot of example experience?)]

Let's say that you have a list of Nike style-color codes (that you from the [Offering API]() or otherwise) and you want get more details about each of them. Just execute a cURL command like:

```
cURL goes here
```

For each style-color that you send, you will get its corresponding attributes like:

[List of juicy attributes from the response]

The Product Attributes API is designed to be used in tandem with the Offerings and Images APIs as follows:

[(Diagram showing context of using this API with Offerings and Images)]

## Key Terms

Here are some important terms that are used in this guide.

###### Table 1: List of Terms Related to Product Attributes

|Term|Definition|
|---|---|
|Offering|A collection of Nike style-color codes provided by the [Offering API]() or obtained otherwise.|
|Product Attributes|The set of metadata for a given Nike product code, e.g. sizes, prices, gender, silhouette.|
|Product Code|The combined Nike style and color codes, e.g. `654321-101`. Also known as style-color code.|
|Region|The Nike geographical region name, e.g. `CHINA`.|
|Season|The Nike season year code, e.g. `SP2020` or `FA2021`.|

## Prerequisites

**Authorization**

Complete all the steps in [Nike Partners - Adding Authentication to your Experience](../authentication/use-partner-authentication.html) before you can add Product Attributes to your app/experience.

## Get Product Attributes

<i class="g72-check"></i>&nbsp;&nbsp;**Get product attributes for one or more Nike product codes**

After completing all of the action items in the [prerequisites](#prerequisites) section, you are ready to add Nike Product Attributes to your app or experience.

### Step 1: Gather the Required Data

One or more product codes (from [Offering API]() or otherwise)
Region code
Season-year

### Step 2: Make the API Request to Product Attributes

If one product code, call the single endpoint.

```
cURL
```

If more than one product codes, call the multiple endpoint.

```
cURL
```

### Step 3: Parse the Response

Parse the response body to get the attributes that you need.

See [API Reference](#api-reference) for details of the response body.

## API Endpoint Quick Reference

**Product Attributes**

- [Get Product Attributes for a Single Product]() **GET**
- [Get Product Attributes for Multiple Products]() **GET**

## Troubleshooting

### Common Questions

**What if this bad thing happens?**

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

|Season Code|Description|
|---|---|
|`SP`|Spring|
|`SU`|Summer|
|`FA`|Fall|
|`HO`|Holiday|

Then, add the year, like `SP` + `2022` = `SP2022`.

Example values for `season` (in no particular sequence):

- `FA2021`
- `HO2022`
- `SP2023`
- etc...

**RESPONSE**

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

Retrieve product attributes for multiple products, when you provide `productCodes`, `region`, and `season` as query parameters.

**REQUEST**

**Endpoint**

GET https://product.api.nike.net/product/v1/{region}/{season}

**Headers**

`Content-Type:application/json`

**Query Parameters**

The following query parameters are required in the request URI:

|Field Name|Description|Example|
|---|---|---|
|`productCodes`|Comma-separated list of Nike product codes|AA1837-400,654321-100|
|`region`|Nike region name|CHINA|
|`season`|Nike season year|SP2020|

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
|Initial publish|03/05/2020|