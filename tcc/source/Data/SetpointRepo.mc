import Toybox.Application.Storage;

class SetpointRepo {

    function initialize() {
        if (GetSetpoint() == null) {
           SetSetpoint(74);
        }
    }

    function GetSetpoint() as Number {
        return Storage.getValue("setpoint");
    }

    function SetSetpoint(setpoint as Number) {
        Storage.setValue("setpoint", setpoint);
    }
}