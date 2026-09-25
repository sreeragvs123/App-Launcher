import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launcher/presentation/components/alphabet_sidebar.dart';
import 'package:launcher/presentation/components/letter_bubble.dart';
import '../../core/constants/app_colors.dart';
import '../bloc/launcher_bloc.dart';
import '../bloc/launcher_event.dart';
import '../bloc/launcher_state.dart';
import 'filtered_apps_view.dart';
import 'home_content_view.dart';

class LauncherHomeScreen extends StatelessWidget {
  const LauncherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<LauncherBloc, LauncherState>(
          builder: (context, state) {
            if (state is LauncherLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            if (state is LauncherError) {
              return Center(
                child: Text(state.message, style: const TextStyle(color: Colors.red)),
              );
            }

            if (state is LauncherLoaded) {
              return Stack(
                children: [
                  // Main Screen Body
                  if (!state.isDragging)
                    HomeContentView(favourites: state.favourites)
                  else
                    FilteredAppsView(
                      apps: state.filteredApps,
                      onAppTap: (packageName) {
                        context.read<LauncherBloc>().add(LaunchAppEvent(packageName));
                      },
                    ),

                  // Alphabet Curved Sidebar
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: AlphabetSidebar(
                      onLetterSelected: (letter) {
                        context.read<LauncherBloc>().add(SelectLetterEvent(letter));
                      },
                      onDragEnd: () {
                        context.read<LauncherBloc>().add(ReleaseDragEvent());
                      },
                    ),
                  ),

                  if (state.isDragging && state.selectedLetter != null)
                    LetterBubble(letter: state.selectedLetter!),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}