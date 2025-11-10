import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class ReservationProcessScreen extends StatefulWidget {
  final String listingId;

  const ReservationProcessScreen({super.key, required this.listingId});

  @override
  State<ReservationProcessScreen> createState() => _ReservationProcessScreenState();
}

class _ReservationProcessScreenState extends State<ReservationProcessScreen> {
  int _adults = 2;
  int _children = 0;
  // DateTime? _startDate; // Utilisé dans le futur
  // DateTime? _endDate; // Utilisé dans le futur

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
            color: isDark ? AppColors.textDark : AppColors.textMain,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Réserver votre séjour',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textDark : AppColors.textMain,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dates Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sélectionnez vos dates',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textDark : AppColors.textMain,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Calendar
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.backgroundDark : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.chevron_left,
                                color: isDark ? AppColors.textDark : AppColors.textMain,
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              'Juin 2024',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.textDark : AppColors.textMain,
                                fontFamily: 'PlusJakartaSans',
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.chevron_right,
                                color: isDark ? AppColors.textDark : AppColors.textMain,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Calendar Grid
                        _buildCalendarGrid(isDark),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
            ),
            // Guests Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Qui vous accompagne ?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textDark : AppColors.textMain,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Adults
                  _buildGuestSelector(
                    icon: Icons.person,
                    title: 'Adultes',
                    subtitle: '13 ans et plus',
                    count: _adults,
                    onDecrement: () {
                      if (_adults > 1) {
                        setState(() => _adults--);
                      }
                    },
                    onIncrement: () {
                      setState(() => _adults++);
                    },
                    isDark: isDark,
                  ),
                  const SizedBox(height: 16),
                  // Children
                  _buildGuestSelector(
                    icon: Icons.child_care,
                    title: 'Enfants',
                    subtitle: '2-12 ans',
                    count: _children,
                    onDecrement: () {
                      if (_children > 0) {
                        setState(() => _children--);
                      }
                    },
                    onIncrement: () {
                      setState(() => _children++);
                    },
                    isDark: isDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      // Bottom CTA
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: (isDark ? AppColors.backgroundDark : AppColors.backgroundLight).withOpacity(0.8),
          border: Border(
            top: BorderSide(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$345.24',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.textDark : AppColors.textMain,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                    Text(
                      'total',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? AppColors.textDark : AppColors.textMain,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Confirm reservation
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Confirmer la demande',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Détails du prix',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondary,
                  decoration: TextDecoration.underline,
                  fontFamily: 'PlusJakartaSans',
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
                        ? AppColors.textDark.withOpacity(0.7)
                        : AppColors.textMain.withOpacity(0.7),
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
          itemCount: 7 + dates.length, // Empty cells + dates
          itemBuilder: (context, index) {
            if (index < 7) {
              // Empty cells for alignment
              return const SizedBox();
            }
            final dateIndex = index - 7;
            final date = dates[dateIndex];
            final isSelected = date >= 20 && date <= 22;
            final isStart = date == 20;
            final isEnd = date == 22;

            return GestureDetector(
              onTap: () {
                // TODO: Handle date selection
              },
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.accent
                      : (isStart || isEnd
                          ? AppColors.primary
                          : Colors.transparent),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '$date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isStart || isEnd
                          ? Colors.white
                          : (isDark ? AppColors.textDark : AppColors.textMain),
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

  Widget _buildGuestSelector({
    required IconData icon,
    required String title,
    required String subtitle,
    required int count,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
    required bool isDark,
  }) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.textMain),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.textDark : AppColors.textMain,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? AppColors.textDark.withOpacity(0.7)
                      : AppColors.textMain.withOpacity(0.7),
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondary),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Text(
                  '-',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: onDecrement,
                padding: EdgeInsets.zero,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 24,
              child: Text(
                '$count',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isDark ? AppColors.textDark : AppColors.textMain,
                  fontFamily: 'PlusJakartaSans',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondary),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Text(
                  '+',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: onIncrement,
                padding: EdgeInsets.zero,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

