import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/app_entity.dart';

class FilteredAppsView extends StatelessWidget {
  final List<AppEntity> apps;
  final Function(String packageName) onAppTap;

  const FilteredAppsView({
    super.key,
    required this.apps,
    required this.onAppTap,
  });

  @override
  Widget build(BuildContext context) {
    if (apps.isEmpty) {
      return const Center(
        child: Text(
          "No apps",
          style: TextStyle(color: AppColors.textMuted, fontSize: 20),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(left: 16, right: 80, top: 20),
      itemCount: apps.length,
      itemBuilder: (context, index) {
        final app = apps[index];
        return ListTile(
          leading: app.iconBytes != null
              ? Image.memory(app.iconBytes!, width: 40, height: 40)
              : const Icon(Icons.android, color: Colors.white),
          title: Text(
            app.name,
            style: const TextStyle(color: AppColors.textPrimary),
          ),
          onTap: () => onAppTap(app.packageName),
        );
      },
    );
  }
}