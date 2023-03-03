import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:noisemeter_project/bottom_bar/bottom_bar.dart';
import 'package:noisemeter_project/services/all_routes.dart';
import 'package:noisemeter_project/services/info_to_screens.dart';

class HomePage extends StatefulWidget {
  final InfoToScreens infoToScreens;
  const HomePage(this.infoToScreens, {super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isRecording = false;
  StreamSubscription<NoiseReading>? noiseSubscription;
  late NoiseMeter noiseMeter;
  List<double> listActualNoise = [0];
  
  double actualNoise = 0.0;

  @override
  void initState() {
    super.initState();
    noiseMeter = NoiseMeter(onError);
  }

  @override
  void dispose() {
    noiseSubscription?.cancel();//отписка от подписки
    super.dispose();
  }

  void onData(NoiseReading noiseReading) {
    setState(() {
      if (!isRecording) {
        isRecording = true;
      }
    });
    print(noiseReading.toString());
    actualNoise = noiseReading.maxDecibel;
    listActualNoise.add(actualNoise);
  }

  void onError(Object error) {
    print(error.toString());
    isRecording = false;
  }

  void start() async {
    try {
      noiseSubscription = noiseMeter.noiseStream.listen(onData);
      isRecording = true;
      listActualNoise.removeAt(0); 
    }
    
    catch (err) {
      print(err);
    }
  }

  void stop() async {
    try {
      if (noiseSubscription != null) {
        noiseSubscription!.cancel();
        noiseSubscription = null;
      }
      setState(() {
        isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      //Navigator.of(context).pushNamed('/info');
                      widget.infoToScreens.goToRoute(AllRoutes.info);
                    },
                    iconSize: 30.0,
                    icon: const Icon(
                      Icons.info_outline,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //Navigator.of(context).pushNamed('/settings');
                      widget.infoToScreens.goToRoute(AllRoutes.settings);
                    },
                    iconSize: 30.0,
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       Text(
                        actualNoise.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 70.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(
                            'Min ${listActualNoise.reduce(min).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          Text(
                            'Max ${listActualNoise.reduce(max).toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(widget.infoToScreens),
    );
  }
}
