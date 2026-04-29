import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/manager/cubit/gym_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/widgets/resident_gym_item.dart';

class ResidentGymList extends StatelessWidget {
  const ResidentGymList({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymResidentCubit>();

    return PaginationListener(
      onLoadMore: () {
        cubit.getAllGyms(fromPagination: true);
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(bottom: 20),
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              physics: const BouncingScrollPhysics(),
              itemCount: cubit.allGyms.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  context.pushScreen(
                    AppRoutes.gymResidentDetailsScreen,
                    arguments: {
                      AppStrings.gymId: cubit.allGyms[index].id,
                      AppStrings.gymName: cubit.allGyms[index].name,
                    },
                  );
                },
                child: ResidentGymItem(
                  index: index,
                  withoutFav: true,
                  gym: cubit.allGyms[index],
                ),
              ),
            ),
          ),

          BlocBuilder<GymResidentCubit, GymResidentState>(
            builder: (context, state) {
              return state is GymResidentGetAllGymsFromPaginationLoading
                  ? const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
