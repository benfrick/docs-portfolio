function nikeIdBuilder(builderApi){
    var rootElement = document.getElementById('nike-id-builder-app');
    var config = {
        'nike-api-caller-id': 'com.nike:test',
        locale: 'en_US',
        country: 'US',
        pathName: 'af1High14_July',
        };
    var builderApi = nikeIdBuilder(rootElement, config)
}

window.onload = nikeIdBuilder;
