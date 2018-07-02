<link rel="stylesheet" href="https://assets.commerce.nikecloud.com/ncss/glyphs/2.0/css/glyphs.min.css"/>
<link rel="stylesheet" href="https://assets.commerce.nikecloud.com/ncss/0.17/dotcom/desktop/css/ncss.en-us.min.css"/>
<link rel="stylesheet" href="/css/style.css"/>
<script type="text/javascript" src="/js/nde.js" ></script>

<!--
See Bitbucket (link to .md in APID repository) for version history of this document.
Author: Jane Moore
SME Consultants: Jeremy Myrland, Cameron Hinkle
-->

<div class="guide-nav-container">
    <div class="guide-nav-column guide-nav-left">
        <a href="/index.html"><i class="g72-arrow-fill-left"></i>&nbsp;<u>Back to NDe Documentation</u></a>
    </div>
    <div class="guide-nav-column guide-nav-right">
        <a href="slack://channel?team=T0G3T5X2B&amp;id=C9Q1MNJ1J" class="ncss-brand pt2-sm pr5-sm pb2-sm pl5-sm ncss-btn-black"><i class="g72-alert"></i>&nbsp;FIND AN ISSUE? SLACK US!</a>
    </div>
</div>

# UNDERSTANDING YOUR SEARCH RESULTS (DRAFT)

###### Last Updated: 06/26/2018<br>Submit Feedback: API Doc Slack channel <a href="https://nikedigital.slack.com/messages/nde-doc" target="_blank">#nde-doc</a>

---

