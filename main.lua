math.randomseed(os.time()*626)
gc,kb,ms,fs,tm=love.graphics,love.keyboard,love.mouse,love.filesystem,love.timer
toN,toS=tonumber,tostring
int,sqr,abs,rnd,sin,cos,atan,pi=math.floor,math.sqrt,math.abs,math.random,math.sin,math.cos,math.atan,math.pi
sub,gsub,find,format=string.sub,string.gsub,string.find,string.format
ins,rem=table.insert,table.remove

ww,wh=gc.getWidth(),gc.getHeight()
xOy=love.math.newTransform()

Timer=tm.getTime
mx,my=-10,-10--mouse x,y
mouseLine=love.math.newBezierCurve({})
mouseShow=true--mouse display
mouseIn=false--mouse inwindow
touching=nil--first touching id
pause=0--pause countdown
focus=true--if focus on
scene=""--scene name
gamemode=nil--mode name
bgmPlaying=nil--bgm name
curBG="menu"--background name
touchingmode=false--if touching mode
info=false--show more infomation

languages={"eng","chi"}
prevMenu={
	load=love.event.quit,
	play=function()
		if life>0 or p.alive then data.coin=data.coin+int(sc*.02)end
		p.slow=nil
		for k,v in pairs(sfx)do
			if v:isPlaying()then
				v:stop()
			end
		end
		gotoScene("mode","deck")
	end,
	result="mode",
	stage="mode",
	entertain="mode",
	mode="main",

	help="main",
	shop="main",
	stat="main",
	about="main",
	setting="main",
	allclear_h="main",
	allclear_e="main",
	intro="quit",
	main="quit",
}
swap={
none={2,1,d=function()end},
swipe={30,15,d=function()
	local t=sceneSwaping.time
	gc.setColor(1,0,0)
	gc.rectangle("fill",1000-100*t,0,2000,600)
end},
shuttle={40,20,d=function()
	local t=sceneSwaping.time
	t=t>20 and(40-t)^2 or t^2
	gc.setColor(1,0,0,t*.005)
	gc.rectangle("fill",0,0,t*500/400,600)
	gc.rectangle("fill",t*500/400,0,1000-t*2*500/400,t*300/400)
	gc.rectangle("fill",1000-t*500/400,0,500,600)
	gc.rectangle("fill",t*500/400,600-t*300/400,1000-t*2*500/400,t*300/400)
end},
flash={8,1,d=gc.clear},
deck={60,20,d=function()
	local t=sceneSwaping.time
	t=t>40 and 60-t or t>20 and 20 or t
	gc.setColor(1,0,0,t*.05)
	gc.rectangle("fill",0,0,1000,t*15)
	gc.rectangle("fill",0,600-t*15,1000,t*15)
	gc.setColor(.5,0,0,t*.05)
	gc.line(0,t*15,1000,t*15)
	gc.line(0,600-t*15,1000,600-t*15)
end
},
}

gc.setDefaultFilter("linear","nearest")
kb.setKeyRepeat(false)
kb.setTextInput(false)

Buttons={}
numFonts={}
function numFont(s)
	if numFonts[s]then
		gc.setFont(numFonts[s])
	else
		local t=gc.setNewFont("font.ttf",s)
		numFonts[s]=t
		gc.setFont(t)
	end
	currentFont=-1
end
Fonts={}for i=1,#languages do Fonts[languages[i]]={}end
fontLib={
eng=function(s)
	if s~=currentFont then
		if Fonts[s]then
			gc.setFont(Fonts[s])
		else
			local t=gc.setNewFont("font.ttf",s)
			Fonts[s]=t
			gc.setFont(t)
		end
		currentFont=s
	end
end,
chi=function(s)
	if s~=currentFont then
		if Fonts[setting.lang][s]then
			gc.setFont(Fonts[setting.lang][s])
		else
			local t=gc.newFont("font.ttf",s-5,"normal")
			Fonts[setting.lang][s]=t
			gc.setFont(t)
		end
		currentFont=s
	end
end,
}
fontLib.chi2=fontLib.chi
setting={
	sfx=true,
	bgm=true,
	fullscreen=false,
	lang="eng",
	mouseK=4,
	keyboardK=4,
}
stat={
	run=0,
	game=0,
	gametime=0,
	collect=0,
	die=0,
}
data={
	coin=0,
	cent=0,
	diamond=0,
	skinS=1,
	skinT=1,
	skinAmount={-2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,},
	HARDlock=true,
	EASIlock=true,
	INFlock=true,
	gameunlock=0,
}

require("scenes")
require("toolfunc")
require("gamefunc")

require("lists")
require("text")
require("texture")
require("easi_data")

require("call&sys")
require("timer")
require("paint")
userData=fs.newFile("userData")
if fs.getInfo("userData")then loadData()end

stat.run=stat.run+1
setFont=fontLib[setting.lang]
Text=Texts[setting.lang]