// ignore_for_file: avoid_print

import 'package:cubbes/Service/countryApi.dart';
import 'package:flutter/material.dart';

class CountryUI extends StatefulWidget {
  const CountryUI({super.key});

  @override
  State<CountryUI> createState() => _CountryUIState();
}

class _CountryUIState extends State<CountryUI> {
  //Initializing an object for the api service class
  final Countryapi countryApi = Countryapi();
  String? selectedFlag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Country UI'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: countryApi.fetchCountries(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                     print(snapshot.error); // Logs the error in the console
                    return Center(child: Text('Error: ${snapshot.error}'));
}
 else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Countries Found'));
                } else {
                  final countries = snapshot.data!;
                  return ListView.builder(
                    itemCount: countries.length,  // Added itemCount
                    itemBuilder: (context, index) {
                      final country = countries[index];
                      return ListTile(
                        leading: Image.network(
                          country.flag,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(country.name),
                        subtitle: Text('Population: ${country.population}'),
                        onTap: () {
                          setState(() {
                            selectedFlag = country.flag;
                          });
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          //Flag display section
          Container(
            height: 150,
            color: Colors.grey,
            child: selectedFlag != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Selected Country Flag',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Image.network(
                        selectedFlag!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  )
                : const Center(
                    child: Text(
                      'Tap on a country to view its flag',  // Fixed apostrophe
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}