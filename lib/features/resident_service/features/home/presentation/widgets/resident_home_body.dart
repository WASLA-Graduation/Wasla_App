import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/resident_service/features/home/data/models/category_service_model.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_bannar_widget.dart';
import 'package:wasla/core/widgets/custom_home_app_bar.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_identfier_widget.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/search/custom_search_bar.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_service_category_list.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/user_event/user_event_recommended_list.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/user_event/user_event_top_week_list.dart';

class ResidentHomeBody extends StatelessWidget {
  const ResidentHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
      child: Column(
        children: [
          BlocBuilder<HomeResidentCubit, HomeResidentState>(
            buildWhen: (previous, current) =>
                current is HomeResidentGetProfileSuccess,
            builder: (context, state) {
              final cubit = context.read<HomeResidentCubit>();

              return CustomHomeAppBar(
                isLoading: cubit.user == null,
                userName: cubit.user?.fullName,
                imageUrl: cubit.user?.imageUrl,
                onBookmarkTap: () {
                  context.pushScreen(AppRoutes.allFavouritesScreen);
                },
              );
            },
          ),

          SizedBox(height: AppSizes.paddingSizeThelve),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: CustomSearchBar(
                    onTap: () {
                      context.pushScreen(AppRoutes.residentSearchScreen);
                    },
                  ),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(height: AppSizes.paddingSizeThelve),
                ),

                SliverToBoxAdapter(
                  child: CustomIdentfierWidget(
                    leadingText: "spacialOffers".tr(context),
                    actionText: "seeAll".tr(context),
                    onTap: () async {},
                  ),
                ),

                SliverToBoxAdapter(child: CustomBannarWidget()),

                SliverToBoxAdapter(
                  child: CustomIdentfierWidget(
                    leadingText: "services".tr(context),
                    actionText: "seeAll".tr(context),
                    onTap: () {
                      context.pushScreen(AppRoutes.allServicesScreen);
                    },
                  ),
                ),

                CustomServiceCategoryList(
                  listLength: CategoryServiceModel.categories.length,
                ),

                SliverToBoxAdapter(
                  child: SizedBox(height: AppSizes.paddingSizeThelve),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    "recommend".tr(context),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: AppSizes.paddingSizeFifteen),
                ),

                SliverToBoxAdapter(child: UserEventRecommendedList()),
                SliverToBoxAdapter(
                  child: SizedBox(height: AppSizes.paddingSizeThelve),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    "topOfTheWeek".tr(context),
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: AppSizes.paddingSizeFifteen),
                ),

                SliverToBoxAdapter(child: UserEventTopWeekList()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
