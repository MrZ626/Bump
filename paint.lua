function mStr(s,x,y)gc.printf(s,x-500,y,1000,"center")end
function drawButton(BL)
	for i=1,#BL do
		local B=BL[i]
		if not(B.hide and B.hide())then
			gc.setColor(But.sel==B and(B.backS or buttonSelectedColor)or(B.back or buttonColor))
			gc.rectangle("fill",B.x-B.w*.5,B.y-B.h*.5,B.w,B.h,6)
			gc.setColor(0,0,0)
			gc.rectangle("line",B.x-B.w*.5,B.y-B.h*.5,B.w,B.h,6)
			local t=Text.but[scene][i]
			mStr(type(t)=="string"and t or t(),B.x,B.y-currentFont*.5)
		end
	end
end
drawCurrency={
none=function()end,
coin=function()
	gc.setColor(1,1,0)gc.rectangle("fill",890,570,20,20)
	gc.setColor(0,0,0)gc.rectangle("line",890,570,20,20)
	if data.coin<10000 then
		numFont(30)
		gc.print(data.coin,920,566)
	else
		numFont(24)
		gc.print(data.coin,915,569)
	end
end,
cent=function()
	gc.setColor(.82,.82,.82)gc.rectangle("fill",890,570,20,20)
	gc.setColor(0,0,0)gc.rectangle("line",890,570,20,20)
	if data.cent<10000 then
		numFont(30)
		gc.print(data.cent,920,566)
	else
		numFont(24)
		gc.print(data.cent,915,571)
	end
end,
all=function()
	gc.setColor(1,1,0)gc.rectangle("fill",890,520,20,20)
	gc.setColor(.82,.82,.82)gc.rectangle("fill",890,545,20,20)
	gc.setColor(.5,.82,1)gc.circle("fill",900,580,10,4)
	gc.setColor(0,0,0)
	gc.rectangle("line",890,520,20,20)
	gc.rectangle("line",890,545,20,20)
	gc.circle("line",900,580,10,4)
	if data.coin<10000 then
		numFont(30)
		gc.print(data.coin,920,516)
	else
		numFont(24)
		gc.print(data.coin,915,519)
	end
	if data.cent<10000 then
		numFont(30)
		gc.print(data.cent,920,541)
	else
		numFont(24)
		gc.print(data.cent,915,544)
	end
	numFont(30)
	gc.print(data.diamond,920,566)
end,
}

Pnt={obj={},BG={}}
function Pnt.obj.laser()
	local e=obj.laser
	local x,w=e.x-e.r,2*e.r
	gc.setColor(1,1,1)gc.draw(PTC.laser)
	gc.rectangle("fill",x,587,w,18)
	gc.setColor(1,0,0,.5+rnd()*.5)
	gc.rectangle("fill",x,590,w,6)
	if e.sd>0 then
		ShdColor[e.sd][4]=.8+rnd()*.2
		gc.setColor(ShdColor[e.sd])
		gc.rectangle("fill",x,585,w,3)
	end
end
function Pnt.obj.snipper()
	local e=obj.snipper
	gc.setColor(1,0,0,.63)
	gc.circle("line",e.x,e.y,30,24)
	gc.line(e.x,e.y-50,e.x,e.y+50)
	gc.line(e.x-50,e.y,e.x+50,e.y)
end
function Pnt.obj.bombard()
	local e=obj.bombard
	if e.ct>0 then
		gc.setColor(1,0,0,(1-e.ct/e.ct0))
		gc.setLineWidth(4)
		local d=100*e.ct/e.ct0
		gc.rectangle("line",e.x-d,e.y-d,2*d,2*d,5)
		gc.setLineWidth(2)
		gc.line(e.x-8,e.y,e.x+8,e.y)
		gc.line(e.x,e.y-8,e.x,e.y+8)
	else
		gc.setColor(1,.82,0)
		gc.setLineWidth(e.r2-e.r1)
		local d=(e.r1+e.r2)*.5
		gc.rectangle("line",e.x-d,e.y-d,2*d,2*d)
		gc.setLineWidth(2)
	end
