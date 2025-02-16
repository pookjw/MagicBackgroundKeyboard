#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <substrate.h>

namespace mbk_UIKBRenderConfig {
    namespace animatedBackground {
        BOOL (*original)(id self, SEL _cmd);
        BOOL custom(id self, SEL _cmd) {
            return YES;
        }
        void hook(void) {
            MSHookMessageEx(
                objc_lookUpClass("UIKBRenderConfig"),
                sel_registerName("animatedBackground"),
                reinterpret_cast<IMP>(&custom),
                reinterpret_cast<IMP *>(&original)
            );
        }
    }

    namespace setAnimatedBackground_ {
        void (*original)(id self, SEL _cmd, BOOL newValue);
        void custom(id self, SEL _cmd, BOOL newValue) {
            original(self, _cmd, YES);
        }
        void hook(void) {
            MSHookMessageEx(
                objc_lookUpClass("UIKBRenderConfig"),
                sel_registerName("setAnimatedBackground:"),
                reinterpret_cast<IMP>(&custom),
                reinterpret_cast<IMP *>(&original)
            );
        }
    }
}

__attribute__((constructor)) static void init() {
    NSAutoreleasePool *pool = [NSAutoreleasePool new];

    mbk_UIKBRenderConfig::animatedBackground::hook();
    mbk_UIKBRenderConfig::setAnimatedBackground_::hook();

    [pool release];
}
