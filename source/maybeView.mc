import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class maybeView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get the current time
        var clockTime = System.getClockTime();
        var timeString = getChineseTimeDescription(clockTime);
        
        var view = View.findDrawableById("TimeLabel") as Text;
        view.setText(timeString);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Convert time to Chinese description using Unicode characters
    function getChineseTimeDescription(clockTime) {
        var hour = clockTime.hour;
        var minute = clockTime.min;
        var timeStr = hour.format("%02d") + ":" + minute.format("%02d");
        
        // 使用Unicode编码显示中文
        if (hour >= 23 || hour < 1) {
            return "\u{25C6} " + timeStr + " \u{25C6}\n\u{6DF1}\u{591C}"; // 深夜
        } else if (hour < 5) {
            return "\u{263D} " + timeStr + " \u{263D}\n\u{51CC}\u{6668}"; // 凌晨
        } else if (hour < 7) {
            return "\u{263C} " + timeStr + " \u{263C}\n\u{6E05}\u{6668}"; // 清晨
        } else if (hour < 9) {
            return "\u{2662} " + timeStr + " \u{2662}\n\u{65E9}\u{4E0A}"; // 早上
        } else if (hour < 11) {
            return "\u{25B3} " + timeStr + " \u{25B3}\n\u{4E0A}\u{5348}"; // 上午
        } else if (hour < 13) {
            return "\u{25A0} " + timeStr + " \u{25A0}\n\u{4E2D}\u{5348}"; // 中午
        } else if (hour < 17) {
            return "\u{25B2} " + timeStr + " \u{25B2}\n\u{4E0B}\u{5348}"; // 下午
        } else if (hour < 19) {
            return "\u{25CE} " + timeStr + " \u{25CE}\n\u{508D}\u{665A}"; // 傍晚
        } else if (hour < 23) {
            return "\u{2605} " + timeStr + " \u{2605}\n\u{665A}\u{4E0A}"; // 晚上
        }
        
        return "??:??";
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
