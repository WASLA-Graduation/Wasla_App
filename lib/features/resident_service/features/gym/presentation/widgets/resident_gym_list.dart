import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/manager/cubit/gym_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/widgets/resident_gym_item.dart';

class ResidentGymList extends StatelessWidget {
  const ResidentGymList({super.key, required this.isLoading});
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymResidentCubit>();
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels ==
                notification.metrics.maxScrollExtent &&
            notification is ScrollUpdateNotification) {
          cubit.getAllGyms(fromPagination: true);
        }
        return true;
      },
      child: Column(
        spacing: 20,
        children: [
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(bottom: 20),
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              physics: const BouncingScrollPhysics(),
              itemCount: cubit.allGyms.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  context.pushScreen(AppRoutes.gymResidentDetailsScreen);
                },
                child: ResidentGymItem(
                  index: index,
                  withoutFav: true,
                  gym: cubit.allGyms[index],
                ),
              ),
            ),
          ),
          Visibility(
            visible: isLoading,
            child: Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