Search is a rule-driven API used to retrieve the products or context navigation needed to build a personalized, global and consistent search and navigational experience for Nike customers. Most Search functionality is accessed through the Product Feeds Rollup Threads Service API. If you are not familiar with that service, we recommend reading the [Product Feed Rollup Threads V2 API Developer's Guide](/doc/commerce/product/api_rollup_threads.html) first.

## **In this guide:**

[Use Cases](#use-cases)

[Glossary](#glossary)

[Contacting the Team](#contacting-the-team)

[Search Types](#search-types)

[Rules, Results and Rankings](#rules-results-rankings)

[Troubleshooting](#troubleshooting)

## <a name="use-cases"></a>Use Cases
Here are just some of the ways Search can be used to drive your experience:

- Build a grid wall of products curated for customers
- Add autocomplete functionality by returning search keyword suggestions based on a partial word typed in the search bar
- Add search preview by listing highly-ranked products matching an autocomplete keyword suggestion
- Retrieve a set of filters used to build navigation
- List the most-purchased products even if they can no longer be purchased
- Return threads containing your search term in Facebook with #[search-term]
- Retrieve a product feed when you ask a product question in the Consumer Services Portal

## <a name="glossary"></a>Glossary

Listed below are some common search terms.

|Term|Definition|
|---|---|
|Action|Used to manipulate search results by boosting, burying or excluding products|
|Authored Concept|Group of concepts and/or keyword terms|
|Channel|User experience such as Bootroom or NIKE.com|
|Collection|Grouping of products such as the Mother's Day collection|
|Concept|Taxonomy, size, collection or authored concept e.g "Mens", "size 8", "Mother's Day", "Mother's Day floral"|
|Search Term|Customer-supplied keyword|
|Signal|Driven by consumer behavior or business objectives, signals are used to boost a product in the search rankings|
|Taxonomy|Mapping of product attributes to UUIDs. Products are stamped with taxonomy ids in Prodigy.|
|Trigger|Event that causes a search rule to react, such as typing a search term or selecting a navigation filter|

## <a name="contacting-the-team"></a>Contacting the Team

Need to reach out to the Search team?

|Method|Contact|
|---|---|
|Slack|<a href="https://nikedigital.slack.com/messages/#search-integration" target="_blank">#search-integration</a><br><a href="https://nikedigital.slack.com/messages/#nde-search-merch" target="_blank">#nde-search-merch</a>|
|Confluence space|<a href="https://confluence.nike.com/display/SEARCH/Content+Discovery+in+the+Cloud" target="_blank">Content Discovery Team</a>|
|Mailing List|[Lst-nde.pdm.merch.dev@nike.com](mailto:Lst-digitaltech.merch.apis)|
|Email the Product Owner<a name="product-owner"></a>|[Jeremy Myrland](mailto:jeremy.myrland@nike.com) (Search)<br>[Patti Cousins](mailto:patrcia.cousins@nike.com) (Apollo Tool)|

## <a name="search-types"></a>Search Types

Search can be used in several ways to both tell the Nike story and decrease the time to purchase by getting customers to the products they are looking for as quickly as possible. This section discusses the various search types.

### Autocomplete
This type of search suggests keywords when customers provide three or more letters of a search term. The experience calling Autocomplete search controls the maximum number of keywords to return. If a customer types "red" in the search bar, Autocomplete could return keyword suggestions "Boston Red Sox", "Cincinnati Reds" and "Washington Red Skins". A keyword suggestion can be used in a subsequent search to find products matching that keyword.

### Search Preview
Search Preview is a simple type of search using one or more search keywords that returns a subset of product information using default relevancy settings. On Nike.com web, Search Preview returns products matching the first suggested keyword returned from Autocomplete and is called each time the customer hovers over an Autocomplete keyword. Using the Autocomplete example above, hovering over "red sox" returns the top 6 Red Sox products according to the default rule. Clicking one of the 6 products opens the PDP. Clicking the View All link executes another search that returns all Red Sox products used to build the gridwall.

The image below illustrates how Autocomplete and Search Preview can be used together to quickly lead customers to the products they want.

![](/images/commerce/search/autocomplete-search-preview.png)

>**TIP:** For information on how to use the Global Navigation service to integrate search capabilities into the UI of your experience, see the <a href="https://tourguide.prod.commerce.nikecloud.com/global-nav" target="_blank">Global Navigation Guide</a>.


### Smart Search
Smart Search is a query enhancer. It uses the default rule and any custom rules configured for an experience to create an optimized search URL. This URL guarantees that when search is executed, it returns a curated result set with the most relevant products sorted first. Part of this optimization is achieved by mapping free text search keywords supplied by the customer, to ids stamped on the product. These ids represent concepts. Concepts can be taxonomy (attribute) based such as "floral" or "hoodie", size based such as "size 9", collection based such as "Mother's Day" or groups of concepts such as "Mother's day floral." Smart Search currently drives the Athletes gridwall in the [Bootroom](https://www.nike.com/bootroom) experience.

The image below depicts how Smart Search gathers search results and ranks them.

![](/images/commerce/search/smart-search.png)

1. Product Feeds Rollup Threads service: a) calls Smart Search service, passing consumerChannelId, language and marketplace filters, other filters and search terms b) calls Core Search Service with Smart Search URL

2. Smart Search Service: a) passes search terms to Key2Concepts Service and is returned concept UUIDs b) passes UUIDs to the Rules Service c) generates the Smart Search URL based on rules

3. Key2Concepts service passes taxonomy terms to Taxonomy Service, looks up sizes, collections and authored concepts in concept index, and returns concept UUIDs

4. Taxonomy looks up and returns UUIDs for each taxonomy term

5. Rules engine finds applicable rules and uses search strategy to find signals

6. Search strategy algorithm finds and returns applicable signals that boost products in search rankings

7. Smart Search URL executes search and returns the search results


### Core Search
Core Search does not use custom rules. It uses a default search rule and sort rule configured for the experience calling it. The main consumer of Core Search is the Product Feeds Rollup Threads Service. After it gets the refined Search URL from Smart Search, the Product Feeds Rollup Threads Service calls Core Search to get the final search results. Certain experiences call Core Search directly but eventually all experiences will call the Product Feeds Rollup Threads Service to get search results.

### Recommended Navigation
Use this type of search to build navigation in your experience. Like Smart Search, Recommended Navigation uses a keyword/concept mapping and custom rules to determine the appropriate set of navigation objects to return. For instance, if you pass the "gender" attributeId, Recommended Navigation search returns "mens", "womens", "girls" and "boys" navigation objects. Making a second call to Recommended Navigation passing the "girls" attributeId might return "size range", "sport", "best for", and "fit" navigation objects.


## <a name="rules-results-rankings"></a>Rules, Results and Rankings

Search culls data from several sources and utilizes a robust rules engine to determine what products or context navigation to return and how to sort them.

### Rules

Search rules play a key role in determining search results and rankings. Rules are administered in the Apollo rule management tool. Authorized users can add actions to rules that boost products to the top and/or bury products at the end of search results. Actions can also exclude products completely.

Rules are triggered either by customer activity such as searching for a particular keyword or by context, such as an attribute that a product is assigned. The two rule types are Grid Wall and Navigation. Grid Wall rules are used to build a product wall of related products. They allow a rule administrator to curate exactly what products to display for an experience in a particular geography. Navigation rules are used to build a dynamic navigation filter tree based on filter. For instance, clicking the Gender filter triggers another search that uses a Navigation rule that might return the "girls", "boys", "womens" and "mens" filters.

Each channel has one default rule customized for the experience that determines relevancy. Rule administrators can create additional layers of rules that either work in concert with or override the default rule.  Contact the <a href="#contacting-the-team">Apollo Product Owner</a> for access to the tool.

### <a name="results"></a>Results

Several factors affect search results, including product attributes and the fields those product attributes are assigned to. If a product's state field is not set to ACTIVE or the product's "hide from search" attribute it marked "true", the product will be filtered out of the search results. Similarly, if a search keyword is not in a field that search indexes, the product will not be included in the search results.

Depending upon the type of search, the source of product data is different and slightly different product data is available to search. Currently, Search Preview and Autocomplete Search use Endeca as a product data source. Navigation and Core search use product information supplied by the Product Feed Service. It is important to note that both data sources provide Search with inventory availability information.

Because the product data source differs across search types, different default rules are applied depending upon the type of search  performed.

### <a name="rankings"></a>Rankings

Through parameters passed into the Product Feeds Rollup Threads Service API, clients can control sorting based on a limited set of product fields. See the [Product Feeds Rollup Threads API V2](/projects/Product%20Feed%20Rollup%20Threads%20Service%20API%20V2?tab=api) API.md for the complete list.

A search rule can be assigned a priority to influence when the rule is applied in relation to other rules. Rules with a high priority get applied first. Rules assigned a low priority ensure that higher priority rules are applied first.

Behind the scenes, the rules engine uses signals as part of the search strategy to influence search rankings. Signals are either consumer or business driven. Consumer driven signals are trends based on consumer behavior over a period of time. For example, a signal could boost the product that had the most viewed product display page within the past week, or a signal could boost the product that was most added to cart within the past month. Because this type of signal is an aggregate of consumer actions, consumer driven signals are constantly changing. Signals can also be driven by marketing objectives. The signal for the newest product or the signal for the product with the highest margin could boost those products to the top of the search rankings.

## <a name="troubleshooting"></a>Troubleshooting

If the products returned by search are either not ranked as you expect or not returned at all, there are a few steps you can take to trouble shoot.

### Check Splunk
Use Splunk to trace the call to provide insight into what rules are being applied and what results the Search API returns.  All you need is the Trace Id. See the [Query Logs with a Trace ID](/content/doc/getting-started/using_nike_apis.html#query-logs-with-a-trace-id) section of the Using Nike APIs guide to learn how to get and use the trace id of the response to query Splunk.

An abbreviated Splunk trace sequence for Trace Id 65519e4e2c01ba2d is listed below for the Neymar Jr. gridwall in Bootroom, URL https://www.nike.com/soccer/bootroom/f/neymar-jr/.

```
 TRACE 2018-06-14 18:58:39,389 [I/O dispatcher 2] com.nike.phylon.rest.events.LoggingEventsClientResponseHandler app=smartsearchv1 version2.0.1.5 : Sent domain event. statusCode=200 responseBody={"ShardId":"shardId-000000000004","SequenceNumber":"49579947210318633997012504867285607064259247813704024130"} eventBody={"resourceType":"smartsearch","resourceVersion":"v1","context":{"additionalResourceInfo":{"version":"1.3"},"requestHeaders":{"Accept":["*/*"],"X-Nike-AppId":["productfeedrollupsv2"],"X-B3-ParentSpanId":["51f91cc7aa938ffb"],"User-Agent":["Java/1.8.0_171"],"Connection":["keep-alive"],"Host":["172.26.173.229:8080"],"Authorization":["Bearer XXXXXX.eyJpc3MiOiJwcm9kdWN0ZmVlZHJvbGx1cHN2MiIsImV4cCI6MTUyOTAwMzMxOCwic3ViIjoicHJvZHVjdGZlZWRyb2xsdXBzdjIiLCJhdWQiOlsicHJvZHVjdGZlZWRyb2xsdXBzdjIiXSwic2NwIjpbInJlYWQiLCJ3cml0ZSJdLCJqdGkiOiIxZmM1YTY4Mi0yMmUxLTQ0OWItYjkzMi00MzgzMDQ1MGM4MDAifQ.ZZZZZZ"],"X-NewRelic-ID":["UwcDVlVUGwsAU1FaBwgC"],"instanceId":["static"],"X-B3-SpanId":["119abad1c061e2c8"],"appId":["productfeedrollupsv2"],"X-NewRelic-Transaction":["PxRTBAMBCgJRUwVUBgdRUlIAFB8EBw8RVU4aBl1dVgACBA4FB1AFBFAABkNKQV4CVVZUBAEGFTs="],"X-B3-Sampled":["1"],"X-B3-TraceId":["65519e4e2c01ba2d"]},"event":{"type":"READ","id":"25de92b1-0c31-42ea-9441-b668dfde1a42","date":"2018-06-14T18:58:38Z","formatVersion":"v3.0"}},"notification":{"domain":"product_feed","resource":"threads","version":"v2","language":"en","searchTerms":null,"queryFields":"searchMetaData.productInfo[].productContent.fullTitle:language,searchMetaData.productInfo[].productContent.title:language,searchMetaData.productInfo[].productContent.subtitle:language,searchMetaData.publishedContent.propertiesConsumerLabelsClassificationText[]:language","where":"((marketplace==\"US\"))","facetQuery":null,"totalResources":1,"consumerChannelId":"06cec393-5bd2-4835-bbd5-89c8dbcae1ff","marketplace":"US","attributeIds":["250ebb18-ce0f-41ba-ba3f-4b62d09ad346"],"response":{"modifiedCoreSearchUrl":"http://search-searches-v2/search/searches/v2/product_feed/threads/v2?language=en&rollupField=searchMetaData.productRollup.key&sort=searchMetaData.publishedContent.publishStartDateDesc,idAsc&rollupSort=searchMetaData.publishedContent.publishStartDateDesc,idAsc&boost=searchMetaData.productInfo[].merchProduct.styleColor=AH7380-107,searchMetaData.productInfo[].merchProduct.styleColor=AH7375-107,searchMetaData.productInfo[].merchProduct.styleColor=AH7347-107,searchMetaData.productInfo[].merchProduct.styleColor=AH7382-107,searchMetaData.productInfo[].merchProduct.styleColor=893858-749,searchMetaData.productInfo[].merchProduct.styleColor=893855-453,searchMetaData.productInfo[].merchProduct.styleColor=893944-453,searchMetaData.productInfo[].merchProduct.styleColor=893857-453,searchMetaData.productInfo[].merchProduct.styleColor=893331-454,searchMetaData.productInfo[].merchProduct.styleColor=893353-454,searchMetaData.productInfo[].merchProduct.styleColor=894432-411,searchMetaData.productInfo[].merchProduct.styleColor=847267-011,searchMetaData.productInfo[].merchProduct.styleColor=555475-067,searchMetaData.productInfo[].merchProduct.styleColor=942842-001,searchMetaData.productInfo[].merchProduct.styleColor=AH8050-300,searchMetaData.productInfo[].merchProduct.styleColor=AH8145-100,searchMetaData.productInfo[].merchProduct.styleColor=AH7380-810,searchMetaData.productInfo[].merchProduct.styleColor=893856-749,searchMetaData.productInfo[].merchProduct.styleColor=893945-749,searchMetaData.productInfo[].merchProduct.styleColor=893970-749,searchMetaData.productInfo[].merchProduct.styleColor=893969-453,searchMetaData.productInfo[].merchProduct.styleColor=892553-036,searchMetaData.productInfo[].merchProduct.styleColor=914480-063,searchMetaData.productInfo[].merchProduct.styleColor=AQ0954-010,searchMetaData.productInfo[].merchProduct.styleColor=886150-036&where=(((marketplace==%22US%22)));((channelId==d9a5bc42-4b9c-4976-858a-f159cf99c647%20and%20searchMetaData.productInfo[].merchProduct.status==ACTIVE%20and%20searchMetaData.productInfo[].available==true%20and%20(publishedContent.properties.threadType!=soldier%20and%20searchMetaData.productInfo[].merchProduct.styleType!=NIKEID)%20and%20(searchMetaData.productInfo[].merchProduct.channels==Bootroom)%20and%20(searchMetaData.productInfo[].merchProduct.hideFromSearch!=true%20or%20searchMetaData.productInfo[].merchProduct.hideFromSearch==null)));searchMetaData.taxonomyAttributeSearchIds==250ebb18-ce0f-41ba-ba3f-4b62d09ad346&fields=id,language,marketplace,channelId,channelName,lastFetchTime,resourceType,active,links,publishedContent.viewStartDate,publishedContent.createdDateTime,publishedContent.publishStartDate,publishedContent.publishEndDate,publishedContent.properties,productInfo.merchProduct,productInfo.merchPrice.fullPrice,productInfo.merchPrice.currentPrice,productInfo.merchPrice.currency,productInfo.merchPrice.discounted,productInfo.merchPrice.links,productInfo.availability,productInfo.productContent.title,productInfo.productContent.subtitle,productInfo.productContent.colors,productInfo.imageUrls,productInfo.customizedPreBuild&queryFields=searchMetaData.productInfo[].productContent.fullTitle:language,searchMetaData.productInfo[].productContent.title:language,searchMetaData.productInfo[].productContent.subtitle:language,searchMetaData.publishedContent.propertiesConsumerLabelsClassificationText[]:language&anchor=0&count=50","searchParameters":{"searchTerms":null,"fields":["id","language","marketplace","channelId","channelName","lastFetchTime","resourceType","active","links","publishedContent.viewStartDate","publishedContent.createdDateTime","publishedContent.publishStartDate","publishedContent.publishEndDate","publishedContent.properties","productInfo.merchProduct","productInfo.merchPrice.fullPrice","productInfo.merchPrice.currentPrice","productInfo.merchPrice.currency","productInfo.merchPrice.discounted","productInfo.merchPrice.links","productInfo.availability","productInfo.productContent.title","productInfo.productContent.subtitle","productInfo.productContent.colors","productInfo.imageUrls","productInfo.customizedPreBuild"],"queryFields":[{"name":"searchMetaData.productInfo[].productContent.fullTitle:language","weight":1.0},{"name":"searchMetaData.productInfo[].productContent.title:language","weight":1.0},{"name":"searchMetaData.productInfo[].productContent.subtitle:language","weight":1.0},{"name":"searchMetaData.publishedContent.propertiesConsumerLabelsClassificationText[]:language","weight":1.0}],"where":"(((marketplace==\"US\")));((channelId==d9a5bc42-4b9c-4976-858a-f159cf99c647 and searchMetaData.productInfo[].merchProduct.status==ACTIVE and searchMetaData.productInfo[].available==true and (publishedContent.properties.threadType!=soldier and searchMetaData.productInfo[].merchProduct.styleType!=NIKEID) and (searchMetaData.productInfo[].merchProduct.channels==Bootroom) and (searchMetaData.productInfo[].merchProduct.hideFromSearch!=true or searchMetaData.productInfo[].merchProduct.hideFromSearch==null)));searchMetaData.taxonomyAttributeSearchIds==250ebb18-ce0f-41ba-ba3f-4b62d09ad346","sort":[{"field":"searchMetaData.publishedContent.publishStartDate","direction":"DESCENDING"},{"field":"id","direction":"ASCENDING"}],"anchor":0,"count":50,"facetFields":null,"facetQuery":null,"rollupField":"searchMetaData.productRollup.key","rollupSort":[{"field":"searchMetaData.publishedContent.publishStartDate","direction":"DESCENDING"},{"field":"id","direction":"ASCENDING"}],"rollupCount":null,"boost":[{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"AH7380-107"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"AH7375-107"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"AH7347-107"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"AH7382-107"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"893858-749"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"893855-453"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"893944-453"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"893857-453"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"893331-454"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"893353-454"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"894432-411"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"847267-011"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"555475-067"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"942842-001"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"AH8050-300"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"AH8145-100"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"AH7380-810"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"893856-749"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"893945-749"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"893970-749"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"893969-453"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"892553-036"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"914480-063"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","value":"AQ0954-010"},{"name":"searchMetaData.productInfo[].merchProduct.styleColor","

65519e4e2c01ba2d INFO  2018-06-14 18:58:38,871 [XNIO-5 task-3] com.nike.productfeedcommonv2.util.EventLogger app=productfeedrollupsv2 version2.0.3.113 : Event=EndRequest, Message='HttpStatus=200, HttpMethod=GET, Url=http://172.26.10.170:8080/product_feed/rollup_threads/v2/?consumerChannelId=06cec393-5bd2-4835-bbd5-89c8dbcae1ff&anchor=0&count=50&filter=marketplace%28US%29&filter=language%28en%29&filter=taxonomyIds%28250ebb18-ce0f-41ba-ba3f-4b62d09ad346%29'

65519e4e2c01ba2d INFO  2018-06-14 18:58:38,862 [XNIO-5 task-3] com.nike.nde.search.client.NikeSearchClient app=productfeedrollupsv2 version2.0.3.113 : event=elastic type=query success=true transactionDuration=57 queryDuration=45 clusterName=search-productfeed-v2-5-5 indexName=product_feed-threads-v2:en::1 resultCount=22
traceId=65519e4e2c01ba2d instance-id=i-0fe92b635def6169a 2018-06-14T18:58:38,861Z [epollEventLoopGroup-3-8] appname=nio-public-router environment=prod version=1.1.86 |-INFO  VALID_WINGTIPS_SPANS - [DISTRIBUTED_TRACING] {"traceId":"65519e4e2c01ba2d","parentSpanId":"748893f971b9a3b7","spanId":"f79f887b7899c9fb","spanName":"GET_/product_feed/rollup_threads/v2/","sampleable":"true","userId":"null","spanPurpose":"SERVER","startTimeEpochMicros":"1529002718754000","durationNanos":"107023682"}
traceId=65519e4e2c01ba2d instance-id=i-0fe92b635def6169a 2018-06-14T18:58:38,861Z [proxyRouterEventLoopGroup-9-8] appname=nio-public-router environment=prod version=1.1.86 |-INFO  VALID_WINGTIPS_SPANS - [DISTRIBUTED_TRACING] {"traceId":"65519e4e2c01ba2d","parentSpanId":"f79f887b7899c9fb","spanId":"b425e6488b811e1f","spanName":"async_downstream_call-GET_172.26.10.170:8080/product_feed/rollup_threads/v2/?consumerChannelId=06cec393-5bd2-4835-bbd5-89c8dbcae1ff&anchor=0&count=50&filter=marketplace%28US%29&filter=language%28en%29&filter=taxonomyIds%28250ebb18-ce0f-41ba-ba3f-4b62d09ad346%29","sampleable":"true","userId":"null","spanPurpose":"CLIENT","startTimeEpochMicros":"1529002718759000","durationNanos":"102695600"}
traceId=65519e4e2c01ba2d instance-id=i-0fe92b635def6169a 2018-06-14T18:58:38,860Z [epollEventLoopGroup-3-8] appname=nio-public-router environment=prod version=1.1.86 |-INFO  c.n.n.filter.BotLoggingFilter - bot-dashboard: true_client_ip=165.225.50.104 forwarded_for_ips=[165.225.50.104, 10.27.178.119, 184.27.178.103, 10.217.232.13, 63.217.232.15] method=GET path=/product_feed/rollup_threads/v2/ uri=/product_feed/rollup_threads/v2/?consumerChannelId=06cec393-5bd2-4835-bbd5-89c8dbcae1ff&anchor=0&count=50&filter=marketplace%28US%29&filter=language%28en%29&filter=taxonomyIds%28250ebb18-ce0f-41ba-ba3f-4b62d09ad346%29 response_code=200

65519e4e2c01ba2d INFO  2018-06-14 18:58:38,803 [XNIO-5 task-3] com.nike.productfeedcommonv2.util.EventLogger app=productfeedrollupsv2 version2.0.3.113 : Event=CoreSearchV2Service, Message='Querying for language en with searchParameters where=(((marketplace=="US")));((channelId==d9a5bc42-4b9c-4976-858a-f159cf99c647 and searchMetaData.productInfo[].merchProduct.status==ACTIVE and searchMetaData.productInfo[].available==true and (publishedContent.properties.threadType!=soldier and searchMetaData.productInfo[].merchProduct.styleType!=NIKEID) and (searchMetaData.productInfo[].merchProduct.channels==Bootroom) and (searchMetaData.productInfo[].merchProduct.hideFromSearch!=true or searchMetaData.productInfo[].merchProduct.hideFromSearch==null)));searchMetaData.taxonomyAttributeSearchIds==250ebb18-ce0f-41ba-ba3f-4b62d09ad346&sort=searchMetaData.publishedContent.publishStartDateDesc,idAsc&anchor=0&count=50&rollupField=searchMetaData.productRollup.key&rollupSort=searchMetaData.publishedContent.publishStartDateDesc,idAsc&boost=searchMetaData.productInfo[].merchProduct.styleColor=AH7380-107,searchMetaData.productInfo[].merchProduct.styleColor=AH7375-107,searchMetaData.productInfo[].merchProduct.styleColor=AH7347-107,searchMetaData.productInfo[].merchProduct.styleColor=AH7382-107,searchMetaData.productInfo[].merchProduct.styleColor=893858-749,searchMetaData.productInfo[].merchProduct.styleColor=893855-453,searchMetaData.productInfo[].merchProduct.styleColor=893944-453,searchMetaData.productInfo[].merchProduct.styleColor=893857-453,searchMetaData.productInfo[].merchProduct.styleColor=893331-454,searchMetaData.productInfo[].merchProduct.styleColor=893353-454,searchMetaData.productInfo[].merchProduct.styleColor=894432-411,searchMetaData.productInfo[].merchProduct.styleColor=847267-011,searchMetaData.productInfo[].merchProduct.styleColor=555475-067,searchMetaData.productInfo[].merchProduct.styleColor=942842-001,searchMetaData.productInfo[].merchProduct.styleColor=AH8050-300,searchMetaData.productInfo[].merchProduct.styleColor=AH8145-100,searchMetaData.productInfo[].merchProduct.styleColor=AH7380-810,searchMetaData.productInfo[].merchProduct.styleColor=893856-749,searchMetaData.productInfo[].merchProduct.styleColor=893945-749,searchMetaData.productInfo[].merchProduct.styleColor=893970-749,searchMetaData.productInfo[].merchProduct.styleColor=893969-453,searchMetaData.productInfo[].merchProduct.styleColor=892553-036,searchMetaData.productInfo[].merchProduct.styleColor=914480-063,searchMetaData.productInfo[].merchProduct.styleColor=AQ0954-010,searchMetaData.productInfo[].merchProduct.styleColor=886150-036&fuzziness=0'

65519e4e2c01ba2d INFO  2018-06-14 18:58:38,795 [XNIO-3 task-15] com.nike.nde.search.client.NikeSearchClient app=smartsearchv1 version2.0.1.5 : event=elastic type=get success=true duration=5 clusterName=search-recommend-v1-5-5 indexName=recommend-concepts-v1:en::3 documentId=d80ac58c4bf844d34098df66b8eb779816fb1ef767ed759b20cbd8adea4a38a8

65519e4e2c01ba2d INFO  2018-06-14 18:58:38,790 [XNIO-3 task-2] com.nike.recommendrulesv1.service.ruleaction.RuleActionService app=recommendrulesv1 version${releaseVersion} : transactionId=getRuleActionsByIds state=SUCCESS duration=5

65519e4e2c01ba2d INFO  2018-06-14 18:58:38,790 [XNIO-3 task-2] com.nike.nde.search.client.NikeSearchClient app=recommendrulesv1 version${releaseVersion} : event=elastic type=query success=true transactionDuration=5 queryDuration=1 clusterName=search-recommend-v1-5-5 indexName=recommend-rule_actions-v1:::1 resultCount=2

65519e4e2c01ba2d INFO  2018-06-14 18:58:38,789 [XNIO-3 task-15] com.nike.smartsearchv1.service.smartsearch.RuleEngineService app=smartsearchv1 version2.0.1.5 : Processing rule id=34e4d8c7-4fd5-4f7c-8082-a003de30ad0b

65519e4e2c01ba2d INFO  2018-06-14 18:58:38,789 [XNIO-3 task-15] com.nike.smartsearchv1.service.smartsearch.RuleEngineService app=smartsearchv1 version2.0.1.5 : Processing rule id=ALL_LOCATIONS_DOCUMENT_RULE_BOOTROOM

65519e4e2c01ba2d INFO  2018-06-14 18:58:38,789 [XNIO-3 task-15] com.nike.smartsearchv1.repository.recommendrules.RuleActionRepository app=smartsearchv1 version2.0.1.5 : transactionId=getMatchingRuleActions state=SUCCESS Args=[{"domain":"product_feed","resource":"threads","version":"v2","language":"en","fields":[],"queryFields":[],"where":"((marketplace==\"US\"))","anchor":0,"count":50,"consumerChannelId":"06cec393-5bd2-4835-bbd5-89c8dbcae1ff","marketplace":"US","attributeIds":["250ebb18-ce0f-41ba-ba3f-4b62d09ad346"]}] duration=16

65519e4e2c01ba2d INFO  2018-06-14 18:58:38,785 [XNIO-3 task-2] com.nike.recommendrulesv1.repositories.ruleaction.lookup.RuleLookupRepository app=recommendrulesv1 version${releaseVersion} : transactionId=matchingRulesForQuery state=SUCCESS duration=7

65519e4e2c01ba2d INFO  2018-06-14 18:58:38,785 [XNIO-3 task-2] com.nike.nde.search.client.NikeSearchClient app=recommendrulesv1 version${releaseVersion} : event=elastic type=query success=true transactionDuration=6 queryDuration=1 clusterName=search-recommend-v1-5-5 indexName=recommend-rules-v1:::1 resultCount=2

65519e4e2c01ba2d DEBUG 2018-06-14 18:58:38,774 [XNIO-5 task-3] com.nike.productfeedcommonv2.clients.SmartSearchClient app=productfeedrollupsv2 version2.0.3.113 : [SmartSearchClient#getSmartSearch] ---> GET http://smartsearchv1/recommend/searches/v1/product_feed/threads/v2?where=%28%28marketplace%3D%3D%22US%22%29%29&language=en&marketplace=US&consumerChannelId=06cec393-5bd2-4835-bbd5-89c8dbcae1ff&anchor=0&count=50&attributeIds=250ebb18-ce0f-41ba-ba3f-4b62d09ad346 HTTP/1.1

65519e4e2c01ba2d INFO  2018-06-14 18:58:38,770 [XNIO-5 task-3] com.nike.productfeedcommonv2.util.EventLogger app=productfeedrollupsv2 version2.0.3.113 : Event=StartRequest, Message='HttpMethod=GET, Url=http://172.26.10.170:8080/product_feed/rollup_threads/v2/?consumerChannelId=06cec393-5bd2-4835-bbd5-89c8dbcae1ff&anchor=0&count=50&filter=marketplace%28US%29&filter=language%28en%29&filter=taxonomyIds%28250ebb18-ce0f-41ba-ba3f-4b62d09ad346%29, nike-api-caller-id=nike:bootroom:web:1.0'
127.0.1.1 - - [14/Jun/2018:18:58:38  +0000] "GET /product_feed/rollup_threads/v2/?consumerChannelId=06cec393-5bd2-4835-bbd5-89c8dbcae1ff&anchor=0&count=50&filter=marketplace%28US%29&filter=language%28en%29&filter=taxonomyIds%28250ebb18-ce0f-41ba-ba3f-4b62d09ad346%29 HTTP/1.1" 200 102536 "https://www.nike.com/soccer/bootroom/f/neymar-jr/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36" accept-Req=*/* content-type-Req=application/json; charset=UTF-8 content-length-Res=- transfer_encoding-Res=chunked http_status_code-Res=200 error_uid-Res=- X-B3-Sampled-Req=1 X-B3-SpanId-Req=748893f971b9a3b7 X-B3-TraceId-Req=65519e4e2c01ba2d X-B3-TraceId-Res=65519e4e2c01ba2d raw_content_length-Req=0 raw_content_length-Res=102536 final_content_length-Res=102536 elapsed_time_millis=106 appId= upmId= True-Client-IP=165.225.50.104 nike-api-caller-id=nike:bootroom:web:1.0

```

### Check the rules

You will need Apollo access to check rule configuration. If you do not know the rule name(s) affecting your search results, check Splunk using the method described above. Then go into Apollo and verify that the rules are configured correctly and that no rules are competing with one another.

### Check the products

Ensure that the product is set up correctly to be found by search. If you know the style-color or product id, you can call the [Merchandised Product API](/doc/commerce/product/api_merch_product.html) directly to look at the product details. Note that not all fields in the Merchandised Product are exposed in the Product Feed API.

If you are unable to locate the product in Merchandised Product, you may need to go even further upstream in the product life cycle. Check the Prodigy Merchandising Tool to troubleshoot why the product has not streamed into the Merchandised Product system yet.

Still need help? <a href="#contacting-the-team">Contact the Search Team</a>.