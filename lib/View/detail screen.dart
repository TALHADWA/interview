import 'package:flutter/material.dart';
import 'package:interview/Model/model.dart';

class DetailsScreen extends StatelessWidget {
 Data? data; // URL to the flag image

   DetailsScreen({
    Key? key,
   this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data?.name.toString()??""),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
               data!.flag,
                height: 150,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              'Country Name:',
       
            ),
            Text(
              data!.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Population:',
           //   style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              data!.population.toString(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Region:',
           
            ),
            Text(
             data!. region,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
