import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:roadsage/constants.dart';
import 'package:roadsage/state/models.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(Slide(
        title: translate(RoadSageStrings.welcomeToRoadSage),
        marginTitle: const EdgeInsets.only(top: 400),
        description: translate(RoadSageStrings.welcomeDescription1),
        // styleDescription: const TextStyle(color: Colors.black),
        backgroundColor: Colors.transparent));
    slides.add(Slide(
        title: translate(RoadSageStrings.welcomeToRoadSage),
        marginTitle: const EdgeInsets.only(top: 400),
        // styleTitle: const TextStyle(color: Colors.black),
        description: translate(RoadSageStrings.welcomeDescription2),
        // styleDescription: const TextStyle(color: Colors.black),
        backgroundColor: Colors.transparent));
    slides.add(Slide(
        title: translate(RoadSageStrings.welcomeToRoadSage),
        marginTitle: const EdgeInsets.only(top: 400),
        // styleTitle: const TextStyle(color: Colors.black),
        description: translate(RoadSageStrings.welcomeDescription3),
        // styleDescription: const TextStyle(color: Colors.black),
        backgroundColor: Colors.transparent));
  }

  void onDonePress() {
    // Mark first launch as done so that the welcome screen doesn't come up again
    ref.read(roadSageModelProvider.notifier).switchFirstLaunch(false);
    // Navigate to login screen
    Navigator.pushNamedAndRemoveUntil(context, Routes.root, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    for (var slide in slides) {
      slide.styleTitle = TextStyle(
          color: Theme.of(context).textTheme.button!.color,
          fontWeight: FontWeight.bold,
          fontSize: 30);
      slide.styleDescription = TextStyle(
          color: Theme.of(context).textTheme.button!.color, fontSize: 18);
    }

    return IntroSlider(
      slides: slides,
      onDonePress: onDonePress,
      renderDoneBtn: Icon(
        Icons.done,
        color: Theme.of(context).colorScheme.primary,
      ),
      renderSkipBtn: Icon(
        Icons.skip_next,
        color: Theme.of(context).colorScheme.primary,
      ),
      renderNextBtn: Icon(
        Icons.navigate_next,
        color: Theme.of(context).colorScheme.primary,
      ),
      backgroundColorAllSlides: Theme.of(context).scaffoldBackgroundColor,
      colorDot: Theme.of(context).primaryColorLight,
      colorActiveDot: Theme.of(context).colorScheme.primary,
    );
  }
}
