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
    final filteredList = therapistList.where((therapist) => therapist.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();
    final screenSize = MediaQuery.of(context).size;
    final isTabletOrDesktop = screenSize.width > 600;

    return Consumer2<TherapistViewModel, AuthViewModel>(
      builder: (context, therapistViewModel, authViewModel, child) {
        return Scaffold(
          appBar: _buildAppBar(context),
          body: therapistViewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : therapistViewModel.errorMessage != null
              ? Center(child: Text(therapistViewModel.errorMessage!))
              : _buildTherapistList(filteredList, isTabletOrDesktop, authViewModel),
          floatingActionButton: authViewModel.isAdmin
              ? FloatingActionButton(
            backgroundColor: const Color(0xFF00838F),
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddTherapistScreen())).then((_) {
                therapistViewModel.loadTherapists();
              });
            },
          )
              : null,
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar (
      toolbarHeight: MediaQuery.of(context).size.height * 0.12,
      automaticallyImplyLeading: false,
      elevation: 4,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        margin: const EdgeInsets.only(bottom: 5),
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
            Positioned(
              top: 25,
              left: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(left: 8.0),
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
                      suffixIcon: const Icon(Icons.search, color: Colors.grey),
                      prefixIcon: isSearching
                          ? IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
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
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTherapistList(List<Therapist> therapists, bool isTabletOrDesktop, AuthViewModel authViewModel) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: therapists.length,
      itemBuilder: (context, index) {
        final therapist = therapists[index];
        double? rate = double.tryParse(therapist.rate);
        if (rate != null) {
          print("Parsed value: $rate");
        } else {
          print("Invalid input");
        }
        final therapistCard = Card(
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(25), right: Radius.circular(25)),
          ),
          margin: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: isTabletOrDesktop ? 16 : 18,
          ),
          child: ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage('images/doctor_18467657.png'),
              radius: 24,
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
                    rate != null ? rate.round() : 0,
                        (starIndex) => const Icon(
                      Icons.star,
                      size: 14,
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

        if (authViewModel.isAdmin) {
          print(authViewModel.isAdmin);
          return Dismissible(
            key: ValueKey(therapist.id),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            secondaryBackground: Container(
              color: Colors.blue,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.edit, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                await Provider.of<TherapistViewModel>(context, listen: false).deleteTherapist(therapist.id);
                return true;
              } else {
                showDialog(
                  context: context,
                  builder: (context) => TherapistEditDialog(
                    therapist: therapist,
                    onSave: (updatedTherapist) {
                      Provider.of<TherapistViewModel>(context, listen: false).updateTherapist(updatedTherapist);
                    },
                  ),
                );
                return false;
              }
            },
            child: therapistCard,
          );
        }
        return therapistCard;
      },
    );
  }
}

class TherapistEditDialog extends StatefulWidget {
  final Therapist therapist;
  final Function(Therapist) onSave;

  const TherapistEditDialog({super.key, required this.therapist, required this.onSave});

  @override
  _TherapistEditDialogState createState() => _TherapistEditDialogState();
}

class _TherapistEditDialogState extends State<TherapistEditDialog> {
  late TextEditingController nameController;
  late TextEditingController locationController;
  late TextEditingController rateController;
  late TextEditingController genderController;
  late TextEditingController phoneController;
  late TextEditingController availableSlotsController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.therapist.name);
    locationController = TextEditingController(text: widget.therapist.location);
    rateController = TextEditingController(text: widget.therapist.rate);
    genderController = TextEditingController(text: widget.therapist.gender);
    phoneController = TextEditingController(text: widget.therapist.phonenumber);
    availableSlotsController =TextEditingController(text: widget.therapist.availableSlots);
  }

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    rateController.dispose();
    genderController.dispose();
    phoneController.dispose();
    availableSlotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Therapist'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: locationController, decoration: const InputDecoration(labelText: 'Location')),
            TextField(controller: rateController, decoration: const InputDecoration(labelText: 'Rate')),
            TextField(controller: genderController, decoration: const InputDecoration(labelText: 'Gender')),
            TextField(controller: phoneController, decoration: const InputDecoration(labelText: 'Phone Number')),
            TextField(controller: availableSlotsController, decoration: const InputDecoration(labelText: 'Available Slots')),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () async {
            final updated = widget.therapist.copyWith(
              name: nameController.text,
              location: locationController.text,
              rate: rateController.text,
              gender: genderController.text,
              phoneNumber: phoneController.text,
              availableSlots: availableSlotsController.text,
            );
            try {
              await widget.onSave(updated);
              if (context.mounted) Navigator.pop(context);
            } catch (e) {
              debugPrint('Failed to save therapist: $e');
            }
          },
          child: const Text('Save'),
        ),

      ],
    );
  }
}