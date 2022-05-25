---
id: use-search
tags: pdf
category: b-use-case
position: 4
title: Search
url: /doc/commerce/search/use-search.html
toc:
  - h2: Use Cases
    url: /doc/commerce/search/use-search.html#use-cases
  - h2: Key Terms
    url: /doc/commerce/search/use-search.html#key-terms
  - h2: E-commerce Search Types
    url: /doc/commerce/search/use-search.html#e-commerce-search-types
  - h2: Rules, Results, and Rankings
    url: /doc/commerce/search/use-search.html#rules-results-and-rankings
  - h2: Troubleshooting
    url: /doc/commerce/search/use-search.html#troubleshooting
  - h2: Contacting the Team
    url: /doc/commerce/search/use-search.html#contacting-the-team
  - h2: Document Change Log
    url: /doc/commerce/search/use-search.html#document-change-log
  - h2: Related Links
    url: /doc/commerce/search/use-search.html#related-links
---
##### Last Updated: 02/04/2020

E-commerce search provides a robust and consistent e-commerce search experience that is personalized for Nike consumers around the globe. Most search functionality is accessed through the Product Feeds Rollup Threads Service API. If you are not familiar with that service, we recommend reading the [Product Feed Rollup Threads V2 API Developer's Guide](/doc/commerce/product/use-rollup-threads.html) first.

## Use Cases

Here are just some of the ways e-commerce search can be used to drive your experience:

- Quickly return e-commerce search results using Simple Search, no rule configuration necessary
- Return search keyword suggestions based on a partial word typed in the search bar using Autocomplete Search
- List highly-ranked products matching an Autocomplete keyword suggestion using Search Preview
- Build navigation in your experience by retrieving a set of product filters
- List the most-purchased products even if they can no longer be purchased
- Return [Product Feed Threads](/doc/commerce/product/use-rollup-threads.html) containing your search term in Facebook with #[search-term]
- Retrieve a [Product Feed](/doc/commerce/product/use-rollup-threads.html) when you ask a product question in the Consumer Services Portal
- Finely tune e-commerce search results using the context aware Smart Search rules engine

## Key Terms

Listed below are some common e-commerce search terms and definitions.

###### Table 1: Definitions of Common Search-Related Terms

|Term|Definition|
|---|---|
|Context|Consumer's marketplace, experience, channel and language|
|Trigger|Context or consumer-initiated query that causes an e-commerce search rule to fire|
|Action|What an e-commerce search rule does when it fires, i.e. manipulates e-commerce search rankings|
|Query|What the consumer is searching for|
|Search Rule|Controls how items are ranked or excluded from e-commerce search results|
|Taxonomy|Nike product attributes|
|Search Term|Consumer-supplied e-commerce search keyword|
|Concept|Translates a consumer-supplied e-commerce search term into Nike product attribute(s)|
|Authored Concept|Group of concepts|
|Collection|Group of products such as the Mother's Day collection|
|Channel|Consumer experience such as Bootroom or NIKE.com|
|Signal|Consumer behavior and merchandiser-defined factors used to rank e-commerce search results|

## E-commerce Search Types

E-commerce search can be used to:

- tell the Nike story
- decrease time to purchase by quickly leading consumers to the products they need

Currently, e-commerce search handles product and navigation data. Content will be added in the near future. This section discusses the various search types.

### Smart Search
Smart Search is a rule-based filter. You can access this functionality by calling the [Product Feed Rollup Threads V2 service](/doc/commerce/product/use-rollup-threads.html). Smart Search uses the experience's default and custom rules to return a result set sorted according to merchandising rules. The e-commerce search engine is optimized by mapping consumer-provided search terms to product attributes, also known as concepts. Concepts can be taxonomy (attribute) based such as "red", size based such as "size 9", collection based such as "Mother's Day" or groups of concepts.

**Used by:** [Bootroom](https://www.nike.com/bootroom) to drive the Athletes product gridwall

### Autocomplete
This type of search suggests keywords when consumers provide three or more letters of a search term. Nike.com calls Autocomplete Search when the consumer types in the search bar. If a consumer types "red", Autocomplete search could return keyword suggestions "Boston Red Sox", "Cincinnati Reds" and "Washington Redskins". A keyword suggestion can be used in a subsequent search to find products matching that keyword.

**Used by:** Nike.com

### Search Preview
Search Preview is a simple type of search that uses one or more search keywords to return a subset of product information using default relevancy rankings. Using the Autocomplete example above, hovering over "red sox" returns the top 6 Red Sox products according to the default rule. Nike.com web uses Search Preview from the Search bar to return products matching the first suggested keyword returned from Autocomplete. That experience calls Search Preview each time the consumer hovers over an Autocomplete keyword.

**Used by:** Nike.com

The Nike.com image below illustrates how Autocomplete and Search Preview can be used together to quickly lead consumers to the products they want.

![](/images/commerce/search/autocomplete-search-preview.png){:class="border"}

>**TIP:** For information on how to integrate Search Bar with Search Preview in your experience, see the [Global Navigation Guide](https://tourguide.prod.commerce.nikecloud.com/global-nav){:target="new-tab"}.

<!--

The image below depicts how Smart Search gathers search results and ranks them.

![](/images/commerce/search/smart-search.png)

1. Product Feeds Rollup Threads service: a) calls Smart Search service, passing consumerChannelId, language and marketplace filters, other filters and search terms b) calls Core Search Service with Smart Search URL

2. Smart Search Service: a) passes search terms to Key2Concepts Service and is returned concept UUIDs b) passes UUIDs to the Rules Service c) generates the Smart Search URL based on rules

