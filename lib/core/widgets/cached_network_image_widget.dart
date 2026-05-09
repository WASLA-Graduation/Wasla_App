import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.loadingWidget,
    this.errorWidget,
    this.width,
    this.height,
    this.borderRadius,
  });

  final String imageUrl;
  final BoxFit? fit;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CachedNetworkImage(
      fit: fit ?? BoxFit.cover,
      imageUrl: imageUrl,
      width: width,
      height: height,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          loadingWidget ?? _DefaultLoadingWidget(width: width, height: height),
      errorWidget: (context, url, error) =>
          errorWidget ??
          _DefaultErrorWidget(
            width: width,
            height: height,
            colorScheme: colorScheme,
          ),
      imageBuilder: borderRadius != null
          ? (context, imageProvider) => ClipRRect(
              borderRadius: borderRadius!,
              child: Image(
                image: imageProvider,
                fit: fit ?? BoxFit.cover,
                width: width,
                height: height,
              ),
            )
          : null,
    );
  }
}

class _DefaultLoadingWidget extends StatelessWidget {
  const _DefaultLoadingWidget({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,

      child: Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class _DefaultErrorWidget extends StatelessWidget {
  const _DefaultErrorWidget({
    this.width,
    this.height,
    required this.colorScheme,
  });

  final double? width;
  final double? height;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.errorContainer.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colorScheme.errorContainer, width: 1.2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.broken_image_rounded,
            size: _iconSize,
            color: colorScheme.error.withOpacity(0.7),
          ),
          if (_hasEnoughHeight) ...[
            const SizedBox(height: 6),
            Text(
              'Failed to load',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colorScheme.error.withOpacity(0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }

  double get _iconSize {
    final h = height ?? 80;
    if (h < 48) return 16;
    if (h < 80) return 24;
    return 36;
  }

  bool get _hasEnoughHeight => (height ?? 80) >= 72;
}
