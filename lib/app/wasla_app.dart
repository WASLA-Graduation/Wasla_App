import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_router.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/config/themes/app_theme.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/manager/global/global_cubit.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/features/auth/data/repo/auth_repo_impl.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/data/repo/doctor_repo_impl.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

class WaslaApp extends StatelessWidget {
  const WaslaApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GlobalCubit(), lazy: true),
        BlocProvider(
          create: (context) => AuthCubit(AuthRepoImpl(api: sl<ApiConsumer>())),
          lazy: true,
        ),
        BlocProvider(create: (context) => HomeResidentCubit(), lazy: true),
        BlocProvider(
          create: (context) =>
              DoctorCubit(DoctorRepoImpl(api: sl<ApiConsumer>())),
          lazy: true,
        ),
        BlocProvider(create: (context) => ProfileCubit(), lazy: true),
      ],
      child: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) {
          final globalCubit = context.read<GlobalCubit>();

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
            theme: AppThemes.lightTheme(context),
            darkTheme: AppThemes.darkTheme(context),
            themeMode: globalCubit.themeMode,
            // initialRoute: handleInitialRoute(),
            initialRoute: AppRoutes.chnageLangScreen,
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