3. Key2Concepts service passes taxonomy terms to Taxonomy Service, looks up sizes, collections and authored concepts in concept index, and returns concept UUIDs

4. Taxonomy looks up and returns UUIDs for each taxonomy term

5. Rules engine finds applicable rules and uses search strategy to find signals

6. Search strategy algorithm finds and returns applicable signals that boost products in search rankings

7. Smart Search URL executes search and returns the search results
-->

### Recommended Navigation
Use this type of search to build navigation in your experience. Nike.com calls the Recommended Navigation API directly to list filters (product attributes) in the left navigation based on one or more search terms and/or attribute IDs. Like Smart Search, Recommended Navigation uses concepts and rules to determine the appropriate set of navigation filters to return. For instance, if you pass the "blue" search term in the call to Recommended Navigation, it returns a list of filters including "gender", "product type", and "apparel". Checking the "womens" gender filter in the UI executes another Recommended Navigation search for the search terms "blue" and "womens", narrowing the list of navigation filters even further.

**Used by:** Nike.com

## Rules, Results and Rankings

Smart Search culls data from several sources and utilizes a robust rules engine to determine what data to return and how to rank the e-commerce search results. Search results are not cached.

### Rules

Smart Search rules play a key role in determining e-commerce search results and rankings. Each channel has a default rule and may also have custom rules.

Custom rules are administered in the Apollo rule management tool and are specific to a channel. Authorized Apollo users can add actions to rules to influence the search rankings such as boosting, burying, and hiding. Custom rules layer on top of the default rule to either work in concert with or override the default rule. Contact the Apollo Product Owner for access to the tool.

Rules are triggered either by consumer activity such as searching for a particular term or by context such as the experience or geography. The two rule types are Grid Wall and Navigation. Grid Wall rules are used to merchandise a product wall of related products for an experience in a particular geography and/or marketplace. Navigation rules are used to build a dynamic navigation filter tree based on search terms and attribute IDs.

The default rule for each experience is listed below. Default rules are not available through the Apollo tool. Contact the Product Owner to create a new or edit an existing default rule. Note that each default rule filters on the same channelId (d9a5bc42-4b9c-4976-858a-f159cf99c647) to get nike.com product threads. Each default rule is associated with an experience through the experience's consumerChannelId passed into the Product Feed Rollup Threads service. See [Product Feed Rollup Threads V2 service](/doc/commerce/product/use-rollup-threads.html#consumer-channel-id-and-channel-id) to read about the difference between channelId and consumerChannelId.

**SNKRS/nike.com**
```
(channelId = d9a5bc42-4b9c-4976-858a-f159cf99c647
AND
status = ACTIVE
AND
((available = true AND effectiveStartViewDate <= now) OR (available = true AND (hardLaunch = null OR hardLaunch==false)))
AND
exclusiveAccess = false
AND
(commerceCountryExclusions==null OR commerceCountryExclusions!={excludeMarketplaceParam})
AND
((threadType = null OR (threadType = soldier AND styleType != NIKEID)) OR  (styleType==null OR (threadType != soldier AND styleType==NIKEID)))
AND
(channels = nike.com OR channels = .com OR channels = SNKRS OR channels = Nike.com legacy)
AND
(hideFromSearch != true OR hideFromSearch = null)
```

**Bootroom**
```
channelId = d9a5bc42-4b9c-4976-858a-f159cf99c647
AND
status = ACTIVE
AND
available = true
AND
(threadType != soldier AND styleType != NIKEID)
AND
channels = Bootroom
AND
hideFromSearch != true OR hideFromSearch = null
```

