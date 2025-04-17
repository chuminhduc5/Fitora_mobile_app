import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/button_auth_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> onboardingPages = [
    OnboardingContent(
      image: AppSvg.education,
      title: 'Không gian học tập',
      description:
          'Khám phá một không gian học tập hiện đại, nơi bạn có thể tập trung phát triển bản thân và chạm tới những đỉnh cao tri thức.',
    ),
    OnboardingContent(
      image: AppSvg.college,
      title: 'Học tập mọi lúc mọi nơi',
      description:
          'Dễ dàng tiếp cận kiến thức mọi lúc, mọi nơi với trải nghiệm học tập linh hoạt, phù hợp với nhịp sống năng động của bạn.',
    ),
    OnboardingContent(
      image: AppSvg.school,
      title: 'Kết nối bạn bè',
      description:
          'Tạo dựng mối quan hệ, học hỏi cùng nhau và lan tỏa tinh thần học tập trong cộng đồng đầy cảm hứng.',
    ),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          onPageChanged: _onPageChanged,
          itemCount: onboardingPages.length,
          itemBuilder: (_, index) {
            final content = onboardingPages[index];
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  SvgPicture.asset(content.image, height: 300),
                  const SizedBox(height: 40),
                  Text(
                    content.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    content.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  if (index < onboardingPages.length - 1) ...[
                    ButtonAuthWidget(
                      title: 'Tiếp theo',
                      bgColor: AppColors.bgPink,
                      onPressed: () => _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ButtonAuthWidget(
                        title: 'Bỏ qua',
                        bgColor: Colors.grey[300]!,
                        onPressed: () {
                          context.pushReplacementNamed(AppRoute.auth.name);
                        }),
                  ] else ...[
                    ButtonAuthWidget(
                        title: 'Đăng nhập',
                        bgColor: AppColors.bgPink,
                        onPressed: () {
                          context.pushReplacementNamed(AppRoute.auth.name);
                        }),
                    const SizedBox(height: 20),
                    ButtonAuthWidget(
                        title: 'Đăng ký',
                        bgColor: Colors.grey[300]!,
                        onPressed: () {
                          context.pushReplacementNamed(AppRoute.auth.name);
                        }),
                  ],
                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
