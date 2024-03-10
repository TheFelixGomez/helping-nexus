import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../models/location.dart';

class DashboardCard extends StatelessWidget {
  final User informationCard;

  const DashboardCard(
      this.informationCard, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/backgrounds/screens_background_grey.png'),
                  fit: BoxFit.cover,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFF3868), Color(0xFFFFB49A)],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${informationCard.firstName} ${informationCard.lastName}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  informationCard.dob,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  informationCard.location.city,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final List<User> users = [
  User(
      id: '1',
      firstName: 'Sebastian',
      lastName: 'Losada',
      email: 'sebas@mail.com',
      dob: '15-03-1998',
      location: Location(
        address: 'Calle 123',
        city: 'Bogota',
        state: 'Cundinamarca',
        zip: '11001',
        country: 'Colombia',
      )
  ),
  User(
      id: '2',
      firstName: 'Felix',
      lastName: 'Gomez',
      email: 'felix@mail.com',
      dob: '12-05-1999',
      location: Location(
        address: 'Calle 123',
        city: 'Bogota',
        state: 'Cundinamarca',
        zip: '11001',
        country: 'Colombia',
      )
  ),
  User(
      id: '3',
      firstName: 'Julian',
      lastName: 'Rique',
      email: 'Juli@mail.com',
      dob: '22-02-1998',
      location: Location(
        address: 'Calle 123',
        city: 'Bogota',
        state: 'Cundinamarca',
        zip: '11001',
        country: 'Colombia',
      )
  ),
  User(
      id: '1',
      firstName: 'Pepito',
      lastName: 'Perez',
      email: 'Pepe@mail.com',
      dob: '15-09-1998',
      location: Location(
        address: 'Calle 100',
        city: 'Bogota',
        state: 'Cundinamarca',
        zip: '110431',
        country: 'Colombia',
      )
  ),

];