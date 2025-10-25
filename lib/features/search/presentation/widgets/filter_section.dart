import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:litlore/core/theme/colors.dart';
import 'package:litlore/features/search/data/model/filter_options.dart';

class FilterSection extends StatelessWidget {
  final String title;
  final List<FilterOption> options;
  final String selectedValue;
  final Function(String) onChanged;
  const FilterSection({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Fancy animated title with icon
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: MyColors.kPrimaryColor,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),

        // Animated options grid
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.asMap().entries.map((entry) {
            final index = entry.key;
            final option = entry.value;
            final isSelected = selectedValue == option.value;

            return TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: Duration(milliseconds: 300 + (index * 50)),
              curve: Curves.elasticOut,
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: InkWell(
                    onTap: () {
                      onChanged(option.value);
                      // Optional: Add haptic feedback
                      HapticFeedback.lightImpact();
                    },
                    borderRadius: BorderRadius.circular(25),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [
                                  MyColors.kPrimaryColor,
                                  MyColors.kAccentBrown,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [
                                  MyColors.kCreamyWhite,
                                  MyColors.kCreamyWhite.withOpacity(0.8),
                                ],
                              ),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected
                              ? MyColors.kPrimaryColor.withOpacity(0.8)
                              : MyColors.kLightBrown.withOpacity(0.4),
                          width: isSelected ? 2.5 : 1.5,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: MyColors.kPrimaryColor.withOpacity(
                                    0.4,
                                  ),
                                  blurRadius: 12,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 4),
                                ),
                                BoxShadow(
                                  color: MyColors.kAccentBrown.withOpacity(0.2),
                                  blurRadius: 8,
                                  spreadRadius: -2,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: MyColors.kLightBrown.withOpacity(0.15),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Animated emoji
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(fontSize: isSelected ? 16 : 14),
                            child: Text(option.emoji),
                          ),
                          const SizedBox(width: 8),
                          // Label with animation
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: isSelected ? 13 : 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              color: isSelected
                                  ? MyColors.kCreamyWhite
                                  : MyColors.kPrimaryColor,
                              letterSpacing: isSelected ? 0.3 : 0,
                            ),
                            child: Text(option.label),
                          ),
                          // Checkmark for selected
                          if (isSelected) ...[
                            const SizedBox(width: 6),
                            AnimatedOpacity(
                              opacity: 1.0,
                              duration: const Duration(milliseconds: 200),
                              child: Icon(
                                Icons.check_circle,
                                size: 14,
                                color: MyColors.kCreamyWhite,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
