import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final bool isCollapsed;

  const AppBarWidget({
    super.key,
    required this.isCollapsed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      color: isCollapsed ? Colors.blue : Colors.transparent,
      height: 80.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        child: Row(
          children: [
            Icon(Icons.arrow_back,
                color: isCollapsed ? Colors.white : Colors.transparent),
            const SizedBox(width: 10),
            Text(
              isCollapsed ? 'Collapsed Title' : '',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Icon(Icons.settings,
                color: isCollapsed ? Colors.white : Colors.transparent),
          ],
        ),
      ),
    );
  }
}
