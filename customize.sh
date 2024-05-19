VERSION=$(grep_prop version "${MODPATH}/module.prop")
ui_print "- Installing J7 Pro Stock Cam Mods $VERSION"

if [ "$API" -lt 28 ]; then
  ui_print "! Unsupported sdk: $API"
  abort "! Minimal supported sdk is 28 (Android 9/ One UI 1)"
else
  ui_print "- Device sdk is valid: $API"
fi

ui_print "- Extracting..."

ui_print "- Remounting /system as read-write..."
mount -o rw,remount /system

ui_print "- Backing up the original camera-feature.xml..."
cp -f "/system/cameradata/camera-feature.xml" "/system/cameradata/original.bak"

ui_print "- Replacing camera-feature.xml file..."
cp -f "${MODPATH}/system/cameradata/camera-feature.xml" "/system/cameradata/camera-feature.xml"
chmod 644 "/system/cameradata/camera-feature.xml"
chown root:root "/system/cameradata/camera-feature.xml"

ui_print "- Remounting /system as read-only..."
mount -o ro,remount /system

ui_print "- Forcing camera stop..."
am force-stop com.sec.android.app.camera

ui_print "- Clearing camera data..."
pm clear com.sec.android.app.camera

ui_print "Done. Reboot is required."
ui_print "Enjoy your new camera features!"