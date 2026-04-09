import 'package:flutter/material.dart';

import '../../../../app/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/food_items.dart';
import '../../domain/models/food_item.dart';
import '../widgets/food_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _favorites = <String>{};
  String _selectedCategory = categories.first;
  int _selectedNavIndex = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<FoodItem> get _filteredItems {
    final query = _searchController.text.trim().toLowerCase();

    return foodItems.where((item) {
      final matchesCategory = _selectedCategory == 'All' ||
          item.category == _selectedCategory;
      final haystack = '${item.title} ${item.subtitle}'.toLowerCase();
      final matchesQuery = query.isEmpty || haystack.contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
  }

  void _toggleFavorite(String id) {
    setState(() {
      if (_favorites.contains(id)) {
        _favorites.remove(id);
      } else {
        _favorites.add(id);
      }
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _openProfile() {
    Navigator.pushNamed(context, AppRouter.profile);
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Foodgo',
                          style: theme.textTheme.headlineLarge?.copyWith(
                            fontSize: 28,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w800,
                            height: 1,
                            color: const Color(0xFF3A2A28),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Order your favourite food!',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            color: const Color(0xFF766A67),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _openProfile,
                    child: Container(
                      width: 54,
                      height: 54,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFFF1E8E5)),
                      ),
                      child: const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/profile_avatar.png'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(19),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x12000000),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setState(() {}),
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            size: 30,
                            color: Color(0xFF433432),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 18),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 58,
                    height: 58,
                    child: FilledButton(
                      onPressed: () => _showMessage('Filtros abiertos'),
                      style: FilledButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Icon(Icons.tune_rounded, size: 26),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 42,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final isSelected = category == _selectedCategory;
                    return ChoiceChip(
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF6F6662),
                        fontWeight: FontWeight.w500,
                      ),
                      backgroundColor: const Color(0xFFF4F4F6),
                      selectedColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide.none,
                      ),
                      showCheckmark: false,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 10,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: items.isEmpty
                    ? Center(
                        child: Text(
                          'No encontramos resultados',
                          style: theme.textTheme.titleMedium,
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.only(bottom: 110),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.67,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return FoodCard(
                            item: item,
                            isFavorite: _favorites.contains(item.id),
                            onFavoriteTap: () => _toggleFavorite(item.id),
                            onTap: () => Navigator.pushNamed(
                              context,
                              AppRouter.product,
                              arguments: item,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 76,
        height: 76,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x25000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: AppColors.primary,
          onPressed: () => Navigator.pushNamed(
            context,
            AppRouter.customize,
            arguments: foodItems.first,
          ),
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 34, color: Colors.white),
        ),
      ),
      bottomNavigationBar: _HomeBottomBar(
        currentIndex: _selectedNavIndex,
        onTap: (index) {
          setState(() {
            _selectedNavIndex = index;
          });

          const messages = <String>[
            'Inicio activo',
            'Perfil activo',
            'Pedidos activos',
            'Favoritos activos',
          ];

          if (index == 1) {
            _openProfile();
            return;
          }

          if (index == 2) {
            Navigator.pushNamed(
              context,
              AppRouter.payment,
              arguments: AppRouter.sampleOrderSummary,
            );
            return;
          }

          if (index == 3) {
            Navigator.pushNamed(context, AppRouter.chat);
            return;
          }

          _showMessage(messages[index]);
        },
      ),
    );
  }
}

class _HomeBottomBar extends StatelessWidget {
  const _HomeBottomBar({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    const items = <IconData>[
      Icons.home_outlined,
      Icons.person_outline,
      Icons.receipt_long_outlined,
      Icons.favorite_border,
    ];

    return BottomAppBar(
      color: AppColors.primary,
      height: 86,
      padding: const EdgeInsets.symmetric(horizontal: 26),
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Row(
        children: List.generate(items.length, (index) {
          final isLeftGroup = index < 2;
          final color = currentIndex == index
              ? Colors.white
              : Colors.white.withValues(alpha: 0.9);

          return Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isLeftGroup && index == 2) const SizedBox(width: 34),
                IconButton(
                  onPressed: () => onTap(index),
                  icon: Icon(items[index], color: color, size: 28),
                ),
                if (isLeftGroup && index == 1) const SizedBox(width: 34),
              ],
            ),
          );
        }),
      ),
    );
  }
}
