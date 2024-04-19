import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_demo/app/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'router.dart';


class Application extends ConsumerStatefulWidget {
  const Application({super.key});

  @override
  ConsumerState<Application> createState() => _ApplicationState();
}

class _ApplicationState extends ConsumerState<Application> with WidgetsBindingObserver {
  
  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        locale: const Locale('es'),
        builder: DevicePreview.appBuilder,
        theme: AppTheme.materialTheme,
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      );
    }));
  }
}
