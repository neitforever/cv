import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const CVApp());
}

void launchUrl(String url) {
  if (url.startsWith('mailto:')) {
    html.window.location.href = url;
  } else {
    html.window.open(url, '_blank');
  }
}

class CVApp extends StatefulWidget {
  const CVApp({super.key});

  @override
  State<CVApp> createState() => _CVAppState();
}

class _CVAppState extends State<CVApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Владислав Птяжко — Резюме',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      home: CVHomePage(
        themeMode: _themeMode,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

const _seedColor = Color(0xFF2F6FED);

ThemeData buildLightTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.light,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: const Color(0xFFF4F6FB),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFFF4F6FB),
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    dividerColor: colorScheme.outlineVariant,
  );
}

ThemeData buildDarkTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.dark,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: const Color(0xFF10131A),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF10131A),
      foregroundColor: colorScheme.onSurface,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: const Color(0xFF1A1E27),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    dividerColor: colorScheme.outlineVariant,
  );
}

class CVHomePage extends StatelessWidget {
  const CVHomePage({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
  });

  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  Widget build(BuildContext context) {
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Резюме',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            tooltip: isDark ? 'Светлая тема' : 'Тёмная тема',
            icon: Icon(
                isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
            onPressed: onToggleTheme,
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isNarrow = constraints.maxWidth < 640;
                final colorScheme = Theme.of(context).colorScheme;
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isNarrow ? 16 : 32,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      HeaderSection(isNarrow: isNarrow),
                      const SizedBox(height: 28),
                      SectionCard(
                        title: 'Обо мне',
                        icon: Icons.person_outline,
                        child: const Text(
                          'Самостоятельно разработал фитнес-приложение Trainify — от прототипа '
                          'до полноценного сервиса с ИИ-функционалом. Выстроил инфраструктуру '
                          'проекта: настроил облачную синхронизацию на базе Firebase и реализовал '
                          'бизнес-логику на клиенте.\n\n'
                          'Создал жизнеспособный продукт, доведённый до предрелизного состояния.\n\n'
                          'В процессе разработки быстро освоил смежные технологии, что позволило '
                          'быстро интегрировать сервисы в проект.',
                          style: TextStyle(fontSize: 15, height: 1.5),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SectionCard(
                        title: 'Навыки',
                        icon: Icons.build_outlined,
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: skills
                              .map((skill) => Chip(
                                    label: Text(skill),
                                    visualDensity: VisualDensity.compact,
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SectionCard(
                        title: 'Опыт работы',
                        icon: Icons.work_outline,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (var i = 0;
                                i < experienceItems.length;
                                i++) ...[
                              ExperienceTile(item: experienceItems[i]),
                              if (i != experienceItems.length - 1)
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Divider(height: 1),
                                ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const TrainifySection(),
                      const SizedBox(height: 20),
                      SectionCard(
                        title: 'Образование',
                        icon: Icons.school_outlined,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/mmf_logo.svg',
                              width: 52,
                              height: 67,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Белорусский государственный университет',
                                    style: TextStyle(
                                        fontSize: 15.5,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    '«Математика и информационные технологии»\n'
                                    '(математическое и программное обеспечение мобильных устройств)',
                                    style:
                                        TextStyle(fontSize: 14, height: 1.45),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '2022–2026',
                                    style: TextStyle(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SectionCard(
                        title: 'Языки',
                        icon: Icons.language_outlined,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            LanguageRow(
                                name: 'Русский',
                                level: 'Родной',
                                progress: 1.0),
                            SizedBox(height: 14),
                            LanguageRow(
                                name: 'Английский',
                                level: 'B1–B2',
                                progress: 0.62),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.isNarrow});

  final bool isNarrow;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final avatar = CircleAvatar(
      radius: isNarrow ? 56 : 64,
      backgroundColor: colorScheme.primaryContainer,
      backgroundImage: const AssetImage('assets/images/photo.jpg'),
    );

    final nameAndTitle = Column(
      crossAxisAlignment:
          isNarrow ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Птяжко Владислав Александрович',
          textAlign: isNarrow ? TextAlign.center : TextAlign.left,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          'Android-разработчик (Kotlin)',
          textAlign: isNarrow ? TextAlign.center : TextAlign.left,
          style: TextStyle(
            fontSize: 17,
            color: colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          alignment: isNarrow ? WrapAlignment.center : WrapAlignment.start,
          spacing: 8,
          runSpacing: 8,
          children: const [
            ContactChip(
              materialIcon: Icons.email_outlined,
              label: 'pvs1606@gmail.com',
              url: 'mailto:pvs1606@gmail.com',
            ),
            ContactChip(
              svgAsset: 'assets/icons/telegram.svg',
              label: '@neitforever',
              url: 'https://t.me/neitforever',
            ),
            ContactChip(
              svgAsset: 'assets/icons/github.svg',
              label: 'github.com/neitforever',
              url: 'https://github.com/neitforever',
            ),
            ContactChip(
              svgAsset: 'assets/icons/linkedin.svg',
              label: 'LinkedIn',
              url:
                  'https://www.linkedin.com/in/%D0%B2%D0%BB%D0%B0%D0%B4-%D0%BF%D1%82%D1%8F%D0%B6%D0%BA%D0%BE-754172421/',
            ),
          ],
        ),
      ],
    );

    if (isNarrow) {
      return Column(
        children: [
          avatar,
          const SizedBox(height: 16),
          nameAndTitle,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        avatar,
        const SizedBox(width: 24),
        Expanded(child: nameAndTitle),
      ],
    );
  }
}

class ContactChip extends StatelessWidget {
  const ContactChip({
    super.key,
    this.materialIcon,
    this.svgAsset,
    required this.label,
    required this.url,
  }) : assert(materialIcon != null || svgAsset != null);

  final IconData? materialIcon;
  final String? svgAsset;
  final String label;
  final String? url;

  Widget _buildIcon(Color color) {
    if (svgAsset != null) {
      return SvgPicture.asset(
        svgAsset!,
        width: 16,
        height: 16,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }
    return Icon(materialIcon, size: 17, color: color);
  }

  @override
  Widget build(BuildContext context) {
    final enabled = url != null;
    final colorScheme = Theme.of(context).colorScheme;

    return Opacity(
      opacity: enabled ? 1.0 : 0.55,
      child: Material(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: enabled ? () => launchUrl(url!) : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildIcon(colorScheme.primary),
                const SizedBox(width: 7),
                Text(label, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  final String title;
  final IconData icon;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(icon, color: colorScheme.primary, size: 22),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class ExperienceItem {
  const ExperienceItem({
    required this.role,
    required this.place,
    required this.duration,
    required this.bullets,
  });

  final String role;
  final String place;
  final String duration;
  final List<String> bullets;
}

const experienceItems = [
  ExperienceItem(
    role: 'Android-разработчик (pet-project / дипломная работа)',
    place: 'Trainify',
    duration: '1+ год, разработка продолжается',
    bullets: [
      'Самостоятельно спроектировал и разработал приложение с нуля до текущего состояния.',
      'Реализовал ИИ-функции на базе Google Gemini через собственный backend-прокси на Cloudflare Workers.',
      'Готовлю проект к коммерческому релизу.',
    ],
  ),
  ExperienceItem(
    role: 'Flutter-разработчик (практика от БГУ)',
    place: 'IndevSolutions (indev.by)',
    duration: '3 месяца',
    bullets: [
      'Обучался Dart и Flutter в процессе практики.',
      'Реализовал MVP интеграции с BLE-устройством.',
      'Реализовал MVP двухфакторной аутентификации (2FA).',
    ],
  ),
  ExperienceItem(
    role: 'Специалист по информационным технологиям (практика)',
    place: 'БГАТУ',
    duration: '4 месяца',
    bullets: [
      'Решал задачи технической поддержки и сопровождения ИТ-инфраструктуры.',
    ],
  ),
];

class ExperienceTile extends StatelessWidget {
  const ExperienceTile({super.key, required this.item});

  final ExperienceItem item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.role,
          style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 3),
        Text(
          '${item.place} · ${item.duration}',
          style: TextStyle(
            fontSize: 13.5,
            color: colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        for (final bullet in item.bullets) BulletPoint(text: bullet),
      ],
    );
  }
}

class BulletPoint extends StatelessWidget {
  const BulletPoint({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.circle, size: 5),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}

const skills = [
  'Kotlin',
  'Jetpack Compose',
  'ViewModel / MVVM',
  'MVI',
  'Clean Architecture',
  'Room',
  'Navigation Component',
  'Coroutines',
  'Flow',
  'Retrofit',
  'Dagger / Hilt',
  'Firebase (Auth, Firestore, Storage)',
  'WorkManager',
  'DataStore',
  'Material Design 3',
  'Google Health Connect',
  'Google Sign-In / Credential Manager',
  'Интеграция AI API (Google Gemini)',
  'Cloudflare Workers (serverless backend)',
  'Android Studio',
  'Gradle (Kotlin DSL)',
  'Git',
  'CI/CD',
];

const trainifyFeatures = [
  'Дневник тренировок: подходы, повторения, вес, дроп-сеты и кластерные подходы, таймер отдыха, календарь и история тренировок.',
  'ИИ-функции на базе Google Gemini через собственный backend-прокси (Cloudflare Workers): генерация упражнений, шаблонов и планов тренировок, распознавание тренажёров по фото, анализ техники выполнения упражнения по видео.',
  'Поиск обучающих видео по технике выполнения упражнений через YouTube Data API.',
  'Геймификация: система наград и уровней (Wood → Bronze → Silver → Gold → Platinum) по 14 категориям достижений.',
  'Интеграции с Google Health Connect (шаги, пульс, калории) и внешними Bluetooth-устройствами.',
  'Firebase Auth и Google Sign-In, синхронизация локальной базы Room с Firebase Firestore для офлайн-режима.',
  'Локализация на русский, английский и белорусский языки.',
];

const trainifyTech = [
  'Kotlin',
  'Jetpack Compose',
  'MVVM',
  'Room',
  'Firebase',
  'Retrofit',
  'WorkManager',
  'Health Connect',
  'Media3',
  'Cloudflare Workers',
  'Google Gemini API',
];

class TrainifySection extends StatelessWidget {
  const TrainifySection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 26,
                  backgroundImage:
                      AssetImage('assets/images/trainify_icon.png'),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trainify',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        'Фитнес-приложение',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimaryContainer
                              .withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  tooltip: 'Открыть репозиторий на GitHub',
                  onPressed: () =>
                      launchUrl('https://github.com/neitforever/Trainify'),
                  icon: SvgPicture.asset(
                    'assets/icons/github.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                        colorScheme.onPrimaryContainer, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              'Android-приложение для тренировок с ИИ-функциями на базе Google Gemini: '
              'генерация упражнений и планов тренировок, распознавание оборудования по фото, '
              'анализ техники выполнения упражнений по видео. Собственная облачная '
              'инфраструктура на Firebase обеспечивает синхронизацию данных между устройствами '
              'и офлайн-режим. Проект доведён до предрелизного состояния и готовится к '
              'коммерческому запуску.',
              style: TextStyle(
                fontSize: 14.5,
                height: 1.5,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            for (final feature in trainifyFeatures)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2.5, right: 8),
                      child: Icon(Icons.check_circle,
                          size: 15, color: colorScheme.primary),
                    ),
                    Expanded(
                      child: Text(
                        feature,
                        style: TextStyle(
                          fontSize: 13.5,
                          height: 1.45,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: trainifyTech
                  .map((tech) => Chip(
                        label:
                            Text(tech, style: const TextStyle(fontSize: 12.5)),
                        visualDensity: VisualDensity.compact,
                        backgroundColor: colorScheme.surface,
                        side: BorderSide(
                            color: colorScheme.primary.withValues(alpha: 0.3)),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageRow extends StatelessWidget {
  const LanguageRow({
    super.key,
    required this.name,
    required this.level,
    required this.progress,
  });

  final String name;
  final String level;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            Text(level,
                style: const TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}
