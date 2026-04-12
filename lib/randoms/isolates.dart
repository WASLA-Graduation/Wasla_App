import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/core/utils/isolate_manager.dart';

class IsolatesScreen extends StatelessWidget {
  const IsolatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Isolates")),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            const SizedBox(height: 50),
            SizedBox(
              width: SizeConfig.screenWidth * 0.6,
              child: GeneralButton(
                onPressed: () async {
                  IsolateManager().start(
                    (message) {
                      for (int i = 0; i <= message.data; i++) {
                        message.sendPort.send(i);
                      }
                    },
                    10,
                    onError: (error) => log('Error $error'),
                    onData: (data) => log('Data $data'),
                  );
                },
                text: 'Start Count',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
