import 'package:flutter/material.dart';
import 'package:location_service/services/location_service.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LocationService>(builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value.latitude.toString(),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                value.longitude.toString(),
              ),
              const SizedBox(
                height: 10,
              ),
              OutlinedButton(
                onPressed: () async {
                  await value.getLocation();
                },
                child: const Text('Current Location'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
