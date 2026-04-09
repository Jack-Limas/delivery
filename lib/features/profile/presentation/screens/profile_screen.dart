import 'package:flutter/material.dart';

import '../../../../app/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 170,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFF3757), Color(0xFFFF2347)],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  Positioned(
                    left: -36,
                    top: 22,
                    child: Opacity(
                      opacity: 0.28,
                      child: Image.asset(
                        'assets/images/veggie_burger.png',
                        width: 120,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -28,
                    top: 20,
                    child: Opacity(
                      opacity: 0.28,
                      child: Image.asset(
                        'assets/images/fried_chicken_burger.png',
                        width: 140,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    top: 10,
                    child: _HeaderIcon(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 10,
                    child: _HeaderIcon(
                      icon: Icons.settings,
                      onTap: () => Navigator.pushNamed(context, AppRouter.chat),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: _AvatarFrame(),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(14, 54, 14, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    const _InfoField(
                      label: 'Name',
                      value: 'Sophia Patel',
                    ),
                    const SizedBox(height: 14),
                    const _InfoField(
                      label: 'Email',
                      value: 'sophiapatel@gmail.com',
                    ),
                    const SizedBox(height: 14),
                    const _InfoField(
                      label: 'Delivery address',
                      value: '123 Main St Apartment 4A,New York, NY',
                    ),
                    const SizedBox(height: 14),
                    const _InfoField(
                      label: 'Password',
                      value: '● ● ● ● ● ● ● ● ● ●',
                      showLock: true,
                    ),
                    const SizedBox(height: 28),
                    const Divider(color: Color(0xFFF0E8E6)),
                    _MenuRow(
                      title: 'Payment Details',
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRouter.payment,
                        arguments: AppRouter.sampleOrderSummary,
                      ),
                    ),
                    _MenuRow(
                      title: 'Order history',
                      onTap: () => Navigator.pushNamed(context, AppRouter.chat),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: FilledButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Perfil editable pronto'),
                                  ),
                                );
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: const Color(0xFF453533),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Edit Profile'),
                                  SizedBox(width: 8),
                                  Icon(Icons.edit_outlined, size: 18),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                                context,
                                AppRouter.splash,
                                (route) => false,
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(
                                  color: AppColors.primary,
                                  width: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Log out'),
                                  SizedBox(width: 8),
                                  Icon(Icons.logout, size: 18),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}

class _AvatarFrame extends StatelessWidget {
  const _AvatarFrame();

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, 34),
      child: Container(
        width: 102,
        height: 102,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Color(0x29000000),
              blurRadius: 18,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary, width: 2),
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage('assets/images/profile_avatar.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoField extends StatelessWidget {
  const _InfoField({
    required this.label,
    required this.value,
    this.showLock = false,
  });

  final String label;
  final String value;
  final bool showLock;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFD9D2CF)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 14,
            top: -10,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Row(
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xFF9A8F8B),
                      fontSize: 14,
                    ),
                  ),
                  if (showLock) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.lock, size: 12, color: Color(0xFF9A8F8B)),
                  ],
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF3F302D),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF6D625E),
              ),
            ),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Color(0xFF6D625E)),
          ],
        ),
      ),
    );
  }
}
