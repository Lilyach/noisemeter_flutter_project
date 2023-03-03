import 'package:flutter/material.dart';
import 'package:noisemeter_project/screens/home_page_screen.dart';
import 'package:noisemeter_project/services/all_routes.dart';
import 'package:noisemeter_project/services/info_to_screens.dart';
import 'package:permission_handler/permission_handler.dart';

class BottomBar extends StatefulWidget {
  final InfoToScreens infoToScreens;
  const BottomBar(this.infoToScreens, {super.key});

  @override
  State<BottomBar> createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  //String? thisRoute() => ModalRoute.of(context)?.settings.name;

  getisRecording() {
    setState(() {
      
    });
    return context.findAncestorStateOfType<HomePageState>()?.isRecording??false;
  }

  void getOnStart() =>
      context.findAncestorStateOfType<HomePageState>()?.start();

  void getOnStop() => context.findAncestorStateOfType<HomePageState>()?.stop();

  /* activeButtonNavigation(String route) {
    if (thisRoute() != route) {
      Navigator.of(context).pushNamed(route);
    }
  } */

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //кнопка сохранение
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: IconButton(
            onPressed: () {
              /* if (thisRoute() != '/saves') {
                Navigator.of(context).pushNamed('/saves');
            } */
            },
            iconSize: 30.0,
            icon: const Icon(
              Icons.save,
              color: Colors.black87,
            ),
          ),
        ),
        //кнопка микрофон
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: IconButton(
            onPressed: () async {
              //activeButtonNavigation(AllRoutes.home);
              widget.infoToScreens.goToRoute(AllRoutes.home);
              if (widget.infoToScreens.thisRoute == AllRoutes.home &&
                  await Permission.microphone.status.isDenied) {
                await Permission.microphone.request();
              } else {
                print(await Permission.microphone.status);
              }
              //print(getisRecording());

              if (getisRecording() == false) {
                getOnStart();
              } else if (getisRecording() == true) {
                getOnStop();
              }
            },
            iconSize: 30.0,
            icon: getisRecording()
                ? const Icon(
                    Icons.pause,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.mic_none_rounded,
                    color: Colors.black87,
                  ),
          ),
        ),
        //кнопка список
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: IconButton(
            onPressed: () {
              /* if (thisRoute() != activeButtonNavigation(AllRoutes.saves)) {
                Navigator.of(context).pushNamed(AllRoutes.saves);
              } */
              widget.infoToScreens.goToRoute(AllRoutes.saves);
            },
            iconSize: 30.0,
            icon: const Icon(
              Icons.list_outlined,
              color: Colors.black87,
            ),
          ),
        ),
        //кнопка часы
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: IconButton(
            onPressed: () {},
            iconSize: 30.0,
            icon: const Icon(
              Icons.timer,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
