game={}
function game.load()
	scene="load"
	curBG="none"
	currencyDisp="none"
	setMouse(true)
	loading=1--Loading mode
	loadnum=1--Loading counter
	loadprogress=0--Loading bar
	tip=Text.tip[rnd(#Text.tip)]
end
function game.intro()
	count=0
	y,v=-100,0
	scene="intro"
	curBG="none"
	currencyDisp="none"
	setMouse(true)
	BGM()
end
function game.main()
	scene="main"
	curBG="menu"
	currencyDisp="all"
	setMouse(true)
	h,v=0,0
	BGM("title")
end
function game.mode()
	scene="mode"
	curBG="menu"
	currencyDisp="all"
	setMouse(true)
	BGM("title")
end
function game.stage()
	scene="stage"
	curBG="menu"
	currencyDisp="all"
	setMouse(true)
	BGM("title")
end
function game.entertain()
	scene="entertain"
	curBG="menu"
	currencyDisp="all"
	setMouse(true)
	BGM("title")
end
function game.play()
	scene="play"
	currencyDisp="none"
	setMouse(false)
	ms.setPosition(ww*.5,wh*.5)
	restart()
end
function game.result()
	scene="result"
	currencyDisp="coin"
	setMouse(false)
	ms.setPosition(ww*.5,wh*.5)
	restart()
end
function game.shop()
	scene="shop"
	curBG="menu"
	currencyDisp="all"

	list,sel=data.skinS,data.skinT
	combo,comboTime=0,0
	h,v=0,12
	BGM("shop")
end
function game.setting()
	scene="setting"
	curBG="menu"
	currencyDisp="none"
	BGM("title")
end
function game.help()
	scene="help"
	curBG="none"
	currencyDisp="none"
	BGM("title")
end
function game.stat()
	scene="stat"
	curBG="none"
	currencyDisp="none"
	BGM("title")
end
function game.allclear_h()
	scene="allclear_h"
	curBG="allclear_h"
	currencyDisp="none"
	BGM("allclear_h")
	time=0
	caption={}
	for i=1,#Text.allclear_h do
		local t=Text.allclear_h[i]
		if find(t,"&time")then
			local i=stat.gametime
			i=int(i/3600).."h"..int(i%3600/60).."m"
			t=gsub(t,"&time",i)
		end
		ins(caption,t)
	end
end
function game.allclear_e()
	scene="allclear_e"
	curBG="allclear_e"
	currencyDisp="none"
	BGM("allclear_e")
	time=0
end
function game.quit()
	love.event.quit()
end