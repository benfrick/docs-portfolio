## Enable Purchasing

**Is the product available for purchase? How do I select a size? When would my design be delivered to me?**

The consumer is finished customizing their product, so it's time to get them ready for the checkout process.

#### Show Product Availability Messaging

Show the consumer on the PDP whether the product can be purchased. If it can, show an estimated lead time (in weeks) for the product to be delivered. Here a few example messages:

###### Table 4:  Product Availability Conditions with Corresponding PDP Message

|Condition|Message on PDP|
|---|---|
|Product is available|`"Custom-made and delivered to you in 4 weeks or less."`|
|Product is not available|`"The product is currently unavailable."`

To retrieve the availability and lead-time data, there are two options:

**Call the [Customization Availability API](https://developer.niketech.com/docs/projects/Customization%20Availability?tab=api)**

- The API returns availability by size, lead-time in days, and message text, all for a particular style-color.
- In the `pathName` query parameter, use the value in `objects.productInfo.customizedPreBuild.legacy.pathName` from the Product Feeds API response, like `https://api.nike.com/customization/availability/v1/us/en_US?filter=pathName(af1LowChampsSU19)`.

OR

**Read the Build Data**

- Availability: From the returned [Build Data](https://developer.niketech.com/docs/projects/Commerce%20Docs/Builder%20Reference/Builder%20API#build-data), if `sizingData.displayName` is "Size", then loop through `sizingData.answers` and evaluate whether `isAvailable` is true or false for all sizes.
- Lead Time: Call the [`getLeadTimeMessage`](https://developer.niketech.com/docs/projects/Commerce%20Docs/Builder%20Reference/Methods#getleadtimemessage) method of the Builder API to get the message text and lead time in days for the product.

>**TIP**: Remember, by initializing and interacting with the Builder API prior to showing the Builder UX, you can access the Build Data. See [Step 1: Load the Builder](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Using%20Customization/Show%20Products#step-1-load-the-builder) for more.

#### Show Gender, Width and Size Options and Confirm Consumer's Selections

Show the consumer all of the possible gender and size options for the product. From the possible sizes, show which sizes are available for purchase. Allow the consumer to make their gender and size selections.

**Show gender options (if applicable), and confirm consumer's selection**

- Use the info from the `sizingData` object (in the [Build Data](https://developer.niketech.com/docs/projects/Commerce%20Docs/Builder%20Reference/Builder%20API#build-data)) to display the available genders, making note of the respective `questionId` and `answerId` values.
- Using the `questionId` and `answerId` values for the gender selected by the consumer, call the [`setAnswer`](https://developer.niketech.com/docs/projects/Commerce%20Docs/Builder%20Reference/Methods#setanswer) method of the Builder API, like:

    ```javascript
    builderApi.setAnswer('ER2teamSP19_barca:LTITEM8538:LTITEM8112','LTITEM8011','')`
    ```
    This sets `isSelected: true` in `sizingData.answers`, indicating that a particular gender was selected.
    
- Note that selecting a gender will change the size options in `sizingData`.

**Show size and width options (if applicable), and confirm consumer's selection**

- Use the info from `sizingData` to display the available sizes, making note of the respective `questionId` and `answerId` values.
- Using the `questionId` and `answerId` values for the size selected by the consumer, call the [`setSizeAnswer`](https://developer.niketech.com/docs/projects/Commerce%20Docs/Builder%20Reference/Methods#setsizeanswer) method, like:
    
    ```javascript
    builderApi.setSizeAnswer('FUTUREELITEFA18:LTITEM8538:LTITEM8112:LTITEM8010:LTITEM403108','LTITEM8132','us-mens'))
    ```
    This sets `isSelected: true` in `sizingData.answers`, indicating that a particular size was selected.

>**TIP**: Answering the gender and size-related questions are the only required Builder interactions for a design to be purchasable. 

#### Save the Build

**Save the Build**

- Call the [`saveDesign`](https://developer.niketech.com/docs/projects/Commerce%20Docs/Builder%20Reference/Methods#savedesign) method like:

    ```javascript
    builderApi.saveDesign()
    ```    
    This saves the current build configuration and returns a promise to send a metric ID for that build.
    
#### Show 'Add to Cart' CTA

Once you have a metric ID for the build, the consumer should be able to add their design to the shopping cart.

**Show the consumer a way to add the product to their shopping cart with an 'Add to Cart' CTA.**

- Display an 'Add to Cart' CTA that adds the design to the cart.

- Example button code using [NCSS](https://tourguide.prod.commerce.nikecloud.com/ncss):

    ```html
    <button class="ncss-btn-primary-dark">Add to Bag</button>
    ```
    <button style="margin-top: 5px; margin-bottom: 5px;" class="ncss-btn-primary-dark">Add to Bag</button>

- This CTA should only be active once the gender, width, and size-related selections have been passed to the Builder, as shown in [Show Gender, Width, and Size Options and Confirm Consumer's Selections](https://developer.niketech.com/docs/projects/Commerce%20Docs/Customization/Using%20Customization/Enable%20Purchasing#show-gender-width-and-size-options-and-confirm-consumers-selections).

- Once active, the specific behavior of this CTA can vary depending on your requirements, but here is an example:

    - Call the [Carts API]() with the metric ID for the build to add the product to a cart.
    - Show an updated cart item count on the PDP and/or navigate the consumer to a cart page/view.

    >**TIP**: For more see [Adding Cart and Checkout to your Experience]().