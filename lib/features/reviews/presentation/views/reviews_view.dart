import 'package:flutter/material.dart';
import 'package:wasla/features/reviews/presentation/widgets/reviews_body.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("All Reviews"),
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: ReviewdBody(),
      ),
    );
  }
}
