import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit,
    this.loadingWidget,
    this.errorWidget,
    this.width,
    this.height,
  });
  final String imageUrl;
  final BoxFit? fit;
  final Widget? loadingWidget;
  final Widget? errorWidget;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit ?? BoxFit.contain,
      imageUrl: imageUrl,
      width: width,
      height: height,

      progressIndicatorBuilder: (context, url, downloadProgress) =>
          loadingWidget ?? CupertinoActivityIndicator(),
      errorWidget: (context, url, error) => errorWidget ?? Icon(Icons.error),
    );
  }
}
