import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:helping_nexus/api/matches_service.dart';

final currentChatIdProvider = StateProvider<String?>((ref) => null);
final currentChatNameProvider = StateProvider<String?>((ref) => null);

class MatchesScreen extends ConsumerStatefulWidget {
  const MatchesScreen({super.key});

  @override
  ConsumerState<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends ConsumerState<MatchesScreen> {
  final MatchesService _matchesService = MatchesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/screens_background_grey.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.only(
              top: 5.0, right: 10.0, left: 10.0, bottom: 10.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: _buildMessages(),
            ),
          ),
        ),
      ),
    );
  }

  // user id 65ed8fd2fed34ccf99555e40
  // wisher id 65ed9009fed34ccf99555e41
  // wish id 65ed9027fed34ccf99555e42
  Widget _buildMessages() {
    return FutureBuilder(
      future: _matchesService.getMatches(userId: '65ed8fd2fed34ccf99555e40'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              String? lastMessage = snapshot.data?[index]['lastMessage']?['message'];

              return Card(
                child: ListTile(
                  title: Text(snapshot.data?[index]['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
                  subtitle: Text(lastMessage ?? 'Say hello to your new volunteering!'),
                  onTap: () {
                    ref.read(currentChatIdProvider.notifier).state = snapshot.data?[index]['_id'];
                    ref.read(currentChatNameProvider.notifier).state = snapshot.data?[index]['title'];
                    context.goNamed('chat');
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
