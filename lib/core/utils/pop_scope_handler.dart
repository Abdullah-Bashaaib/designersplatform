// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'custom_dialog_getx.dart';

// /// نوع إجراء الرجوع
// enum PopAction {
//   /// السماح بالرجوع العادي
//   allow,
//   /// منع الرجوع
//   prevent,
//   /// عرض حوار تأكيد
//   confirm,
//   /// حفظ البيانات قبل الرجوع
//   saveAndPop,
//   /// إجراء مخصص
//   custom,
// }

// /// فئة معالج PopScope المخصص لمنصة المصممين
// class CustomPopScope extends StatefulWidget {
//   final Widget child;
//   final PopAction popAction;
//   final String? confirmTitle;
//   final String? confirmMessage;
//   final String? confirmButtonText;
//   final String? cancelButtonText;
//   final Future<bool> Function()? onWillPop;
//   final VoidCallback? onPopConfirmed;
//   final VoidCallback? onPopCancelled;
//   final Future<void> Function()? onSaveBeforePop;
//   final bool showExitDialog;
//   final Duration? exitDialogDelay;

//   const CustomPopScope({
//     Key? key,
//     required this.child,
//     this.popAction = PopAction.allow,
//     this.confirmTitle,
//     this.confirmMessage,
//     this.confirmButtonText,
//     this.cancelButtonText,
//     this.onWillPop,
//     this.onPopConfirmed,
//     this.onPopCancelled,
//     this.onSaveBeforePop,
//     this.showExitDialog = false,
//     this.exitDialogDelay,
//   }) : super(key: key);

//   @override
//   State<CustomPopScope> createState() => _CustomPopScopeState();
// }

// class _CustomPopScopeState extends State<CustomPopScope> {
//   DateTime? _lastBackPressed;
//   bool _isProcessing = false;

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: widget.popAction == PopAction.allow,
//       onPopInvoked: (didPop) async {
//         if (didPop) return;
        
//         await _handlePopAttempt();
//       },
//       child: widget.child,
//     );
//   }

//   Future<void> _handlePopAttempt() async {
//     if (_isProcessing) return;
    
//     setState(() {
//       _isProcessing = true;
//     });

//     try {
//       switch (widget.popAction) {
//         case PopAction.allow:
//           _performPop();
//           break;
          
//         case PopAction.prevent:
//           // لا تفعل شيئاً - منع الرجوع
//           break;
          
//         case PopAction.confirm:
//           await _handleConfirmPop();
//           break;
          
//         case PopAction.saveAndPop:
//           await _handleSaveAndPop();
//           break;
          
//         case PopAction.custom:
//           await _handleCustomPop();
//           break;
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isProcessing = false;
//         });
//       }
//     }
//   }

//   Future<void> _handleConfirmPop() async {
//     final shouldPop = await DialogHelper.showConfirmationDialog(
//       context,
//       title: widget.confirmTitle ?? 'تأكيد الخروج',
//       message: widget.confirmMessage ?? 'هل أنت متأكد من أنك تريد المغادرة؟',
//       confirmText: widget.confirmButtonText ?? 'نعم، اخرج',
//       cancelText: widget.cancelButtonText ?? 'إلغاء',
//     );

//     if (shouldPop == true) {
//       widget.onPopConfirmed?.call();
//       _performPop();
//     } else {
//       widget.onPopCancelled?.call();
//     }
//   }

//   Future<void> _handleSaveAndPop() async {
//     if (widget.onSaveBeforePop != null) {
//       // عرض حوار التحميل أثناء الحفظ
//       LoadingDialog.show(context, message: 'جاري حفظ البيانات...');
      
//       try {
//         await widget.onSaveBeforePop!();
//         LoadingDialog.hide(context);
//         _performPop();
//       } catch (e) {
//         LoadingDialog.hide(context);
//         await DialogHelper.showErrorDialog(
//           context,
//           title: 'خطأ في الحفظ',
//           message: 'حدث خطأ أثناء حفظ البيانات. هل تريد المحاولة مرة أخرى؟',
//         );
//       }
//     } else {
//       _performPop();
//     }
//   }

//   Future<void> _handleCustomPop() async {
//     if (widget.onWillPop != null) {
//       final shouldPop = await widget.onWillPop!();
//       if (shouldPop) {
//         _performPop();
//       }
//     }
//   }

//   void _performPop() {
//     if (mounted) {
//       Navigator.of(context).pop();
//     }
//   }
// }

// /// فئة معالج الخروج من التطبيق
// class AppExitHandler extends StatefulWidget {
//   final Widget child;
//   final String exitMessage;
//   final Duration doubleTapDuration;
//   final bool showSnackBar;
//   final String snackBarMessage;

//   const AppExitHandler({
//     Key? key,
//     required this.child,
//     this.exitMessage = 'اضغط مرة أخرى للخروج من التطبيق',
//     this.doubleTapDuration = const Duration(seconds: 2),
//     this.showSnackBar = true,
//     this.snackBarMessage = 'اضغط مرة أخرى للخروج',
//   }) : super(key: key);

//   @override
//   State<AppExitHandler> createState() => _AppExitHandlerState();
// }

