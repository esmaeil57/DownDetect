import 'package:flutter/material.dart';
import '../data/models/journey.dart';
import '../data/models/school.dart';

class CommunityViewModel extends ChangeNotifier {
  final List<Journey> _journeys = [
    Journey(
      name: 'Sarah M.',
      relation: 'Mom to Ethan',
      childAge: 4,
      avatar: 'assets/images/avatar1.png',
      story: '"When we first received Ethan\'s diagnosis, we were scared. But today, I can\'t believe how much he\'s taught her and endless hugs. He teaches us about patience. He\'s here for every single day."',
    ),
    Journey(
      name: 'User251',
      relation: '',
      childAge: 0,
      avatar: 'assets/images/avatar2.png',
      story: '"Take it one day at a time."\n"The future can feel overwhelming when you first receive a diagnosis. Focus on today, enjoy the little moments, and celebrate small victories."',
    ),
    Journey(
      name: 'User384',
      relation: '',
      childAge: 0,
      avatar: 'assets/images/avatar3.png',
      story: '"Don\'t be afraid to ask for help."\n"There\'s a whole community of parents, therapists, and advocates who understand what you\'re going through. You don\'t have to do it alone."',
    ),
    Journey(
      name: 'James R.',
      relation: 'Dad to Lily',
      childAge: 7,
      avatar: 'assets/images/avatar4.png',
      story: '"Lily has changed our perspective on life. She has a way of lighting up every room she walks into. Watching her overcome challenges has made our family stronger and more compassionate."',
    ),
  ];

  final List<School> _schools = [
    School(
      name: 'Hope Academy Egypt',
      type: 'Special Education School',
      location: 'El Shorouk, Cairo',
      contact: '+20 122 293 9505',
      website: 'hopeacademyegypt.com',
      logoUrl: 'assets/images/hope_academy.png',
      description: 'Founded by parents of children with special needs, Hope Academy provides individualized education plans, therapy services, and a nurturing environment for students with diverse disabilities.',
    ),
    School(
      name: 'Continental School of Cairo (CSC)',
      type: 'Mainstream School with Inclusion Program',
      location: 'Cairo, Egypt',
      contact: '',
      website: 'continental-school.com',
      logoUrl: 'assets/images/csc.png',
      description: 'CSC is a British-style special education school for children with learning difficulties and other educational needs. It follows the British National Curriculum and offers adapted educational programs to meet individual student needs.',
    ),
    School(
      name: 'Misr Language Schools - American Division',
      type: 'Curriculum School with Special Education Services',
      location: 'Giza, Egypt',
      contact: '',
      website: 'americandivision.mls-egypt.org',
      logoUrl: 'assets/images/mls.png',
      description: 'MLS provides services to students with special educational needs included in the general education program, offering support through individualized plans and accommodations.',
    ),
    School(
      name: 'Menara Centre for Special Needs Children',
      type: 'Special Needs Education and Therapy',
      location: 'St. Michel Lutfallah Street, Zamalek, Cairo, Egypt',
      contact: '',
      website: 'www.autismconnect.com',
      logoUrl: 'assets/images/menara.png',
      description: 'Focusing on children with autism spectrum disorders, Menara provides individualized learning plans, rehabilitation services, and a supportive environment for students with diverse abilities.',
    ),
  ];

  List<Journey> get journeys => _journeys;
  List<School> get schools => _schools;
}
