import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class DesignHandoffScreen extends StatelessWidget {
  const DesignHandoffScreen({super.key});

  static const _screens = <String>[
    'Splash / bienvenida',
    'Home con categorias y promociones',
    'Detalle de producto',
    'Carrito / checkout',
    'Pantallas secundarias por confirmar',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Base lista para construir tu Figma en Flutter',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Ya dejé la app arrancando con tema, rutas y referencia visual del archivo .fig extraído localmente.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.92),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Siguiente paso: compartir exportes grandes o link de Figma para replicar el diseño exacto.',
                            ),
                          ),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primaryDark,
                      ),
                      child: const Text('Continuar con el handoff'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Referencia extraída',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 400 / 128,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.asset(
                            'assets/reference/figma_overview.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Este overview viene directamente de tu archivo .fig y nos sirve para mapear el flujo antes de replicarlo pantalla por pantalla.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Pantallas identificadas',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ..._screens.map(
                (screen) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: AppColors.card,
                        foregroundColor: AppColors.primaryDark,
                        child: Icon(Icons.layers_outlined),
                      ),
                      title: Text(screen),
                      subtitle: const Text(
                        'La estructura Flutter ya está lista para implementarla.',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Lo que sí hace falta para copiarlo igualito',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              const _NeedItem(
                title: 'Frames exportados en PNG o JPG',
                description:
                    'Idealmente uno por pantalla, en tamaño completo, para replicar cada margen, texto y jerarquía visual.',
              ),
              const _NeedItem(
                title: 'O un link compartido de Figma',
                description:
                    'Con eso sí puedo leer nombres, medidas, colores y componentes con mucha más precisión.',
              ),
              const _NeedItem(
                title: 'Assets puntuales si tienen branding propio',
                description:
                    'Logos, ilustraciones o iconos personalizados que no vengan ya rasterizados dentro del archivo.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NeedItem extends StatelessWidget {
  const _NeedItem({
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.outline),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2),
              child: Icon(
                Icons.check_circle_outline,
                color: AppColors.primaryDark,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(description, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
