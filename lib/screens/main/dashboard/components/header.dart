import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondayColor, // Set the background color of the header
      padding: EdgeInsets.symmetric(
        vertical: defaultPadding / 2, // Adjust top and bottom padding
        horizontal: defaultPadding / 2, // Adjust left and right padding
      ),
      child: Row(
        children: [
          Text(
            "DashBoard",
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: bgColor),
          ),
          Spacer(
            flex: 2,
          ),
          Expanded(
            child: SearchField(),
          ),
          ProfileCard(),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      decoration: BoxDecoration(
          color: secondayColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10)),
      child: Row(
        children: [
          Icon(
            Icons.account_circle,
            size: 38,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            child: Text("John Doe"),
          ),
          Icon(Icons.keyboard_arrow_down, color: Colors.white),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: const Color.fromARGB(150, 255, 255, 255),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            // Add your search action here
          },
          icon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
