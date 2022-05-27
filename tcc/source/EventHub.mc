import Toybox.Lang;

// EventHub is instantiated in the TccGlanceView constructor.
// Every class that is instantiated when a glance runs needs a glance annotation.
// https://forums.garmin.com/developer/connect-iq/f/discussion/228440/glancemode-causing-error-illegal-access-out-of-bounds
(:glance)
class EventHub {

    private var _setCompleteCallbacks as Array<Method>;
    private var _getCompleteCallbacks as Array<Method>;
    private var _setErrorCallbacks as Array<Method>;
    private var _getErrorCallbacks as Array<Method>;

    public function initialize() {
        _setCompleteCallbacks = new Array<Method>[0];
        _getCompleteCallbacks = new Array<Method>[0];
        _setErrorCallbacks = new Array<Method>[0];
        _getErrorCallbacks = new Array<Method>[0];
    }

    public function SubscribeSetSetpointSuccessCallback(callback as Method) as Void {
        _setCompleteCallbacks.add(callback);
    }

    public function SubscribeGetSetpointSuccessCallback(callback as Method) as Void {
        _getCompleteCallbacks.add(callback);
    }

    public function SubscribeSetSetpointErrorCallback(callback as Method) as Void {
        _setErrorCallbacks.add(callback);
    }

    public function SubscribeGetSetpointErrorCallback(callback as Method) as Void {
        _getErrorCallbacks.add(callback);
    }

    public function NotifySetSetpointComplete() as Void {
        System.println("EventHub.NotifySetSetpointComplete()");

        for (var i = 0; i < _setCompleteCallbacks.size(); i += 1) {
            _setCompleteCallbacks[i].invoke();
        }
    }

    public function NotifyGetSetpointComplete(setpoint as Number) as Void {
        System.println("EventHub.NotifyGetSetpointComplete(" + setpoint + ")");

        for (var i = 0; i < _getCompleteCallbacks.size(); i += 1) {
            _getCompleteCallbacks[i].invoke(setpoint);
        }
    }

    public function NotifySetSetpointError(error as String) as Void {
        System.println("EventHub.NotifySetSetpointError(" + error + ")");

        for (var i = 0; i < _setErrorCallbacks.size(); i += 1) {
            _setErrorCallbacks[i].invoke(error);
        }
    }

    public function NotifyGetSetpointError(error as String) as Void {
        System.println("EventHub.NotifyGetSetpointError(" + error + ")");

        for (var i = 0; i < _getErrorCallbacks.size(); i += 1) {
            _getErrorCallbacks[i].invoke(error);
        }
    }
}