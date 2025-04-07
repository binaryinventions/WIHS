function onKeyEvent(key as String, press as Boolean) as Boolean 'Key functions for UI
  if press
      if key = "replay"
          if (m.Audio.state = "playing")
            m.audio.control = "pause"
            m.Play.text = "N"
            return true
          else 
            m.audio.control = "resume"
            m.Play.text = "O"
            return true
          end if
      else if key = "play"
          if (m.Audio.state = "playing")
              m.audio.control = "pause"
              m.Play.text = "N"
              return true
            else if (m.Audio.state = "paused")
              m.audio.control = "resume"
              m.Play.text = "O"
              return true
            else 
               m.audio.control = "play"
               m.Play.text = "O"
               return true
          end if
      end if
  end if
  m.top.setFocus(true)
end Function

sub init()
  m.Play = m.top.findNode("play") 'Play button

  m.top.backgroundURI = "pkg:/images/hartford_skyline.jpg"

  m.Audio = createObject("roSGNode", "Audio")

  audiocontent = createObject("RoSGNode", "ContentNode")
  ' audiocontent.url = "http://ic2.christiannetcast.com/wihs-fm"
  audiocontent.url = "https://streaming.live365.com/a60257"

  m.audio.content = audiocontent

  m.top.appendChild(m.audio)
  m.top.setFocus(true)

  m.defaulttext = "WIHS - We're In His Service."
  m.nowplaying = m.top.FindNode("nowPlayingPoster")
  m.nowplayingposter = createObject("roSGNode", "ContentNode")
end sub

sub Main()
  showChannelSGScreen()
end sub

sub showChannelSGScreen()
  screen = CreateObject("roSGScreen")
  m.port = CreateObject("roMessagePort")
  screen.setMessagePort(m.port)
  scene = screen.CreateScene("WIHSRadio")
  screen.show()

  while(true)
    msg = wait(0, m.port)
    msgType = type(msg)

    if msgType = "roSGScreenEvent"
      if msg.isScreenClosed() then return
    end if
  end while

end sub
