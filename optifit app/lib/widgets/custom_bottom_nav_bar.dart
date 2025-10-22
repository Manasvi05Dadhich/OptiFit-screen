import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../theme/theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    
    // On desktop, show as side rail
    if (isDesktop) {
      return Container(
        width: 80,
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(2, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavItem(
              context,
              icon: Icons.public,
              label: 'Home',
              index: 0,
              isVertical: true,
            ),
            const SizedBox(height: 16),
            _buildNavItem(
              context,
              icon: Icons.fitness_center,
              label: 'Workouts',
              index: 1,
              isVertical: true,
            ),
            const SizedBox(height: 16),
            _buildNavItem(
              context,
              icon: Icons.smart_toy,
              label: 'AI',
              index: 2,
              isVertical: true,
            ),
            const SizedBox(height: 16),
            _buildNavItem(
              context,
              icon: Icons.show_chart,
              label: 'Progress',
              index: 3,
              isVertical: true,
            ),
            const SizedBox(height: 16),
            _buildNavItem(
              context,
              icon: Icons.person,
              label: 'Profile',
              index: 4,
              isVertical: true,
            ),
          ],
        ),
      );
    }
    
    // On mobile/tablet, show as bottom nav
    return Container(
      height: AppTheme.bottomNavHeight,
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        boxShadow: AppTheme.bottomNavShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            context,
            icon: Icons.public,
            label: 'Home',
            index: 0,
          ),
          _buildNavItem(
            context,
            icon: Icons.fitness_center,
            label: 'Workouts',
            index: 1,
          ),
          _buildNavItem(
            context,
            icon: Icons.smart_toy,
            label: 'AI',
            index: 2,
          ),
          _buildNavItem(
            context,
            icon: Icons.show_chart,
            label: 'Progress',
            index: 3,
          ),
          _buildNavItem(
            context,
            icon: Icons.person,
            label: 'Profile',
            index: 4,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    bool isVertical = false,
  }) {
    final bool isSelected = currentIndex == index;
    final color = isSelected ? AppTheme.primary : AppTheme.textSubtle;
    
    final child = InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: isVertical ? 28 : AppTheme.bottomNavIconSize,
              color: color,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: isVertical ? 10 : AppTheme.bottomNavLabelSize,
                color: color,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
    
    return isVertical ? child : Expanded(child: child);
  }
} 