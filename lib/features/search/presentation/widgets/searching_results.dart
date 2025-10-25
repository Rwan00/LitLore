import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/core/theme/fonts.dart';
import 'package:litlore/core/widgets/flapping_owl_loading.dart';
import 'package:litlore/features/search/manager/search_cubit.dart';

class SearchingResults extends StatelessWidget {
  final TextEditingController searchController;
  const SearchingResults({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Row(
          children: [
            Text(
              'Searching for: ',
              style: MyFonts.subTiltleStyle14.copyWith(
                fontSize: 14,
                color: MyColors.kAccentBrown,
              ),
            ),
            Text(
              '"${context.read<SearchCubit>().state.searchKey}"',
              style: MyFonts.titleMediumStyle18.copyWith(
                fontSize: 16,
                color: MyColors.kPrimaryColor,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),
        Center(
          child: FlappingOwlLoading(
            loadingText:
                'Our wisest owls are searching...\n Flipping through ${(searchController.text.length * 1000)} pages!',
          ),
        ),
      ],
    );
  }
}
