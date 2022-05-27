import Toybox.Application.Storage;

class SetpointRepo {

    function initialize() {
        if (Storage.getValue("setpoint") == null) {
           SetSetpoint(74);
        }
    }

    function GetSetpoint() as Number {
        var setpoint = Storage.getValue("setpoint");
        return setpoint;
    }

    function SetSetpoint(setpoint as Number) {
        Storage.setValue("setpoint", setpoint);
    }
}