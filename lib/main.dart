import 'package:flutter/material.dart';
import 'package:noisemeter_project/screens/info_screen.dart';
import 'package:noisemeter_project/screens/saves_screen.dart';
import 'package:noisemeter_project/screens/settings_screen.dart';
import 'package:noisemeter_project/services/all_routes.dart';
import 'package:noisemeter_project/services/info_to_screens.dart';
import 'screens/home_page_screen.dart';

void main() {
  runApp(
    const NoiseMetr(),
  );
}

class NoiseMetr extends StatefulWidget {
  const NoiseMetr({
    Key? key,
  }) : super(key: key);

  @override
  State<NoiseMetr> createState() => _NoiseMetrState();
}

class _NoiseMetrState extends State<NoiseMetr> {
  String thisRoute = AllRoutes.home;
  bool is404 = false;
  late InfoToScreens infoToScreens;

  /* @override
  void initState() {
    infoToScreens=InfoToScreens(thisRoute, goToRoute);
    super.initState();
  } */

  void goToRoute(String route) {
    setState(() {
      thisRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
   InfoToScreens infoToScreens=InfoToScreens(thisRoute, goToRoute); 
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Navigator(
          pages: [
            MaterialPage(child: HomePage(infoToScreens)),
            if (thisRoute == AllRoutes.saves)
              MaterialPage(child: Saves(infoToScreens)),
            if (thisRoute == AllRoutes.info)
              MaterialPage(child: Info(infoToScreens)),
            if (thisRoute == AllRoutes.settings)
              MaterialPage(child: Settings(infoToScreens)),
            if (is404)
              const MaterialPage(
                child: Scaffold(
                  body: Center(child: Text('Error! Please restart the app')),
                ),
              )
          ],
          onPopPage: ((route, result) {
            if (!route.didPop(result)) {
              return false;
            }
            return true;
          }),
        )
        /* routes: {
       AllRoutes.home: (context) => const HomePage(),
       AllRoutes.saves: (context) =>  const Saves(),
       AllRoutes.info: (context) => const Info(),
       AllRoutes.settings: (context) => const Settings(),//именнованные маршруты не рекомендуются
     },
     initialRoute: '/', */
        );
  }
}


