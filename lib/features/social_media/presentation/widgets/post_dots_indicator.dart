import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class PostDotsIndicator extends StatefulWidget {
  const PostDotsIndicator({
    super.key,
    required this.currentIndex,
    required this.length,
  });

  final int currentIndex;
  final int length;

  @override
  State<PostDotsIndicator> createState() => _PostDotsIndicatorState();
}

class _PostDotsIndicatorState extends State<PostDotsIndicator> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void didUpdateWidget(covariant PostDotsIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      const dotWidth = 8.0;
      const dotSpacing = 4.0;
      const visibleWidth = 60.0;

      final targetOffset =
          (dotWidth + dotSpacing) * widget.currentIndex -
          visibleWidth / 2 +
          dotWidth / 2;

      _scrollController.animateTo(
        targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 16,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: List.generate(widget.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 4),
              width: widget.currentIndex == index ? 8 : 4,
              height: widget.currentIndex == index ? 8 : 4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.currentIndex == index
                    ? AppColors.primaryColor
                    : Colors.grey,
              ),
            );
          }),
        ),
      ),
    );
  }
}
