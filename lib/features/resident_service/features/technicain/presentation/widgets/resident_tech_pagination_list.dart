import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/enums/event_type.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/technicain/data/models/resident_technician_model.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/manager/cubit/resident_technician_cubit.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/widgets/resident_tech_pagination_list_item.dart';

class ResidentAllTechinicalsPaginationList extends StatelessWidget {
  const ResidentAllTechinicalsPaginationList({
    super.key,
    required this.technicals,
  });
  final List<ResidentTechnicianModel> technicals;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentTechnicianCubit>();
    return PaginationListener(
      onLoadMore: () async {
        cubit.getTechniciansBySpeciality(fromPagination: true);
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              physics: const BouncingScrollPhysics(),
              itemCount: technicals.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  context.pushScreen(
                    AppRoutes.residentTechnicianDetailsScreen,
                    arguments: {
                      AppStrings.name: technicals.elementAt(index).name,
                      AppStrings.id: technicals.elementAt(index).id,
                    },
                  );

                  context.read<HomeResidentCubit>().createUserEvent(
                    serviceProviderId: technicals[index].id,
                    eventType: EventType.viewDetails,
                  );
                },
                child: ResidentTechPaginationListItem(
                  withFav: true,
                  index: index,
                  technical: technicals.elementAt(index),
                ),
              ),
            ),
          ),

          BlocBuilder<ResidentTechnicianCubit, ResidentTechnicianState>(
            builder: (context, state) {
              return state
                      is ResidentGetTechniciansSpecializationsLoadingFromPagination
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
