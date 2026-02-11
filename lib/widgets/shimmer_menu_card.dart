import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMenuCard extends StatelessWidget {
  const ShimmerMenuCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF2A2A2A),
      highlightColor: const Color(0xFF3A3A3A),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF1E1E1E),
        ),
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(8),
            width: 40,
            height: 40,
          ),
          title: Container(
            height: 12,
            width: 100,
            color: Colors.grey[800],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: 10,
              width: 150,
              color: Colors.grey[800],
            ),
          ),
          trailing: Container(
            width: 18,
            height: 18,
            color: Colors.grey[800],
          ),
        ),
      ),
    );
  }
}

