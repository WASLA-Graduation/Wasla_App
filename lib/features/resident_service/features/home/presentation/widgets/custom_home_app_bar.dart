import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/assets.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 22,
        backgroundImage: AssetImage(Assets.assetsImagesProfile),
      ),
      title: Text(
        "Mostafa Salah",
        style: Theme.of(context).textTheme.bodySmall,
      ),
      subtitle: Text(
        "Welcome back!",
        style: Theme.of(context).textTheme.labelSmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {},
            child: Image.asset(
              Assets.assetsImagesNotification,
              width: 23,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(width: 12),
          InkWell(
            onTap: () {},
            child: Image.asset(
              Assets.assetsImagesBookmark,
              width: 23,
              color: context.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
