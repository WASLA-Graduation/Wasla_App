import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_router.dart';
import 'package:wasla/core/config/themes/app_theme.dart';
import 'package:wasla/core/functions/handle_initial_route.dart';
import 'package:wasla/core/manager/cubit/global_cubit.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/utils/size_config.dart';

class WaslaApp extends StatelessWidget {
  const WaslaApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocProvider(
      create: (context) => GlobalCubit(),
      child: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) {
          final globalCubit = context.read<GlobalCubit>();
          globalCubit.changeLanguage(locale: Locale('ar'));

          return MaterialApp(
            supportedLocales: const [Locale('ar'), Locale('en')],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizations.delegate,
            ],
            locale: globalCubit.locale,
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme(
              fontFamily: globalCubit.locale.languageCode == 'ar'
                  ? 'Cairo'
                  : 'Roboto',
            ),
            darkTheme: AppThemes.darkTheme(
              fontFamily: globalCubit.locale.languageCode == 'ar'
                  ? 'Cairo'
                  : 'Roboto',
            ),
            themeMode: globalCubit.themeMode,
            initialRoute: handleInitialRoute(),
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
