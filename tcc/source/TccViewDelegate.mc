//! Input handler for the main view
import Toybox.WatchUi;

class TccViewDelegate extends WatchUi.BehaviorDelegate {

    private var _client as TccClient;
    private var _repo as SetpointRepo;

    //! Constructor
    public function initialize() {
        _client = new TccClient(null, null);
        _repo = new SetpointRepo();

        BehaviorDelegate.initialize();
    }

    //! Handle the select behavior
    //! @return true if handled, false otherwise
    public function onSelect() as Boolean {
        return pushPicker();
    }

    //! Push a new picker view
    //! @return true if handled, false otherwise
    public function pushPicker() as Boolean {
        WatchUi.pushView(new $.TempPicker(), new $.TempPickerDelegate(method(:HandleSetpointChanged)), WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

    public function HandleSetpointChanged(setpoint as Number) {
        _repo.SetSetpoint(setpoint);
        _client.SetSetpoint(setpoint);
    }
}