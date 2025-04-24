import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final int currentTab;
  final void Function(int) onTabChange;
  final ColorFilter colorFilter;

  const HomeBottomNavigationBar({
    super.key,
    required this.currentTab,
    required this.onTabChange,
    required this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    final icons = ["icon-user", "icon-home", "icon-meditation", "icon-greenhouse"];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color.fromRGBO(139, 159, 155, 1),
      showUnselectedLabels: false,
      showSelectedLabels: false,
      currentIndex: currentTab,
      onTap: onTabChange,
      items: List.generate(icons.length, (index) {
        return BottomNavigationBarItem(
          icon: SvgPicture(
            AssetBytesLoader("assets/img/${icons[index]}.svg.vec"),
            colorFilter: (currentTab == index) ? colorFilter : null,
          ),
          label: '',
        );
      }),
    );
  }
}
