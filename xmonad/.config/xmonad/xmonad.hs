-- Base
import XMonad
import System.Directory
import System.IO (hPutStrLn)
import System.Exit (exitSuccess)
import qualified XMonad.StackSet as W

    -- Actions
import XMonad.Actions.CopyWindow (kill1)
import XMonad.Actions.CycleWS (Direction1D(..), moveTo, shiftTo, WSType(..), nextScreen, prevScreen)
import XMonad.Actions.GridSelect
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.WindowGo (runOrRaise)
import XMonad.Actions.WithAll (sinkAll, killAll)
import qualified XMonad.Actions.Search as S

    -- Data
import Data.Char (isSpace, toUpper)
import Data.Maybe (fromJust)
import Data.Monoid
import Data.Maybe (isJust)
import Data.Tree
import qualified Data.Map as M

    -- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.ManageDocks (avoidStruts, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers (isFullscreen, doFullFloat)
import XMonad.Hooks.ServerMode
import XMonad.Hooks.SetWMName
import XMonad.Hooks.WorkspaceHistory

    -- Layouts
import XMonad.Layout.Accordion
import XMonad.Layout.GridVariants (Grid(Grid))
import XMonad.Layout.SimplestFloat
import XMonad.Layout.Spiral
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

    -- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.Magnifier
import XMonad.Layout.MultiToggle (mkToggle, single, EOT(EOT), (??))
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL, MIRROR, NOBORDERS))
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.ShowWName
import XMonad.Layout.Simplest
import XMonad.Layout.Spacing
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowArranger (windowArrange, WindowArrangerMsg(..))
import XMonad.Layout.WindowNavigation
import qualified XMonad.Layout.ToggleLayouts as T (toggleLayouts, ToggleLayout(Toggle))
import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))

   -- Utilities
import XMonad.Util.Dmenu
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe)
import XMonad.Util.SpawnOnce

myFont :: String
myFont = "xft:SauceCodePro Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty"    -- Sets default terminal

myBrowser :: String
myBrowser = "qutebrowser "  -- Sets qutebrowser as browser

myFileManager :: String
myFileManager = "pcmanfm"

myBorderWidth :: Dimension
myBorderWidth = 3           -- Sets border width for windows

myNormColor :: String
myNormColor   = "#0f4b6e"   -- Border color of normal windows

myFocusColor :: String
myFocusColor  = "#2ac3de"   -- Border color of focused windows

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "picom &"														-- picom 
    spawnOnce "pulseaudio --daemonize &"									-- audio
    spawnOnce "nitrogen --restore &"										-- background
    spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"	-- authenticator
    spawnOnce "xfce4-power-manager &"										-- power manager
    spawnOnce "fcitx -d &"													-- language support
    spawnOnce "libinput-gestures-setup start"								-- trackpad gestures
    spawnOnce "dropbox &"													-- dropbox
    spawnOnce "conky &"														-- conky
    -- spawnOnce "bluetoothctl power on"										-- bluetooth, probably not needed

spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def
                   { gs_cellheight   = 40
                   , gs_cellwidth    = 200
                   , gs_cellpadding  = 6
                   , gs_originFractX = 0.5
                   , gs_originFractY = 0.5
                   , gs_font         = myFont
                   }

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "mpv-music" spawnMpv findMpv manageMpv
                , NS "calendar" spawnCal findCal manageCal
                , NS "calculator" spawnCalc findCalc manageCalc
                ]
  where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnMpv  = myTerminal ++ " -t mpv-music"
    findMpv   = title =? "mpv-music"
    manageMpv = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnCal  = "google-calendar-nativefier"
    findCal   = className =? "googlecalendar-nativefier-e22938"
    manageCal = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w 
    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.5
                 w = 0.4
                 t = 0.75 -h
                 l = 0.70 -w

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall     = renamed [Replace "tall"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (Simplest)
           $ limitWindows 12
           $ mySpacing 5
           $ ResizableTall 1 (3/100) (1/2) []
magnify  = renamed [Replace "magnify"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (Simplest)
           $ magnifier
           $ limitWindows 12
           $ mySpacing 5
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ smartBorders
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 Full
floats   = renamed [Replace "floats"]
           $ limitWindows 20 simplestFloat
spirals  = renamed [Replace "spirals"]
           $ windowNavigation
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (Simplest)
           $ mySpacing' 5
           $ spiral (6/7)
tabs     = renamed [Replace "tabs"]
           -- I cannot add spacing to this layout because it will
           -- add spacing between window and tabs which looks bad.
           $ tabbed shrinkText myTabTheme

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = "#2ac3de"
                 , inactiveColor       = "#1a1b26"
                 , activeBorderColor   = "#2ac3de"
                 , inactiveBorderColor = "#1a1b26"
                 , activeTextColor     = "#1a1b26"
                 , inactiveTextColor   = "#a9b1d6"
                 }

-- Theme for showWName which prints current workspace when you change workspaces.
myShowWNameTheme :: SWNConfig
myShowWNameTheme = def
    { swn_font              = "xft:SauceCodePro Nerd Font:bold:size=60"
    , swn_fade              = 1.0
    , swn_bgcolor           = "#1c1f24"
    , swn_color             = "#ffffff"
    }

-- The layout hook
myLayoutHook = avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     withBorder myBorderWidth tall
                                 ||| magnify
                                 ||| spirals
                                 ||| monocle
                                 ||| tabs
                                 ||| floats
                                 -- ||| grid
                                 -- ||| threeCol
                                 -- ||| threeRow
                                 -- ||| tallAccordion
                                 -- ||| wideAccordion

myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
-- myWorkspaces = ["dev", "www", "sys", "doc", "pdf", "term", "chat", "mus", "gfx"]
myWorkspaceIndices = M.fromList $ zipWith (,) myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out the full
     -- name of my workspaces and the names would be very long if using clickable workspaces.
     [ className =? "confirm"         --> doFloat
     , className =? "file_progress"   --> doFloat
     , className =? "dialog"          --> doFloat
     , className =? "download"        --> doFloat
     , className =? "error"           --> doFloat
     , className =? "Gimp"            --> doFloat
     , className =? "notification"    --> doFloat
     , className =? "pinentry-gtk-2"  --> doFloat
     , className =? "splash"          --> doFloat
     , className =? "toolbar"         --> doFloat
     , className =? "libreoffice"     --> doShift ( myWorkspaces !! 3 )
     , className =? "Xournalpp"       --> doShift ( myWorkspaces !! 3 )
     , className =? "Zathura"         --> doShift ( myWorkspaces !! 4 )
     , className =? "Vmplayer"        --> doShift ( myWorkspaces !! 5 )
     , className =? "discord"         --> doShift ( myWorkspaces !! 6 )
     , className =? "vlc"             --> doShift ( myWorkspaces !! 7 )
     , className =? "Deadbeef"        --> doShift ( myWorkspaces !! 7 )
     , className =? "pomotroid"       --> doShift ( myWorkspaces !! 8 )
     , isFullscreen -->  doFullFloat
     ] <+> namedScratchpadManageHook myScratchPads

myKeys :: [(String, X ())]
myKeys =
    -- Xmonad
        [ ("M-C-r", spawn "xmonad --recompile")  -- Recompiles xmonad
        , ("M-S-r", spawn "xmonad --restart")    -- Restarts xmonad
        , ("M-S-q", io exitSuccess)              -- Quits xmonad

    -- Dmenu 
        -- , ("M-<Space>", spawn "dmenu_run -i -l 20 -x 10 -y 10 -z 1900 -p \"Run: \"")    -- choose an ambient background
        , ("M-<Space>", spawn "dmenu_run -i -l 20 -p \"Run: \"")    -- choose an ambient background
        , ("M-p w", spawn "bash $HOME/.config/dmscripts/scripts/dm-wifi -i")
        -- , ("M-p q", spawn "bash $HOME/.config/dmscripts/scripts/dm-logout -i x 10 -y 10 -z 1900")
        , ("M-p q", spawn "bash $HOME/.config/dmscripts/scripts/dm-logout -i")
        -- , ("M-p p", spawn "passmenu -i -x 10 -y 10 -z 1900 -p \"Password: \"")    -- choose an ambient background
        , ("M-p p", spawn "passmenu -i -p \"Password: \"")    -- choose an ambient background

    -- Useful programs to have a keybinding for launch
        , ("M-<Return>", spawn (myTerminal))
        , ("M-b", spawn (myBrowser))
        , ("M-f", spawn (myFileManager))

    -- Kill windows
        , ("M1-q", kill1)     -- Kill the currently focused client
        , ("M1-S-q", killAll)   -- Kill all windows on current workspace

    -- Floating windows
        , ("M1-<Space>", sendMessage (T.Toggle "floats")) -- Toggles my 'floats' layout
        , ("M1-S-<Space>", withFocused $ windows.W.sink)

    -- Windows navigation
        , ("M1-m", windows W.focusMaster)  -- Move focus to the master window
        , ("M1-j", windows W.focusDown)    -- Move focus to the next window
        , ("M1-k", windows W.focusUp)      -- Move focus to the prev window
        , ("M1-S-m", windows W.swapMaster) -- Swap the focused window and the master window
        , ("M1-S-j", windows W.swapDown)   -- Swap focused window with next window
        , ("M1-S-k", windows W.swapUp)     -- Swap focused window with prev window
        , ("M1-<Backspace>", promote)      -- Moves focused window to master, others maintain order

    -- Workspaces
        , ("M-<Tab>", moveTo Next NonEmptyWS)
        , ("M-S-<Tab>", moveTo Prev NonEmptyWS)

    -- Layouts
        , ("M1-;", sendMessage NextLayout)           -- Switch to next layout
        , ("M1-S-<Tab>", sendMessage NextLayout)           -- Switch to next layout
        , ("M1-f", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full

    -- Increase/decrease windows in the master pane or the stack
        , ("M-S-k", sendMessage (IncMasterN 1))      -- Increase # of clients master pane
        , ("M-S-j", sendMessage (IncMasterN (-1))) -- Decrease # of clients master pane
        , ("M-C-k", increaseLimit)                   -- Increase # of windows
        , ("M-C-j", decreaseLimit)                 -- Decrease # of windows

    -- Window resizing
        , ("M1-C-h", sendMessage Shrink)                   -- Shrink horiz window width
        , ("M1-C-l", sendMessage Expand)                   -- Expand horiz window width
        , ("M1-C-j", sendMessage MirrorShrink)          -- Shrink vert window width
        , ("M1-C-k", sendMessage MirrorExpand)          -- Expand vert window width

    -- Multimedia Keys
        , ("<XF86AudioPlay>", spawn "playerctl play-pause")
        , ("<XF86AudioPrev>", spawn "playerctl previous")
        , ("<XF86AudioNext>", spawn "playerctl next")
        , ("<XF86AudioMute>", spawn "amixer set Master toggle")
        , ("<XF86AudioLowerVolume>", spawn "amixer set Master 2%- unmute")
        , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 2%+ unmute")
        , ("<Print>", spawn "flameshot gui")

	-- scratchpad
	    , ("M1-s t", namedScratchpadAction myScratchPads "terminal")
	    , ("M1-s m", namedScratchpadAction myScratchPads "mpv-music")
	    , ("M1-c", namedScratchpadAction myScratchPads "calendar")
		, ("M1-s c", namedScratchpadAction myScratchPads "calculator")


        ]
myKeys2 conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [((m .|. mod1Mask, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    [((m .|. mod1Mask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm .|. shiftMask, button1), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]



main :: IO ()
main = do
    -- Launching three instances of xmobar on their monitors.
    xmproc0 <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/xmobar.hs"
    -- the xmonad, ya know...what the WM is named after!
    xmonad $ ewmh def
        { manageHook         = myManageHook <+> manageDocks
        , handleEventHook    = docksEventHook
        , modMask            = myModMask
        , keys               = myKeys2
        , mouseBindings      = myMouseBindings
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = showWName' myShowWNameTheme $ myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        , logHook = dynamicLogWithPP $ namedScratchpadFilterOutWorkspacePP $ xmobarPP
              -- the following variables beginning with 'pp' are settings for xmobar.
              { ppOutput = \x -> hPutStrLn xmproc0 x
              , ppCurrent = xmobarColor "#9ece6a" "#1a1b26" . wrap "[" "]"           -- Current workspace
              , ppVisible = xmobarColor "#9ece6a" "#1a1b26" . clickable              -- Visible but not current workspace
              , ppHidden = xmobarColor "#7aa2f7" "#1a1b26" . wrap "*" "" . clickable -- Hidden workspaces
              , ppHiddenNoWindows = xmobarColor "#bb9af7" "#1a1b26"  . clickable     -- Hidden workspaces (no windows)
              , ppTitle = xmobarColor "#a9b1d6" "#1a1b26" . shorten 60               -- Title of active window
              , ppSep =  "<fc=#565f89,#1a1b26> | </fc>"                    -- Separator character
              , ppUrgent = xmobarColor "#f7768e" "#1a1b26" . wrap "!" "!"            -- Urgent workspace
              , ppExtras  = [windowCount]                                     -- # of windows current workspace
              , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]                    -- order of things in xmobar
              }
        } `additionalKeysP` myKeys 

