import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_router.dart';
import 'package:wasla/core/config/themes/app_theme.dart';
import 'package:wasla/core/functions/buid_appCubits.dart';
import 'package:wasla/core/functions/change_status_bar_theme.dart';
import 'package:wasla/core/functions/handle_initial_route.dart';
import 'package:wasla/core/manager/global/global_cubit.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/views/doctor_dashboard_view.dart';

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

          return MaterialApp(
            supportedLocales: const [Locale('ar'), Locale('en')],
            localizationsDelegates: _getDelegates,
            locale: globalCubit.locale,
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme(context),
            darkTheme: AppThemes.darkTheme(context),
            themeMode: globalCubit.themeMode,
            initialRoute: handleInitialRoute(),
            // home: DoctorDashboardView(),
            onGenerateRoute: AppRouter.onGenerateRoute,
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
