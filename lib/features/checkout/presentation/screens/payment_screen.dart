import 'package:flutter/material.dart';

import '../../../../app/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/order_summary.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.summary,
  });

  final OrderSummary summary;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'mastercard';
  bool _saveCard = true;

  @override
  Widget build(BuildContext context) {
    final summary = widget.summary;

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
                  const _TopIconButton(icon: Icons.search, onTap: _noop),
                ],
              ),
              const SizedBox(height: 26),
              const Text(
                'Order summary',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3F302D),
                ),
              ),
              const SizedBox(height: 24),
              _SummaryRow('Order', '\$${summary.subtotal.toStringAsFixed(2)}'),
              const SizedBox(height: 16),
              _SummaryRow('Taxes', '\$${summary.taxes.toStringAsFixed(1)}'),
              const SizedBox(height: 16),
              _SummaryRow(
                'Delivery fees',
                '\$${summary.deliveryFee.toStringAsFixed(1)}',
              ),
              const Divider(height: 34, color: Color(0xFFF0E8E6)),
              _SummaryRow(
                'Total:',
                '\$${summary.total.toStringAsFixed(2)}',
                isBold: true,
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Text(
                    'Estimated delivery time:',
                    style: TextStyle(
                      color: Color(0xFF4D403C),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '15 - 30mins',
                    style: TextStyle(
                      color: Color(0xFF4D403C),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 56),
              const Text(
                'Payment methods',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF3F302D),
                ),
              ),
              const SizedBox(height: 22),
              _PaymentMethodCard(
                selected: _selectedMethod == 'mastercard',
                title: 'Credit card',
                subtitle: '5105 **** **** 0505',
                logoPath: 'assets/images/mastercard_logo.png',
                dark: true,
                onTap: () => setState(() => _selectedMethod = 'mastercard'),
              ),
              const SizedBox(height: 16),
              _PaymentMethodCard(
                selected: _selectedMethod == 'visa',
                title: 'Debit card',
                subtitle: '3566 **** **** 0505',
                logoPath: 'assets/images/visa_logo.png',
                dark: false,
                onTap: () => setState(() => _selectedMethod = 'visa'),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Checkbox(
                    value: _saveCard,
                    activeColor: AppColors.primary,
                    side: const BorderSide(color: Color(0xFFD7CFCC)),
                    onChanged: (value) {
                      setState(() {
                        _saveCard = value ?? false;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text(
                      'Save card details for future payments',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF7E736F),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total price',
                          style: TextStyle(
                            color: Color(0xFF9D908B),
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '\$${summary.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF3F302D),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 72,
                      child: FilledButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AppRouter.success,
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF453533),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Pay Now'),
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
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow(this.label, this.value, {this.isBold = false});

  final String label;
  final String value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: isBold ? const Color(0xFF3F302D) : const Color(0xFF746A66),
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: const Color(0xFF3F302D),
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _PaymentMethodCard extends StatelessWidget {
  const _PaymentMethodCard({
    required this.selected,
    required this.title,
    required this.subtitle,
    required this.logoPath,
    required this.dark,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final String subtitle;
  final String logoPath;
  final bool dark;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = dark ? const Color(0xFF453533) : const Color(0xFFF8F8FB);
    final titleColor = dark ? Colors.white : const Color(0xFF3F302D);
    final subtitleColor =
        dark ? Colors.white.withValues(alpha: 0.58) : const Color(0xFFA29A97);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(logoPath, width: dark ? 54 : 64, height: 36),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: subtitleColor)),
                ],
              ),
            ),
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: dark ? Colors.white : const Color(0xFFD8D3D1),
            ),
          ],
        ),
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
