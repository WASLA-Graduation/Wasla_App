import 'package:flutter/widgets.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/custom_circle_with_data_list.dart';
import 'package:wasla/core/widgets/custom_details_card_widget.dart';
import 'package:wasla/core/widgets/readmore_text.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_text_identfier_widget.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/widgets/resident_tech_details_card_text.dart';
import 'package:wasla/features/reviews/presentation/widgets/add_review_widget.dart';
import 'package:wasla/features/reviews/presentation/widgets/custom_reviws_list.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';

class ResidentTechnacalDetailsWidget extends StatelessWidget {
  const ResidentTechnacalDetailsWidget({
    super.key,
    required this.technician,
    required this.techId,
  });
  final TechnicianModel technician;
  final String techId;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      children: [
        CustomDoctorDatailsCardWeiget(
          withHero: false,
          imageUrl: technician.profilePhotoUrl,
          child: ResidentTechDetailsCardText(technical: technician),
        ),
        const SizedBox(height: 18),
        CustomCircleWithDataList(items: _getItemList(context)),
        const SizedBox(height: 18),
        TextDetailsIdentfierWidget(
          leading: "aboutMe".tr(context),
          trailing: "bookNow".tr(context),
          onTap: () {},
        ),

        const SizedBox(height: 10),
        ReadmoreText(maxLines: 2, text: technician.description),
        const SizedBox(height: 15),
        TextDetailsIdentfierWidget(
          leading: "reviwes".tr(context),
          trailing: "seeAll".tr(context),
          onTap: () {
            context.pushScreen(AppRoutes.reviewScreen);
          },
        ),
        const SizedBox(height: 15),
        CustomAddReviweWidget(serviceProviderId: techId),
        const SizedBox(height: 15),
        ReviewsList(length: 7, withShrinkWrap: true),
      ],
    );
  }

  List<CircleStatModel> _getItemList(BuildContext context) {
    return [
      CircleStatModel(
        icon: Assets.assetsImagesGroup,
        title: "resident".tr(context).toLowerCase(),
        value: "10000+",
      ),

      CircleStatModel(
        icon: Assets.assetsImagesHalfStar,
        title: "rating".tr(context).toLowerCase(),
        value: technician.rate.toStringAsPrecision(2),
      ),
      CircleStatModel(
        icon: Assets.assetsImagesChatFilled,
        title: "reviwes".tr(context).toLowerCase(),
        value: "${10}+",
      ),
    ];
  }
}
