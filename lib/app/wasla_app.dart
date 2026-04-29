import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/go_router.dart';
import 'package:wasla/core/config/themes/app_theme.dart';
import 'package:wasla/core/functions/buid_app_cubits.dart';
import 'package:wasla/core/functions/change_status_bar_theme.dart';
import 'package:wasla/core/manager/global/global_cubit.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/widgets/internet/network_aware_wrapper.dart';

class WaslaApp extends StatelessWidget {
  const WaslaApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MultiBlocProvider(
      providers: buildAppCubits,
      child: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) {
          final globalCubit = context.read<GlobalCubit>();
          changeThemeStatusBar(globalCubit.themeMode);

          return ScreenUtilInit(
            designSize: const Size(375, 812),
            builder: (context, child) {
              return MaterialApp.router(
                scaffoldMessengerKey: scaffoldMessangerKey,
                routerConfig: appRouter,
                // navigatorKey: navigatorKey,
                supportedLocales: const [Locale('ar'), Locale('en')],
                localizationsDelegates: _getDelegates,
                locale: globalCubit.locale,
                title: AppStrings.appName,
                debugShowCheckedModeBanner: false,
                theme: AppThemes.lightTheme(context),
                darkTheme: AppThemes.darkTheme(context),
                themeMode: globalCubit.themeMode,
                builder: (context, child) =>
                    NetworkAwareWrapper(child: child ?? const SizedBox()),
              );
            },
          );
        },
      ),
    );
  }

  List<LocalizationsDelegate<dynamic>> get _getDelegates {
    return const [
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      AppLocalizations.delegate,
    ];
  }
}
