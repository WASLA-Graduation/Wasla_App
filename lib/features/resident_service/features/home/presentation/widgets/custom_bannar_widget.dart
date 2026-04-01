import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_bannar_item.dart';
import 'package:wasla/features/resident_service/features/home/presentation/widgets/custom_bannar_smooth_indicator.dart';

class CustomBannarWidget extends StatelessWidget {
  const CustomBannarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 160,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        ),
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: const CustomBannarPageSlider(),
    );
  }
}

class CustomBannarPageSlider extends StatefulWidget {
  const CustomBannarPageSlider({super.key});

  @override
  State<CustomBannarPageSlider> createState() => _CustomBannarPageSliderState();
}

class _CustomBannarPageSliderState extends State<CustomBannarPageSlider> {
  late PageController pageController;
  Timer? timer;

  final int bannerCount = 3;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: 0);

    _animatedPageView();
  }

  Timer _animatedPageView() {
    return timer = Timer.periodic(const Duration(seconds: 2), (_) {
      final cubit = context.read<HomeResidentCubit>();

      int nextIndex = cubit.currentIndex + 1;
      if (nextIndex >= bannerCount) {
        nextIndex = 0;
      }

      pageController.animateToPage(
        nextIndex,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );

      cubit.updateCurrentIndex(nextIndex);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          itemCount: bannerCount,
          onPageChanged: (index) {
            context.read<HomeResidentCubit>().updateCurrentIndex(index);
          },
          itemBuilder: (context, index) {
            return const CustomBannarItem();
          },
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: CustomBannarSmoothIndicator(),
        ),
      ],
    );
  }
}
