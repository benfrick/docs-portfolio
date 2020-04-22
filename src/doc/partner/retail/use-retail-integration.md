---
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="new-tab" class="ncss-btn-secondary-grey guide-button float"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# NIKE PARTNERS: USING RETAIL INTEGRATION

---

##### Last Updated: 04/21/2020

Integrate your retail POS system with Nike's Retail Integration System to publish sales and returns data.

## Introduction

The Retail Integration System features real-time communication to Nike via cloud-based APIs to submit sales & returns data from your POS system. Here is a summary of the process:

- Send an API request to Nike with POS sales and returns data which conforms to Nike's POSlog JSON format.

|Data Format|JSON|
|URL (Development)|https://?/store/ingest/v1| 
|URL (Production)|https://partners.nike.com/store/ingest/v1|
|When|Real-time|

## Key Terms

Here are some important terms used in this guide.

|Term|Definition|
|---|---|
|||

## Prerequisites

### Authorization

### Encryption

## Send Sales and Returns Data to Nike

Send POS sales and returns data to Nike's Retail Integration endpoint in real-time.

## API Reference

### Transaction Header

Each POS transaction must have a transaction header in the following format:

```json
{
  "Transaction": {
    "BusinessUnit": {
      "UnitID": {
        "type": "string"
      },
      "Brand": {
        "type": "string"
      },
      "Country": {
        "type": "string"
      },
      "LocationType": {
        "type": "string"
      },
      "LocationCode": {
        "type": "string"
      }
    },
    "Workstation": {
      "ID": {
        "type": "string"
      },
      "TypeCode": {
        "type": "string"
      }
    },
    "CurrencyCode": {
      "type": "string"
    },
    "SequenceNumber": {
      "type": "integer"
    },
    "Operator": {
      "ID": {
        "type": "string"
      }
    },
    "TrainingModeFlag": {
      "type": "boolean"
    },
    "OfflineFlag": {
      "type": "boolean"
    },
    "TillID": {
      "type": "string"
    },
    "BusinessDayDate": {
      "type": "date"
    },
    "BeginDateTime": {
      "type": "dateTime"
    },
    "EndDateTime": {
      "type": "dateTime"
    }
  }
}
```

### Item Sale

A POS transaction can have one or more line items, representing the following types of activities: 

- Sales
- Returns
- Sales for pickup
- Sales for delivery
- Stored value fund
- Taxes
- Tenders
- Tender Changes
    
The sale line item must be added for all merchandise items (Nike products) and non-merchandise items (gift box, gift card, additional shipping fees, product supplies, race fees).

```json
{
  "RetailTransaction": {
    "LineItems": [
      {
        "EntryMethod": {
          "type": "string: EntryMethodEnumeration"
        },
        "VoidFlag": {
          "type": "boolean"
        },
        "Coupon": {
          "ID": {
            "type": "string"
          }
        },
        "SequenceNumber": {
          "type": "integer"
        },
        "ScanData": [
          {
            "Data": {
              "type": "string"
            }
          }
        ],
        "BeginDateTime": {
          "type": "dateTime"
        },
        "EndDateTime": {
          "type": "dateTime"
        },
        "RepairID": {
          "type": "string"
        },
        "Sale": {
          "SerialNumbers": [
            {
              "ID": {
                "type": "string"
              }
            }
          ],
          "Associates": [
            {
              "ID": {
                "type": "string"
              }
            }
          ],
          "ItemType": {
            "type": "string: RetailTransactionItemTypeEnumeration"
          },
          "Item": {
            "ID": {
              "type": "string: ItemLookup"
            },
            "Type": {
              "type": "string"
            }
          },
          "Descriptions": [
            {
              "Text": {
                "type": "string"
                :
                "Item Lookup"
              },
              "TypeCode": {
                "type": "string"
              }
            }
          ],
          "RegularSalesUnitPrice": {
            "Amount": {
              "type": "decimal"
            }
          }
        },
        "ActualSalesUnitPrice": {
          "Amount": {
            "type": "decimal"
          }
        },
        "ExtendedAmount": {
          "Amount": {
            "type": "decimal"
          }
        },
        "Quantity": {
          "Quantity": {
            "type": "long"
          }
        },
        "Taxes": [
          {
            "TaxType": {
              "type": "string: TaxTypeCodeEnumeration"
            },
            "VoidFlag": {
              "type": "boolean"
            },
            "TaxAuthority": {
              "type": "string"
            },
            "TaxableAmount": {
              "Amount": {
                "type": "decimal"
              }
            },
            "Amount": {
              "Amount": {
                "type": "decimal"
              }
            },
            "Percent": {
              "type": "decimal"
            },
            "TaxGroupID": {
              "type": "string"
            },
            "TaxJurisdictionID": {
              "type": "string"
            }
          }
        ],
        "eCommerceID": {
          "type": "string"
        },
        "GiftReceiptFlag": {
          "type": "boolean"
        },
        "ItemNotOnFileFlag": {
          "type": "boolean"
        },
        "RetailPriceModifiers": [
          {
            "VoidFlag": {
              "type": "boolean"
            },
            "MethodCode": {
              "type": "string"
            },
            "SequenceNumber": {
              "type": "integer"
            },
            "Amount": {
              "Action": {
                "type": "string"
              },
              "Amount": {
                "type": "decimal"
              }
            },
            "PromotionID": {
              "type": "string"
            },
            "Coupon": {
              "ScanCode": {
                "type": "string"
              }
            },
            "PreviousPrice": {
              "Amount": {
                "type": "decimal"
              }
            },
            "NewPrice": {
              "Amount": {
                "type": "decimal"
              }
            },
            "Reason": {
              "Code": {
                "type": "string"
              },
              "Description": {
                "type": "string"
              },
              "Name": {
                "type": "string"
              }
            },
            "Descriptions": [
              {
                "Text": {
                  "type": "string: DiscountReasonsLookup"
                }
              }
            ],
            "Employee": {
              "ID": {
                "type": "string"
              }
            }
          }
        ]
      }
    ]
  }
}
```