end
function Pnt.obj.pin()
	for i=#obj.pin,1,-1 do
		local e=obj.pin[i]
		local h=e.t>obj.pin.t-20 and obj.pin.t-e.t or e.t>20 and 20 or e.t
		gc.setColor(1,0,0,h*.007)gc.rectangle("fill",e.x-50,1,100,584)
		gc.setColor(1,0,0)gc.draw(img.pin,e.x,587,0,1,h*.05,50,10)
	end
end
function Pnt.obj.lasergun()
	local e=obj.lasergun
	for i=1,#e do
		if e[i][2]>30 then
			gc.setColor(0,0,0,(90-(e[i][2]-30))/255)
			gc.setLineWidth(120-e[i][2])
		else
			gc.setColor(1,0,0,e[i][2]*.03)
			gc.setLineWidth(e[i][2]*3)
		end
		if e[i][3]==1 then
			gc.line(0,e[i][1],999,e[i][1])
		elseif e[i][3]==2 then
			gc.line(e[i][1],0,e[i][1],586)
		end
	end
	gc.setLineWidth(2)
end
function Pnt.obj.sim()
	gc.setColor(0,1,0)
	gc.rectangle("fill",obj.sim.x-12,obj.sim.y-12,25,25)
end
function Pnt.obj.block()
	for i=1,#obj.block do
		local e=obj.block[i]
		local a=e.t1>0 and (1-e.t1/e.t10)or min(e.t2,10)*.1
		gc.setColor(0,0,0,a)
		gc.rectangle("fill",e.x-e.w*.5,e.y-e.h*.5,e.w,e.h)
		if e.text then
			numFont(e.font)
			gc.setColor(1,1,1,a)
			mStr(e.text,e.x,e.y-e.font*.5)
		end
	end
end
function Pnt.obj.beat()
	for i=1,#obj.beat do
		local e=obj.beat[i]
		if e.stat==1 then
			gc.setColor(e.t<15 and 1 or 0,0,0,.5)
			gc.circle("fill",e.x,e.y,12)
			if e.t<82 then
				gc.setColor(0,0,0,.8)
				gc.circle("line",e.x,e.y,e.t)
			end
		elseif e.stat==2 then
			gc.setColor(0,0,0,1-.0667*e.t)
			gc.circle("line",e.x,e.y,8*e.t)
		end
	end
end
function Pnt.obj.blackhole()
	local e=obj.blackhole
	gc.setColor(0,0,0)
	gc.circle("fill",e.x,e.y,9+1.5*sin(Timer()*3),12)
	gc.setColor(1,1,1)
	gc.draw(PTC.blackhole)
end
function Pnt.obj.pool()
	local e=obj.pool
	local l={}
	ins(l,1000)ins(l,587)
	ins(l,0)ins(l,587)
	for i=0,100 do
		ins(l,10*i)
		ins(l,e.level+e.h[i])
	end
	gc.setColor(.5,.82,1)
	gc.polygon("fill",l)
	gc.setColor(0,.5,1)
	if p.alive and data.skinS~=17 and e.ox<200 then--17=transparent
		local t=e.ox/6
		gc.rectangle("fill",p.x-t*.5,p.y-22,t+1,7)
	end
end
function Pnt.obj.fish()
	gc.setColor(1,1,1)
	for i=1,#obj.fish do
		local e=obj.fish[i]
		if e.t=="shark"then
			gc.draw(img.fish.shark[e.stat],e.x,e.y,nil,e.vx>0 and -1 or 1,1,24,24)
		elseif e.t=="whale"then
			gc.draw(img.fish.whale[e.stat],e.x,e.y,nil,e.vx>0 and -1 or 1,1,24,24)
		elseif e.t=="octopus"then
			gc.draw(img.fish.octopus[e.stat],e.x,e.y,nil,nil,nil,44,44)
		end
	end
