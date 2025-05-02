import 'package:flutter/material.dart';
import '../../domain/entities/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xFFF9F9F9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with emoji
            Text(
              '🍽️ ${recipe.title}',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff333333),
              ),
            ),
            const SizedBox(height: 8),

            // Prep time with clock emoji
            Row(
              children: [
                const Icon(Icons.schedule, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  'Ready in: ${recipe.prepTime ?? 'N/A'}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Color(0xff666666),
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            // Ingredients with 🧂 emoji
            const Text(
              '🧂 Ingredients:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Color(0xff444444),
              ),
            ),
            const SizedBox(height: 6),
            ...recipe.ingredients.map(
                  (ingredient) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  '• $ingredient',
                  style: const TextStyle(fontSize: 14.5,color: Color(0xff666666)),
                ),
              ),
            ),
            const Divider(height: 24),

            // Steps with 🍳 emoji
            const Text(
              '🍳 Instructions:',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Color(0xff444444),
              ),
            ),
            const SizedBox(height: 6),
            // ...recipe.instructions.asMap().entries.map(
            //       (entry) => Padding(
            //     padding: const EdgeInsets.only(top: 6.0),
            //     child: Text(
            //       '${entry.key + 1}. ${entry.value}',
            //       style: const TextStyle(fontSize: 14.5,color: Color(0xff666666)),
            //     ),
            //   ),
            // ),

            ...recipe.instructions.asMap().entries.map(
                  (entry) => Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24, // Fixed width to align numbers
                      child: Text(
                        '${entry.key + 1}.',
                        style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500,color: Color(0xff666666)),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(fontSize: 14.5,color: Color(0xff666666)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
