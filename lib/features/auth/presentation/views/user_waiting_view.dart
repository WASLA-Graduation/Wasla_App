import 'package:flutter/material.dart';
import 'package:wasla/features/auth/presentation/widgets/user_waiting_body.dart';

class UserWaitingView extends StatelessWidget {
  const UserWaitingView({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
  });
  final String title;
  final String subTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: UserWaitingBody(image: image, subTitle: subTitle, title: title),
      ),
    );
  }
}
