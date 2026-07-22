import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../localization/locale_cubit.dart';

class LanguageSelectorButton extends StatelessWidget {
  const LanguageSelectorButton({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.watch<LocaleCubit>().state;

    return PopupMenuButton<Locale>(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            currentLocale.languageCode == 'vi' ? '🇻🇳' : '🇬🇧',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(width: 4),
          Text(
            currentLocale.languageCode.toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Icon(Icons.arrow_drop_down, color: Colors.white),
        ],
      ),
      tooltip: 'Chuyển đổi ngôn ngữ / Change Language',
      onSelected: (Locale locale) {
        context.read<LocaleCubit>().changeLocale(locale);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
        const PopupMenuItem<Locale>(
          value: Locale('vi'),
          child: Row(
            children: [
              Text('🇻🇳', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Text('Tiếng Việt', style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const PopupMenuItem<Locale>(
          value: Locale('en'),
          child: Row(
            children: [
              Text('🇬🇧', style: TextStyle(fontSize: 18)),
              SizedBox(width: 8),
              Text('English', style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
      ],
    );
  }
}
