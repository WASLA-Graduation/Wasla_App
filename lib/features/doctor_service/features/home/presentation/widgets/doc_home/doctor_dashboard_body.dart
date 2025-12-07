import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_err_get_data.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/doc_dash_content.dart';

class DoctorDashboardBody extends StatelessWidget {
  const DoctorDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorHomeCubit, DoctorHomeState>(
      builder: (context, state) {
        if (state is DoctorGetDataFailure) {
          return const Center(child: CustomGetDataWidget());
        }

        if (state is DoctorGetChartLoading ||
            state is DoctorGetBookingsLoading ||
            state is DoctorRemoveBookingLoading) {
          return const Center(
            child: SpinKitFadingCircle(color: AppColors.primaryColor, size: 50),
          );
        }

        return SingleChildScrollView(child: DoctorDashboardContent());
      },
    );
  }
}