// class _AppExitHandlerState extends State<AppExitHandler> {
//   DateTime? _lastBackPressed;

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (didPop) async {
//         if (didPop) return;
        
//         await _handleAppExit();
//       },
//       child: widget.child,
//     );
//   }

//   Future<void> _handleAppExit() async {
//     final now = DateTime.now();
    
//     if (_lastBackPressed == null || 
//         now.difference(_lastBackPressed!) > widget.doubleTapDuration) {
//       _lastBackPressed = now;
      
//       if (widget.showSnackBar) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(widget.snackBarMessage),
//             duration: widget.doubleTapDuration,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         );
//       }
//       return;
//     }
    
//     // الخروج من التطبيق
//     SystemNavigator.pop();
//   }
// }

// /// فئة معالج التنقل المتقدم
// class NavigationHandler {
//   /// التنقل مع حفظ البيانات
//   static Future<void> navigateWithSave(
//     BuildContext context, {
//     required Widget destination,
//     Future<void> Function()? onSave,
//     String? saveMessage,
//   }) async {
//     if (onSave != null) {
//       LoadingDialog.show(
//         context, 
//         message: saveMessage ?? 'جاري حفظ البيانات...',
//       );
      
//       try {
//         await onSave();
//         LoadingDialog.hide(context);
        
//         if (context.mounted) {
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => destination),
//           );
//         }
//       } catch (e) {
//         LoadingDialog.hide(context);
//         await DialogHelper.showErrorDialog(
//           context,
//           title: 'خطأ في الحفظ',
//           message: 'حدث خطأ أثناء حفظ البيانات',
//         );
//       }
//     } else {
//       Navigator.of(context).push(
//         MaterialPageRoute(builder: (context) => destination),
//       );
//     }
//   }

//   /// التنقل مع تأكيد
//   static Future<void> navigateWithConfirmation(
//     BuildContext context, {
//     required Widget destination,
//     String? title,
//     String? message,
//     String? confirmText,
//     String? cancelText,
//   }) async {
//     final shouldNavigate = await DialogHelper.showConfirmationDialog(
//       context,
//       title: title ?? 'تأكيد التنقل',
//       message: message ?? 'هل تريد الانتقال إلى الصفحة التالية؟',
//       confirmText: confirmText ?? 'نعم',
//       cancelText: cancelText ?? 'إلغاء',
//     );

//     if (shouldNavigate == true && context.mounted) {
//       Navigator.of(context).push(
//         MaterialPageRoute(builder: (context) => destination),
//       );
//     }
//   }

//   /// استبدال الصفحة الحالية
//   static void replaceWith(BuildContext context, Widget destination) {
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => destination),
//     );
//   }

//   /// العودة إلى الصفحة الرئيسية
//   static void popToRoot(BuildContext context) {
//     Navigator.of(context).popUntil((route) => route.isFirst);
//   }

//   /// العودة مع نتيجة
//   static void popWithResult<T>(BuildContext context, T result) {
//     Navigator.of(context).pop(result);
//   }

//   /// التنقل مع إزالة جميع الصفحات السابقة
//   static void navigateAndClearStack(BuildContext context, Widget destination) {
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => destination),
//       (route) => false,
//     );
//   }
// }

// /// فئة معالج حالة التطبيق
// class AppStateHandler extends StatefulWidget {
//   final Widget child;
//   final VoidCallback? onAppPaused;
//   final VoidCallback? onAppResumed;
//   final VoidCallback? onAppDetached;
//   final Future<void> Function()? onAutoSave;
//   final Duration autoSaveInterval;

//   const AppStateHandler({
//     Key? key,
//     required this.child,
//     this.onAppPaused,
//     this.onAppResumed,
//     this.onAppDetached,
//     this.onAutoSave,
//     this.autoSaveInterval = const Duration(minutes: 5),
//   }) : super(key: key);

//   @override
//   State<AppStateHandler> createState() => _AppStateHandlerState();
// }

// class _AppStateHandlerState extends State<AppStateHandler> 
//     with WidgetsBindingObserver {
  
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
    
//     // بدء الحفظ التلقائي إذا كان مطلوباً
//     if (widget.onAutoSave != null) {
//       _startAutoSave();
//     }
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     switch (state) {
//       case AppLifecycleState.paused:
//         widget.onAppPaused?.call();
//         // حفظ تلقائي عند إيقاف التطبيق مؤقتاً
//         widget.onAutoSave?.call();
//         break;
//       case AppLifecycleState.resumed:
//         widget.onAppResumed?.call();
//         break;
//       case AppLifecycleState.detached:
//         widget.onAppDetached?.call();
//         break;
//       default:
//         break;
//     }
//   }

//   void _startAutoSave() {
//     // يمكن استخدام Timer.periodic للحفظ التلقائي
//     // Timer.periodic(widget.autoSaveInterval, (timer) {
//     //   widget.onAutoSave?.call();
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }

// /// مثال على الاستخدام
// class ExampleUsage extends StatefulWidget {
//   @override
//   State<ExampleUsage> createState() => _ExampleUsageState();
// }

// class _ExampleUsageState extends State<ExampleUsage> {
//   bool _hasUnsavedChanges = false;

//   @override
//   Widget build(BuildContext context) {
//     return AppExitHandler(
//       child: CustomPopScope(
//         popAction: _hasUnsavedChanges ? PopAction.confirm : PopAction.allow,
//         confirmTitle: 'لديك تغييرات غير محفوظة',
//         confirmMessage: 'هل تريد المغادرة بدون حفظ التغييرات؟',
//         confirmButtonText: 'نعم، اخرج',
//         cancelButtonText: 'إلغاء',
//         onPopConfirmed: () {
//           // تنظيف البيانات إذا لزم الأمر
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             title: const Text('مثال على الاستخدام'),
//           ),
//           body: const Center(
//             child: Text('محتوى الصفحة'),
//           ),
//         ),
//       ),
//     );
//   }
// }

