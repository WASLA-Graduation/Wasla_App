import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/resident_service/features/home/data/models/category_service_model.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_service_category_list.dart';

class AllServicesView extends StatelessWidget {
  const AllServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("allServices".tr(context))),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
        child: SizedBox(
          child: CustomScrollView(
            slivers: [
              CustomServiceCategoryList(
                listLength: CategoryServiceModel.categories.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
