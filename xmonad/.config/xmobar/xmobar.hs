-- http://projects.haskell.org/xmobar/
-- I use Font Awesome 5 fonts in this config for unicode "icons".  On Arch Linux,
-- install this package from the AUR to get these fonts: otf-font-awesome-5-free

Config { font = "xft:SauceCodePro Nerd Font:weight=bold:pixelsize=11:antialias=true:hinting=true"
       , additionalFonts = [ "xft: Font Awesome 5 Free Solid:pixelsize=12"]
       , bgColor = "#24283b"
       , fgColor = "#a9b1d6"
       , position = Static { xpos = 10 , ypos = 10, width = 1900, height = 22 }
       , lowerOnStart = True
       , hideOnStart = False
       , allDesktops = True
       , persistent = True
       , iconRoot = "/home/tcmb139/.xmonad/xpm/"  -- default: "."
       , commands = [
                      Run Date "\xf017  %b %d %Y - (%H:%M) " "date" 50
                    , Run Network "wlp1s0" ["-t", "\xf0ab  <rx>kb  \xf0aa  <tx>kb"] 20
                    , Run Cpu ["-t", "<fn=1>\xf2db</fn> (<total>%)","-H","50","--high","red"] 20
                    , Run Memory ["-t", "<fn=1>\xf538</fn> <used>M (<usedratio>%)"] 20
                    , Run DiskU [("/", "\xf0c7  <free>")] [] 60
                    , Run Com "/home/tcmb139/.xmonad/scripts/volume" [] "vol" 30
                    , Run Com "/home/tcmb139/.xmonad/scripts/batinfo" [] "bat" 20
                    , Run Com "/home/tcmb139/.xmonad/scripts/pacupdate" [] "pacupdate" 36000
                    , Run Com "uname" ["-r"] "" 3600
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"


       -- , template = " <icon=haskell_20.xpm/> <fc=#565f89>|</fc> %UnsafeStdinReader% }{  <fc=#565f89>|</fc>  <fc=#a9b1d6>  <action=`alacritty -e htop`>%uname%</action> </fc> <fc=#565f89>|</fc> <fc=#e0af68> %cpu% </fc> <fc=#565f89>|</fc> <fc=#f7768e> %memory% </fc> <fc=#565f89>|</fc> <fc=#2ac3de> %disku% </fc> <fc=#565f89>|</fc> <fc=#9ece6a> <action=`alacritty -e sudo iftop`>%wlp1s0%</action> </fc> <fc=#565f89>|</fc>  <fc=#bb9af7>  <action='alacritty -e sudo pacman -Syu'>%pacupdate%</action></fc> <fc=#565f89>|</fc> <fc=#7aa2f7>   vol: %vol% </fc> <fc=#565f89>|</fc> <fc=#b4f9f8> %date% </fc><fc=#565f89>|</fc> <fc=#c0caf5> %bat% </fc> "

       , template = "<fc=#c0caf5,#1a1b26> <icon=haskell_20.xpm/> </fc>\

                      \<fc=#24283b,#1a1b26> </fc>\
                      \<fc=#1a1b26,#24283b> </fc>\

                      \<fc=#a9b1d6,#1a1b26>%UnsafeStdinReader% </fc>\

                      \<fc=#24283b,#1a1b26> </fc> }\
                      \{ <fc=#24283b,#1a1b26> </fc>\

                      \<fc=#c0caf5,#1a1b26> <action='flameshot-gui'> </action></fc>\
                      \<fc=#c0caf5,#1a1b26> <action='discord'> </action></fc>\
                      \<fc=#c0caf5,#1a1b26> <action='alacritty -e nmgui'> </action>\

                      \<fc=#1a1b26,#24283b> </fc>\
                      \<fc=#24283b,#1a1b26> </fc>\

                      \<fc=#bb9af7,#1a1b26> %wlp1s0% </fc>\

                      \<fc=#1a1b26,#24283b> </fc>\
                      \<fc=#24283b,#1a1b26> </fc>\

                      \<fc=#7aa2f7,#1a1b26> %cpu% </fc>\
                      \<fc=#7dcfff,#1a1b26> %memory% </fc>\
                      \<fc=#2ac3de,#1a1b26> %disku% </fc>\

                      \<fc=#1a1b26,#24283b> </fc></fc>\
                      \<fc=#24283b,#1a1b26> </fc>\

                      \<fc=#73daca,#1a1b26> %bat%  </fc>\
                      \<fc=#9ece6a,#1a1b26>  %pacupdate% </fc>\
                      \<fc=#ff9e64,#1a1b26><action='pavucontrol'>  %vol% </action></fc>\
                      \<fc=#f7768e,#1a1b26> %date%</fc>"
       }


