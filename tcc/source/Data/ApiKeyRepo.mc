import Toybox.Application.Storage;

// ApiKeyRepo is instantiated in the TccClient constructor.
// Every class that is instantiated when a glance runs needs a glance annotation.
// https://forums.garmin.com/developer/connect-iq/f/discussion/228440/glancemode-causing-error-illegal-access-out-of-bounds
(:glance)
class ApiKeyRepo {

    function initialize() {
        Set("none");
    }

    function Get() as String {
        return Storage.getValue("apikey");
    }

    function Set(value as String) {
        Storage.setValue("apikey", value);
    }
}