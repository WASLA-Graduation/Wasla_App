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

class UserEventRecommendedList extends StatefulWidget {
  const UserEventRecommendedList({super.key});

  @override
  State<UserEventRecommendedList> createState() =>
      _UserEventRecommendedListState();
}

class _UserEventRecommendedListState extends State<UserEventRecommendedList> {
  List<UserEventModel> recommendedList = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeResidentCubit, HomeResidentState>(
      buildWhen: (previous, current) =>
          current is HomeResidentGetRecommendedForYouLoading ||
          current is HomeResidentGetRecommendedForYouLoaded,
      builder: (context, state) {
        if (state is HomeResidentGetRecommendedForYouLoading ||
            state is HomeResidentInitial) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else if (state is HomeResidentGetRecommendedForYouLoaded) {
          recommendedList = state.recommendedList;
        }

        return recommendedList.isEmpty
            ? SizedBox.shrink()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    "recommend".tr(context),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(height: AppSizes.paddingSizeFifteen),
                  UserEventList(uesrEventList: recommendedList),
                ],
              );
      },
    );
  }
}
