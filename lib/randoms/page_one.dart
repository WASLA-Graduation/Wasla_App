import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page One")),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }
          showModalBottomSheet(
            context: context,
            builder: (bottomSheetContext) {
              return Container(
                color: AppColors.whiteColor,
                height: 200,
                padding: EdgeInsets.all(20),
                width: double.infinity,
                child: Column(
                  spacing: 12,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GeneralButton(
                      onPressed: () {
                        Navigator.pop(
                          bottomSheetContext,
                          'Cancel From Bottom Sheet',
                        );
                      },
                      text: 'Cancel',
                    ),
                    GeneralButton(
                      onPressed: () {
                        Navigator.pop(
                          bottomSheetContext,
                          'Accept From Bottom Sheet',
                        );
                        Navigator.pop(context, 'Accept From Bottom Sheet Pop');
                      },
                      text: 'Accept',
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: SizedBox(),
      ),
    );
  }
}
