import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/connection/network_info_impl.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/manager/network/network_cubit.dart';
import 'package:wasla/features/chat/data/repo/chat_repo_impl.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/driver/features/booking/data/repo/driver_booking_repo_impl.dart';
import 'package:wasla/features/driver/features/booking/presentation/manager/cubit/driver_booking_cubit.dart';
import 'package:wasla/features/driver/features/home/data/repo/driver_repo_impl.dart';
import 'package:wasla/features/driver/features/home/presentation/manager/cubit/driver_cubit.dart';
import 'package:wasla/features/driver/features/trip/data/repo/driver_trip_repo_impl.dart';
import 'package:wasla/features/driver/features/trip/presentation/manager/cubit/driver_trip_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/data/repo/residnet_driver_repo_impl.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/favourite/presentation/manager/cubit/favourite_cubit.dart';
import 'package:wasla/core/manager/global/global_cubit.dart';
import 'package:wasla/features/favourite/data/repo/favourite_repo_impl.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/auth/data/repo/auth_repo_impl.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/doctor_service/features/home/data/repo/doctor_dashboard_repo_impl.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/doctor_service/features/service/data/repo/doctor_service_mangement_repo_impl.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';
import 'package:wasla/features/gym/features/dashboard/data/repo/gym_dashboard_repo_imp.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/manager/cubit/gym_dashboard_cubit.dart';
import 'package:wasla/features/gym/features/packages/data/repo/gym_packages_repo_impl.dart';
import 'package:wasla/features/gym/features/packages/presentation/manager/cubit/gym_packages_cubit.dart';
import 'package:wasla/features/notifications/data/repo/notification_repo_impl.dart';
import 'package:wasla/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:wasla/features/profile/data/repo/profile_repo_impl.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/resident_service/features/booking/data/repo/resident_booking_repo_impl.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/manager/cubit/resident_booking_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/data/repo/doctor_repo_impl.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/gym/data/repo/gym_resident_repo_impl.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/manager/cubit/gym_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/home/data/repo/home_repo_impl.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/reviews/data/repo/reviews_repo_imp.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';
import 'package:wasla/features/social_media/data/repo/social_media_repo_impl.dart';
import 'package:wasla/features/social_media/presentation/manager/cubit/social_media_cubit.dart';
import 'package:wasla/features/technicant/features/home/data/repo/technicant_dashboard_repo_impl.dart';
import 'package:wasla/features/technicant/features/home/presentation/manager/cubit/technicant_dashboard_cubit.dart';

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
    BlocProvider(
      create: (context) =>
          ResidentBookingCubit(ResidentBookingRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) =>
          ReviewsCubit(ReviewsRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) =>
          FavouriteCubit(FavouriteRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) =>
          GymDashboardCubit(GymDashboardRepoImp(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) =>
          GymPackagesCubit(GymPackagesRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) =>
          GymResidentCubit(GymResidentRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) => NotificationCubit(
        notificationRepo: NotificationRepoImpl(api: sl<ApiConsumer>()),
      ),
      lazy: true,
    ),
    BlocProvider(
      create: (context) =>
          SocialMediaCubit(SocialMediaRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) =>
          ResidentDriverCubit(ResidnetDriverRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) => DriverCubit(DriverRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) => ChatCubit(ChatRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) =>
          DriverTripCubit(DriverTripRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) =>
          DriverBookingCubit(DriverBookingRepoImpl(api: sl<ApiConsumer>())),
      lazy: true,
    ),
    BlocProvider(
      create: (context) => NetworkCubit(sl<NetworkInfo>()),
      lazy: true,
    ),
    BlocProvider(
      create: (context) => TechnicantDashboardCubit(
        TechnicantDashboardRepoImpl(api: sl<ApiConsumer>()),
      ),
      lazy: true,
    ),
  ];
}
