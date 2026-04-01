import 'package:flutter/material.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_identfier_widget.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_not_found_widget.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_search_bar.dart';

class ResidentSearchBody extends StatelessWidget {
  const ResidentSearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: SizeConfig.blockHeight * 8,
        bottom: 0,
      ),
      child: Column(
        children: [
          CustomSearchBar(onChanged: (value) {}, readOnly: false),
          SizedBox(height: 7),
          CustomIdentfierWidget(
            leadingText: "Recent",
            actionText: "Clear All",
            onTap: () {},
          ),
          // CustomResultSearchTextWidget(title: "Doctor",total: 7099,),

          // Expanded(child: CustumSearchRecentList()),
          Expanded(child: CustomNotFoundWidget()),
        ],
      ),
    );
  }
}
