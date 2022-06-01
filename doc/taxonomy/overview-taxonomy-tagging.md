---
id: overview-taxonomy-tagging
tags: pdf
category: a-overview
position: 7
title: TTAC
url: /doc/taxonomy/overview-taxonomy-tagging.html
h1: TTAC Overview
---
Learn how [Taxonomy Tagging for Assets and Content](https://developer.niketech.com/docs/projects/attributions?tab=api){:target="new-tab"} (TTAC) manages complex taxonomical relationships that can be used by front-end Nike experiences to display personalized assets and content to Nike consumers.

### TTAC increases conversion by driving personalized assets and content across Nike experiences.

Nike experiences can use these TTAC-managed relationships to dynamically show customized navigation, content, and images to consumers in their preferred language that reflects their personal style, interests, and preferences. A personalized experience promotes engagement, often strengthening the commitment to purchase.

![SNKRS app payment flow](/images/taxonomy/ttac.png)

How does it work? CMS, Asset Management, and other internal Nike tools supply the content and assets. Taxonomy definitions including navigation, categories, and consumer preference are supplied by Semaphore via the [Merch Taxonomy Attributes](https://developer.niketech.com/docs/projects/Merch%20Taxonomy%20Attributes%20V1?tab=api){:target="new-tab"} service. TTAC connects these tools to front-end web experiences through TTAC components and the TTAC metadata (Attributions) service. TTAC components enable Nike experiences to tag content threads and assets with taxonomy attributes through a user interface. The TTAC metadata service stores and retrieves those taxonomical relationships in the form of UUIDs.

#### Contacting the Team

|---|---|
|Slack|[#asset-delivery](https://nikedigital.slack.com/messages/C20935610){:target="new-tab"}|
|Confluence|[CiC Asset Delivery](https://confluence.nike.com/display/CICAD/CiC+Asset+Delivery){:target="new-tab"}|
|Product Director|[Chris Sparhawk](mailto:chris.sparhawk@nike.com)|

#### About TTAC

The project is in development in PI-26 and is scheduled for release February 2019.

|---|---|
|API|[TTAC Metadata Service](https://developer.niketech.com/docs/projects/attributions?tab=api){:target="new-tab"}|
|COMPONENTS|to be published 2/5/19|

The TTAC Service and Components are inner-sourced within Nike and open to contributions from all development teams to submit design suggestions and code PRs.

Governance will be provided by the following team:
- Architecture: Aaron Hall
- Engineering: Edmund Adjei
- Taxonomy: Rebecca Roberts

#### Use Cases

Step through the TTAC use cases below.

|---|
|<i class="g72-check"></i>&nbsp;&nbsp;Tag images so you can determine which image qualities and sizes motivate consumers.|
|<i class="g72-check"></i>&nbsp;&nbsp;Improve engagement by displaying product images most relevant to the consumer's navigational path to a product wall. e.g. if a consumer navigates to unisex products via a women's navigational path, she prefers to see images of female models instead of male.|
|<i class="g72-check"></i>&nbsp;&nbsp;Boost conversion by using taxonomy tagging to display images to consumers that resonate with their interests and preferences.|
|<i class="g72-check"></i>&nbsp;&nbsp;Tag content to allow your app to select the most relevant threads to display to the consumer.|

<h4>Related Information</h4>
<aside class="note">
<h5 style="text-align:center;">APIs</h5>
<ul>
   <li>
        <a href="https://developer.niketech.com/docs/projects/attributions?tab=api" target="new-tab">TTAC Metadata Service</a><span class="guide-details-li-text"></span>
    </li>
    <li>
        <a href="https://developer.niketech.com/docs/projects/Merch%20Taxonomy%20Attributes%20V1?tab=api" target="new-tab">Merch Taxonomy Attributes</a> <span class="guide-details-li-text"></span>
    </li>
    <li>
            <a href="https://developer.niketech.com/docs/projects/recommendconceptsv1?tab=api" target="new-tab">Recommend Concepts API</a> <span class="guide-details-li-text"></span>
    </li>
  </ul>
</aside>

* [Working with Circuit Breakers:](/doc/commerce/reference/caller-best-practices.html) Learn how to be a good client by following these best practices.

* [Glossary:](/doc/commerce/reference/glossary.html) Common terms explained.

* [Product Life Cycle:](/doc/commerce/reference/product-lifecycle.html) Discover how Nike products become available for purchase in an experience.

#### Connect

We're here to help.&nbsp;&nbsp;&nbsp;<i class="g72-chat"></i> [#Slack](slack://channel?team=T0G3T5X2B&id=C6A18NT7W)&nbsp;&nbsp;&nbsp;<i class="g72-email"></i> [Email](mailto:Lst-nde.docs@nike.com)