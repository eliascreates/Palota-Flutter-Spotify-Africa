part of 'playlist_featured_content.dart';

class FeaturedHeader extends StatelessWidget {
  const FeaturedHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 342,
          padding: const EdgeInsets.symmetric(vertical: 12).copyWith(left: 16),
          decoration: BoxDecoration(
              color: const Color(0xFF211F26),
              borderRadius: const BorderRadiusDirectional.horizontal(
                end: Radius.circular(12),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    offset: const Offset(0, 4),
                    blurRadius: 4)
              ]),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}