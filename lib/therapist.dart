import 'package:flutter/material.dart';
import 'doctor_profile.dart';

class TherapistListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120), // Adjusted height - can tweak
        child: AppBar(
          backgroundColor: Color(0xff1BCCD9),
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20), // Space between button and search bar
                  // Wrapped in Expanded to avoid overflow
                  Expanded(
                    child: Center(
                      child: searchBar(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: ListView(
        padding: EdgeInsets.only(top: 10),
        children: [
          therapistContainer(
            image: "images/Ellipse 6.png",
            name: 'Dr Sima Alpha',
            time: '30 min',
            rating: 5,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DoctorProfilePage()),
              );
            },
          ),
          therapistContainer(
            image: "images/Ellipse 7.png",
            name: 'Dr Samy Ahmed',
            time: '30 min',
            rating: 4,
          ),
          therapistContainer(
            image: "images/Ellipse 8.png",
            name: 'Dr Emilly',
            time: '45 min',
            rating: 5,
          ),
          therapistContainer(
            image: "images/Ellipse 9.png",
            name: 'Dr Ama',
            time: '60 min',
            rating: 3,
          ),
          therapistContainer(
            image: "images/Ellipse 10.png",
            name: 'Dr Amira',
            time: '60 min',
            rating: 3,
          ),
        ],
      ),

      backgroundColor: Colors.white,
    );
  }

  Widget searchBar(context ) {
    return Container(
      margin:EdgeInsets.only(top:14),
      padding:  EdgeInsets.symmetric(vertical: 17,horizontal: 1),
      child: TextField(
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: TherapistSearchDelegate(),
              );
            },
          ),
          hintText: '        Search a Therapist',
          hintStyle: TextStyle(
            fontSize: 13),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget therapistContainer({
    required String image,
    required String name,
    required String time,
    required int rating,
     final VoidCallback? onTap,
  }) {
    return
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(image),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.access_time_filled, size: 16,color: Colors.black,),
                          SizedBox(width: 4),
                          Text(time),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: List.generate(
                          5,
                              (index) => Icon(Icons.star_rounded, color: Colors.yellow, size: 17),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: onTap,
                    child: const Icon(Icons.arrow_right, color: Colors.black, size: 18),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),
            Container(
              height: 1,
              color: Colors.black,
            ),
          ],
        ),
      );

  }
}

class TherapistSearchDelegate extends SearchDelegate {
  final List<Map<String, dynamic>> therapists = [
    {
      'name': 'Dr Sima Alpha',
      'time': '30 min',
      'rating': 5,
      'image': 'images/Ellipse 6.png'
    },
    {
      'name': 'Dr Samy Ahmed',
      'time': '30 min',
      'rating': 4,
      'image': 'images/Ellipse 7.png'
    },
    {
      'name': 'Dr Emilly',
      'time': '45 min',
      'rating': 5,
      'image': 'images/Ellipse 8.png'
    },
    {
      'name': 'Dr Ama',
      'time': '60 min',
      'rating': 3,
      'image': 'images/Ellipse 9.png'
    },
    {
      'name': 'Dr amira Alpha',
      'time': '30 min',
      'rating': 1,
      'image': 'images/Ellipse 10.png'
    },
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Map<String, dynamic>> results = therapists
        .where((therapist) =>
        therapist['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: results
            .map((therapist) => TherapistResultContainer(therapist: therapist))
            .toList(),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Map<String, dynamic>> suggestions = therapists
        .where((therapist) =>
        therapist['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: suggestions.map((therapist) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(therapist['image']),
            ),
            title: Text(therapist['name']),
            onTap: () {
              query = therapist['name'];
              showResults(context);
            },
          );
        }).toList(),
      ),
    );
  }
}
class TherapistResultContainer extends StatelessWidget {
  final Map<String, dynamic> therapist;

  const TherapistResultContainer({Key? key, required this.therapist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(therapist['image']),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  therapist['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16),
                    SizedBox(width: 4),
                    Text(therapist['time']),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: List.generate(
                    therapist['rating'],
                        (index) => Icon(
                      Icons.star_rounded,
                      color: Colors.yellow,
                      size: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),

          InkWell(
            onTap: () {
              if (therapist['name'] == 'Dr Sima Alpha') {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => DoctorProfilePage()),
                );
              } else {
                // Optional: Show a message or do nothing
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No profile available for now to ${therapist['name']}')),
                );
                // Or just do nothing
                // print('${therapist['name']} tapped, but no action.');
              }
            },
            child: Icon(
              Icons.arrow_right,
              color: Colors.black,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
