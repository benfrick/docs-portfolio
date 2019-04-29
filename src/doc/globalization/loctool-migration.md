---
tags: pdf
category: b-use-case
position: 10
title: Localization Tool Migration
url: /doc/globalization/loctool-migration.html
toc:
  - h2: Localization Tool vs. Bodega Comparison
    url: /doc/globalization/loctool-migration.html#localization-tool-vs-bodega-comparison
  - h2: Migration Steps
    url: /doc/globalization/loctool-migration.html#migration-steps
  - h2: Common Questions
    url: /doc/globalization/loctool-migration.html#common-questions
  - h2: Best Practices
    url: /doc/globalization/loctool-migration.html#best-practices
  - h2: Troubleshooting
    url: /doc/globalization/loctool-migration.html#troubleshooting
  - h2: Terms of Service
    url: /doc/globalization/loctool-migration.html#terms-of-service
  - h2: Contacting the Team
    url: /doc/globalization/loctool-migration.html#contacting-the-team
  - h2: Glossary
    url: /doc/globalization/loctool-migration.html#glossary
  - h2: Document Change Log
    url: /doc/globalization/loctool-migration.html#document-change-log
  - h2: Next Steps
    url: /doc/globalization/loctool-migration.html#next-steps
---
<a href="{{ page.url | replace: '.html','.pdf'}}" target="blank" class="ncss-btn-secondary-grey guide-button"><i class="fas fa-arrow-alt-circle-right"></i> DOWNLOAD</a>

# LOCALIZATION TOOL MIGRATION - DRAFT

---

##### Last Updated: 4/25/2019

If you are a current [Localization Tool](http://loctool.nikecloud.com){:target="new-tab"} (LocTool) user or call the [LocTool REST API](https://developer.niketech.com/docs/projects/Localization%20Tool?tab=api){:target="new-tab"}, use this guide to help you migrate your string data to the Bodega Tool (**Need link to tool**).

The legacy LocTool

- allows Globalization teams to manage translation requests
- is used by external translation vendors to submit completed translations
- grants CMS, web, and mobile apps access to translated strings and formatted data through Cloud-based APIs

Bodega is replacing the LocTool and migration completion for all teams is expected by Q2 2020.

## LocTool vs. Bodega: Comparison

Read on to discover the advantages of migrating to Bodega.

**Robust filtering**

What new filtering is offered?

**Notification**

What notifications are offered?

**Enforces context**

You can now attach screenshots to a translation request to provide immediate context for the translator as to where and how the translation will be used. This allows the translator to remain within Bodega and avoids requiring that the translator have access to the page when following a URL for context. (**Can you still provide a URL for context in Bodega?**)

**Enforces best practices**

What best practices are enforced and how is this done?

**Auditing**

What can be audited? How does this differ from the LocTool auditing?


## How to Migrate Your Data

Follow these steps to migrate your data from the LocTool to Bodega.

### Step 1: Remove obsolete strings from the LocTool

To minimize the amount of string data to migrate, your team kicks off the migration process by removing unused strings from your team projects in the LocTool.

### Step 2: Begin the migration process

Once your team has removed all unused strings from the LocTool in  **Step 1**, notify the [Globalization Engineering team](#contacting-the-team) that you are ready to  migrate your data. You will be asked to attend a Globalization Engineering office hour (**is this for Bodega training?**) and schedule your migration date. Optimally, you will have no outstanding translation requests in the LocTool on migration day. **What happens if there are?**

### Step 3: Get set up in Bodega

Contact the [Globalization Engineering team](#contacting-the-team) to set up your team object (similar to a workspace in the LocTool) and your nodes (similar to projects in the LocTool) and define your metadata (**what metadata?**) in Bodega. The Globalization team will also configure permissions in Bodega for your team. (**Will read access be the Bodega default, just like in the LocTool?**)

**What metadata information does the consumer team need to provide?**

### Step 4: Complete Bodega training

**How does one do this? Is there a training guide within the tool or elsewhere? How long does it take to complete training?**

### Step 5: Migrate the data

The Globalization Engineering team will perform string migration from the LocTool to Bodega for you on the scheduled day. After the data migration is complete, the Globalization Engineering team will

- notify your team that the migration is complete
- provide your team with a link to your Team object in Bodega
- give your team a new API endpoint from which to retrieve your strings

>**TIP**: Once your data is migrated from the LocTool to Bodega, you will no longer use the LocTool.  Perform all of your future string management in Bodega.

#### About data migration

- pseudo-strings will be regenerated rather than migrated

- certain keys will not be moved **what are examples of these?**

- LocTool languages may differ from Atlas languages **provide mapping?**

- LocTool project metadata will not be migrated. It will be recreated in Bodega by the Globalization Engineering team upon Team object setup in **Step 3**.

- LocTool team permissions will not be migrated. They will be recreated in Bodega by the Globalization Engineering team in **Step 3**.

- **will string-level history be migrated (because it is Okta-protected and need to perform string key - db id conversion)?**

### Step 6: Verify all of your data was migrated

Go to your team object in Bodega and verify that your strings have been migrated to the proper node(s).

### Step 7: Use the new Bodega endpoint

Change your code to use the Bodega endpoint provided by the Globalization Engineering team in **Step 5**. Discontinue using the LocTool endpoint.

## Common Questions

**How long does the Migration process take?**

**How do I get trained?**

**When and where are Globalization Engineering office hours?**

**How do I get Bodega permissions set up for my team?**

**What string formats are supported in Bodega?**


## Contacting the Team

Need to contact the Globalization team?

|---|---|
|Slack|[#Globalization](https://nikedigital.slack.com/messages/CBSEHUK1N){:target="new-tab"}|
|Confluence Space|[Globalization](https://confluence.nike.com/display/G11N/Capability+Development){:target="new-tab"}|
|Product Manager|[Robert Heinz](mailto:robert.heinz@nike.com)|

## Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft 04/30/2019|Initial Draft|

## Next Steps

You've learned how to migrate your data from the LocTool to Bodega. Here are some links you might want to visit next.

- [Bodega]() **Need Link**
