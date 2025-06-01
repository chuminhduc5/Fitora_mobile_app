import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UserSkeletonLoading extends StatelessWidget {
  const UserSkeletonLoading({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Shimmer.fromColors(
  //     baseColor: Colors.grey.shade300,
  //     highlightColor: Colors.grey.shade100,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         const SizedBox(height: 24),
  //         // Avatar
  //         Container(
  //           width: 100,
  //           height: 100,
  //           decoration: const BoxDecoration(
  //             color: Colors.white,
  //             shape: BoxShape.circle,
  //           ),
  //         ),
  //         const SizedBox(height: 16),
  //         // Tên người dùng
  //         Container(
  //           width: 120,
  //           height: 16,
  //           color: Colors.white,
  //         ),
  //         const SizedBox(height: 16),
  //         // Thông tin row (Công việc - Năm sinh - Quê quán)
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: List.generate(3, (_) {
  //             return Container(
  //               width: 80,
  //               height: 20,
  //               color: Colors.white,
  //             );
  //           }),
  //         ),
  //         const SizedBox(height: 24),
  //         // Thông tin followers
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: List.generate(3, (_) {
  //             return Column(
  //               children: [
  //                 Container(width: 20, height: 14, color: Colors.white),
  //                 const SizedBox(height: 4),
  //                 Container(width: 40, height: 12, color: Colors.white),
  //               ],
  //             );
  //           }),
  //         ),
  //         const SizedBox(height: 24),
  //         // Button Thông tin và Chỉnh sửa
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Container(width: 100, height: 36, color: Colors.white),
  //             const SizedBox(width: 16),
  //             Container(width: 100, height: 36, color: Colors.white),
  //           ],
  //         ),
  //         const SizedBox(height: 24),
  //         // Về tôi
  //         Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 16),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: List.generate(3, (_) {
  //               return Padding(
  //                 padding: const EdgeInsets.only(bottom: 8),
  //                 child: Container(
  //                   width: double.infinity,
  //                   height: 12,
  //                   color: Colors.white,
  //                 ),
  //               );
  //             }),
  //           ),
  //         ),
  //         const SizedBox(height: 24),
  //         // Quan tâm
  //         Wrap(
  //           spacing: 8,
  //           runSpacing: 8,
  //           children: List.generate(6, (_) {
  //             return Container(
  //               width: 80,
  //               height: 30,
  //               color: Colors.white,
  //             );
  //           }),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade300;
    final highlightColor = Colors.grey.shade100;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          children: [
            // Avatar + Cover Photo mock
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  color: Colors.white,
                ),
                Positioned(
                  bottom: -40,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: baseColor, width: 4),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),

            // Name
            Container(
              width: 160,
              height: 20,
              color: Colors.white,
            ),
            const SizedBox(height: 16),

            // Buttons row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 100,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // Bio
            Column(
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  width: double.infinity,
                  height: 14,
                  color: Colors.white,
                );
              }),
            ),

            const SizedBox(height: 24),

            // Interests or Tags
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(6, (index) {
                return Container(
                  width: 80,
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // Posts preview
            Column(
              children: List.generate(2, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header row
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width: 100, height: 10, color: Colors.white),
                              const SizedBox(height: 5),
                              Container(width: 60, height: 10, color: Colors.white),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(width: double.infinity, height: 12, color: Colors.white),
                      const SizedBox(height: 8),
                      Container(width: MediaQuery.of(context).size.width * 0.7, height: 12, color: Colors.white),
                      const SizedBox(height: 12),
                      Container(width: double.infinity, height: 150, color: Colors.white),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
