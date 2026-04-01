import 'package:flutter/material.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/cached_network_image_widget.dart';

class ChatItemImage extends StatelessWidget {
  const ChatItemImage({
    super.key,
    required this.images,
    required this.isMe,
    required this.sentAt,
  });
  final List<String> images;
  final bool isMe;
  final DateTime sentAt;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 3,
        children: [
          Row(
            children: [
              ...List.generate(
                images.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            width: double.infinity,
                            height: SizeConfig.screenHeight / 2,
                            padding: EdgeInsets.all(10),
                            child: CustomCachedNetworkImage(
                              imageUrl: images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      child: CustomCachedNetworkImage(
                        width: 80,
                        height: 80,
                        imageUrl: images[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(
            formatDateToCustomString(sentAt),
            style: Theme.of(context).textTheme.labelSmall!.copyWith(
              color: isMe ? AppColors.whiteColor : AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
