import 'package:flutter/material.dart';
import 'package:wasla/core/utils/assets.dart';

class CustomDoctorImage extends StatelessWidget {
  const CustomDoctorImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.assetsImagesTest),
        ),
      ),
    );
  }
}