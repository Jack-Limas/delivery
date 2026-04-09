import 'package:flutter/material.dart';

import '../../../../app/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../home/domain/models/food_item.dart';
import '../../domain/models/order_summary.dart';

class CustomizeOrderScreen extends StatefulWidget {
  const CustomizeOrderScreen({
    super.key,
    required this.item,
  });

  final FoodItem item;

  @override
  State<CustomizeOrderScreen> createState() => _CustomizeOrderScreenState();
}

class _CustomizeOrderScreenState extends State<CustomizeOrderScreen> {
  late int _quantity = widget.item.initialQuantity;
  int _patties = 2;
  double _spicyLevel = 0.90;

  final Map<String, bool> _toppings = <String, bool>{
    'Tomato': true,
    'Onions': true,
    'Pickles': false,
    'Bacons': false,
  };

  final Map<String, bool> _sides = <String, bool>{
    'Fries': true,
    'Coleslaw': true,
    'Salad': false,
    'Onion': false,
  };

  static const _extraPrices = <String, double>{
    'Tomato': 1.25,
    'Onions': 0.75,
    'Pickles': 0.95,
    'Bacons': 1.75,
    'Fries': 3.25,
    'Coleslaw': 2.00,
    'Salad': 2.15,
    'Onion': 1.00,
  };

  void _toggleOption(Map<String, bool> options, String name) {
    setState(() {
      options[name] = !(options[name] ?? false);
    });
  }

  double get _total {
    final extras = <String, bool>{..._toppings, ..._sides};
    final extrasTotal = extras.entries
        .where((entry) => entry.value)
        .fold<double>(
          0,
          (sum, entry) => sum + (_extraPrices[entry.key] ?? 0),
        );

    final pattiesTotal = (_patties - 1) * 2.40;
    return widget.item.price +
        extrasTotal +
        ((_quantity - 1) * 1.25) +
        pattiesTotal;
  }

  void _goToPayment() {
    final summary = OrderSummary(
      item: widget.item,
      quantity: _quantity,
      patties: _patties,
      spicyLevel: _spicyLevel,
      subtotal: double.parse(_total.toStringAsFixed(2)),
      toppings: _toppings.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList(),
      sides: _sides.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList(),
    );

    Navigator.pushNamed(
      context,
      AppRouter.payment,
      arguments: summary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 0, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    _TopIconButton(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    const Spacer(),
                    const _TopIconButton(
                      icon: Icons.search,
                      onTap: _noop,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.asset(
                              'assets/images/exploded_burger.png',
                              height: 270,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(
                                      fontSize: 15,
                                      height: 1.9,
                                      color: Color(0xFF4D403C),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: 'Customize ',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(text: 'Your Burger\n'),
                                      TextSpan(text: 'to Your Tastes. Ultimate\n'),
                                      TextSpan(text: 'Experience'),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 22),
                                const Text(
                                  'Spicy',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF3F302D),
                                  ),
                                ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 4,
                                    activeTrackColor: AppColors.primary,
                                    inactiveTrackColor: const Color(0xFFF1F0F4),
                                    thumbColor: AppColors.primary,
                                    overlayColor:
                                        AppColors.primary.withValues(alpha: 0.16),
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 6,
                                    ),
                                  ),
                                  child: Slider(
                                    value: _spicyLevel,
                                    onChanged: (value) {
                                      setState(() {
                                        _spicyLevel = value;
                                      });
                                    },
                                  ),
                                ),
                                const Row(
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
                                const SizedBox(height: 36),
                                const Text(
                                  'Meat',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF3F302D),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    _MiniActionButton(
                                      icon: Icons.remove,
                                      onTap: () {
                                        setState(() {
                                          if (_patties > 1) {
                                            _patties--;
                                          }
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 44,
                                      child: Center(
                                        child: Text(
                                          '$_patties',
                                          style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF3F302D),
                                          ),
                                        ),
                                      ),
                                    ),
                                    _MiniActionButton(
                                      icon: Icons.add,
                                      onTap: () {
                                        setState(() {
                                          if (_patties < 4) {
                                            _patties++;
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 28),
                                const Text(
                                  'Portion',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF3F302D),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    _MiniActionButton(
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
                                          style: const TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF3F302D),
                                          ),
                                        ),
                                      ),
                                    ),
                                    _MiniActionButton(
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
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Toppings',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3F302D),
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 128,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _OptionCard(
                              imagePath: 'assets/images/tomato.png',
                              label: 'Tomato',
                              selected: _toppings['Tomato']!,
                              onTap: () => _toggleOption(_toppings, 'Tomato'),
                            ),
                            _OptionCard(
                              imagePath: 'assets/images/onions.png',
                              label: 'Onions',
                              selected: _toppings['Onions']!,
                              onTap: () => _toggleOption(_toppings, 'Onions'),
                            ),
                            _OptionCard(
                              imagePath: 'assets/images/pickles.png',
                              label: 'Pickles',
                              selected: _toppings['Pickles']!,
                              onTap: () => _toggleOption(_toppings, 'Pickles'),
                            ),
                            _OptionCard(
                              imagePath: 'assets/images/bacons.png',
                              label: 'Bacons',
                              selected: _toppings['Bacons']!,
                              onTap: () => _toggleOption(_toppings, 'Bacons'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Side options',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF3F302D),
                        ),
                      ),
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 128,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _OptionCard(
                              imagePath: 'assets/images/fries.png',
                              label: 'Fries',
                              selected: _sides['Fries']!,
                              onTap: () => _toggleOption(_sides, 'Fries'),
                            ),
                            _OptionCard(
                              imagePath: 'assets/images/coleslaw.png',
                              label: 'Coleslaw',
                              selected: _sides['Coleslaw']!,
                              onTap: () => _toggleOption(_sides, 'Coleslaw'),
                            ),
                            _OptionCard(
                              imagePath: 'assets/images/salad.png',
                              label: 'Salad',
                              selected: _sides['Salad']!,
                              onTap: () => _toggleOption(_sides, 'Salad'),
                            ),
                            _OptionCard(
                              imagePath: 'assets/images/onion_rings.png',
                              label: 'Onion',
                              selected: _sides['Onion']!,
                              onTap: () => _toggleOption(_sides, 'Onion'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF7E736F),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '\$${_total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: Color(0xFF3F302D),
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        height: 72,
                        child: FilledButton(
                          onPressed: _goToPayment,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text('ORDER NOW'),
                        ),
                      ),
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
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.imagePath,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String imagePath;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Color(0xFF372A28)],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x18000000),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
            border: selected
                ? Border.all(color: AppColors.primary, width: 1.5)
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(imagePath, fit: BoxFit.contain),
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      selected ? Icons.check : Icons.add,
                      color: Colors.white,
                      size: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniActionButton extends StatelessWidget {
  const _MiniActionButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
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

void _noop() {}
