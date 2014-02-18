/*
 Macros d'Ali
 cf.
 http://forum.cocoacafe.fr/topic/9378-vos-macros-les-plus-utiles/?hl=%2Bwarning+%2Btodo
 */
#define GENERATE_PRAGMA(x) _Pragma(#x)
#define TODO(x) GENERATE_PRAGMA(message("[TODO] " #x))
#define FIXME(x) GENERATE_PRAGMA(message("[FIXME] " #x))
#define NOTE(x) GENERATE_PRAGMA(message("[NOTE] " #x))
#define MAGIC_NUMBER FIXME(Replace magic number with constant)



// méthode de Yoann
//
// the '__unused' instruction removes a "false" warning, telling me that ALERT_BOX is undefined
__unused static void ALERT_BOX(NSString *title, NSString* message) {
#if TARGET_OS_IPHONE
    [[[UIAlertView alloc] initWithTitle:title
                                message:message
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
#else
    [[NSAlert alertWithMessageText:title
                     defaultButton:@"OK"
                   alternateButton:nil
                       otherButton:nil
         informativeTextWithFormat:@"%@", message]
     runModal];
#endif
}

#define NOT_IMPLEMENTED(warningMessage...) ALERT_BOX(@"Not implemented", [NSString stringWithFormat:@"%s",__PRETTY_FUNCTION__]); \
TODO(Implement this - warningMessage)



/*
 Pour printer un BOOLéen
 */
static inline const NSString * BOOL_STR(BOOL v) { return (v ? @"YES" : @"NO"); }
static inline CGFloat width(NSView *view) { return view.frame.size.width; }
static inline CGFloat height(NSView *view) { return view.frame.size.width; }




