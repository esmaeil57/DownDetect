import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view_model/therapist_viewmodel.dart';
import '../view_model/auth_viewmodel.dart';
import '../data/models/therapist_model.dart';
import 'add_therapist_screen.dart';
import 'therapist_detail_screen.dart';

class TherapistListScreen extends StatefulWidget {
   const TherapistListScreen({super.key});

  @override
  State<TherapistListScreen> createState() => _TherapistListScreenState();
}

class _TherapistListScreenState extends State<TherapistListScreen> {
  String searchQuery = "";
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TherapistViewModel>(context, listen: false).loadTherapists();
    });
  }

  @override
  Widget build(BuildContext context) {
    final therapistList = Provider.of<TherapistViewModel>(context).therapists;
    final filteredList =
    therapistList
        .where(
          (therapist) => therapist.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      ),
    )
        .toList();

    final screenSize = MediaQuery.of(context).size;
    final isTabletOrDesktop = screenSize.width > 600;

    return Consumer2<TherapistViewModel, AuthViewModel>(
      builder: (context, therapistViewModel, authViewModel, child) {
        return Scaffold(
          appBar:  AppBar(
            toolbarHeight: MediaQuery.of(context).size.height * 0.12,
            automaticallyImplyLeading: false,
            elevation: 4,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              margin: EdgeInsets.only(bottom: 5),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0E6C73), Color(0xFF199CA4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Stack(
                children: [
                  // Back button top-left
                  Positioned(
                    top: 25,
                    left: 8,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  // Search bar bottom center
                  Positioned(
                    bottom: 12,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(left: 8.0),
                        height: 44,
                        width: MediaQuery.of(context).size.width * 0.85,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                              isSearching = value.isNotEmpty;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search by therapist name',
                            hintStyle: const TextStyle(color: Colors.grey),
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            prefixIcon:
                            isSearching
                                ? IconButton(
                              icon: const Icon(
                                Icons.close,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                FocusScope.of(context).unfocus();
                                setState(() {
                                  searchQuery = '';
                                  isSearching = false;
                                });
                              },
                            )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        body: therapistViewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : therapistViewModel.errorMessage != null
              ? Center(child: Text(therapistViewModel.errorMessage!))
              : _buildTherapistList(filteredList, isTabletOrDesktop),
          floatingActionButton: authViewModel.isAdmin
              ? FloatingActionButton(
            backgroundColor: const Color(0xFF00838F),
            child: const Icon(Icons.add,color: Colors.white,),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddTherapistScreen(),
                ),
              ).then((_) {
                // Refresh list when returning from add screen
                therapistViewModel.loadTherapists();
              });
            },
          )
              : null,
        );
      },
    );
  }

  Widget _buildTherapistList(List<Therapist> therapists, bool isTabletOrDesktop) {
    return ListView.builder(
      padding: EdgeInsets.only(top:10),
      itemCount: therapists.length,
      itemBuilder: (context, index) {
        final therapist = therapists[index];
        return Card(
          elevation: 4,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(borderRadius:
          BorderRadius.horizontal(left: Radius.circular(25),right: Radius.circular(25))),
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: isTabletOrDesktop ? 16 : 18,
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: const AssetImage('images/doctor_18467657.png'),
              radius: isTabletOrDesktop ? 30 : 24,
            ),
            title: Text(
              therapist.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isTabletOrDesktop ? 18 : 16,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.access_time, size: 16),
                  const SizedBox(width: 4),
                  Text('${therapist.availableSlots} '),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  therapist.rate.length,
                      (starIndex) => Icon(
                    Icons.star,
                    size: isTabletOrDesktop ? 18 : 14,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
                          ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TherapistDetailScreen(therapist: therapist),
                ),
              );
            },
          ),
        );
      },
    );
  }
}