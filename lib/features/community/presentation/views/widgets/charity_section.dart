import 'package:flutter/material.dart';
import 'package:save_bite/features/community/presentation/views/widgets/charity_informaton_card.dart';

class CharitySection extends StatelessWidget {
  const CharitySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CharityInformatonCard(
                organizatonName: 'Misr El Kheir',
                cityName: 'Giza',
                oragnizationLocation: ' - 3.2 Km away',
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: CharityInformatonCard(
                organizatonName: 'Ahl misr',
                cityName: 'Cairo',
                oragnizationLocation: ' - 6 Km away',
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: CharityInformatonCard(
                organizatonName: 'Resala',
                cityName: 'Cairo',
                oragnizationLocation: ' - 2 Km away',
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: CharityInformatonCard(
                organizatonName: 'Bahea',
                cityName: 'Giza',
                oragnizationLocation: ' - 8 Km away',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
