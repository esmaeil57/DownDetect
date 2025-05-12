import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/community_view_model.dart';
import '../widgets/journey_card.dart';

class SharedJourneysView extends StatelessWidget {
  const SharedJourneysView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommunityViewModel>(context);
    final journeys = viewModel.journeys;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: journeys.length,
      itemBuilder: (context, index) {
        final journey = journeys[index];
        return JourneyCard(
          journey: journey,
          index: index,
        );
      },
    );
  }
}