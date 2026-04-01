import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';

class CustomChooseTimeWidget extends StatelessWidget {
  const CustomChooseTimeWidget({
    super.key,
    required this.dateChange,
    required this.selectedTime,
    required this.text,
  });
  final ValueChanged<TimeOfDay> dateChange;
  final TimeOfDay selectedTime;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 10),

        InkWell(
          onTap: () {
            showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),

              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 2,
                        ),
                        textStyle: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            ).then((time) {
              if (time != null) dateChange(time);
            });
          },
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(color: AppColors.gray, width: 0.3),
            ),
            child: Center(
              child: Row(
                children: [
                  Text(
                    formatTimeWithIntl(selectedTime),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Spacer(),
                  Image.asset(
                    Assets.assetsImagesClock,
                    width: 20,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
