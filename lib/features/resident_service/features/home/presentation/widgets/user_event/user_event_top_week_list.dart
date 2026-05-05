import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/resident_service/features/home/data/models/user_event_model.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/user_event/user_event_list.dart';

class UserEventTopWeekList extends StatefulWidget {
  const UserEventTopWeekList({super.key});

  @override
  State<UserEventTopWeekList> createState() => _UserEventRecommendedListState();
}

class _UserEventRecommendedListState extends State<UserEventTopWeekList> {
  List<UserEventModel> topWeekList = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeResidentCubit, HomeResidentState>(
      buildWhen: (previous, current) =>
          current is HomeResidentGetTopOfTheWeekLoading ||
          current is HomeResidentGetTopOfTheWeekLoaded,
      builder: (context, state) {
        if (state is HomeResidentGetTopOfTheWeekLoading ||
            state is HomeResidentInitial) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else if (state is HomeResidentGetTopOfTheWeekLoaded) {
          topWeekList = state.topWeekList;
        }

        return topWeekList.isEmpty
            ? SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "topOfTheWeek".tr(context),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(height: AppSizes.paddingSizeFifteen),
                  UserEventList(uesrEventList: topWeekList),
                ],
              );
      },
    );
  }
}
