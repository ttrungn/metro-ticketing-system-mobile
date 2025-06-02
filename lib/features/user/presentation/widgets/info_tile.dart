import 'package:flutter/material.dart';
import 'package:metro_ticketing_system_mobile/core/constants/app_color.dart';

class InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final bool showTrailing;
  final Color? iconColor;
  final Color? titleColor;

  const InfoTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.showTrailing = false,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = iconColor ?? ConstantAppColor.primary;
    final Color effectiveTitleColor = titleColor ?? ConstantAppColor.primary;

    return ListTile(
      leading: Icon(icon, color: effectiveColor, size: 40),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: effectiveTitleColor,
        ),
      ),
      subtitle:
          (subtitle == null || subtitle!.isEmpty)
              ? null
              : Text(subtitle!, style: const TextStyle(fontSize: 16)),
      trailing:
          showTrailing ? const Icon(Icons.arrow_forward_ios, size: 16) : null,
      onTap: onTap,
    );
  }
}
