import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_colors.dart';
import '../../models/listing_model.dart';

/// Carte d'annonce améliorée inspirée du design Airbnb
/// Avec animations, badges et interactions améliorées
class EnhancedListingCard extends StatefulWidget {
  final ListingModel listing;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final bool isFavorite;

  const EnhancedListingCard({
    super.key,
    required this.listing,
    this.onTap,
    this.onFavoriteTap,
    this.isFavorite = false,
  });

  @override
  State<EnhancedListingCard> createState() => _EnhancedListingCardState();
}

class _EnhancedListingCardState extends State<EnhancedListingCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) {
        _animationController.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _animationController.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.08),
                blurRadius: _isHovered ? 12 : 8,
                offset: Offset(0, _isHovered ? 6 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image avec badges et favoris
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: widget.listing.hasPhotos
                        ? CachedNetworkImage(
                            imageUrl: widget.listing.mainPhoto,
                            height: 240,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              height: 240,
                              color: AppColors.softGray,
                              child: const Center(child: CircularProgressIndicator()),
                            ),
                            errorWidget: (context, url, error) => Container(
                              height: 240,
                              color: AppColors.softGray,
                              child: const Icon(Icons.camping, size: 64),
                            ),
                          )
                        : Container(
                            height: 240,
                            color: AppColors.softGray,
                            child: const Icon(Icons.camping, size: 64),
                          ),
                  ),
                  // Badge "Nouveau" ou "Populaire"
                  if (widget.listing.isFeatured)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.forestGreen,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Populaire',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  // Bouton favoris
                  Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: widget.onFavoriteTap,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: widget.isFavorite ? Colors.red : Colors.black87,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  // Indicateur de photos multiples
                  if (widget.listing.photos.length > 1)
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.photo_library, size: 14, color: Colors.white),
                            const SizedBox(width: 4),
                            Text(
                              '${widget.listing.photos.length}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              // Contenu
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre et localisation
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.listing.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black87,
                                  fontFamily: 'PlusJakartaSans',
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      '${widget.listing.city}, ${widget.listing.region}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondary,
                                        fontFamily: 'PlusJakartaSans',
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Type et capacité
                    Row(
                      children: [
                        _buildInfoChip(
                          icon: _getTypeIcon(widget.listing.listingType),
                          label: _getTypeLabel(widget.listing.listingType),
                        ),
                        const SizedBox(width: 8),
                        _buildInfoChip(
                          icon: Icons.people,
                          label: '${widget.listing.maxGuests} voyageurs',
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Note et prix
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (widget.listing.ratingAverage > 0)
                          Row(
                            children: [
                              const Icon(Icons.star, size: 16, color: Colors.amber),
                              const SizedBox(width: 4),
                              Text(
                                widget.listing.ratingAverage.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              if (widget.listing.reviewCount > 0) ...[
                                const SizedBox(width: 4),
                                Text(
                                  '(${widget.listing.reviewCount})',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ],
                          )
                        else
                          const SizedBox.shrink(),
                        Text(
                          '\$${widget.listing.pricePerNight.toStringAsFixed(0)}/nuit',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.forestGreen,
                            fontFamily: 'PlusJakartaSans',
                          ),
                        ),
                      ],
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

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.softGray.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'tent':
        return Icons.camping;
      case 'rv':
        return Icons.rv_hookup;
      case 'cabin':
        return Icons.cabin;
      case 'van':
        return Icons.airport_shuttle;
      case 'glamping':
        return Icons.villa;
      default:
        return Icons.place;
    }
  }

  String _getTypeLabel(String type) {
    switch (type.toLowerCase()) {
      case 'tent':
        return 'Tente';
      case 'rv':
        return 'VR';
      case 'cabin':
        return 'Cabane';
      case 'van':
        return 'Van';
      case 'glamping':
        return 'Glamping';
      default:
        return 'Autre';
    }
  }
}

