import Toybox.WatchUi;

//! Responds to a temp picker selection or cancellation
class TempPickerDelegate extends WatchUi.PickerDelegate {

    private var _callback as Method;

    //! Constructor
    public function initialize(callback as Method) {
        _callback = callback;
        PickerDelegate.initialize();
    }

    //! Handle a cancel event from the picker
    //! @return true if handled, false otherwise
    public function onCancel() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    //! Handle a confirm event from the picker
    //! @param values The values chosen in the picker
    //! @return true if handled, false otherwise
    public function onAccept(values as Array<Number?>) as Boolean {
        var setpoint = values[0];
        _callback.invoke(setpoint);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}