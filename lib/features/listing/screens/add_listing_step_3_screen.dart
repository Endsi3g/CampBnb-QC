import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class AddListingStep3Screen extends StatefulWidget {
  const AddListingStep3Screen({super.key});

  @override
  State<AddListingStep3Screen> createState() => _AddListingStep3ScreenState();
}

class _AddListingStep3ScreenState extends State<AddListingStep3Screen> {
  final _priceController = TextEditingController();
  final Map<int, bool> _calendarDates = {};

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? AppColors.textDark : AppColors.textLight,
          ),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Ajouter une annonce',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.textDark.withOpacity(0.2)
                        : AppColors.textLight.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.textDark.withOpacity(0.2)
                        : AppColors.textLight.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Étape 3: Prix et Calendrier',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textDark : AppColors.textLight,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            const SizedBox(height: 24),
            // Price Section
            Text(
              'Définir votre prix',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textDark : AppColors.textLight,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ceci est le prix de base par nuit pour votre emplacement.',
              style: TextStyle(
                fontSize: 16,
                color: isDark
                    ? AppColors.textDark.withOpacity(0.8)
                    : AppColors.textLight.withOpacity(0.8),
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            const SizedBox(height: 16),
            // Price Input
            Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.backgroundDark.withOpacity(0.5) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      '\$',
                      style: TextStyle(
                        fontSize: 18,
                        color: isDark ? AppColors.textDark : AppColors.textLight,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 18,
                        color: isDark ? AppColors.textDark : AppColors.textLight,
                        fontFamily: 'PlusJakartaSans',
                      ),
                      decoration: InputDecoration(
                        hintText: '50',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontFamily: 'PlusJakartaSans',
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      'CAD / nuit',
                      style: TextStyle(
                        fontSize: 18,
                        color: isDark
                            ? AppColors.textDark.withOpacity(0.6)
                            : AppColors.textLight.withOpacity(0.6),
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Calendar Section
            Text(
              'Gérer votre calendrier',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.textDark : AppColors.textLight,
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Touchez une date pour la marquer comme disponible ou indisponible.',
              style: TextStyle(
                fontSize: 16,
                color: isDark
                    ? AppColors.textDark.withOpacity(0.8)
                    : AppColors.textLight.withOpacity(0.8),
                fontFamily: 'PlusJakartaSans',
              ),
            ),
            const SizedBox(height: 16),
            // Calendar
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? AppColors.backgroundDark.withOpacity(0.5) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.chevron_left,
                          color: isDark ? AppColors.textDark : AppColors.textLight,
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        'Juin 2024',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textDark : AppColors.textLight,
                          fontFamily: 'PlusJakartaSans',
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.chevron_right,
                          color: isDark ? AppColors.textDark : AppColors.textLight,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildCalendarGrid(isDark),
                  const SizedBox(height: 16),
                  // Legend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primary,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Disponible',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? AppColors.textDark : AppColors.textLight,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 24),
                      Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Indisponible',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? AppColors.textDark : AppColors.textLight,
                              fontFamily: 'PlusJakartaSans',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: (isDark ? AppColors.backgroundDark : AppColors.backgroundLight).withOpacity(0.8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Publish listing
                  context.go('/host/dashboard');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Publier l\'annonce',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () => context.pop(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child: const Text(
                  'Retour',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid(bool isDark) {
    final days = ['D', 'L', 'M', 'M', 'J', 'V', 'S'];
    final dates = List.generate(30, (index) => index + 1);

    return Column(
      children: [
        // Day headers
        Row(
          children: days.map((day) {
            return Expanded(
              child: Center(
                child: Text(
                  day,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.textDark.withOpacity(0.6)
                        : AppColors.textLight.withOpacity(0.6),
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        // Calendar dates
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          itemCount: 7 + dates.length,
          itemBuilder: (context, index) {
            if (index < 7) {
              return const SizedBox();
            }
            final dateIndex = index - 7;
            final date = dates[dateIndex];
            final isSelected = date >= 11 && date <= 13;
            final isUnavailable = date >= 14 && date <= 15;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _calendarDates[date] = !(_calendarDates[date] ?? false);
                });
              },
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isUnavailable
                      ? AppColors.secondary
                      : (isSelected
                          ? Colors.transparent
                          : Colors.transparent),
                  border: isSelected
                      ? Border.all(
                          color: AppColors.primary,
                          width: 2,
                        )
                      : null,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isUnavailable
                          ? Colors.white
                          : (isDark ? AppColors.textDark : AppColors.textLight),
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

