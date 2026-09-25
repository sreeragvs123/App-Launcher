import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/app_entity.dart';

class HomeContentView extends StatelessWidget {
  final List<AppEntity> favourites;

  const HomeContentView({super.key, required this.favourites});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "12:51",
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 52,
              fontWeight: FontWeight.w300,
            ),
          ),
          const Text(
            "Thu 24 Sept",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: favourites.length,
              itemBuilder: (context, index) {
                final app = favourites[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      if (app.iconBytes != null)
                        Image.memory(app.iconBytes!, width: 36, height: 36)
                      else
                        const Icon(Icons.android, color: Colors.white, size: 36),
                      const SizedBox(width: 16),
                      Text(
                        app.name,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}