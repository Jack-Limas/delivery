import 'package:flutter/material.dart';

import '../../../../app/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/domain/models/food_item.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.item,
  });

  final FoodItem item;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late int _quantity = widget.item.initialQuantity;
  late double _spiceLevel = widget.item.initialSpiceLevel;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _TopIconButton(
                    icon: Icons.arrow_back,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),
                  _TopIconButton(
                    icon: Icons.search,
                    onTap: () => _showMessage('Busqueda abierta'),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Center(
                child: Hero(
                  tag: item.id,
                  child: Image.asset(
                    item.imagePath,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                '${item.title} ${item.subtitle}',
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF3F302D),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.star, color: Color(0xFFFF9F43), size: 20),
                  const SizedBox(width: 4),
                  Text(
                    item.rating.toStringAsFixed(1),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF665956),
                    ),
                  ),
                  Text(
                    ' - ${item.deliveryTime} mins',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: const Color(0xFF9A8F8B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                item.description,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 15,
                  height: 1.8,
                  color: const Color(0xFF7B726F),
                ),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Spicy',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 16,
                            color: const Color(0xFF3F302D),
                          ),
                        ),
                        SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 4,
                            activeTrackColor: AppColors.primary,
                            inactiveTrackColor: const Color(0xFFF3EFEF),
                            thumbColor: AppColors.primary,
                            overlayColor:
                                AppColors.primary.withValues(alpha: 0.16),
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 6,
                            ),
                          ),
                          child: Slider(
                            value: _spiceLevel,
                            onChanged: (value) {
                              setState(() {
                                _spiceLevel = value;
                              });
                            },
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            children: [
                              Text(
                                'Mild',
                                style: TextStyle(
                                  color: Color(0xFF51B54A),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Hot',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 22),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Portion',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: 16,
                          color: const Color(0xFF3F302D),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _PortionButton(
                            icon: Icons.remove,
                            onTap: () {
                              setState(() {
                                if (_quantity > 1) {
                                  _quantity--;
                                }
                              });
                            },
                          ),
                          SizedBox(
                            width: 44,
                            child: Center(
                              child: Text(
                                '$_quantity',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF3F302D),
                                ),
                              ),
                            ),
                          ),
                          _PortionButton(
                            icon: Icons.add,
                            onTap: () {
                              setState(() {
                                _quantity++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      height: 72,
                      child: FilledButton(
                        onPressed: () =>
                            _showMessage('Precio actual: \$${_totalPrice(item)}'),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          '\$${item.price.toStringAsFixed(2)}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    flex: 7,
                    child: SizedBox(
                      height: 72,
                      child: FilledButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AppRouter.customize,
                          arguments: item,
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF453533),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'ORDER NOW',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _totalPrice(FoodItem item) {
    final total = item.price * _quantity;
    return total.toStringAsFixed(2);
  }
}

class _TopIconButton extends StatelessWidget {
  const _TopIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(icon, color: const Color(0xFF3D2E2A), size: 28),
      ),
    );
  }
}

class _PortionButton extends StatelessWidget {
  const _PortionButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 38,
      height: 38,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}
