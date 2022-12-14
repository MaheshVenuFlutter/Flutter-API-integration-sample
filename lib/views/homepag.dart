import 'package:api_intagration/models/post_model.dart';
import 'package:api_intagration/services/remote.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? posts;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    /// put this in controller
    getData();
  }

  getData() async {
    posts = await RemoteServices().getPost();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("api Integration"),
      ),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(boxShadow: const [
                BoxShadow(
                  color: Color(0xFFe8e8e8),
                  offset: Offset(0, 5),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5, 0),
                ),
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(5, 0),
                ),
              ], borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    posts![index].title,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 25),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    posts![index].body,
                    maxLines: 2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
