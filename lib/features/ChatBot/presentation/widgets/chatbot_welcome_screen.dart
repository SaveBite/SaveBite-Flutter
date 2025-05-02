import 'package:flutter/material.dart';

import 'chat_input_field.dart';

class ChatWelcomeScreen extends StatelessWidget {
  final void Function(String) onSend;
  final TextEditingController controller;

  const ChatWelcomeScreen({super.key, required this.onSend, required this.controller});

  Widget _buildSuggestionButton(String suggestion) {
    return ElevatedButton(
      onPressed: () => onSend(suggestion),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(suggestion),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.restaurant_menu, size: 50, color: Colors.green),
          const SizedBox(height: 16),
          const Text('Hi, there 👋', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'Here to help you with ideas, advice and more! What would you like to cook today?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSuggestionButton('What can I cook with rice, chicken, and carrots?'),
              _buildSuggestionButton('Suggest a quick dinner recipe under 20 minutes.'),
              _buildSuggestionButton('How can I store leftover pasta to keep it fresh?'),
            ],
          ),
          const SizedBox(height: 16),
          ChatInputField(controller: controller, onSend: onSend),
        ],
      ),
    );
  }
}
