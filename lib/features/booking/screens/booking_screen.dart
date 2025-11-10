import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../features/listing/providers/listing_provider.dart';
import '../providers/booking_provider.dart';
import '../../../models/booking_model.dart';
import '../../../features/auth/providers/auth_provider.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final String listingId;
  
  const BookingScreen({
    super.key,
    required this.listingId,
  });
  
  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  DateTime? _checkIn;
  DateTime? _checkOut;
  int _guests = 1;
  final _messageController = TextEditingController();
  bool _isLoading = false;
  
  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
  
  Future<void> _submitBooking() async {
    if (_checkIn == null || _checkOut == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner les dates')),
      );
      return;
    }
    
    final listing = await ref.read(listingDetailsProvider(widget.listingId).future);
    if (listing == null) return;
    
    final authState = ref.read(authNotifierProvider);
    final user = authState.valueOrNull;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vous devez être connecté')),
      );
      return;
    }
    
    final nights = _checkOut!.difference(_checkIn!).inDays;
    final totalPrice = listing.pricePerNight * nights;
    
    final booking = BookingModel(
      id: '',
      listingId: widget.listingId,
      guestId: user.id,
      checkIn: _checkIn!,
      checkOut: _checkOut!,
      nights: nights,
      guests: _guests,
      totalPrice: totalPrice,
      guestMessage: _messageController.text.isEmpty ? null : _messageController.text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    setState(() => _isLoading = true);
    
    try {
      await ref.read(bookingNotifierProvider.notifier).createBooking(booking);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.successBooking)),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final listingAsync = ref.watch(listingDetailsProvider(widget.listingId));
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réserver'),
      ),
      body: listingAsync.when(
        data: (listing) {
          if (listing == null) {
            return const Center(child: Text('Annonce non trouvée'));
          }
          
          final nights = _checkIn != null && _checkOut != null
              ? _checkOut!.difference(_checkIn!).inDays
              : 0;
          final totalPrice = listing.pricePerNight * nights;
          
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Dates
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dates',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                );
                                if (date != null) {
                                  setState(() => _checkIn = date);
                                }
                              },
                              child: Text(
                                _checkIn != null
                                    ? '${_checkIn!.day}/${_checkIn!.month}/${_checkIn!.year}'
                                    : AppStrings.checkIn,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () async {
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: _checkIn ?? DateTime.now(),
                                  firstDate: _checkIn ?? DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                );
                                if (date != null) {
                                  setState(() => _checkOut = date);
                                }
                              },
                              child: Text(
                                _checkOut != null
                                    ? '${_checkOut!.day}/${_checkOut!.month}/${_checkOut!.year}'
                                    : AppStrings.checkOut,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Voyageurs
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppStrings.guests,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _guests > 1
                                ? () => setState(() => _guests--)
                                : null,
                            icon: const Icon(Icons.remove_circle),
                          ),
                          Text(
                            '$_guests',
                            style: const TextStyle(fontSize: 18),
                          ),
                          IconButton(
                            onPressed: _guests < listing.maxGuests
                                ? () => setState(() => _guests++)
                                : null,
                            icon: const Icon(Icons.add_circle),
                          ),
                          const Spacer(),
                          Text('Max: ${listing.maxGuests}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Message
              TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Message pour l\'hôte (optionnel)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              // Récapitulatif
              Card(
                color: AppColors.softGray,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$${listing.pricePerNight.toStringAsFixed(2)} x $nights nuits'),
                          Text('\$${totalPrice.toStringAsFixed(2)}'),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            AppStrings.total,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\$${totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Bouton de réservation
              ElevatedButton(
                onPressed: _isLoading ? null : _submitBooking,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text(AppStrings.bookNow),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Erreur: $error')),
      ),
    );
  }
}

