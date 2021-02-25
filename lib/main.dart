
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_locale/flutter_device_locale.dart';
import 'package:flutter_i18n_demo/l10n/app_localizations.dart';
import 'package:flutter_i18n_demo/locale_cubit.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // from flutter_device_locale plugin
      future: DeviceLocale.getCurrentLocale(),
      builder: (context, snapshot) {
        Locale deviceLocale = snapshot.connectionState == ConnectionState.done && snapshot.hasData ?
          snapshot.data : Locale.fromSubtags(languageCode: 'en');

        if(snapshot.hasError) {
          print(snapshot.error);
        }

        // Default to en on unsupported locales
        if (!AppLocalizations.delegate.isSupported(deviceLocale)) {
          deviceLocale = Locale.fromSubtags(languageCode: 'en', countryCode: deviceLocale.countryCode);
        }

        return BlocProvider<LocaleCubit>(
          create: (BuildContext context) => LocaleCubit(deviceLocale),
          key: ObjectKey(deviceLocale), // Recreate on deviceLocale change. On refresh.
          child: BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) => MaterialApp(
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              locale: locale,
              home: HomePage(),
            ),
          )
      );
      }
    );
  }
}

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    LocaleCubit localeCubit = context.watch<LocaleCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter i18n Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton(items: [
              for ( var i in AppLocalizations.supportedLocales )
                DropdownMenuItem(child: Text(i.toLanguageTag()), value: i.languageCode,)
            ], value: localeCubit.state.languageCode, onChanged: (value) => localeCubit.setLocale(Locale.fromSubtags(languageCode: value, countryCode: localeCubit.state.countryCode)),),
            Text(AppLocalizations.of(context).helloWorld, style: TextStyle(fontFamily: 'noto', fontSize: 40,),),
            Text('${AppLocalizations.of(context).todayIs} ${DateFormat.yMMMMEEEEd(localeCubit.state.toLanguageTag()).format(DateTime.now())}', style: TextStyle(fontFamily: 'noto',),),
            Text(NumberFormat.decimalPattern(localeCubit.state.toLanguageTag()).format(1234567.89), style: TextStyle(fontFamily: 'noto',),),
            Text('${localeCubit.state}', style: TextStyle(fontFamily: 'noto'),),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('(Use chrome\'s locale switcher extension to switch locales for convenient testing)', style: TextStyle(fontFamily: 'noto', fontSize: 10),),
            ),
          ],
        ),
      ),
    );
  }
}
