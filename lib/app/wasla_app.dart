import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_router.dart';
import 'package:wasla/core/config/themes/app_theme.dart';
import 'package:wasla/core/functions/buid_appCubits.dart';
import 'package:wasla/core/functions/change_status_bar_theme.dart';
import 'package:wasla/core/functions/handle_initial_route.dart';
import 'package:wasla/core/manager/global/global_cubit.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_strings.dart';

class WaslaApp extends StatelessWidget {
  const WaslaApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return MultiBlocProvider(
      providers: buildAppCubits,
      child: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) {
          final globalCubit = context.read<GlobalCubit>();
          changeThemeStatusBar(globalCubit.themeMode);
          return MaterialApp(
            supportedLocales: const [Locale('ar'), Locale('en')],
            localizationsDelegates: _getDelegates,
            locale: globalCubit.locale,
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme(context),
            darkTheme: AppThemes.darkTheme(context),
            themeMode: globalCubit.themeMode,
            initialRoute: handleInitialRoute(),
            // home: TestTimeWidge(),
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }

  List<LocalizationsDelegate<dynamic>> get _getDelegates {
    return const [
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      AppLocalizations.delegate,
    ];
  }
}

// class CustomChooseTimeItem extends StatelessWidget {
//   const CustomChooseTimeItem({
//     super.key,
//     required this.selectedTime,
//     required this.text,
//     required this.onTimeChanged,
//   });

//   final TimeOfDay selectedTime;
//   final String text;
//   final ValueChanged<TimeOfDay> onTimeChanged;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(text, style: Theme.of(context).textTheme.headlineMedium),
//         const SizedBox(height: 10),

//         InkWell(
//           onTap: () {
//             showTimePicker(
//               context: context,
//               initialTime: TimeOfDay.now(),

//               builder: (context, child) {
//                 return Theme(
//                   data: Theme.of(context).copyWith(
//                     textButtonTheme: TextButtonThemeData(
//                       style: TextButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 2,
//                         ),
//                         textStyle: const TextStyle(fontSize: 17),
//                       ),
//                     ),
//                   ),
//                   child: child!,
//                 );
//               },
//             ).then((time) {
//               if (time != null) onTimeChanged(time);
//             });
//           },
//           child: Container(
//             height: 50,
//             padding: const EdgeInsets.symmetric(horizontal: 15),
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               borderRadius: BorderRadius.circular(7),
//               border: Border.all(color: AppColors.gray, width: 0.3),
//             ),
//             child: Center(
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: FittedBox(
//                       fit: BoxFit.scaleDown,
//                       child: Text(
//                         formatTimeWithIntl(selectedTime),
//                         style: Theme.of(context).textTheme.headlineMedium,
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Image.asset(
//                     Assets.assetsImagesClock,
//                     width: 20,
//                     color: context.isDarkMode ? Colors.white : Colors.black,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class TestTimeWidge extends StatelessWidget {
//   const TestTimeWidge({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<GlobalCubit>();

//     return Scaffold(
//       appBar: AppBar(title: Text("Choose Time")),

//       body: BlocBuilder<GlobalCubit, GlobalState>(
//         builder: (context, state) {
//           return Padding(
//             padding: const EdgeInsets.all(30),
//             child: Column(
//               children: [
//                 GeneralButton(
//                   onPressed: () {
//                     if (cubit.slots.isNotEmpty) {
//                       final now = DateTime.now();

//                       DateTime date = DateTime(
//                         now.year,
//                         now.month,
//                         now.day,
//                         cubit.slots.last["to"]!.hour,
//                         cubit.slots.last["to"]!.minute,
//                       );
//                       date = date.add(Duration(hours: 1));
//                       cubit.addTimeSlot({
//                         "from": cubit.slots.last["to"]!,
//                         "to": TimeOfDay(hour: date.hour, minute: date.minute),
//                       });
//                     } else {
//                       cubit.addTimeSlot({
//                         "from": cubit.selectedTimeFrom,
//                         "to": cubit.selectedTimeTo,
//                       });
//                     }
//                   },
//                   text: "Add Time",
//                 ),
//                 const SizedBox(height: 30),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: cubit.slots.length,
//                     itemBuilder: (context, index) => Padding(
//                       padding: const EdgeInsets.only(bottom: 20),
//                       child: CustomChooseTimeFromAndToWidget(
//                         index: index,
//                         onDelete: () => cubit.removeTimeSlot(index),
//                         from: cubit.slots[index]["from"]!,
//                         to: cubit.slots[index]["to"]!,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class CustomChooseTimeFromAndToWidget extends StatelessWidget {
//   const CustomChooseTimeFromAndToWidget({
//     super.key,
//     required this.from,
//     required this.to,
//     required this.onDelete,
//     required this.index,
//   });
//   final TimeOfDay from;
//   final TimeOfDay to;
//   final VoidCallback onDelete;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<GlobalCubit>();
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Expanded(
//           child: CustomChooseTimeItem(
//             text: "From",
//             selectedTime: from,
//             onTimeChanged: (time) => cubit.updateSlotes(
//               timeSlot: {"from": time, "to": ?cubit.slots[index]["to"]},
//               index: index,
//             ),
//           ),
//         ),
//         const SizedBox(width: 20),
//         Expanded(
//           child: CustomChooseTimeItem(
//             text: "To",
//             selectedTime: to,
//             onTimeChanged: (time) => cubit.updateSlotes(
//               index: index,
//               timeSlot: {"from": ?cubit.slots[index]["from"], "to": time},
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         InkWell(
//           onTap: onDelete,
//           child: const Icon(Icons.delete, color: Colors.red),
//         ),
//       ],
//     );
//   }
// }
