import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/localizedDays.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';

class CustomWeakDaysWidget extends StatefulWidget {
  const CustomWeakDaysWidget({super.key, this.daysIndex});
  final List<int>? daysIndex;

  @override
  State<CustomWeakDaysWidget> createState() => _CustomWeakDaysWidgetState();
}

class _CustomWeakDaysWidgetState extends State<CustomWeakDaysWidget> {
  @override
  void initState() {
    checkDaysSelected();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorServiceMangementCubit>();
    return BlocBuilder<
      DoctorServiceMangementCubit,
      DoctorServiceMangementState
    >(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "selectDays".tr(context),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  7,
                  (index) => InkWell(
                    onTap: () {
                      cubit.addOrRemoveDaysIndex(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: cubit.daysIndices.contains(index)
                            ? AppColors.primaryColor
                            : AppColors.grayDark.withOpacity(0.16),
                        border: Border.all(
                          color: cubit.daysIndices.contains(index)
                              ? AppColors.primaryColor
                              : AppColors.gray,
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        localizedDays(index: index).tr(context),
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.w400,
                              color: cubit.daysIndices.contains(index)
                                  ? AppColors.whiteColor
                                  : AppColors.gray,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: cubit.daysSelected == null
                  ? false
                  : cubit.daysSelected == true
                  ? false
                  : true,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Text(
                    "selectAtLeastOneDay".tr(context),
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall!.copyWith(color: AppColors.red),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void checkDaysSelected() {
    final cubit = context.read<DoctorServiceMangementCubit>();

    if (widget.daysIndex != null) {
      cubit.daysIndices = {};
      cubit.daysIndices.addAll(widget.daysIndex!);
    }
  }
}
