// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:riaaya_app/features/profile/presentation/view/pages/nurse/presentation/view_model/requests_cubit.dart';
// import 'package:riaaya_app/features/profile/presentation/view/pages/nurse/presentation/view_model/requests_state.dart';
// import 'package:riaaya_app/features/request_status/data/model/request_model.dart';

// import 'screen_nurse_requests_details.dart';

// class NurseRequestsScreen extends StatelessWidget {
//   const NurseRequestsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => RequestsCubit()..fetchPendingRequests(),
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF6F6F6),
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           centerTitle: true,
//           title: const Text(
//             "Available Requests",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
//           ),
//           actions: [
//             IconButton(
//               onPressed: () {
//                 context.read<RequestsCubit>().fetchPendingRequests();
//               },
//               icon: const Icon(Icons.refresh, color: Colors.black),
//             ),
//           ],
//         ),
//         body: BlocBuilder<RequestsCubit, RequestsState>(
//           builder: (context, state) {
//             if (state is RequestsLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state is RequestsFailure) {
//               return Center(
//                 child: Text(
//                   "Error: ${state.message}",
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               );
//             }

//             if (state is RequestsEmpty) {
//               return const Center(
//                 child: Text(
//                   "No pending requests",
//                   style: TextStyle(fontWeight: FontWeight.w600),
//                 ),
//               );
//             }

//             if (state is RequestsSuccess) {
//               return ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: state.requests.length,
//                 itemBuilder: (context, index) {
//                   final req = state.requests[index];
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 14),
//                     child: RequestCard(request: req),
//                   );
//                 },
//               );
//             }

//             return const SizedBox(); // initial
//           },
//         ),
//       ),
//     );
//   }
// }

// class RequestCard extends StatelessWidget {
//   const RequestCard({super.key, required this.request});

//   final RequestModel request;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (_) => NurseRequestDetailsScreen(request: request),
//           ),
//         );
//       },
//       child: Container(
//         padding: const EdgeInsets.all(18),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 12,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: const [
//                 CircleAvatar(
//                   radius: 22,
//                   backgroundColor: Color(0xFFE8F0FF),
//                   child: Icon(
//                     Icons.medical_services_outlined,
//                     color: Color(0xFF2F6BFF),
//                     size: 26,
//                   ),
//                 ),
//                 SizedBox(width: 12),
//               ],
//             ),

//             const SizedBox(height: 14),
//             Text(
//               request.title,
//               style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               request.description,
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.black54,
//                 height: 1.4,
//               ),
//             ),
//             const SizedBox(height: 10),

//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFE8F0FF),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text(
//                 request.date,
//                 style: const TextStyle(
//                   color: Color(0xFF2F6BFF),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
