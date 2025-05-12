import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../view_model/tab_view_model.dart';
import '../widgets/custom_tab_indicator.dart';
import 'shared_journeys_view.dart';
import 'recommended_schools_view.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // Listen to tab changes and update view model
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        Provider.of<TabViewModel>(context, listen: false)
            .setTabIndex(_tabController.index);
        _pageController.animateToPage(
          _tabController.index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabViewModel = Provider.of<TabViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Supportive Community',
          style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.normal),
        ),
        backgroundColor: Colors.transparent ,
        flexibleSpace: Container(
          height: MediaQuery.of(context).size.height*0.13,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0E6C73), Color(0xFF199CA4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            ),
          ),
        ),
      body: Column(
        children: [
          // Custom tab bar with animation
          Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              labelColor: Colors.teal,
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              indicator: CustomTabIndicator(
                color: Colors.green[800]!,
                height: 3,
                radius: 8,
                horizontalPadding: 10,
              ),
              tabs: const [
                Tab(text: 'Shared Journeys'),
                Tab(text: 'Recommended Schools & Centers'),
              ],
              onTap: (index) {
                tabViewModel.setTabIndex(index);
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            ),
          ),

          // Tab descriptions
          Consumer<TabViewModel>(
            builder: (context, model, child) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 0.1),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: Container(
                  key: ValueKey<int>(model.selectedTabIndex),
                  padding: const EdgeInsets.all(16),
                  color: Colors.grey[50],
                  width: double.infinity,
                  child: Text(
                    model.selectedTabIndex == 0
                        ? 'A supportive space where parents share their stories, positive experiences, and advice to uplift others.'
                        : 'A helpful directory where parents can find inclusive schools, therapy centers, and activity hubs.',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
          ),

          // Page views
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                tabViewModel.setTabIndex(index);
                _tabController.animateTo(index);
              },
              children: const [
                SharedJourneysView(),
                RecommendedSchoolsView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}