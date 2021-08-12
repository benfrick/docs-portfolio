---
id: json-api
title: YAML API Contract Template
url: /doc/templates/yaml-api.html
---

# {{ page.title }}

---
```
info:
  title: "API Name"
  description: Provide a brief overview of the service and the business/technical problems it solves. Assume readers do not work on your team and provide more context than you think you might need, especially if the service name is not descriptive or straight-forward. 
  hld: "Link to the High-Level-Diagram if relevant."
  version: "API version number"
  productionurl: "e.g. https://api.nike.com/"
  testurl: ""
  contact:
    name: "Slack channel"
    url: "Confluence site URL"
    email: "Team email address"
  externaldocs: "Provide links to supplemental documentation about the service on https://nde-devportal-docs.niketech.com/index.html, your team's documentation site, Confluence or wherever your documentation resides."
  prerequisites: "Describe what integrators must do before calling this service such as getting an appId. Link to other APIs on https://developer.niketech.com/docs/projects/devportal?tab=api that integrators must call first."

endpoint:
  /xxx/xxx/xxx/{id}:
    put:
      tags:
      - name of endpoint
      summary: "Short summary of why clients should call this endpoint."
      description: "Longer description of this endpoint."
      prerequisites: "Include details about what clients must do before calling this endpoint."

# List the required and optional request headers for all endpoints and what they are used for. Provide sample values. Some are listed below.
      headers:
        upmid: "123456 (string, optional) - Nike registration profile id"
        appId: "com.nike.commerce.xxx.xxx"
        authorization: "Bearer TD1fficQ9LRQWsg4v8L9wDU3BGDd"
        content-type: "application/json; charset=UTF-8"
        accept: "application/json; charset=UTF-8"

      parameters:
        id: upmid

      body: "sample request body details go here"

# Provide a list of error codes, error messages, a description of what each error means and how the caller can correct it.
      errors:
        error:
          field: FIELD_NAME
          code: INVALID_FIELD
          message: FIELD_NAME is invalid
        error:
          field: FIELD_NAME
          code: INVALID_REQUIRED
          message: FIELD_NAME cannot be null
      
      responses:
        "202":
          description: successful response
          content:
            application/json; charset=UTF-8;
            id: ae6575a7-8c0e-44ef-b91b-440bdaf2070b
            status: PENDING
            eta: 5000
            resourceType: job
            links:
              self:
                ref: URL 
        "404":
          description": not found error response
          content:
            application/json; charset=UTF-8;
            message: Validation Failed
            errors:
              - field: request.orderNumber
                code: MISSING_REQUIRED
                message: xxx is a required field
              - field: request.priceInfo.price
                code: INVALID_FIELD
                message: xxx.xxx.xxx is invalid      
schemas:
  "202":
  title: successful response
  type: object
  properties:
    id:
      type: string
      description: Job description
    status:
      id: http://jsonschema.net/code
      type: string
      pattern: "^[A-Z_\\d]#$"
      enum:
      - PENDING
      - IN_PROGRESS
      - COMPLETED
      description: Job status
    eta:
      type: number
      description: Number of milliseconds which should be waiting before the status is requested again.
    resourceType:
      type: string
      description: The type of resource the document is modeling.  This resource is a job.
      enum:
      - job
    links:
      type: object
      description: Collection of links to related resources.
      properties:
        self:
          type: object
          description: Link to this resource, itself.
          properties:
            ref:
              type: string
          required:
          - ref
        result:
          type: object
          description: Link to results of this job.
          properties:
            ref:
              type: string
          required:
          - ref
  required:
  - id
  - status
  - eta
  - resourceType
  - links

"404":
  type: object
  properties:
    message:
      type: string
      description: error message
    errors:
      type: array
       items:
        type: object
        properties:
          field:
            type: string
            description: field name causing the validation error.
          code:
            type: string
            description: specific error code
            enum:
            - MISSING_REQUIRED
            - INVALID_FIELD
            - INVALID_JSON
          message:
            type: string
            description: " error message"
        required:
        - code
        - message
  required:
  - message
  - errors

  "401":
    title: 
    type: object
    properties:

  "403":
    title: 
    type: object
    properties:

  "405":
    title: 
    type: object
    properties:

  "406":
    title: 
    type: object
    properties:

  "429":
    title: 
    type: object
    properties:

  "500":
    title: 
    type: object
    properties:

  "503":
    title: 
    type: object
    properties:
```