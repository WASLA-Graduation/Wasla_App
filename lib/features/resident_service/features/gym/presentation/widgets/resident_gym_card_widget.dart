import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/custom_circle_with_data_list.dart';
import 'package:wasla/core/widgets/custom_details_card_widget.dart';
import 'package:wasla/core/widgets/readmore_text.dart';
import 'package:wasla/features/profile/data/models/gym_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_text_identfier_widget.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/widgets/gym_details_card_text.dart';
import 'package:wasla/features/reviews/presentation/widgets/add_review_widget.dart';
import 'package:wasla/features/reviews/presentation/widgets/custom_reviws_list.dart';

class ResidentGymCardWidget extends StatelessWidget {
  const ResidentGymCardWidget({super.key, required this.gym});
  final GymModel gym;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      children: [
        CustomDoctorDatailsCardWeiget(
          withHero: false,
          imageUrl: gym.profilePhoto,
          child: GymDetailsCardText(gym: gym),
        ),
        const SizedBox(height: 18),
        CustomCircleWithDataList(items: _getItemList(context)),
        const SizedBox(height: 18),
        TextDetailsIdentfierWidget(
          leading: "aboutGym".tr(context),
          trailing: "seePackages".tr(context),
          onTap: () {},
        ),

        const SizedBox(height: 10),
        ReadmoreText(maxLines: 2, text: gym.description),
        const SizedBox(height: 15),
        TextDetailsIdentfierWidget(
          leading: "reviwes".tr(context),
          trailing: "seeAll".tr(context),
          onTap: () {
            context.pushScreen(AppRoutes.reviewScreen);
          },
        ),
        const SizedBox(height: 15),
        CustomAddReviweWidget(serviceProviderId: gym.id),
        const SizedBox(height: 15),
        ReviewsList(length: 7, shrinkWrap: true),
      ],
    );
  }

  List<CircleStatModel> _getItemList(BuildContext context) {
    return [
      CircleStatModel(
        icon: Assets.assetsImagesGroup,
        title: "trainnees".tr(context).toLowerCase(),
        value: "10000+",
      ),

      CircleStatModel(
        icon: Assets.assetsImagesHalfStar,
        title: "rating".tr(context).toLowerCase(),
        value: gym.rating.toStringAsPrecision(2),
      ),
      CircleStatModel(
        icon: Assets.assetsImagesChatFilled,
        title: "reviwes".tr(context).toLowerCase(),
        value: "${gym.reviewsCount}+",
      ),
    ];
  }
}
