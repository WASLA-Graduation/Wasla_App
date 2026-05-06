import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/service/signalR/chat_hub.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/features/driver/features/trip/presentation/manager/cubit/driver_trip_cubit.dart';

class SuggestTripHeader extends StatelessWidget {
  const SuggestTripHeader({super.key, required this.image, required this.name});
  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleNeworkImage(imageUrl: image, isLoading: false),
      trailing: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () async {
          final chatHub = ChatHub();
          chatHub.init();
          await context.push(
            AppRoutes.chatScreen,
            extra: {
              AppStrings.id: context
                  .read<DriverTripCubit>()
                  .tripDetails!
                  .residentId,
              AppStrings.name: name,
              AppStrings.photo: image,
            },
          );
          chatHub.disconnect();
        },
        icon: Image.asset(Assets.assetsImagesChatFilled, height: 22, width: 22),
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.labelMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
