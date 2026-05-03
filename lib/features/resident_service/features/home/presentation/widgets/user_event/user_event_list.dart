import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/enums/service_role.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/features/favourite/presentation/manager/cubit/favourite_cubit.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_event_model.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/user_event/user_event_item.dart';

class UserEventList extends StatelessWidget {
  const UserEventList({super.key, required this.uesrEventList});

  final List<UserEventModel> uesrEventList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: uesrEventList.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) => InkWell(
          onTap: () async {
            final cubit = context.read<FavouriteCubit>();
            switch (ServiceRole.fromString(
              uesrEventList.elementAt(index).roleName,
            )) {
              case ServiceRole.doctor:
                await cubit.getDoctorData(doctorId: uesrEventList[index].id);
                if (cubit.doctorDataModel != null) {
                  context.pushScreen(
                    AppRoutes.doctorDetailsScreen,
                    arguments: cubit.doctorDataModel,
                  );
                } else {
                  toastAlert(
                    color: AppColors.error,
                    msg: "Something went wrong",
                  );
                }
                break;

              case ServiceRole.restaurantOwner:
                context.pushScreen(
                  AppRoutes.residentRestaurantDetailsScreen,
                  arguments: {
                    AppStrings.name: uesrEventList[index].name,
                    AppStrings.id: uesrEventList[index].id,
                  },
                );
                break;
              case ServiceRole.driver:
                return;
              case ServiceRole.gymOwner:
                context.pushScreen(
                  AppRoutes.gymResidentDetailsScreen,
                  arguments: {
                    AppStrings.gymName: uesrEventList[index].name,
                    AppStrings.gymId: uesrEventList[index].id,
                  },
                );
                break;

              case ServiceRole.technician:
                context.pushScreen(
                  AppRoutes.residentTechnicianDetailsScreen,
                  arguments: {
                    AppStrings.name: uesrEventList[index].name,
                    AppStrings.id: uesrEventList[index].id,
                  },
                );
                break;
            }
          },
          child: UserEventItem(userEvent: uesrEventList[index]),
        ),
      ),
    );
  }
}
