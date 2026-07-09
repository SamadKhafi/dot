--------------------
---- LAYERRULES ----
--------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.layer_rule { blur = true, ignore_alpha = 1, match = { namespace = 'rofi' } }
hl.layer_rule { blur = true, match = { namespace = 'logout_dialog' } }

hl.layer_rule { no_anim = true, match = { namespace = '^(dms)$' } }

hl.layer_rule { blur = true, match = { namespace = 'dms:bar' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:dock' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:clipboard' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:dock-context-menu' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:notification-center-modal' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:polkit' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:spotlight' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:slideout' } }
--
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:app-launcher' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:battery' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:clipboard-popout' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:notepad-popout' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:control-center' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:dash' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:notification-center-popout' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:notification-popup' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:popout' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:process-list-popout' } }
hl.layer_rule { blur = true, ignore_alpha = 0.3, match = { namespace = 'dms:osd' } }
hl.layer_rule { blur = true, ignore_alpha = 1, match = { namespace = 'dms:toast' } }
hl.layer_rule { blur = true, ignore_alpha = 0, match = { namespace = 'dms:vpn' } }
hl.layer_rule { blur = true, ignore_alpha = 0, match = { namespace = 'dms:tray-menu-window' } }
hl.layer_rule { blur = true, ignore_alpha = 0, match = { namespace = 'dms:plugins:.*' } }

hl.layer_rule { blur = true, ignore_alpha = 0, match = { namespace = 'dms:desktop-widget:desktopClock:.*' } }
