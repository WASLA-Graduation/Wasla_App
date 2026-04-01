import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/home/data/models/category_service_model.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_service_category_list.dart';

class AllServicesView extends StatelessWidget {
  const AllServicesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Services")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CustomServiceCategoryList(
          listLength: CategoryServiceModel.categories.length,
        ),
      ),
    );
  }
}