end
function Pnt.obj.piano()
	gc.setColor(0,0,0)
	for i=1,20 do
		mStr(pianoKey[i],50*i-25,580-20*#pianoKey[i])
		gc.line(50*i,570,50*i,586)
	end
end
function Pnt.obj.death()
	local e=obj.death
	gc.setColor(.72,0,0,.6)
	gc.rectangle("fill",0,0,1000,e.t)
	gc.setColor(0,0,0,.5)
	setFont(80)
	mStr(e.s,500,e.t-280)
	setFont(30)
end
function Pnt.obj.progressBar()
	local yp=450-obj.progressBar.h
	local tp=deadLine and 150+(deadLine[1]-gameTime)*300/deadLine[2]
	gc.setColor(255,245+10*sin(Timer()*10),0)
	gc.rectangle("fill",10,yp,20,450-yp)
	gc.setColor(0,0,0)
	if tp then
		gc.setColor(1,0,0)
		gc.line(5,tp,35,tp)
		if yp>tp then
			gc.setColor(1,0,0,.7)
			gc.rectangle("fill",11,yp,18,tp-yp)
		end
	end
	gc.setColor(0,0,0)
	gc.line(5,yp,35,yp)
	gc.rectangle("line",10,150,20,300)
end
function Pnt.obj.text()
	for i=#obj.text,1,-1 do
		local e=obj.text[i]
		setFont(e.f)
		gc.setColor(0,0,0,(e.ct>e.ct0*.8 and(e.ct0-e.ct)/e.ct0*1000 or e.ct>e.ct0*.2 and 200 or e.ct/e.ct0*1000)/255)
		mStr(e.t,e.x,e.y)
	end
	setFont(30)
end

function Pnt.BG.none()
end
function Pnt.BG.menu()
	gc.setLineWidth(40)
	gc.setColor(1,.96,.96)
	local t=(Timer()%1)*100
	for i=-6,9 do
		gc.line(t+100*i,-50,t+100*i+600,650)
	end
	gc.setLineWidth(2)
end
function Pnt.BG.game1()
	gc.setColor(1,.96,.96)
	local t=(Timer()%1)*50
	for x=0,20 do
		for y=0,12 do
			if(x+y)%2==0 then
				gc.rectangle("fill",50*x-t,50*y-t,50,50)
			end
		end
	end
end
function Pnt.BG.game2()
	gc.translate(500,300)
	gc.scale(1,.6)
	gc.setColor(1,.96,.96)
	gc.setLineWidth(30)
	local t=(Timer()%1)*60
	for x=0,8 do
		local d=60*x+t
		gc.rectangle("line",-d,-d,2*d,2*d)
	end
	gc.setLineWidth(2)
	gc.replaceTransform(xOy)
end
function Pnt.BG.game3()
	local t=215+sin(Timer()*6)*40
	gc.setColor(255,t,t)
	gc.rectangle("fill",0,0,1000,600)
end
function Pnt.BG.allclear_h()
	gc.setColor(1,.96,.96)
	local t=Timer()
	for i=2,10 do
		local x,y=500+450*sin(t*i*.5+i*20),300+250*sin(t*i/2.6666666+i*25)
		gc.rectangle("fill",x-10*i,y-10*i,20*i,20*i)
	end
end
function Pnt.BG.allclear_e()
end

function Pnt.load()
	if loadprogress then
		gc.setColor(.95,.95,0)
		gc.rectangle("fill",200,280,loadprogress*600,40)
		gc.setColor(0,0,0)
		gc.rectangle("line",200,280,600,40)
		setFont(30)
		mStr(Text.load[loading],500,285)
	end
	gc.setColor(1,1,1)
	gc.draw(PTC.bar_load)
	setFont(20)
	mStr(tip,500,570)
end
function Pnt.intro()
	gc.setColor(1,1,1)
	gc.draw(img.title[setting.lang],500,y,nil,nil,nil,250,100)
	gc.draw(PTC.title_hit)
	if count>120 then
		gc.setColor(0,0,0,abs(sin((count-120)*.03)))
		setFont(30)
		mStr(Text.anykey,500,500)
		return nil
	end
end
function Pnt.main()
	gc.setColor(1,1,1)
	gc.draw(img.title[setting.lang],500,150-30*abs(sin(3*Timer())),nil,.8,nil,250,100)
	gc.draw(skin[data.skinS][data.skinT],370,244-h)
	if v~=0 then
		h,v=h+v,v-.4
		if h<0 then
			h,v=0,0
			SFX("hit")
		elseif h>275 then
			startgame("vs")
		end
	end
end
function Pnt.shop()
	setFont(30)
	gc.setColor(0,0,0)
	mStr(Text.skinName[list],500,20)
	mStr(Text.skillText[skinSkill[list]],750,200)
	gc.line(450,345,550,345)
	local i=data.skinAmount[list]
	if i~=-1 then mStr(Text.shop.remain..(i==-2 and Text.shop.inf or i),500,55)end

	if combo>4 then
		setFont(50)
		local a=comboTime/240
		gc.translate(350,85)
		gc.setColor(min(combo,40)*.025,0,0,a*.5)
		gc.arc("fill",0,0,40,-pi*.5,pi*2*a)
		if a>.95 then gc.scale(1+combo*(a-.95)*.1)end
		gc.rotate(sin(Timer()*7)*min(combo,30)*.003)
		gc.setColor(min(combo,50)*.02,min(combo,50)*.02,0,a)
		local t="x"..combo
		mStr(t,-1,-24)
		mStr(t,-1,-22)
		mStr(t,1,-24)
		mStr(t,1,-22)
		gc.setColor(min(combo,20)*.02,0,0,a)
		mStr(t,0,-23)
		gc.replaceTransform(xOy)
	end
	gc.setColor(1,1,1)
	gc.draw(skin[list][sel],500-25,294-h,0,2,2)
end
function Pnt.playgroundContain()
	gc.setColor(1,1,1)
	gc.rectangle("fill",0,0,1000,600)
	if p.slow then FX.slow()end

	gc.setColor(.63,.5,0)gc.rectangle("fill",0,587,1000,18)--Ground

	if obj.piano then Pnt.obj.piano()end
	if obj.death then Pnt.obj.death()end
	if obj.beat then Pnt.obj.beat()end
	if obj.pool then Pnt.obj.pool()end
	if obj.fish then Pnt.obj.fish()end
	if obj.laser then Pnt.obj.laser()end
	if obj.bombard then Pnt.obj.bombard()end
	gc.setColor(1,1,1)gc.draw(PTC.explode)
	if obj.blackhole then Pnt.obj.blackhole()end
	if obj.pin then Pnt.obj.pin()end
	if obj.lasergun then Pnt.obj.lasergun()end
	if obj.snipper then Pnt.obj.snipper()end
	if obj.sim then Pnt.obj.sim()end

	if p.magnet then FX.magnet()end
	if p.backT then FX.backT()end
	if p.backP then FX.backP()end
	if FX.arrow_t then FX.arrow()end

	for i=1,#light do
		local l=light[i]
		local j=l[3]^1.5+12
		if l[4]==1 then
			gc.setColor(1,1,0,1-l[3]*.06)
		else
			gc.setColor(.82,.82,.82,1-l[3]*.06)
		end
		gc.rectangle("fill",l[1]-j,l[2]-j,2*j,2*j)
		gc.setColor(0,0,0,1-l[3]*.06)
		gc.rectangle("line",l[1]-j,l[2]-j,2*j,2*j)
	end
	--Eating FX

	for i=1,#shade do
		local s=shade[i]
		gc.setColor(1,1,1,s.ct*.03)
		gc.draw(s.pat,s.x-12,s.y-12)
	end
	--Shades

	if g[1]then
		for i=1,#g*.5-1 do
			gc.setColor(.5,.5,0,(220-50*i)/255)
			gc.setLineWidth(4)
			gc.rectangle("line",g[2*i+1]-9,g[2*i+2]-9,20,20)
			gc.setColor(.82,.63,0,.2)
			gc.setLineWidth(2)
			gc.line(g[2*i-1],g[2*i],g[2*i+1],g[2*i+2])
		end
		gc.setColor(0,0,0)
		gc.rectangle("line",g[1]-12,g[2]-12,25,25)
		gc.setColor(coinColor[coinMode])
		gc.rectangle("fill",g[1]-12,g[2]-12,25,25)
	end
	--Coins

	if not p2 then
		if p.alive then
			gc.setColor(1,1,1,(p.inv or 0)%7>4 and .3 or 1)
			gc.draw(curSkin,p.x-12,p.y-12)
			if p.shield then
				FX.shield(p.x,p.y)
			end
		end
	else
		gc.setColor(1,1,1)
		gc.draw(skin[1][1],p.x-12,p.y-12)
		gc.draw(skin[1][3],p2.x-12,p2.y-12)
	end
	--Players

	if obj.block then Pnt.obj.block()end

	if dieFX[3]<30 then
		gc.setColor(1,1,1,1-dieFX[3]*.035)
		local R=12+dieFX[3]^2/10
		gc.draw(curSkin,dieFX[1],dieFX[2],nil,(2*R+1)*.04,(2*R+1)*.04,12,12)
	end
	--Die Fx

	setFont(30)
	for i=1,#bonus do
		gc.setColor(1,0,0,(5*bonus[i][4]+30*sin(Timer()*30))/255)
		mStr(bonus[i][1],bonus[i][2],bonus[i][3]+bonus[i][4])
	end
	--Bonus

	if p.alive then
		gc.setColor(0,0,0,.16)
		gc.line(p.x,p.y,p.x+mx1,p.y+my1)
		gc.setColor(0,0,0,.24)
		gc.circle("line",p.x+mx1,p.y+my1,6,16)
	end
	--Ingame Mouse

	if obj.text then Pnt.obj.text()end
end
function Pnt.fullPlayground_set()
	if FX.shake>0 then
		FX.shake=FX.shake-1
		local t=2*FX.shake
		gc.translate(rnd(-t,t),rnd(-t,t))
	end
end
function Pnt.fullPlayground_end()
	gc.setColor(1,1,1)
	gc.draw(PTC.portal1)
	gc.draw(PTC.portal2)
	if p.portal then
		PTC.portal1:setPosition(-500,rnd(-300,287))PTC.portal1:emit(1)
		PTC.portal2:setPosition(500,rnd(-300,287))PTC.portal2:emit(1)
		gc.setLineWidth(4)
		gc.setColor(0,.75,1)gc.line(-500,-298,-500,286)
		gc.setColor(1,.75,0)gc.line(500,-298,500,286)
		gc.setLineWidth(2)
	end
end
function Pnt.playground_set()
	if FX.shake>0 then
		FX.shake=FX.shake-1
		local t=2*FX.shake*(FX.shake%2*2-1)
		gc.translate(t,-t)
	end
	gc.scale(.85)
	gc.translate(500*.15,300*.15)
	if obj.camera then
		gc.translate(500-obj.camera.x,300-obj.camera.y)
	end
	if obj.shake then
		gc.rotate(obj.shake.a)
		gc.translate(obj.shake.x,obj.shake.y)
	end
end
function Pnt.playground_end()
	gc.setColor(0,0,0)gc.rectangle("line",0,0,1000,600)

	gc.setColor(1,1,1)
	gc.draw(PTC.portal1)
	gc.draw(PTC.portal2)
	if p.portal then
		PTC.portal1:setPosition(-500,rnd(-300,287))PTC.portal1:emit(1)
		PTC.portal2:setPosition(500,rnd(-300,287))PTC.portal2:emit(1)
		gc.setLineWidth(4)
		gc.setColor(0,.75,1)gc.line(-500,-298,-500,286)
		gc.setColor(1,.75,0)gc.line(500,-298,500,286)
		gc.setLineWidth(2)
	end
end
function Pnt.play()
	if fullscreenPlay then
		Pnt.fullPlayground_set()
	else
		Pnt.playground_set()
	end
	gc.stencil(stencil_playground, "replace",1)
	gc.setStencilTest("equal",1)
	Pnt.playgroundContain()
	gc.setStencilTest()
		if fullscreenPlay then
			Pnt.fullPlayground_end()
			return nil
		else
			Pnt.playground_end()
		end
	gc.replaceTransform(xOy)
	--Draw playground&Reset coordinate

	if gamemode~="vs"then
		gc.setColor(1,.82,0)
		local i=(-cos((p.inv or 0)/3)+1)*.5
		gc.setColor(1,.6+.2*i,i*.4)
		gc.rectangle("fill",0,0,bar1*1000/600,16)
		gc.setColor(0,0,0)gc.line(0,17,999,17)
		--Energy bar

		if obj.progressBar then Pnt.obj.progressBar()end
		--Progress Bar

		if p.skill~="na"then
			if p.scd0>30 then
				local h=30*(1-p.scd/p.scd0)
				if h==30 then
					gc.setColor(1,.47+.47*sin(Timer()*10),0)
				else
					gc.setColor(1,0,0)
				end
				gc.rectangle("fill",960,550-h,30,h)
			elseif p.scd0>0 then
				local h=30*(1-p.scd/p.scd0)
				if h==30 then
					gc.setColor(1,.47+.47*sin(Timer()*10),0)
					gc.rectangle("fill",960,520,30,30)
				else
					gc.setColor(1,0,0)
					gc.rectangle("fill",975-h*.5,535-h*.5,h,h)
				end
			end
			gc.setColor(1,1,1,.71)gc.draw(skill_icon[p.skill],960,520)
			gc.setColor(0,0,0)gc.rectangle("line",960,520,30,30)
		end
		--Skill CD

		gc.setColor(1,1,1)
		for i=1,life do gc.draw(curSkin,1000-28*i,22)end
		--Life remain

		if currencyDisp=="none"then
			gc.setColor(1,1,0)gc.rectangle("fill",890,570,20,20)
			gc.setColor(0,0,0)gc.rectangle("line",890,570,20,20)
			numFont(20)
			if resScore and endTime>50 and endTime<200 and sc>=50 then gc.print("+"..int(sc*.02),928,550)end
			local c=(p.alive or life>0 or endTime==200)and data.coin or data.coin-int(sc*.02)
			if c<10000 then
				numFont(30)
				gc.print(c,920,566)
			else
				numFont(24)
				gc.print(c,915,569)
			end
		end
		--Coin/Bonus

		gc.setColor(0,0,0)
		numFont(28)
		gc.print(sc1,5,25)
		gc.print(collect,5,55)
		gc.print(format("%0.2f",gameTime),6,570)
		--Mes

		gc.rectangle("line",969,99,22,402)
		gc.setColor(0,.8,1,.6)
		gc.rectangle("fill",970,500-cbt1*400/800,20,cbt1*400/800)
		gc.setColor(0,0,0,.59)
		for i=1,7 do gc.line(970,500-50*i,990,500-50*i)end
		--Combo Bar

		if not p.alive and life>0 then
			gc.setColor(0,0,0,(70-ct)*.02)
			setFont(30)
			mStr(Text.gameover[3],500,300)
			ms.setPosition(ww*.5,wh*.5)
			--Revive?
		end
	else
		setFont(180)
		gc.setColor(1,0,0,.13)
		mStr(vsGet[1],250,200)
		gc.setColor(0,.5,1,.13)
		mStr(vsGet[2],750,200)
		--VS mode score
	end

	if pause>0 then
		setFont(80)
		gc.setColor(0,0,0,pause*.06)
		mStr("PAUSED",500,250)
	end
end
function Pnt.help()
	gc.setColor(0,0,0)
	setFont(36)
	mStr(Text.help[1],500,40)
	mStr(Text.help[2],500,90)
	setFont(25)
	mStr(Text.help[3],500,200)
	setFont(20)
	mStr(Text.help[4],500,340)
	mStr(Text.help[5],500,360)
	setFont(30)
	mStr(Text.help[6],500,380)
	gc.setColor(1,1,1)gc.draw(img.title[setting.lang],60,420,.2,.5+.05*sin(Timer()*2))
end
function Pnt.stat()
	gc.setColor(0,0,0)
	gc.print(Text.stat[1],250,60)
	gc.print(Text.stat[2],250,100)
	gc.print(Text.stat[3],250,140)
	gc.print(Text.stat[4],250,180)

	gc.print(stat.game,600,60)
	gc.print(format("%0.2f",stat.gametime).."s",600,100)
	gc.print(stat.collect,600,140)
	gc.print(stat.die,600,180)
	gc.setColor(1,1,1)gc.draw(img.title[setting.lang],60,420,.2,.5+.05*sin(Timer()*2))
end
function Pnt.allclear_h()
	gc.setColor(0,0,0)
	setFont(60)
	for i=1,#caption do
		mStr(caption[i],500,500-min(time,3100)/1.5+200*i)
	end
end
function Pnt.allclear_e()
	--
end