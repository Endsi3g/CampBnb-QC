import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../../../services/supabase_service.dart';
import '../../../models/listing_model.dart';
import '../../../features/auth/providers/auth_provider.dart';

class AddListingScreen extends ConsumerStatefulWidget {
  const AddListingScreen({super.key});
  
  @override
  ConsumerState<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends ConsumerState<AddListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _priceController = TextEditingController();
  final _maxGuestsController = TextEditingController();
  
  String? _selectedRegion;
  String? _selectedType;
  double? _latitude;
  double? _longitude;
  final List<String> _selectedAmenities = [];
  final List<String> _photos = [];
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _priceController.dispose();
    _maxGuestsController.dispose();
    super.dispose();
  }
  
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    final authState = ref.read(authNotifierProvider);
    final user = authState.valueOrNull;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vous devez être connecté')),
      );
      return;
    }
    
    if (_latitude == null || _longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner une localisation')),
      );
      return;
    }
    
    final listing = ListingModel(
      id: '', // Généré par Supabase
      hostId: user.id,
      title: _titleController.text,
      description: _descriptionController.text,
      listingType: _selectedType!,
      address: _addressController.text,
      city: _cityController.text,
      region: _selectedRegion!,
      latitude: _latitude!,
      longitude: _longitude!,
      pricePerNight: double.parse(_priceController.text),
      maxGuests: int.parse(_maxGuestsController.text),
      amenities: _selectedAmenities,
      photos: _photos,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    try {
      final supabase = SupabaseService();
      await supabase.createListing(listing);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.successListing)),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.addListing),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Titre',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Requis' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              validator: (value) => value?.isEmpty ?? true ? 'Requis' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedType,
              decoration: const InputDecoration(
                labelText: 'Type de camping',
                border: OutlineInputBorder(),
              ),
              items: AppConstants.listingTypes
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedType = value),
              validator: (value) => value == null ? 'Requis' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'Adresse',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Requis' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _cityController,
              decoration: const InputDecoration(
                labelText: 'Ville',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value?.isEmpty ?? true ? 'Requis' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedRegion,
              decoration: const InputDecoration(
                labelText: 'Région',
                border: OutlineInputBorder(),
              ),
              items: AppConstants.quebecRegions
                  .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedRegion = value),
              validator: (value) => value == null ? 'Requis' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Prix par nuit (\$)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) => value?.isEmpty ?? true ? 'Requis' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _maxGuestsController,
              decoration: const InputDecoration(
                labelText: 'Nombre maximum de voyageurs',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) => value?.isEmpty ?? true ? 'Requis' : null,
            ),
            const SizedBox(height: 24),
            const Text(
              'Équipements',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: AppConstants.amenities.map((amenity) {
                final isSelected = _selectedAmenities.contains(amenity);
                return FilterChip(
                  label: Text(amenity),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedAmenities.add(amenity);
                      } else {
                        _selectedAmenities.remove(amenity);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Créer l\'annonce'),
            ),
          ],
        ),
      ),
    );
  }
}

