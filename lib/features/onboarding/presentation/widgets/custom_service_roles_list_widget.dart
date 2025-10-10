import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/features/auth/data/models/role_service_model.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_service_role_item.dart';

class CustomServiceRolesListWidget extends StatelessWidget {
  const CustomServiceRolesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: ServiceRoleModel.roleServiceList.length,
        separatorBuilder: (context, index) => VerticalSpace(height: 2),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            context.read<AuthCubit>().changeRole(
              ServiceRoleModel.roleServiceList[index].role,
            );
          },
          child: CustomChooseServiceItem(
            serviceRoleModel: ServiceRoleModel.roleServiceList[index],
          ),
        ),
      ),
    );
  }
}
