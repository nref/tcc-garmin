using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

(:glance)
class TccGlanceView extends Ui.GlanceView {

    private var _client as TccClient;
    private var _text as String;

    function initialize() {
        GlanceView.initialize();

        _text = "Loading...";

        var hub = new EventHub();
        hub.SubscribeGetSetpointSuccessCallback(method(:HandleGotSetpoint));
        hub.SubscribeGetSetpointErrorCallback(method(:HandleGetSetpointError));

        _client = new TccClient(hub, new ApiKeyRepo());
        _client.GetSetpoint();
    }
    
    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.drawText(
            20,
            20,
            Graphics.FONT_LARGE,
            _text,
            Graphics.TEXT_JUSTIFY_LEFT
        );
    }

    public function HandleGotSetpoint(setpoint as Number) {
        _text = setpoint.toString();
        Ui.requestUpdate();
    }

    public function HandleGetSetpointError(error as String) {
        _text = error;
        Ui.requestUpdate();
    }
}