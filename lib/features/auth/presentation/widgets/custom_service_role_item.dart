import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/auth/data/models/role_service_model.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';

class CustomChooseServiceItem extends StatelessWidget {
  const CustomChooseServiceItem({super.key, required this.serviceRoleModel});
  final ServiceRoleModel serviceRoleModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        final authCubit = context.read<AuthCubit>();
        return Container(
          width: double.infinity,
          height: 85,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: authCubit.role == serviceRoleModel.role
                ? Border.all(color: AppColors.primaryColor, width: 2)
                : Border.all(color: AppColors.gray, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: _getLeadingCircle(authCubit),
            title: _getTile(context),
            trailing: _getAcceptIcon(authCubit),
          ),
        );
      },
    );
  }

  Visibility _getAcceptIcon(AuthCubit authCubit) {
    return Visibility(
      visible: authCubit.role == serviceRoleModel.role ? true : false,
      child: Image.asset(Assets.assetsImagesAccept, width: 22, height: 22),
    );
  }

  Text _getTile(BuildContext context) {
    return Text(
      overflow: TextOverflow.ellipsis,
      serviceRoleModel.titleKey.tr(context),
      style: Theme.of(
        context,
      ).textTheme.labelLarge!.copyWith(fontSize: SizeConfig.blockHeight * 2.7),
    );
  }

  Container _getLeadingCircle(AuthCubit authCubit) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: authCubit.role == serviceRoleModel.role
            ? Border.all(color: AppColors.primaryColor, width: 2)
            : Border.all(color: AppColors.gray, width: 2),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(serviceRoleModel.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
