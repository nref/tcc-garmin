import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

//! Picker that allows the user to choose a temperature
class TempPicker extends WatchUi.Picker {

    private var _repo as SetpointRepo;

    //! Constructor
    public function initialize() {

        _repo = new SetpointRepo();
        var setpoint = _repo.GetSetpoint();

        var title = new WatchUi.Text
        ({
            :text=>"Temperature", 
            :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
            :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, 
            :color=>Graphics.COLOR_WHITE
        });

        var factories = new Array<PickerFactory or Text>[1];
        factories[0] = new $.NumberFactory(65, 85, 1);

        var defaults = new Array<Number>[factories.size()];
        defaults[0] = factories[0].getIndex(setpoint);

        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
    }

    //! Update the view
    //! @param dc Device Context
    public function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}
