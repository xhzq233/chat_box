/// chat_box - update_page
/// Created by xhz on 30/04/2022
import 'package:chat_box/utils/loading.dart';
import 'package:chat_box/utils/platform_api/platform_api.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Loading.show();
            // await PlatformApi.updateApp('url', await Global.latestTag);
            await PlatformApi.urlLaunch('https://xhzq.xyz');
            Loading.hide();
          },
          child: const Text('click me'),
        ),
      ),
    );
  }
}
