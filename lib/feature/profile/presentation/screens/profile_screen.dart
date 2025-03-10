import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _showTitle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            if (notification.metrics.pixels > 150) {
              if (!_showTitle) setState(() => _showTitle = true);
            } else {
              if (_showTitle) setState(() => _showTitle = false);
            }
          }
          return true;
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: false,
              expandedHeight: kToolbarHeight,
              backgroundColor: AppColors.bgWhite,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  context.goNamed(AppRoute.appView.name);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu, color: Colors.grey),
                ),
              ],
              title: _showTitle ? const Text("Minh Đức") : null,
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60.r,
                                  // backgroundImage: const NetworkImage(
                                  //     'https://i.imgur.com/5M37i3l.jpg'),
                                  child: Image.network("https://localhost:5005/uploads/1ce5a1cd-7768-46bd-b283-c6db18516151_TikVideo.app_7348465457374006535_3.jpeg"),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Minh Đức | Mobile Developer",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Trở thành 1 lập trình viên mobile app!",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 12,
                                    spreadRadius: 0,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildInFoItem("Công việc", "Developer"),
                                  _buildInFoItem("Năm sinh", "2003"),
                                  _buildInFoItem("Quê Quán", "Hà Nội"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _iconText(Icons.favorite_border, "Single"),
                                const SizedBox(width: 20),
                                _iconText(Icons.male, "Male"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _statItem("0", "Followers"),
                        _buildVerticalLine(),
                        _statItem("0", "Following"),
                        _buildVerticalLine(),
                        _statItem("0", "Bạn bè")
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _button(
                            () {}, "Thông tin", AppColors.bgPink, Colors.white),
                        const SizedBox(width: 10),
                        _button(
                          () {
                            context.goNamed(AppRoute.editProfile.name);
                          },
                          "Chỉnh sửa",
                          Colors.white,
                          Colors.black,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle("Về tôi"),
                          const Text(
                            "I believe that no one should ever have to choose between a career we love and living our lives with authenticity and integrity",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                          _sectionTitle("QUAN TÂM"),
                          _buildInterests(),
                          const SizedBox(height: 15),
                          FTabs(
                            style: FTabsStyle(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              indicatorSize: FTabBarIndicatorSize.tab,
                              decoration:
                                  const BoxDecoration(color: AppColors.bgWhite),
                              selectedLabelTextStyle: const TextStyle(
                                color: AppColors.white,
                              ),
                              unselectedLabelTextStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              indicatorDecoration: BoxDecoration(
                                color: AppColors.bgPink,
                                border: Border.all(color: AppColors.bgPink),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              focusedOutlineStyle: FFocusedOutlineStyle(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            tabs: [
                              FTabEntry(
                                //label: const Icon(Icons.grid_view),
                                label: const Text("Bài viết"),
                                content: Container(
                                  width: double.infinity,
                                  constraints: const BoxConstraints(
                                    minHeight: 100,
                                  ),
                                ),
                              ),
                              FTabEntry(
                                //label: const Icon(Icons.play_circle_outline),
                                label: const Text("Ảnh"),
                                content: Container(
                                  width: double.infinity,
                                  constraints: const BoxConstraints(
                                    minHeight: 100,
                                  ),
                                  child: _buildLayoutImage(),
                                ),
                              ),
                              FTabEntry(
                                //label: const Icon(Icons.people_outline),
                                label: const Text("Video"),
                                content: FCard(
                                  child: const Column(
                                    children: [],
                                  ),
                                ),
                              ),
                              FTabEntry(
                                //label: const Icon(Icons.file_copy),
                                label: const Text("Bạn bè"),
                                content: FCard(
                                  child: const Column(
                                    children: [],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInFoItem(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.pink),
        const SizedBox(width: 5),
        Text(text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _statItem(String count, String label) {
    return Column(
      children: [
        Text(count,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildVerticalLine() {
    return const SizedBox(
      height: 25,
      child: VerticalDivider(
        thickness: 1,
        color: Colors.grey,
        width: 0,
      ),
    );
  }

  Widget _button(
      Function() onPressed, String text, Color bgColor, Color textColor) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black, width: 0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 14),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  Widget _buildInterests() {
    List<String> interests = [
      "JavaScript",
      "Flutter",
      ".NET",
      "SQL Server",
      "MY SQL",
      "Web",
      "App"
    ];

    List<Color> backgroundColors = [
      Colors.purple.shade100,
      Colors.blue.shade100,
      Colors.green.shade100,
      Colors.yellow.shade100,
      Colors.orange.shade100,
      Colors.red.shade100,
      Colors.cyan.shade100
    ];

    List<Color> textColors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.yellow[800]!,
      Colors.orange[800]!,
      Colors.red[800]!,
      Colors.cyan[800]!
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(interests.length, (index) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColors[index],
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            interests[index],
            style: TextStyle(color: textColors[index], fontSize: 14),
          ),
        );
      }),
    );
  }

  Widget _buildLayoutImage() {
    final List<String> imageUrls = [
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
    ];

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: imageUrls.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrls[index],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.image, size: 16, color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
