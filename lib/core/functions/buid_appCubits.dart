import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/manager/global/global_cubit.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/auth/data/repo/auth_repo_impl.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/doctor_service/features/home/data/repo/doctor_dashboard_repo_impl.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/doctor_service/features/service/data/repo/doctor_service_mangement_repo_impl.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';
import 'package:wasla/features/profile/data/repo/profile_repo_impl.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/data/repo/doctor_repo_impl.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/home/data/repo/home_repo_impl.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

List<SingleChildWidget> get buildAppCubits {
  return [
    BlocProvider(create: (context) => GlobalCubit(), lazy: true),
    BlocProvider(
      create: (context) => AuthCubit(AuthRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) =>
          HomeResidentCubit(HomeRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) => DoctorCubit(DoctorRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) =>
          ProfileCubit(ProfileRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) =>
          DoctorHomeCubit(DoctorDashboardRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) => DoctorServiceMangementCubit(
        DoctorServiceMangementRepoImpl(api: sl<ApiConsumer>()),
      ),
      lazy: true,
    ),
  ];
}
