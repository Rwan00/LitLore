import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/utils/app_assets.dart';
import 'package:litlore/core/utils/service_locator.dart';
import 'package:litlore/core/widgets/custom_error_widget.dart';
import 'package:litlore/core/widgets/flapping_owl_loading.dart';
import 'package:litlore/features/home/data/repos/home_repo/home_repo_impl.dart';
import 'package:litlore/features/home/manager/book_shelves_cubit/book_shelves_cubit.dart';
import 'package:litlore/features/home/manager/book_shelves_cubit/book_shelves_state.dart';
import 'package:litlore/features/home/presentation/widgets/drawer_item.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

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
                      "Your reading companion",
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
                        children: [
                          DrawerItem(
                            icon: Icons.library_books_rounded,
                            title: "My Library",
                            onTap: () {
                              Navigator.pop(context);
                              // Navigate to library
                            },
                          ),
                          DrawerItem(
                            icon: Icons.bookmark_rounded,
                            title: "Bookmarks",
                            onTap: () {
                              Navigator.pop(context);
                              // Navigate to bookmarks
                            },
                          ),
                          DrawerItem(
                            icon: Icons.favorite_rounded,
                            title: "Favorites",
                            onTap: () {
                              Navigator.pop(context);
                              // Navigate to favorites
                            },
                          ),
                          DrawerItem(
                            icon: Icons.history_rounded,
                            title: "Reading History",
                            onTap: () {
                              Navigator.pop(context);
                              // Navigate to history
                            },
                          ),
                          const Divider(height: 32, indent: 16, endIndent: 16),
                          DrawerItem(
                            icon: Icons.settings_rounded,
                            title: "Settings",
                            onTap: () {
                              Navigator.pop(context);
                              // Navigate to settings
                            },
                          ),
                          DrawerItem(
                            icon: Icons.info_rounded,
                            title: "About",
                            onTap: () {
                              Navigator.pop(context);
                              // Navigate to about
                            },
                          ),
                        ],
                      ),
                    );
                  } else if (state.status == BookShelvesStatus.loading) {
                    return Center(child: FlappingOwlLoading());
                  } else {
                    return Center(
                      child: CustomErrorWidget(
                        error: state.errorMessage!,
                        retryFunction: () async {
                          context.read<BookShelvesCubit>().fetchBookShelves(
                            
                          );
                        },
                      ),
                    );
                  }
                },
              ),

              // Footer
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Version 1.0.0",
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
