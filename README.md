# flutter_i18n_demo
A sample of flutter i18n using [intl](https://pub.dev/packages/intl) &amp; [BloC](https://pub.dev/packages/flutter_bloc)
***
#### How it works
- The device's locale (language & country code like en-US, en-IN, es-US) is obtained using [flutter_device_locale](https://pub.dev/packages/flutter_device_locale)
- App defaults to en-US whenever locale is not supported
- The app locale is held in a [cubit](https://bloclibrary.dev/#/coreconcepts?id=cubit) (a simpler bloc basically)
- Whenever the user language selection changes, the bloc is updated which would rebuild the app with MaterialApp's locale attribute set to the new language, while retaining the regional code
***
#### Issues  
- flutter: MissingPluginException(No implementation found for method deviceLocales on channel flutter_device_locale)  
```flutter clean```