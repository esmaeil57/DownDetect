import 'package:flutter/material.dart';
import 'package:down_detect/therapist.dart';
import 'Early detection.dart';
class HomeScreen extends StatelessWidget {
  static const routeName='details';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xfffffffff7),
      bottomNavigationBar: BottomNavigationBar(iconSize: 40, backgroundColor:Color(0xfff0e6c73) ,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: "Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            ExpandableTextWidget(),
            SizedBox(height: 10),
            Options(image:("images/camera-icon-1024x832-h0gkd0hw 1.png"), text:("Early detection"), description:("Upload a photo of the ultrasound picture to know the risk percentage of your baby having Down syndrome."),
              onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EarlyDetectionScreen ()));
            },),
            Options(image:("images/3890590-200 1 (1).png"), text:("Find a therapist"), description:("You can easily find trusted therapists specializing in Down syndrome. We provide a list of recommended professionals with detailed profiles, ratings, and contact information"), onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TherapistListScreen()));},),
            Options(image:("images/3047859 1.png"), text:("Supportive Community"), description:("Connect with other parents and families who share similar experiences. Our app provides a safe space to exchange advice, share stories, and offer support"), onTap: () {  },),
            Options(image:("images/videooooo 1.png"), text:("Helpful Video Library"), description:("Explore a collection of videos featuring real-life stories from other parents and individuals with Down syndrome, sharing their experiences and insights, and other educational videos"), onTap: () {},),
            SizedBox(height: 5),
          ],

        ),
      ),
    );
  }
}
class Options extends StatelessWidget{
  final String image;
  final String text;
  final String description;
  final VoidCallback? onTap;

  const Options({super.key, required this.image, required this.text, required this.description,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin:EdgeInsets.only(bottom:9),
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Soft black shadow
            blurRadius: 8, // Soft blur for 3D effect
            offset: const Offset(4, 4), // Right and down shadow
          ),
          BoxShadow(
            color: Colors.white.withOpacity(0.6), // Light highlight
            blurRadius: 8,
            offset: const Offset(-4, -4), // Top left highlight
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("$image"),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$text",
                  style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                 Text(
                  "$description",
                  style: TextStyle(fontSize: 10, color: Colors.black),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: onTap,
                    child: const Icon(
                        Icons.arrow_forward_rounded, color: Colors.black, size: 25),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableTextWidget extends StatefulWidget {
  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is Down Syndrome?",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          isExpanded
              ? "Down syndrome is a genetic condition that occurs when a child is born with an extra copy of chromosome 21, resulting in three copies instead of the usual two. This additional genetic material impacts physical and intellectual development. Children with Down syndrome may experience developmental delays and have unique physical traits such as a flatter facial profile, almond-shaped eyes, and a shorter stature.\n\nWhile each individual with Down syndrome is unique, many may face challenges such as learning disabilities, speech delays, and an increased risk of certain health conditions. However, with early intervention, medical care, and supportive environments, children with Down syndrome can lead happy, healthy, and fulfilling lives.\n\nThis app is designed to provide parents with the tools, resources, and support they need to help their child thrive. Whether you're looking for guidance on therapy options, educational strategies, or community connections, we're here to help every step of the way."
              : "Down syndrome is a genetic condition that occurs when a child is born with an extra copy of chromosome 21, resulting in three copies instead of the usual...",
          style: const TextStyle(fontSize: 16),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? "Show less" : "Show more",
              style: const TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
