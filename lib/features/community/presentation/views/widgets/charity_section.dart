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
                oraganizationDescription:
                    'A national charity targeting hunger, education, and healthcare. Our food security branch distributes staple ingredients and clean water supplies to rural families in Upper Egypt.',
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
                oraganizationDescription:
                    'Al Amal focuses on serving remote villages by coordinating monthly food deliveries. Your donations help us reduce malnutrition in areas with little government support.',
                organizatonName: 'Al Amal Charity',
                cityName: 'Asyut',
                oragnizationLocation: ' - 6 10.3 km',
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
                oraganizationDescription:
                    'We believe in sustainability and zero waste. Takaful takes surplus food from markets and restaurants, ensuring it reaches orphanages and elderly homes while still fresh and usable.',
                organizatonName: 'Resala',
                cityName: 'Mansoura',
                oragnizationLocation: ' - 2.9 km',
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: CharityInformatonCard(
                oraganizationDescription:
                    'A national charity targeting hunger, education, and healthcare. Our food security branch distributes staple ingredients and clean water supplies to rural families in Upper Egypt.',
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
