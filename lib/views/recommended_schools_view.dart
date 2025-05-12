import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/community_view_model.dart';
import '../widgets/school_card.dart';

class RecommendedSchoolsView extends StatelessWidget {
  const RecommendedSchoolsView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommunityViewModel>(context);
    final schools = viewModel.schools;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: schools.length,
      itemBuilder: (context, index) {
        final school = schools[index];
        return SchoolCard(
          school: school,
          index: index,
        );
      },
    );
  }
}