function love.conf(t)
	local X=nil
	t.identity="Bump"
	t.appendidentity=X
	t.version="11.1"
	t.console=X
	t.accelerometerjoystick=X
	t.gammacorrect=true
	t.audio.mixwithsystem=true


	local W=t.window
	W.title="Bump V0.9.3"
	W.icon="/image/icon.png"
	W.width,W.height=1000,600
	W.borderless=X
	W.resizable=true
	W.minwidth,W.minheight=80,48
	W.fullscreen=X
	W.fullscreentype="desktop"
	W.vsync=1
	W.msaa=X
	W.depth=X
	W.stencil=8
	W.display=1
	W.highdpi=X
	W.x=nil
	W.y=nil

	local M=t.modules
	M.window=true
	M.system=true
	M.audio=true
	M.data=true
	M.event=true
	M.font=true
	M.graphics=true
	M.image=true
	M.keyboard=true
	M.math=true
	M.mouse=true
	M.sound=true
	M.timer=true
	M.touch=true

	M.thread=X
	M.joystick=X
	M.physics=X
	M.video=X
end