import Toybox.Application;

(:glance)
class TccApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function onStart(state as Dictionary?) as Void {
    }

    function onStop(state as Dictionary?) as Void {
    }

    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new $.TccView(), new $.TccViewDelegate() ] as Array<Views or InputDelegates>;
    }

    function getGlanceView() {
        return [ new TccGlanceView() ];
    }
}

function getApp() as TccApp {
    return Application.getApp() as TccApp;
}