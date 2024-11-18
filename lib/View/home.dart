import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview/Model/model.dart';
import 'package:interview/View/detail%20screen.dart';
import 'package:interview/riverpod/riverpod.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Consumer(
              builder: (_, ref, child) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: TextField(
                    onChanged: (value) {
                    ref.read(provider.notifier).getData(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for a country...',
                      prefixIcon: const Icon(Icons.search, color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.teal),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                      ),
                      filled: true,
                      fillColor: Colors.teal.shade50,
                    ),
                  ),
                );
              },
            ),

            // Country List
            Expanded(
              child: Consumer(
                builder: (_, ref, child) {
                  final providerData = ref.watch(provider);
                  final countries = providerData.dataa;

                  if (providerData.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (countries.isEmpty) {
                    return const Center(
                      child: Text(
                        "No countries found. Try searching for another term.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    );
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (_, index) {
                        final Data country = countries[index];
                        return CountryCard(country: country);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A card widget to display country information in the list
class CountryCard extends StatelessWidget {
  final Data country;

  const CountryCard({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 2.0,
      child: ListTile(
        subtitle: Text(country.region),
        title: Text(
          country.name,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        leading: country.flag != null
            ? Image.network(
                country.flag!,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.flag, color: Colors.teal),
        trailing: IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DetailsScreen(data: country),
              ),
            );
          },
          icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.teal),
        ),
      ),
    );
  }
}
