import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoading extends StatelessWidget {
  const SkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 120,
                height: 15,
                color: Colors.white,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 20,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            height: 14,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            height: 14,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
