import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/core/utils/service_locator.dart';
import 'package:litlore/core/widgets/custom_error_widget.dart';
import 'package:litlore/core/widgets/flapping_owl_loading.dart';
import 'package:litlore/features/home/data/repos/home_repo/home_repo_impl.dart';
import 'package:litlore/features/home/manager/book_shelves_cubit/book_shelves_cubit.dart';
import 'package:litlore/features/home/manager/book_shelves_cubit/book_shelves_state.dart';
import 'package:litlore/features/home/presentation/views/shelf_books_view.dart';
import 'package:litlore/features/home/presentation/widgets/drawer_item.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final GlobalKey _shelfKey = GlobalKey();
  late TutorialCoachMark tutorialCoachMark;

  @override
  void initState() {
    super.initState();
    _checkAndShowDrawerTutorial();
  }

  Future<void> _checkAndShowDrawerTutorial() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenDrawerTutorial = prefs.getBool('has_seen_drawer_tutorial') ?? false;
    
    if (!hasSeenDrawerTutorial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _showDrawerTutorial();
        });
      });
    }
  }

  void _showDrawerTutorial() async {
    tutorialCoachMark = TutorialCoachMark(
      targets: [
        TargetFocus(
          identify: "Shelves",
          keyTarget: _shelfKey,
          shape: ShapeLightFocus.RRect,
          radius: 16,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              padding: const EdgeInsets.all(20),
              builder: (context, controller) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(20),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(AppAssets.wizard, width: 70),
                      const SizedBox(height: 16),
                      Text(
                        "Your Magical Library! 📚✨",
                        textAlign: TextAlign.center,
                        style: MyFonts.titleMediumStyle18.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "These are your personal bookshelves!\n\nOrganize your books however you like - by mood, genre, or 'books that made me cry at 2am' 📖",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: MyColors.kPrimaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "📚",
                              style: TextStyle(fontSize: 24),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Tap any shelf to explore!",
                              style: TextStyle(
                                color: MyColors.kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Pro wizard tip: The number shows how many books are on each shelf! 🧙‍♂️",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ],
      colorShadow: Colors.black.withOpacity(0.8),
      paddingFocus: 10,
      opacityShadow: 0.9,
      textSkip: "Thanks, Wizard! 🧙‍♂️",
      textStyleSkip: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      onFinish: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('has_seen_drawer_tutorial', true);
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("The wizard is proud of you! 🎉✨"),
              backgroundColor: MyColors.kPrimaryColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      },
      onSkip: () {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setBool('has_seen_drawer_tutorial', true);
        });
        return true;
      },
    );

    tutorialCoachMark.show(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BookShelvesCubit(ServiceLocator.getIt<HomeRepoImpl>())
            ..fetchBookShelves(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              MyColors.kPrimaryColor.withAlpha(50),
              MyColors.kLightBrown.withAlpha(10),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with wizard theme
              Container(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: MyColors.kPrimaryColor.withAlpha(30),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Image(
                        image: AssetImage(AppAssets.wizard),
                        width: 60,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "LitLoRe Wizard",
                      style: MyFonts.logoStyle.copyWith(fontSize: 20),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Your reading companion 📖✨",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Menu Items
              BlocBuilder<BookShelvesCubit, BookShelvesState>(
                builder: (context, state) {
                  if (state.status == BookShelvesStatus.success) {
                    return Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        children: state.shelves!
                            .asMap()
                            .entries
                            .map(
                              (entry) => DrawerItem(
                                key: entry.key == 0 ? _shelfKey : null,
                                count: entry.value.volumeCount ?? 0,
                                title: entry.value.title ?? "",
                                onTap: () {
                                  context.push(
                                    ShelfBooksView.routeName,
                                    extra: {
                                      "title": entry.value.title ?? "",
                                      "shelfId": entry.value.id,
                                    },
                                  );
                                },
                              ),
                            )
                            .toList(),
                      ),
                    );
                  } else if (state.status == BookShelvesStatus.loading) {
                    return const Center(child: FlappingOwlLoading());
                  } else {
                    return Center(
                      child: CustomErrorWidget(
                        error: state.errorMessage!,
                        retryFunction: () async {
                          context.read<BookShelvesCubit>().fetchBookShelves();
                        },
                      ),
                    );
                  }
                },
              ),

              // Footer with fun message
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "✨ Keep reading, keep growing ✨",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Version 1.0.0",
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}