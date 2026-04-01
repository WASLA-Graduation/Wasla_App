import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/reviews/presentation/widgets/custom_review_item.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';

class ReviewsList extends StatefulWidget {
  const ReviewsList({
    super.key,
    required this.length,
    this.reviewId,
    this.withShrinkWrap,
  });
  final int? reviewId;
  final int length;
  final bool? withShrinkWrap;

  @override
  State<ReviewsList> createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList>
    with SingleTickerProviderStateMixin {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  int? highlightedIndex;
  late AnimationController animationController;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 2),
    );
    colorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.grey.withOpacity(0.15),
    ).animate(animationController);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void scrollToReview() {
    final cubit = context.read<ReviewsCubit>();
    if (widget.reviewId == null) return;

    int index = cubit.reviewList.indexWhere(
      (review) => review.reviewId == widget.reviewId,
    );
    if (index == -1) return;

    if (index > 5) {
      itemScrollController.scrollTo(
        index: index,
        duration: const Duration(seconds: 1),
        alignment: 0.5,
        curve: Curves.easeInOut,
      );
    }

    setState(() {
      highlightedIndex = index;
      animationController.repeat(reverse: true, count: 2).then((_) {
        setState(() {
          highlightedIndex = null;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReviewsCubit, ReviewsState>(
      listener: (context, state) {
        final cubit = context.read<ReviewsCubit>();
        if (state is GetReviewsSuccess &&
            widget.reviewId != null &&
            cubit.reviewList.any((r) => r.reviewId == widget.reviewId)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollToReview();
          });
        }
      },
      child: BlocBuilder<ReviewsCubit, ReviewsState>(
        builder: (context, state) {
          final cubit = context.read<ReviewsCubit>();
          if (state is GetReviewsLoading) {
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50.0,
              ),
            );
          } else if (cubit.reviewList.isEmpty) {
            return Center(
              child: Text(
                "noReviews".tr(context),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            );
          } else {
            return ScrollablePositionedList.separated(
              shrinkWrap: widget.withShrinkWrap ?? false,
              physics: widget.withShrinkWrap == true
                  ? const NeverScrollableScrollPhysics()
                  : const ClampingScrollPhysics(),
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              padding: const EdgeInsets.only(bottom: 20),
              separatorBuilder: (context, index) => const Divider(
                thickness: 0.019,
                color: AppColors.gray,
                height: 20,
              ),
              itemCount: cubit.reviewList.length < widget.length
                  ? cubit.reviewList.length
                  : widget.length,
              itemBuilder: (context, index) {
                bool isHighlighted = index == highlightedIndex;
                return AnimatedBuilder(
                  animation: colorAnimation,
                  builder: (context, child) => Container(
                    decoration: BoxDecoration(
                      color: isHighlighted ? colorAnimation.value : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: child,
                  ),

                  child: CustomReviewItem(reviewModel: cubit.reviewList[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}
