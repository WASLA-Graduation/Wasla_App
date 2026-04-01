import 'package:flutter/material.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';

class PulsingAvatar extends StatefulWidget {
  final String? imageUrl;
  final double size;
  final Color glowColor;
  final bool withImage;

  const PulsingAvatar({
    super.key,
    required this.imageUrl,
    this.size = 80,
    this.glowColor = const Color(0xFF4CAF50),
    required this.withImage,
  });

  @override
  State<PulsingAvatar> createState() => _PulsingAvatarState();
}

class _PulsingAvatarState extends State<PulsingAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 2.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(
      begin: 0.6,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size * 3,
      height: widget.size * 3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.glowColor.withOpacity(0.4),
                    ),
                  ),
                ),
              );
            },
          ),

          Container(
            width: widget.size + 16,
            height: widget.size + 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.glowColor.withOpacity(0.3),
            ),
          ),
          widget.withImage || widget.imageUrl!.isNotEmpty
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(widget.size / 2),
                  child: CustomCachedNetworkImage(
                    imageUrl: widget.imageUrl!,
                    height: widget.size / 1.8,
                    width: widget.size / 1.8,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
