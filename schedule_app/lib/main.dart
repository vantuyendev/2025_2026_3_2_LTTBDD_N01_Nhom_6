import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/custom_button.dart';
import 'features/calendar/screens/calendar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schedule App',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const CalendarScreen(),
    );
  }
}

class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI/UX System Demo'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Visual Theme Demo',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Đây là bản demo giao diện tích hợp Light Theme và Custom Button dùng chung của dự án.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              CustomButton(
                title: 'Primary Button',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Custom Button Pressed!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                title: 'Accent Button',
                color: AppTheme.accentColor,
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Accent Color Button Pressed!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                title: 'Disabled Button',
                onPressed: null, // Disabled state
              ),
            ],
          ),
        ),
      ),
    );
  }
}
