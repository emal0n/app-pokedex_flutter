import 'package:adaptive_platform_ui/adaptive_platform_ui.dart';
import 'package:flutter/material.dart';

class AdaptiveBottomNavBar {
  final int selectedIndex;
  final Function(int) onTap;

  const AdaptiveBottomNavBar({
    required this.selectedIndex,
    required this.onTap,
  });

  AdaptiveBottomNavigationBar build() {
    return AdaptiveBottomNavigationBar(
      items: const [
        AdaptiveNavigationDestination(
          icon: Icons.home,
          label: "",
        ),
        AdaptiveNavigationDestination(
          icon: Icons.more_horiz,
          label: "",
        ),
      ],
      selectedIndex: selectedIndex,
      onTap: onTap,
    );
  }
}



