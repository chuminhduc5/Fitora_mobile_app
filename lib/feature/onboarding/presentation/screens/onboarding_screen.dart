import 'package:fitora_mobile_app/common/helper/navigation/app_navigation.dart';
import 'package:fitora_mobile_app/common/widgets/skleton/dot_indicators.dart';
import 'package:fitora_mobile_app/feature/onboarding/presentation/widgets/onboarding_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  final List<Map<String, String>> _onboardData = [
    {
      "image": "",
      "imageDarkTheme": "",
      "title": "",
      "description": "",
    },
  ];

  @override
  void initState() {
    // Khởi tạo giá trị _pageController ban đầu bằng 0
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    // Đóng _pageController
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _onboardData.length,
                  onPageChanged: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                  itemBuilder: (context, index) => OnboardingContentWidget(
                    title: _onboardData[index]["title"] ?? "",
                    image: (Theme.of(context).brightness == Brightness.dark &&
                            _onboardData[index]["imageDarkTheme"] != null)
                        ? _onboardData[index]["image"] ?? ""
                        : _onboardData[index]["image"] ?? "",
                    description: _onboardData[index]["description"] ?? "",
                    isTextOnTop: index.isOdd,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                    _onboardData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_pageIndex < _onboardData.length - 1) {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          } else {

                          }
                        },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/Arrow - Right.svg",
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
