import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';
import 'package:wasla/features/gym/features/packages/presentation/manager/cubit/gym_packages_cubit.dart';

class GymDeleteUpdateModelSheet extends StatelessWidget {
  const GymDeleteUpdateModelSheet({super.key, required this.packageId});
  final int packageId;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymPackagesCubit>();
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),

          UnderLineWidget(),

          ListTile(
            onTap: () {},
            leading: const Icon(Icons.edit),
            title: Text("edit".tr(context)),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              cubit.deletePackageOrOffer(serviceId: packageId);
            },
            leading: const Icon(Icons.delete),
            title: Text("delete".tr(context)),
          ),
        ],
      ),
    );
  }
}
