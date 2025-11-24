import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_choose_time_doc_service_widget.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/date_timeline_picker.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doc_add_service_form.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doc_weak_day_widget.dart';

class AddServiceViewBody extends StatelessWidget {
  const AddServiceViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorServiceMangementCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DateTimelinePicker(title: "Select Date"),
                const SizedBox(height: 15),
                CustomChooseTimeDocServiceWidget(),
                const SizedBox(height: 10),
                CustomWeakDaysWidget(),
                const SizedBox(height: 20),
                CustomDoctorAddServiceForm(),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GeneralButton(
            onPressed: () {
              cubit.checkDaysSelected();
              if (cubit.addServiceFormKey.currentState!.validate()) {}
            },
            text: "Add",
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
