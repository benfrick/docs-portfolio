## Methods

### applyMyDesign

Description: Loads the design associated with the included designKey into the Builder. The `onProductLoad` bridge method will be called in response to a successful load.

Usage:
```javascript
builderApi.applyMyDesign(1561569431459)
```

### clearJerseyCustomization

Description: Clears the customization (un-answers questions) and returns the new build data, for jerseys exclusively.

Usage:

```javascript
builderApi.clearJerseyCustomization()
```

### clearMessage

Description: Clears the message in the Builder.

Usage:
```javascript
builderApi.clearMessage()
```

### deleteMyDesign

Description: Deletes the myDesign associated with the included designKey from the localStorageCache. See also [deleteMyDesigns](#deletemydesigns)

Usage:
```javascript
builderApi.deleteMyDesign(1561569431459)
```

### deleteMyDesigns

Description: Deletes all of the myDesigns from the localStorageCache. See also [deleteMyDesign](#deletemydesign)

Usage:
```javascript
builderApi.deleteMyDesigns()
```

### getAffectedQuestionMap

Description: Return questionsMappingInfo based on the questionId

Usage:
```javascript
/**
* @returns {Array}
*/
builderApi.getAffectedQuestionMap()

```

### getAnswersByCode

Description: Returns answers and their matching questionsId which can then be used to display an answer. Useful for tapping into specific question or answer nodes.

Usage:

```javascript
/**
* @returns {Array} List of normalized questions
*/
builderApi.getAnswersByCode('jersey')
```

### getAvailability

Description: Returns promise to fetch availability information for the current configuration.

Usage:

```javascript
/**
• @returns {Promise->Array} a promise to return availability data
*/
builderApi.getAvailability()
```

### getAvailabilityMessages

Description: Returns promise to fetch availability messages information for the current configuration.

Usage:

```javascript
/**
• @returns {Promise->Object} a promise to return availability messages including leadtimeUpperBoundInDays, longCapacityMessage, and shortCapacityMessage
*/
builderApi.getAvailabilityMessages()
```

### getBomXML

Description: Returns the Bill Of Materials (BOM) in XML format. Filters out options with blank pidText, meaning, if the user selects only customizable options and enters no text for those options, then there will be no customization returned. Returns a Promise that either:

- Resolves to a metricId, if the builder data is valid

OR

- Rejects with an error message, if the builder data is invalid

Usage:

```javascript
builderApi.getBomXML()
```

### getBuild

Description: Returns the current build snapshot. Filters out options with blank pidText, meaning, if the user selects only customizable options and enters no text for those options, then there will be no customization returned.  Also, returns the isJerseyCustomized data.

Usage: 

```javascript
/**
* @return {Object} The current build snapshot
*/
builderApi.getBuild()
```

### getCapacity

Description: Returns promise to fetch capacity information for current or passed-in product configuration.

Usage: 

```javascript
/**
* @returns {Promise->Object} a promise to return capacity data
*/
builderApi.getCapacity().then() 
// or
builderApi.getCapacity({ country, pathName }).then()
```

### getLeadTimeMessage

Description: Returns promise to fetch lead time information for current or passed-in product configuration.

```javascript
/**
* @returns {Promise->Object} a promise to return leadTimeMessage data
*/
builderApi(getLeadTimeMessage)
```

### getMarketingComponents

Description: Returns a list of normalized marketing components with nested question keys. The questions index can be used to lookup nested question values.

Usage:

```javascript
/**
* @returns {Object} the current prouduct marketing components data
*/
builderApi.getMarketingComponents()
```

### getMyDesigns

Description: Gets all of the myDesigns from the localStorageCache. Returns an Array of myDesigns sorted from newest to oldest.

Usage:
```javascript
/**
* @returns {Array}
*/
builderApi.getMyDesigns()
```

### getProductColorPalette

Description: Returns a list of unique colors for the loaded builder.

Usage:

```javascript
/**
* @return {Array} List of selected color answers unique by hex
*/
builderApi.getProductColorPalette()
```
### getProductFillColors

Description: Returns a list of unique colors applicable to all marketing components for the loaded Builder

Usage:
```javascript
/**
* @returns {Array} List of selected color answers unique by hex
*/
builderApi.getProductFillColors()
```

### getQuestionsIndex

Description: Returns a normalized array of questions keyed by their ID. Effectively, this is a flattened tree of all questions contained in the product data with nested questions as keys.

Usage:
```javascript
/**
* @returns {Array} List of normalized questions
*/
builderApi.getQuestionsIndex()
```

Example:

```
{
  pathName:questionId: {
    id: 'pathName:questionId',
    isHidden: false,
    questions: [
      0: 'pathName:questionId:nestedQuestionId'
    ]
  }
}
```

### getSelectedColors

Description: Returns a collection of all selected colors from the current build, unique by hex(attribute).

Usage:

```javascript
/**
* @returns {Array} List of selected color answers unique by hex
*/
builderApi.getSelectedColors()
```

### getSelectedColorsPatterns

Description: Returns a collection of all selected colors and patterns from the current build. Colors are unique by hex(attribute) and patterns are unique by src(attribute).

Usage: 
```javascript
/**
* @returns {Array} List of selected color answers unique by hex & pattern type questions unique by src
*/
builderApi.getSelectedColorsPatterns
```

### getSelectedPalette

Description: Returns a list of unique colors for the selected answers of the loaded builder.

Usage:

```javascript
/**
* @returns {Array} List of selected color answers unique by displayName
*/
builderApi.getSelectedPalette()
```

### getSelectedPatterns

Description: Returns a collection of all selected patterns from the current build, unique by src(attribute).

Usage:

```javascript
/**
* @returns {Array} List of selected pattern answers unique by src
*/
builderApi.getSelectedPatterns
```

### getSelectedQuestionAnswerPairs

Description: Returns a collection of all answered questions along with their answer. For most products this will return the majority of questions, as defaults are selected in B16 APIs.

Usage:

```javascript
/**
* @returns {Array}
*/
builderApi.getSelectedQuestionAnswerPairs
```
### getUpCharges

Description: Returns an array of applicable up-charge objects corresponding to the answered questions.

Usage:

```javascript
/**
* @returns {Object}
*/
builderApi.getUpCharges()
```
Example:

```
[
    {
      answer: "ANSWER_ID",
      displayName: "Display Name",
      question: "QUESTION:PATH",
      upCharge: "$0"_
    }
]
```

### isJerseyCustomized

Description: Returns information on the jersey customization. Filters out options with blank pidText, meaning, if the user selects only customizable options and enters no text for those options, then the function will return false.

Usage:

```javascript
builderApi.isJerseyCustomized()
```

### isPidAllowed

Description: Returns true if the profanity service allowed the string (no stop word was matched). String passed must match records in the capacity service exactly. Only single strings are supported.

Usage:

```javascript
/**
* @returns {Promise->Boolean} a promise to return profanity result
*/
builderApi.isPidAllowed('MYPID')
```

### openHighResImageUrl

Description: Returns the high-resolution image URL in a new window.

```javascript
builderApi.openHighResImageUrl()
```

### saveBuild (Deprecated)

Description: Persists build data and returns promise to send back a metric ID for that build.

Usage:

```javascript
/**
* @returns {Promise->String}
*/

builderApi.saveBuild()
```

### saveDesign

Description: Persists the current build after validating it can be purchased. Filters out options with blank pidText, meaning, if the user selects only customizable options and enters no text for those options, then there will be no customization returned. Returns a Promise that either:

- Resolves to a metricId, if the builder data is valid

OR

- Rejects with an error message, if the builder data is invalid

Usage:

```javascript
/**
* @returns {Promise->String}
*/

builderApi.saveDesign()
```

### saveMyDesign

Description: Saves a myDesign to the localStorageCache. Returns the new Array of myDesigns sorted from newest to oldest.

Usage:
```javascript
/**
* @returns {Array}
*/
builder.Api.saveMyDesign
```

### setAnswer

Description: Returns the current build snapshot after changing the answer to a question in the Builder. Send the full question path, e.g. `"af1High14_July:LTITEM8170:LTITEM12012:LTITEM236023:LTITEM213006"` and the ID of the answer you would like to apply for that question, e.g. `"LTITEM167036"`.

Usage:

```javascript
/**
* @param {String} questionId
* @param {String} answerId
* @param {String} pidValue
* @returns {Object} Updated build snapshot
*/
builderApi.setAnswer(questionId, answerId, pidValue)
```

### setBuild

Description: Allows reloading the Builder with a new product by passing one of the following:

###### Table 7:  Parameters for setBuild Method

|Param|Type|Result|Example|
|---|---|---|---|
|`metricId`|String|Build is loaded and applied to the product data.|`setBuild({ metricId: 123456789 });`|
|`prebuildId`|String|Build is loaded and applied to the product data.|`setBuild({ prebuildId: 123456789 });`|
|`buildData`|Object|Product for that build is reloaded and has the build data applied to the product.|`setBuild({ buildData: buildData });`|

After calling this method the `bridge.onProductLoad` callback is called with the `buildData` for the newly-applied build.

Usage:

```javascript
/**
* @param {Object} buildData
*/
builderApi.setBuild(buildData)
```

### setIsVisible

Description: Informs the Builder whether it is visible on-screen or not. To take effect, `enableAnimationInit: true` needs to be passed in the initialization config options.

Usage:

```javascript
builderApi.setIsVisible(true)
```

### setMessage

Description: Causes the Builder to display a message. Takes a message object consisting of the following properties:

###### Table 8:  Properties of Message Object in setMessage

|Field|Type|Description|
|---|---|---|
|`header`|String|The text displayed at the top of the message.|
|`content`|String|The text displayed under the header.|
|`type`|String|The type of message to be displayed, which controls how the message is displayed. Default is 'COUNTDOWN'. Possible values are: <br>'COUNTDOWN', <br>'COUNTDOWN_URGENT', <br>'COUNTDOWN_EXPIRED'|

Usage:

```javascript
/**
* @param {Object} message
*/
builderApi.setMessage(message)
```

Examples:

```javascript
var countdownMessage = { header: 'Available for', content: '22:14:54:06', type: 'COUNTDOWN' };
builderApi.setMessage(countdownMessage);

var countdownUrgentMessage = { header: 'Available for', content: '00:00:10:06', type: 'COUNTDOWN_URGENT' };
builderApi.setMessage(countdownUrgentMessage);

var countdownExpiredMessage = { header: 'Great choice but...', content: 'This one sold out fast. Check back soon for availability. Keep customizing, save your design and share it with friends.', type: 'COUNTDOWN_EXPIRED' };
builderApi.setMessage(countdownExpiredMessage);

```

### setSizeAnswer

Description: Given a question ID and answer ID, answer the corresponding question in the build.

Usage:

```javascript
/**
* @param {String} questionId
* @param {String} answerId
* @param {String} sizeType
* @returns {Object} Updated build snapshot
*/
setSizeAnswer(questionId, answerId, sizeType)
```

### setSizeType

Description: Allows updating the Builder's internal state for selected size type, which updates the size, price, and color data when the Builder creates the buildData.

Usage:

```javascript
/**
* @param {String} sizeType
* @returns {Object} Updated build snapshot
*/
builderApi.setSizeType(sizeType)
```

### shareDesign

Description: Persists the current build and returns Promise that resolves to a metricId. Unlike [saveDesign](#savedesign), with `shareDesign` no validation is done on the build.

### showNotification

Description: Causes the Builder to display a notification. It takes a message object consisting of the following properties:

###### Table 9:  Properties of Message Object in showNotification Method

|Field|Type|Description|
|---|---|---|
|`type`|String|The type of message. Only one message of a given type will be displayed.|
|`message`|String|The message text.|
|`level`|String|Optional - Determines the message level. Possible values: 'alert', undefined/null.|
|`title`|String|Optional - The message title.|

Usage:

```javascript
/**
* @param {Object} message
*/
builderApi.showNotification(message)
```

Examples:

```javascript
var alert = { message: 'This is an alert with the orange thing', level: 'alert', type: 'some val' };
builderApi.showNotification(alert);

var titled = { message: 'This is just a plain message, but with a title', title: 'Hey yo!', type: 'some val' };
builderApi.showNotification(titled);

var plain = { message: 'just a plain old message. not that fun, sorry.', type: 'some val' };
builderApi.showNotification(plain);
```