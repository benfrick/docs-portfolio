---
tags: pdf
#category: b-use-case
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
{% include dev-header.html %}

# LOCALIZATION TOOL MIGRATION - DRAFT

---

##### Last Updated: 6/25/2019

If you are a current [Localization Tool](http://loctool.nikecloud.com){:target="new-tab"} (LocTool) user or call the [LocTool REST API](https://developer.niketech.com/docs/projects/Localization%20Tool?tab=api){:target="new-tab"}, use this guide to help you migrate your string data to the new Bodega string store tool. <!--Need link to tool**-->

The new Bodega string store tool:

- Allows Globalization teams to manage translation requests
- Is used by external translation vendors to submit completed translations
- Grants CMS, web, and mobile apps access to translated strings and formatted data through Cloud-based APIs **at build time**

Bodega is replacing the LocTool and migration completion for all teams is expected by Q2 2020.

## Bodega Advantages

Read on to discover the advantages of migrating from the LocTool to Bodega.

**Robust filtering**

<!--What new filtering is offered?-->

**Flexible job notification**

In your translation request using the Bodega API, you can tell Bodega who to notify and how you want to be notified when your translation job is complete. You can be notified via Slack, at a URL, and email.

**Enforces context**

You can now attach screenshots to a translation request to provide immediate context for the translator as to where and how the translation will be used. This allows the translator to remain within Bodega and avoids requiring that the translator have access to the page when following a context URL. But don't worry. You can still provide a URL for context if you prefer.

**Enforces best practices**

Bodega enforces Globalization best practices by separating strings, configurations, URLs, fonts, and screenshots.

**Improved Auditing**

<!--What can be audited? How does this differ from LocTool auditing?-->


## Migrate Your Data

Now that you know the advantages of Bodega, follow these steps to migrate your strings from the legacy LocTool to the Bodega string store.


|What needs to be done?|Who does it?|
|---|---|---|
|<i class="numberCircle green">1</i> Attend Bodega office hours|Consumer Team|
|<i class="numberCircle green">2</i> Clean up LocTool strings|Consumer Team|
|<i class="numberCircle green">3</i> Complete Bodega training|Consumer Team|
|<i class="numberCircle green">4</i> Determine your Bodega project structure and set up your project in the Bodega test environment|Consumer Team/Operations and Engineering Team|
|<i class="numberCircle green">5</i> Migrate and QA in the Bodega test environment|Consumer Team/Operations and Engineering Team|
|<i class="numberCircle green">6</i> Set up your project in the Bodega production environment|Consumer Team/Operations and Engineering Team|
|<i class="numberCircle green">7</i> Migrate and QA in the Bodega production environment|Consumer Team/Operations and Engineering Team|
|<i class="numberCircle green">8</i> Use the new Bodega production endpoint|Consumer Team|

### 1: Attend Bodega office hours

Reach out to the Globalization Product Manager [Robert Heinz](mailto:robert.heinz@nike.com) to schedule your office hours.

At the meeting, you can expect to identify your current LocTool projects and schedule your production migration date.

### 2: Clean up LocTool strings

To minimize the amount of string data to migrate, it is recommended that your team removes unused strings from your team projects in the LocTool.

### 3: Complete Bodega training

Learn how to use the Bodega string store tool and APIs. Familiarize your team with Globalization best practices.

<!--How does one do this? Is there a training guide within the tool or elsewhere? Is it done ad hoc between consumer/Bodega team?-->

### 4. Determine your Bodega project structure and set up your project in the Bodega test environment

Contact the [Bodega Operations and Engineering Team](#contacting-the-team) to:

 - Help your team determine a project structure that best fits your team's needs
 - Set up your team object (similar to a workspace in the LocTool), your nodes (similar to projects in the LocTool), and define your metadata <!--what metadata?-->
 - Configure permissions for your team in test Bodega
 - Provide your team with the URL to your team's project in test Bodega
 - Provide your team with the new API test endpoint from which to retrieve your strings

### 5: Migrate and QA in the Bodega test environment

The [Bodega Operations and Engineering Team](#contacting-the-team) will migrate your data from the LocTool to the Bodega test environment. They will notify your team when this step is complete.

After your team is notified of a successful data migration to the test environment, your team needs to:
- Configure your app/experience to point to the test Bodega string retrieval API
- Create and execute your QA plan using the Bodega API test endpoint
- QA your project data in the Bodega UI in the test environment

### 6. Set up your project in the Bodega production environment

Once your team has verified that your data was successfully migrated to Bodega test environment, contact the [Bodega Operations and Engineering Team](#contacting-the-team) to:

- Set up your team object, nodes, and metadata in the Bodega production environment
- Configure permissions for your team in the Bodega production environment
- Provide your team with the URL to your team's project in the Bodega production environment
- Provide your team with the new API endpoint in the production Bodega environment from which to retrieve your strings

### 7: Migrate and QA in the Bodega production environment

The [Bodega Operations and Engineering Team](#contacting-the-team) will migrate your data from the LocTool to the Bodega production environment on the previously scheduled day. They will notify your team when this step is complete.

>**TIP**: Once your data is migrated from the LocTool to Bodega, you will no longer use the LocTool.  Perform all of your future string management in Bodega.

After your team is notified of a successful data migration to the Bodega production environment, your team needs to:
- Configure your test app/experience to point to the production Bodega string retrieval API
- Create and execute your QA plan using the Bodega API production endpoint
- QA your project data in the Bodega UI in the production environment

#### Facts about data migration

- pseudo-strings will be regenerated rather than migrated

- certain keys will not be moved **what are examples of these?**

- LocTool languages may differ from Atlas languages **provide mapping?**

- LocTool project metadata will not be migrated. It will be recreated in Bodega by the Globalization Engineering team upon Team object setup in **Step 6**.

- LocTool team permissions will not be migrated. They will be recreated in Bodega by the Globalization Engineering team in **Step 6**.

- **Will string-level history be migrated (because it is Okta-protected and need to perform string key - db id conversion)?**

### Step 8: Use the new Bodega production endpoint

Change your code to use the Bodega string retrieval API endpoint provided by [Bodega Operations and Engineering Team](#contacting-the-team) in **Step 6**. Discontinue using the LocTool endpoint.

## Common Questions

**How long does the Migration process take?**

**How do I get Bodega training?**

**When and where are Globalization Engineering office hours?**

**How do I get Bodega permissions set up for my team?**

**What string formats are supported in Bodega?**

**How can I validate all strings transferred from the LocTool to Bodega?**


## Contacting the Team

Need to contact the Globalization team?

|---|---|
|Slack|[#Globalization](https://nikedigital.slack.com/messages/CBSEHUK1N){:target="new-tab"}|
|Confluence Space|[Globalization](https://confluence.nike.com/display/G11N/Capability+Development){:target="new-tab"}|
|Product Manager|[Robert Heinz](mailto:robert.heinz@nike.com)|

## Document Change Log

|Summary |Date |Description|
|---|---|---|
|Initial draft 06/25/2019|Initial Draft|

## Next Steps

You've learned how to migrate your data from the LocTool to Bodega. Here are some links you might want to visit next.

- [Bodega]() **Need Link**
