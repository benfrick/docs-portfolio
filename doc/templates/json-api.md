---
id: json-api
title: JSON API Contract Template
url: /doc/templates/json-api.html
---

# {{ page.title }}

---
```
FORMAT: 1A

# Service Name

Provide a brief overview of the service and the business/technical problems it solves. Assume readers do not work on your team and provide more context than you think you might need, especially if the service name is not descriptive or straight-forward.

Link to the High-Level-Diagram if relevant.

## API Documentation

Provide links to supplemental documentation about the service on [Commerce Docs](https://nde-devportal-docs.niketech.com/index.html), your team's documentation site, Confluence or wherever your documentation resides.

## Prerequisites

Describe what integrators must do before calling this service such as getting an appId. Link to other APIs on the [Developer Portal](https://console.platforms.nike.com/developer/docs/projects/devportal?tab=api) that integrators must call first.

## Error Codes

Provide a list of error codes, error messages, a description of what each error means and how the caller can correct it.

| Error Code|Error Message|Description|
|---|---|---|
|INVALID_FIELD|"FIRST_NAME" is invalid |Correct the field value indicated in the error message and try the request again|

## Headers

List the required and optional request headers for all endpoints and what they are used for. Provide sample values. Some are listed below.

* upmid: 1234567890 (optional)

  Apigee sets the upmid (customer identifier) header and passes it through for registered members.
  Service-to-service calls should pass this value in the request.

* appId: com.nike.commerce.x.x

  Provide the list of possible values if known

* Authorization: Bearer Awy3atJg4ZbxaVbwtQOVtwFoIB4v

  Authorization header with the 'Bearer' token (JWT). The token identifies and authorizes systems to call to this API.

## Service Name

Describe the type of requests that this group of APIs is used for. List all endpoints. Within each endpoint section, include parameters, sample request, request schema, response, response schema.

### Endpoint name [PUT /xxx/xxx/xxx/{id}] 

List parameters, headers, and a sample request

+ Parameters

    + id - Client-provide ID (UUID) for the Request

+ Request

    + Headers

            upmid: 123456 (string, optional) - Nike registration profile id
            appId: com.nike.commerce.xxx.xxx
            Authorization: Bearer TD1fficQ9LRQWsg4v8L9wDU3BGDd
            Content-Type: application/json; charset=UTF-8
            Accept: application/json; charset=UTF-8

    + Body

    Sample JSON request body

    + JSON Schema
    
+ Response 202 PENDING (application/json; charset=UTF-8) 

    + Headers

            Location: URL

    + Body

            {
              "id": "ae6575a7-8c0e-44ef-b91b-440bdaf2070b",
              "status": "PENDING",
              "eta": 5000,
              "resourceType": "job",
              "links": {
                "self": {
                  "ref": "URL"
                }
              }
            }

    + Schema

            {
              "$schema": "http://json-schema.org/draft-04/schema#",
              "type": "object",
              "properties": {
                "id": {
                  "type": "string",
                  "description": "Job description"
                },
                "status": {
                  "id": "http://jsonschema.net/code",
                  "type": "string",
                  "pattern": "^[A-Z_\\d]+$",
                  "enum": [
                    "PENDING",
                    "IN_PROGRESS",
                    "COMPLETED"
                  ],
                  "description": "Job status"
                },
                "eta": {
                  "type": "number",
                  "description": "Number of milliseconds which should be waiting before the status is requested again."
                },
                "resourceType": {
                  "type": "string",
                  "description": "The type of resource the document is modeling.  This resource is a job.",
                  "enum": [
                    "job"
                  ]
                },
                "links": {
                  "type": "object",
                  "description": "Collection of links to related resources.",
                  "properties": {
                    "self": {
                      "type": "object",
                      "description": "Link to this resource, itself.",
                      "properties": {
                        "ref": {
                          "type": "string"
                        }
                      },
                      "required": [
                        "ref"
                      ]
                    },
                    "result": {
                      "type": "object",
                      "description": "Link to results of this job.",
                      "properties": {
                        "ref": {
                          "type": "string"
                        }
                      },
                      "required": [
                        "ref"
                      ]
                    }
                  }
                }
              },
              "required": [
                "id",
                "status",
                "eta",
                "resourceType",
                "links"
              ]
            }

+ Response 400 (application/json; charset=UTF-8)

    + Body

            {
              "message": "Validation Failed",
              "errors": [{
                "field": "request.orderNumber",
                "code": "MISSING_REQUIRED",
                "message": "xxx is a required field"
              }, {
                "field": "request.priceInfo.price",
                "code": "INVALID_FIELD",
                "message": "xxx.xxx.xxx is invalid"
              }]
            }

    + Schema

            {
              "$schema": "http://json-schema.org/draft-04/schema#",
              "type": "object",
              "properties": {
                "message": {
                  "type": "string",
                  "description": "error message"
                },
                "errors": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "properties": {
                      "field": {
                        "type": "string",
                        "description": "field name causing the validation error."
                      },
                      "code": {
                        "type": "string",
                        "description": "specific error code",
                        "enum": [
                          "MISSING_REQUIRED",
                          "INVALID_FIELD",
                          "INVALID_JSON"
                        ]
                      },
                      "message": {
                        "type": "string",
                        "description": " error message"
                      }
                    },
                    "required": [
                      "code",
                      "message"
                    ]
                  }
                }
              },
              "required": [
                "message",
                "errors"
              ]
            }

+ Response 401

+ Response 403

+ Response 405

+ Response 406

+ Response 429

+ Response 500

+ Response 503

### Endpoint name [GET /xxx/xxx/xxx/{id}]

+ Parameters

    + id - same ID passed into the job request PUT.

+ Response 200 (application/json; charset=UTF-8)

    + Body

    Sample JSON response body

    + Schema

    JSON schema

+ Response 401

+ Response 403

+ Response 404

+ Response 405

+ Response 406

+ Response 500

+ Response 503

## Results [url]

### Results [GET]

This service retrieves the results of the service by ID.

+ Parameters
    + id - ID for the request. This is the same ID passed in to the request PUT.

+ Request

    + Headers

            AppId: xxx
            Authorization: Bearer TD1fficQ9LRQWsg4v8L9wDU3BGDd

+ Response 200 (application/json; charset=UTF-8)

    + Body

    Sample JSON response body

    + Schema
    
    JSON schema

+ Response 401

+ Response 403

+ Response 404

+ Response 405

+ Response 406

+ Response 500

+ Response 503
```