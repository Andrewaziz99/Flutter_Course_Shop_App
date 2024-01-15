import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:souqy/models/onboarding_model.dart';
import 'package:souqy/modules/login/login_screen.dart';
import 'package:souqy/shared/components/components.dart';
import 'package:souqy/shared/styles/colors.dart';

class onBoardingScreen extends StatefulWidget {
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;

  List<onboardingModel> boarding = [
    onboardingModel(
      image: 'assets/onboarding/onboarding_00.png',
      title: 'On Boarding 1 Title',
      body: 'On Boarding 1 Body',
    ),
    onboardingModel(
      image: 'assets/onboarding/onboarding_01.png',
      title: 'On Boarding 2 Title',
      body: 'On Boarding 2 Body',
    ),
    onboardingModel(
      image: 'assets/onboarding/onboarding_02.png',
      title: 'On Boarding 3 Title',
      body: 'On Boarding 3 Body',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardController,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    navigateAndFinish(context, ShopLoginScreen());
                  },
                  child: Text('SKIP',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      )),
                ),
                const Spacer(),
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: PrimaryColor,
                    dotHeight: 10.0,
                    expansionFactor: 4.0,
                    dotWidth: 10.0,
                    spacing: 5.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      navigateAndFinish(context, ShopLoginScreen());
                    } else {
                      boardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastEaseInToSlowEaseOut,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(onboardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                '${model.image}',
              ),
            ),
          ),
          Text(
            '${model.title}',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
        ],
      );
}
