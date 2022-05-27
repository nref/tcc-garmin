import Toybox.Communications;

// TccClient is instantiated in the TccGlanceView constructor.
// Every class that is instantiated when a glance runs needs a glance annotation.
// https://forums.garmin.com/developer/connect-iq/f/discussion/228440/glancemode-causing-error-illegal-access-out-of-bounds
(:glance)
class TccClient {

    private var _url = "https://tcc.sltr.us/setpoint";
    private var _hub as EventHub;

    public function initialize(hub as EventHub) {
        _hub = hub;

        if (_hub == null) {
            _hub = new EventHub();
        }
    }

    public function GetSetpoint() as Void {

        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_GET,
            :headers => {
                "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED,
            },
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
        };

        Communications.makeWebRequest(_url, null, options, method(:HandleGetSetpointComplete));
    }

    public function SetSetpoint(setpoint as Number) as Void {

        var params = {
            "setpoint" => setpoint,
        };

        var options = {
            :method => Communications.HTTP_REQUEST_METHOD_POST,
            :headers => {
                "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED,
            },
            :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON,
        };

        Communications.makeWebRequest(_url, params, options, method(:HandleSetSetpointComplete));
    }

    public function HandleGetSetpointComplete(responseCode as Number, data as Dictionary?) as Void {
        System.println("TccClient.HandleGetSetpointComplete(" + responseCode + ", " + data + ")");

        if (responseCode == 200) {
            if (!data.hasKey("setpoint")) {
                System.println("TccClient.HandleGetSetpointComplete(): Received 200 but no setpoint.");
                _hub.NotifyGetSetpointError("---");
                return;
            }

            var setpoint = data["setpoint"];
            _hub.NotifyGetSetpointComplete(setpoint);
        } else {
            _hub.NotifyGetSetpointError("Error " + responseCode);
        }
    }

    public function HandleSetSetpointComplete(responseCode as Number, data as Dictionary?) as Void {
        System.println("TccClient.HandleSetSetpointComplete(" + responseCode + ", " + data + ")");

        if (responseCode == 200) {
            _hub.NotifySetSetpointComplete();
        } else {
            _hub.NotifySetSetpointError("Error " + responseCode);
        }
    }
}