**Facebook Messenger**
```
(channelId = d9a5bc42-4b9c-4976-858a-f159cf99c647
AND
status = ACTIVE
AND
((available = true AND effectiveStartViewDate <= now)
OR
(available = true
AND
(hardLaunch = null OR hardLaunch==false)))
AND
exclusiveAccess = false
AND
(commerceCountryExclusions = null OR commerceCountryExclusions != {excludeMarketplaceParam})
AND
((threadType = null OR (threadType = soldier AND styleType != NIKEID))
OR
(styleType = null OR (threadType != soldier AND styleType = NIKEID)))
AND
(channels = nike.com OR channels = .com OR channels = Nike.com OR channels = SNKRS OR channels = Nike.com legacy)
AND
(hideFromSearch != true OR hideFromSearch = null))
```

**Nike App Visual Search**
```
channelId = d9a5bc42-4b9c-4976-858a-f159cf99c647
AND
taxonomyAttributeSearchIds = 16633190-45e5-4830-a068-232ac7aea82c
AND
(taxonomyAttributeSearchIds != 92be6a0f-24dd-4e2e-87d0-5ce4ade3a923
OR
taxonomyAttributeSearchIds != efc99096-767d-40d9-a954-019b35858310
OR
taxonomyAttributeSearchIds != 3a4e07b5-2fc4-43f6-a480-ce6ed9030ac6
OR
taxonomyAttributeSearchIds != 9215b17d-efa4-4258-aabf-d5af737cde05
OR
taxonomyAttributeSearchIds != a2e74fc6-5388-4fc7-9cb5-801e1d8b42eb)
```

>**TIP:** E-commerce search is not the source of data. Data originates in the [Product Feed Rollup Threads V2 service](/doc/commerce/product/use-rollup-threads.html).

### Results

Several factors affect e-commerce search results, including product attributes and the fields those product attributes are assigned to. If a product's state field is not set to ACTIVE or the product's "hide from search" attribute it marked "true", a product rule may filter out the product from the search results. Similarly, if a search keyword is not in a field that search indexes, the product will not be included in the search results.

### Rankings

A search rule can be assigned a priority to influence when the rule is applied in relation to other rules. Rules with a high priority get applied first. Rules assigned a low priority ensure that higher priority rules are applied first.

Behind the scenes, the rules engine uses signals as part of the search strategy to influence search rankings. Signals are either consumer or business driven. Consumer driven signals are trends based on consumer behavior over a period of time. For example, a signal could boost the product that had the most viewed product display page within the past week, or a signal could boost the product that was most added to cart within the past month. Because this type of signal is an aggregate of consumer actions, consumer driven signals are constantly changing. Signals can also be driven by marketing objectives. The signal for the newest product or the signal for the product with the highest margin could boost those products to the top of the search rankings.

## Troubleshooting

If the products returned by e-commerce search are either not ranked as you expect or not returned at all, there are a few steps you can take to trouble shoot.

### Check Splunk
Use Splunk to trace the call to provide insight into what rules are being applied and what results the Search API returns.  All you need is the Trace Id. See the [Query Logs with a Trace ID](/content/doc/getting-started/using-nike-apis.html#query-logs-with-a-trace-id) section of the Using Nike APIs guide to learn how to get and use the trace id of the response to query Splunk.

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

Ensure that the product is set up correctly to be found by search. If you know the style-color or product id, you can call the [Merchandised Product API](/doc/commerce/product/use-merch-product.html) directly to look at the product details. Note that not all fields in the Merchandised Product are exposed in the Product Feed API.

If you are unable to locate the product in Merchandised Product, you may need to go even further upstream in the product life cycle. Check the Prodigy Merchandising Tool to troubleshoot why the product has not streamed into the Merchandised Product system yet.

## Contacting the Team

Need to reach out to the Search team?

|Method|Contact|
|---|---|
|Slack|[#search-integration](https://nikedigital.slack.com/messages/C4MGZ8GDB){:target="new-tab"}|
|Confluence space|[Content Discovery Team](https://confluence.nike.com/display/SEARCH/Content+Discovery+in+the+Cloud){:target="new-tab"}|
|Mailing List|[Lst-nde.pdm.merch.dev@nike.com](mailto:Lst-digitaltech.merch.apis)|
|Email the Product Manager|[Jeremy Myrland](mailto:jeremy.myrland@nike.com) (Search)<br>[Patti Cousins](mailto:patrcia.cousins@nike.com) (Apollo Tool)|

## Document Change Log

|Summary|Date|
|---|---|
|Initial publish|08/7/2018|

## Related Links

- [Using Nike APIs](/doc/getting-started/using-nike-apis.html)
- [Glossary](/doc/commerce/reference/glossary.html)