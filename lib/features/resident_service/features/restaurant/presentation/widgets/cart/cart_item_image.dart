import 'package:flutter/material.dart';

/// Square thumbnail for a cart item.
/// Shows a network image when [imageUrl] is non-empty,
/// falls back to a neutral placeholder icon otherwise.
class CartItemImage extends StatelessWidget {
  const CartItemImage({super.key, required this.imageUrl});

  final String imageUrl;

  static const double _size = 58;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: _size,
        height: _size,
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _Placeholder(),
              )
            : _Placeholder(),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: const Center(
        child: Icon(Icons.fastfood_outlined, size: 24, color: Colors.grey),
      ),
    );
  }
}
