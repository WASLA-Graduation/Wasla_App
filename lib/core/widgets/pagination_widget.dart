import 'package:flutter/material.dart';

class PaginationListener extends StatelessWidget {
  const PaginationListener({
    super.key,
    required this.child,
    required this.onLoadMore,
    this.threshold = 0,
  });

  final Widget child;
  final VoidCallback onLoadMore;
  final double threshold;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - threshold &&
            notification.metrics.axis == Axis.vertical &&
            notification is ScrollUpdateNotification) {
          onLoadMore();
        }
        return false;
      },
      child: child,
    );
  }
}
