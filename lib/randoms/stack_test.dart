import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';

class StackTest extends StatelessWidget {
  const StackTest({super.key});

  @override
  Widget build(BuildContext context) {
    final double containerHeight = 170;
    final double imageSize = 130;
    final topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildContainer(containerHeight),
          ),

          Positioned(
            top: topPadding + 10,
            left: 16,
            child: Text(
              "Profile",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),

          Positioned(
            top: containerHeight - imageSize / 2,
            left: 0,
            right: 0,
            child: _buildColumnWidget(imageSize),
          ),
        ],
      ),
    );
  }

  Container _buildContainer(double containerHeight) {
    return Container(
      width: double.infinity,
      height: containerHeight,
      color: AppColors.primaryColor,
    );
  }

  Column _buildColumnWidget(double containerHeight) {
    return Column(
      children: [
        CircleNeworkImage(
          imageUrl:
              'https://waslammka.runasp.net/assets/images/user/4d1734ba-b4e7-45ef-8250-3a4d6c752403.jpg',
          isLoading: false,
          size: containerHeight,
        ),

        const SizedBox(height: 14),
        Text(
          'Mostafa Salah',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),

        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.star_border,
                  color: AppColors.primaryColor,
                  size: 28,
                ),
              );
            }),
          ],
        ),
      ],
    );
  }
}
