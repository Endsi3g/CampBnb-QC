import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class AddListingStep2Screen extends StatefulWidget {
  const AddListingStep2Screen({super.key});

  @override
  State<AddListingStep2Screen> createState() => _AddListingStep2ScreenState();
}

class _AddListingStep2ScreenState extends State<AddListingStep2Screen> {
  final Map<String, bool> _equipments = {
    'Wi-Fi': false,
    'Douche': true,
    'Toilettes': true,
    'Électricité': false,
    'Foyer': true,
    'Table de pique-nique': false,
    'Eau potable': true,
  };

  final Map<String, bool> _activities = {
    'Randonnée': true,
    'Accès au lac': false,
    'Pêche': false,
    'Kayak/Canot': true,
    'Vélo de montagne': false,
    'Baignade': false,
  };

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
      body: Column(
        children: [
          // Progress Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (isDark ? AppColors.backgroundDark : AppColors.backgroundLight)
                  .withOpacity(0.8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Étape 2 sur 5',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? AppColors.textDark : AppColors.textLight,
                        fontFamily: 'PlusJakartaSans',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Équipements et Activités',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textDark : AppColors.textLight,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Équipements Section
                  Text(
                    'Quels équipements offrez-vous ?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textDark : AppColors.textLight,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black.withOpacity(0.2) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: _equipments.entries.map((entry) {
                        return _buildCheckboxItem(
                          icon: _getEquipmentIcon(entry.key),
                          label: entry.key,
                          value: entry.value,
                          onChanged: (value) {
                            setState(() {
                              _equipments[entry.key] = value ?? false;
                            });
                          },
                          isDark: isDark,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Activités Section
                  Text(
                    'Quelles sont les activités populaires à proximité ?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.textDark : AppColors.textLight,
                      fontFamily: 'PlusJakartaSans',
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? Colors.black.withOpacity(0.2) : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: _activities.entries.map((entry) {
                        return _buildCheckboxItem(
                          icon: _getActivityIcon(entry.key),
                          label: entry.key,
                          value: entry.value,
                          onChanged: (value) {
                            setState(() {
                              _activities[entry.key] = value ?? false;
                            });
                          },
                          isDark: isDark,
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: (isDark ? AppColors.backgroundDark : AppColors.backgroundLight).withOpacity(0.8),
          border: Border(
            top: BorderSide(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.pop(),
                style: OutlinedButton.styleFrom(
                  foregroundColor: isDark ? AppColors.textDark : AppColors.textLight,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child: const Text(
                  'Précédent',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlusJakartaSans',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => context.push('/listing/add/step3'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child: const Text(
                  'Suivant',
                  style: TextStyle(
                    fontSize: 16,
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

  IconData _getEquipmentIcon(String equipment) {
    switch (equipment) {
      case 'Wi-Fi':
        return Icons.wifi;
      case 'Douche':
        return Icons.shower;
      case 'Toilettes':
        return Icons.wc;
      case 'Électricité':
        return Icons.electrical_services;
      case 'Foyer':
        return Icons.local_fire_department;
      case 'Table de pique-nique':
        return Icons.deck;
      case 'Eau potable':
        return Icons.water_drop;
      default:
        return Icons.check;
    }
  }

  IconData _getActivityIcon(String activity) {
    switch (activity) {
      case 'Randonnée':
        return Icons.hiking;
      case 'Accès au lac':
        return Icons.kayaking;
      case 'Pêche':
        return Icons.phishing;
      case 'Kayak/Canot':
        return Icons.scuba_diving;
      case 'Vélo de montagne':
        return Icons.directions_bike;
      case 'Baignade':
        return Icons.pool;
      default:
        return Icons.check;
    }
  }

  Widget _buildCheckboxItem({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool?> onChanged,
    required bool isDark,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
          ),
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: 32,
          color: AppColors.secondary,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDark ? AppColors.textDark : AppColors.textLight,
            fontFamily: 'PlusJakartaSans',
          ),
        ),
        trailing: Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    );
  }
}

