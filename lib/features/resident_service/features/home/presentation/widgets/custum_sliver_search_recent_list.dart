import 'package:flutter/material.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_recent_seach_item.dart';

class CustumSliverSearchRecentList extends StatelessWidget {
  const CustumSliverSearchRecentList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: 14,
      itemBuilder: (context, index) {
        return CustomSearchRecentitem();
      },
    );
  }
}

