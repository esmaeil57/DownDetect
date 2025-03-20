import 'package:down_detect/constants.dart';
import 'package:flutter/material.dart';
import 'package:down_detect/therapist.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Early detection.dart';
class HomeScreen extends StatelessWidget {
  static const routeName='details';

  const HomeScreen({super.key});
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
          Image.asset(image),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 5),
                 Text(
                  description,
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
  const ExpandableTextWidget({super.key});

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
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
          Constants.shortText,
          style: const TextStyle(fontSize: 16),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {
              _showFullTextOverlay(context);
            },
            child: const Text(
              "Show more",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showFullTextOverlay(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9), // Semi-transparent background
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xff0E6C73),
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6, // Limit height to avoid overflow
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "What is Down Syndrome?",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                      ),
                    )
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        Constants.fullText,
                         style: GoogleFonts.lato(
                           textStyle: TextStyle(fontSize: 13, color: Colors.white),
                         )
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}