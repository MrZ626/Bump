But={
	null={},
	main={
		{x=500,y=300,w=320,h=60,code=function()gotoScene("mode")end},
		{x=415,y=380,w=150,h=60,code=function()gotoScene("shop")end},
		{x=585,y=380,w=150,h=60,code=function()gotoScene("setting")end},
		{x=415,y=460,w=150,h=60,code=function()gotoScene("help")end},
		{x=585,y=460,w=150,h=60,code=function()gotoScene("stat")end},
		{x=500,y=540,w=320,h=60,code=function()gotoScene("quit")end},
	},
	mode={
		{x=350,y=280,w=200,h=200,back={.82,.82,0},backS={.95,.95,0},code=function()gotoScene("stage")end},
		{x=650,y=280,w=200,h=200,back={.7,.7,.7},backS={.88,.88,.88},hide=function()return data.gameunlock==0 end,code=function()gotoScene("entertain")end},
		{x=500,y=520,w=350,h=80,code=function()gotoScene("main")end},
	},
	stage={
		{x=500,y=100,w=220,h=70,back={.3,.82,.3},backS={.3,.9,.5},code=function()startgame("tutorial")end},
		{x=500,y=200,w=220,h=70,back={1,.9,.5},backS={1,1,.5},code=function()startgame("normal")end},
		{x=400,y=300,w=180,h=70,back={.63,0,0},backS={.82,0,0},hide=function()return data.HARDlock end,code=function()startgame("hard")end},
		{x=600,y=300,w=180,h=70,back={.7,.5,1},backS={.75,.6,1},hide=function()return data.INFlock end,code=function()startgame("inf")end},
		{x=500,y=400,w=220,h=70,back={0,.5,1},backS={0,.65,1},hide=function()return data.EASIlock end,code=function()startgame("easi")end},
		{x=500,y=520,w=350,h=80,code=function()gotoScene("mode")end},
	},
	entertain={
		{x=260,y=120,w=100,h=70,back={0,.5,.9},backS={.5,.75,1},code=function()startgame("sprint")end},
		{x=380,y=120,w=100,h=70,back={0,.5,.9},backS={.5,.75,1},code=function()startgame("snake")end},
		{x=500,y=120,w=100,h=70,back={0,.5,.9},backS={.5,.75,1},code=function()startgame("pool")end},
		{x=620,y=120,w=100,h=70,back={0,.5,.9},backS={.5,.75,1},code=function()startgame("float")end},
		{x=740,y=120,w=100,h=70,back={0,.5,.9},backS={.5,.75,1},code=function()startgame("piano")end},
		{x=500,y=520,w=350,h=80,code=function()gotoScene("mode")end},
	},
	setting={
		{x=300,y=150,w=320,h=60,back={.9,.7,.5},backS={.95,.9,0},
			code=function()
				setting.sfx=not setting.sfx
				SFX("revive")
			end
		},
		{x=300,y=250,w=320,h=60,back={.9,.7,.5},backS={.95,.9,0},
			code=function()
				setting.bgm=not setting.bgm
				if setting.bgm then
					BGM("title")
				else
					bgm[bgmPlaying]:stop()
					bgmPlaying=nil
				end
			end
		},
		{x=700,y=150,w=320,h=60,back={.9,.7,.5},backS={.95,.9,0},
			code=function()
				setting.fullscreen=not setting.fullscreen
				love.window.setFullscreen(setting.fullscreen)
				if not setting.fullscreen then
					love.resize(gc.getWidth(),gc.getHeight())
				end
			end
		},
		{x=700,y=250,w=320,h=60,back={.9,.7,.5},backS={.95,.9,0},
			code=function()
				setting.lang=nextLanguage(setting.lang)
				setFont=fontLib[setting.lang]
				Text=Texts[setting.lang]
				currentFont=0
			end},
		{x=300,y=350,w=320,h=60,back={.9,.7,.5},backS={.95,.9,0},code=function()setting.mouseK=setting.mouseK%5+1 end},
		{x=700,y=350,w=320,h=60,back={.9,.7,.5},backS={.95,.9,0},code=function()setting.keyboardK=setting.keyboardK%5+1 end},
		{x=500,y=500,w=200,h=60,code=function()back()end},
	},
	help={
		{x=500,y=500,w=200,h=60,code=function()back()end},
	},
	stat={
		{x=500,y=500,w=200,h=60,code=function()back()end},
	},
	shop={
		{x=300,y=250,w=50,h=50,back={1,.38,.38},backS={1,.63,.63},hide=function()return sel==1 end,code=function()SFX("blip")sel=sel-1 end},--left
		{x=400,y=250,w=50,h=50,back={1,.38,.38},backS={1,.63,.63},hide=function()return sel==#skin[list]end,code=function()SFX("blip")sel=sel+1 end},--right
		{x=350,y=190,w=150,h=50,back={1,.38,.38},backS={1,.63,.63},hide=function()return list==1 end,code=function()SFX("blip2")list,sel,combo=list-1,1,0 end},--up
		{x=350,y=310,w=150,h=50,back={1,.38,.38},backS={1,.63,.63},hide=function()return list==#skin end,code=function()SFX("blip2")list,sel,combo=list+1,1,0 end},--down
		{x=400,y=400,w=240,h=50,hide=function()return data.skinAmount[list]==-2 end,code=function()
			if data.skinAmount[list]==-1 then
				if data.coin>=skinUnlockPrice[list]then
					data.coin=data.coin-skinUnlockPrice[list]
					data.skinAmount[list]=1
					data.skinS,data.skinT=list,sel
				end
			elseif data.skinAmount[list]>=0 then
				if data.coin>=skinPrice[list]then
					data.coin=data.coin-skinPrice[list]
					data.skinAmount[list]=data.skinAmount[list]+skinNum[list]
					if data.skinAmount[list]>999 then
						SFX("purchase_inf")
						data.skinAmount[list]=-2
					end
					combo=combo+1
					comboTime=min(comboTime+max(20-combo*.2,6),240)
					SFX("purchase")
					sfx.purchase_combo:setPitch(1+min(max(combo-10,0),50)*.06)
					SFX("purchase_combo")
				end
			end
		end},
		{x=620,y=400,w=140,h=50,hide=function()return int((data.skinAmount[list]+1)*.5)==0 end,code=function()if data.skinS~=list or data.skinT~=sel then data.skinS,data.skinT=list,sel;SFX("equip")end end},
		{x=500,y=500,w=200,h=60,code=function()back()end},
	},
	sel=nil--selected button Obj
}
img={
	title={
		eng=gc.newImage("/image/title/eng.png"),
		chi=gc.newImage("/image/title/chi.png"),
		chi2=gc.newImage("/image/title/chi.png"),
	},
	fish={
		shark={
			gc.newImage("/image/fish/shark.png"),
			gc.newImage("/image/fish/shark_wait.png"),
			gc.newImage("/image/fish/shark_dry.png"),
		},
		whale={
			gc.newImage("/image/fish/whale.png"),
			gc.newImage("/image/fish/whale_wait.png"),
			gc.newImage("/image/fish/whale_dry.png"),
		},
		octopus={
			gc.newImage("/image/fish/octopus.png"),
			gc.newImage("/image/fish/octopus_dry.png"),
		},
	},
	arrow={0,-150,100,-50,30,-50,30,150,-30,150,-30,-50,-100,-50},
}
sfx={
	"revive",
	"get",
	"cool1","cool2","cool3",
	"hit","hit_floor","hit_wall","hit_cell","hit_piano",
	"die",
	"bonuslife",

	"warning",
	"explode",
	"laser_hitwall","laser_kill",
	"snipper_kill",
	"pin_up",
	"laser_emit",
	"smash",
	"beat",
	"deathscreen",

	"invicible",
	"shield_break",
	"teleport",
	"teleport_back",
	"flip",
	"freeze",
	"eager",
	"magnet",
	"miss",
	"slow",
	"time_back",
	"gravity_down",
	"gravity_up",

	"shuttle",
	"flash",
	"deck",

	"blip","blip2",
	"purchase","purchase_combo","purchase_inf",
	"equip",
	"portal_1","portal_2","portal_enter","portal_close",
}
bgm={
	"title",
	"shop",
	"n",
	"h1","h2","h3",
	"l1","l2","l3",
	"e1","e2","e3","e4","e5","e6","ee",
	"inf","hide",
	"allclear_h","allclear_e",
}
ctSpeed={.004,.006,.008,.01,.015}
skinUnlockPrice={23333,100,100,300,150,600,800,900,1000,1000,1600,2500,2500,2500,4000,4000,5000,}
skinPrice={666,15,60,60,45,100,90,120,120,150,25,450,500,450,750,750,150,}
skinNum={26,5,10,5,5,5,5,10,10,10,1,30,25,20,5,5,10,}
skinSkill={"na","tp_r","freeze","tp_f","boost","inv","shield","back","tp_h","flip","dbl","atg","eager","magnet","portal","slow","miss",}
skillName={"tp_f","tp_r","flip","freeze","eager","magnet","slow","shield","portal","dbl","boost","miss","back","tp_h","atg","inv",}
pianoKey=string.splitS("6/#6/7/1/#1/2/#2/3/4/#4/5/#5/6/#6/7/1/#1/2/#2/3/")
ShdColor={{.5,.75,1,0},{.38,1,.7,0}}--[n][4] is alpha,a temp var!
coinColor={{1,1,0},{.82,.82,.82}}
buttonSelectedColor={.95,.7,.7}
buttonColor={.6,.8,1}

FX={
	teleport=function(x1,y1,x2,y2)
		if abs((y1-y2)/(x1-x2))<1 then
			for x=x1,x2,-25*sgn(x1-x2)do
				if g[1]and abs(x-g[1])<25 and abs(y1+(y2-y1)*(x-x1)/(x2-x1)-g[2])<25 then get()end
				ins(shade,{x=x,y=y1+(y2-y1)*(x-x1)/(x2-x1),pat=curSkin,ct=20*(x-x1)/(x2-x1)})
			end
		else
			for y=y1,y2,-25*sgn(y1-y2)do
				if g[1]and abs(x1+(x2-x1)*(y-y1)/(y2-y1)-g[1])<25 and abs(y-g[2])<25 then get()end
				ins(shade,{x=x1+(x2-x1)*(y-y1)/(y2-y1),y=y,pat=curSkin,ct=20*(y-y1)/(y2-y1)})
			end
		end
	end,
	shield=function(x,y)
		gc.setColor(0,.82,1,.35)
		gc.rectangle("fill",x-15,y-15,31,31)
	end,
	miss=function(x,y)
		step(p.x-12,p.y-12,curSkin)
		step(p.x+13,p.y-12,curSkin)
		step(p.x-12,p.y+13,curSkin)
		step(p.x+13,p.y+13,curSkin)
	end,
	slow=function()
		gc.setColor(0,.7,1,min(p.slow,25)*.01)
		gc.circle("fill",500,300,p.slow*10)
	end,
	magnet=function()
		gc.setColor(1,1,0,.6)
		gc.setLineWidth(8)
		gc.circle("line",p.x,p.y,p.magnet%30*4)
		gc.setLineWidth(2)
	end,
	arrow=function()
		local t=FX.arrow_t
		FX.arrow_t=t-sgn(t)
		if t==0 then p.arrow_t=nil end
		gc.setColor(1,0,0,abs(t)*.012)
		gc.translate(500,300-3*t)
		if t>0 then gc.scale(1,-1)end
		gc.polygon("fill",img.arrow)
		if t>0 then gc.scale(1,-1)end
		gc.translate(-500,3*t-300)
	end,
	backT=function()
		local i=p.backT
		gc.setLineWidth(5)
		gc.setColor(0,0,0,.15)
		gc.line(p.x,p.y,i[2],i[3])
		gc.setColor(0,0,0,(1-i[1]/60))
		gc.setLineWidth(2)
		local d=i[1]*.5
		gc.rectangle("line",i[2]-d,i[3]-d,2*d,2*d)
	end,
	backP=function()
		local i=p.backP
		gc.setColor(0,0,0)
		gc.line(i[2]-6,i[3],i[2]+6,i[3])
		gc.line(i[2],i[3]-6,i[2],i[3]+6)
	end,
	flash=0,--Black screen(frame)
	shake=0,--Screen shake(frame)
}
loadmode={
	tutorial=function()
		useBlock=false
		coinType="near"
		life=0
		p.eneK=2
		g[3],g[4],g[5],g[6]=nil
		BGM("n")
	end,
	normal=function()
		coinType="near"
		setTarget(15)
		curRate=1
		BGM("n")
	end,
	hard=function()
		setTarget(30)
		coinType="normal"
		curRate=3
		gravity=0
		p.vy=10
		obj.snipper={x=500,y=-100,v1=3,v2=.97,close=false,closeTime=0}
		obj.bombard={x=0,y=-150,r1=150,r2=150,ct=0,ct0=90}
		obj.lasergun={t=300,t0=300,mode=1}
		BGM("h1")
	end,
	inf=function()
		coinType="natural"
		curRate=1
		curBG="game2"
		BGM("inf")
	end,
	easi=function()
		collect=0
		coinType="natural"
		curRate=.8
		deadLine={26,26}
		freshCoin(true)
		setTarget(30)
		showText(Text.easi[0],nil,200,60,90)
		BGM("e1")
	end,

	sprint=function()
		useBlock=false
		coinType="natural"
		life=0
		p.eneK=0
		freshCoin(true)
		setTarget(40)
		BGM("e1")
	end,
	snake=function()
		coinType="natural"
		coinMode=2
		currencyDisp="cent"
		curRate=0
		obj.block={}
		ins(obj.task,{t=1,t0=1,loop=0,looptime=1e99,code=function()if p.alive then newBlockEnemy(p.x,p.y,15,15,10,10+collect)end end})
		BGM("l1")
	end,
	pool=function()
		coinType="normal"
		coinMode=2
		currencyDisp="cent"
		curRate=0
		obj.pool={ox=200,level=200,level0=200,h={},v={}}
		obj.fish={octopus=0}
		for i=0,100 do obj.pool.h[i],obj.pool.v[i]=0,0 end
		BGM("l1")
	end,
	float=function()
		coinType="normal"
		coinMode=2
		currencyDisp="cent"
		curRate=0
		obj.laser={x=500,r=120,auto=0,sd=1,cj=0}
		obj.bombard={x=0,y=-150,r1=150,r2=150,ct=0,ct0=120}
		obj.lasergun={t=1e99}
		obj.task={{t=30,t0=30,loop=0,looptime=1e99,code=function()
			ins(obj.lasergun,{20,120,1})
		end}}
		BGM("l2")
	end,
	piano=function()
		useBlock=false
		coinType="none"
		coinMode=2
		currencyDisp="none"
		curRate=0
		obj.piano={chord=0}
		if data.skinS==1 and data.skinT==3 then
			p={x=300,y=50,vx=0,vy=0,alive=true,inv=nil}
			p2={x=700,y=50,vx=0,vy=0}
			showText(Text.piano,500,140)
		end
		g={}
		BGM()
	end,
	vs=function()
		coinType="jump"
		useBlock=false
		curRate=0
		vsGet={0,0}
		p={x=300,y=50,vx=0,vy=0,alive=true,inv=nil}
		p2={x=700,y=50,vx=0,vy=0}
		BGM("n")
		showText(Text.vs[1],205,140)
		showText(Text.vs[2],790,140)
		curSkin=skin[1][1]
	end,
}
event_get={
	tutorial=function()
		if collect==1 then
			showText(Text.tutorial[1],nil,70,60)
			showText(Text.tutorial[2],nil,150,30)
		elseif collect==4 then
			showText(Text.tutorial[3],nil,nil,30)
		elseif collect==7 then
			freshCoin(true)freshCoin(true)
			showText(Text.tutorial[4],nil,nil,30)
		elseif collect==10 then
			showText(Text.tutorial[5],nil,nil,30)
		elseif collect==15 then
			bar=565
			showText(Text.tutorial[6],nil,nil,30)
		elseif collect==20 then
			showText(Text.tutorial[7],nil,nil,40)
			obj.bombard={x=p.x,y=p.y,r1=10,r2=0,ct=0,ct0=1}
			ins(obj.task,{t=24,code=function()obj.bombard=nil end})
		elseif collect==25 then
			showText(Text.tutorial[8],nil,nil,40)
			obj.laser=p.x>500 and{x=-70,r=50,v=1,sd=1}or{x=1070,r=50,v=-1,sd=1}
			SFX("warning")
			FX.shake=3
		elseif collect==35 then
			showText(Text.tutorial[9],nil,nil,40)
			obj.snipper=p.x>500 and{x=-50,y=-50,v1=2,v2=.993}or{x=1050,y=-50,v1=2,v2=.993}
			SFX("warning")
			FX.shake=3
		elseif collect==40 then
			showText(Text.tutorial[10],nil,nil,40)
			showText(Text.tutorial[11],nil,150,20)
			local i=max(data.skinS,2)
			p.skill=skinSkill[i],
			loadSkill[skinSkill[i]]()
		elseif collect==55 then
			obj.death={t=0,s=Text.tutorial[12]}
		end
	end,
	normal=function()
		if obj.laser and obj.laser.r<120 then
			local e=obj.laser
			e.v=e.v+(sgn(e.v)/15)
			e.r=e.r+1
		end
		if obj.snipper and collect<=100 then
			local e=obj.snipper
			e.v1,e.v2=2+collect/100,.99-collect*.0002
		end
		if obj.bombard and obj.bombard.ct0>90 then
			obj.bombard.ct0=obj.bombard.ct0-2
		end
		
		if collect==15 then
			setTarget(25)
			obj.laser=p.x>500 and{x=-70,r=70,v=1,sd=1}or{x=1070,r=70,v=-1,sd=1}
			SFX("warning")
			FX.shake=3
		elseif collect==40 then
			setTarget(35)
			obj.snipper=p.x>500 and{x=-50,y=-50,v1=2.4,v2=.982}or{x=1050,y=-50,v1=2.4,v2=.982}
			SFX("warning")
			FX.shake=3
		elseif collect==75 then
			setTarget(25)
			obj.bombard={x=0,y=-150,r1=150,r2=150,ct=0,ct0=150}
			SFX("warning")
			FX.shake=3
		elseif collect==100 then
			coinType="normal"
			setTarget(30)
			curRate=3
			gravity=0
			FX.arrow_t=-30
			obj.laser=nil
			obj.lasergun={t=1,t0=300,mode=1}
			FX.flash=2
			SFX("flash")
			BGM("h1")
			if data.HARDlock then
				data.HARDlock=false
				showText(Text.unlock.hard,500,200,70,150)
			end
		elseif collect>100 then
			event_get.hard(collect-100)
		end
	end,
	inf=function()
		if obj.laser and obj.laser.r<140 then
			local e=obj.laser
			e.v=e.v+(sgn(e.v)*.06)
			e.r=e.r+1
		end
		if obj.snipper and obj.snipper.v1<5 then
			local e=obj.snipper
			e.v1,e.v2=e.v1+.1,e.v2-.0003
		end
		if obj.lasergun and obj.lasergun.t0>90 then
			obj.lasergun.t0=obj.lasergun.t0-2
		end
		if obj.bombard and obj.bombard.ct0>80 then
			obj.bombard.ct0=obj.bombard.ct0-1
		end
		if obj.pin and obj.pin.t<200 then obj.pin.t=obj.pin.t+2 end
		
		if collect==5 then
			obj.laser=p.x>500 and{x=-70,r=80,v=1.5,sd=0}or{x=1070,r=80,v=-1.5,sd=0}
			SFX("warning")
			FX.shake=3
		elseif collect==10 then
			curRate=1.5
			obj.snipper=p.x>500 and{x=-50,y=-50,v1=2,v2=1}or{x=1050,y=-50,v1=2,v2=1}
			SFX("warning")
			FX.shake=3
		elseif collect==15 then
			obj.bombard={x=0,y=-150,r1=150,r2=150,ct=0,ct0=150}
			SFX("warning")
			FX.shake=3
		elseif collect==20 then
			curRate=2
			obj.pin={t=120}
			SFX("warning")
			FX.shake=3
		elseif collect==30 then
			curRate=3
			obj.lasergun={t=1,t0=180,mode=3}
			SFX("warning")
			FX.shake=3
		elseif collect==50 then
			curRate=4
		elseif collect==80 then
			curRate=5
		end
	end,
	hard=function(c)
		local collect=c or collect--diffrerent from normal
		if collect==30 then
			setTarget(30)
			curRate=4
			FX.flash=2
			gravity=1
			obj.blackhole={x=500,y=300}
			obj.laser,obj.snipper=nil
			obj.bombard.ct0=120
			show("excellent",true)
			BGM("h2")
			curBG="game2"
			if data.gameunlock==0 then
				data.gameunlock=1
				showText(Text.unlock.game1,500,200,50,100)
			end
		elseif collect==60 then
			setTarget(40)
			coinType="natural"
			curRate=5
			obj.snipper,obj.bombard,obj.blackhole=nil
			FX.arrow_t=30
			p.inv=20
			obj.lasergun.t=30
			obj.lasergun.t0=60
			obj.lasergun.mode=1
			FX.flash=2
			if data.EASIlock then
				data.EASIlock=false
				showText(Text.unlock.easi,500,200,70,100)
			end
			SFX("flash")
			BGM("h3")
		elseif collect>60 and collect<100 then
			if collect<80 then
				obj.lasergun.t0=140-collect
			elseif collect==80 then
				p.inv=30
				obj.blackhole={x=500,y=300}
				obj.camera={x=500,y=300}
				obj.lasergun.t0=120
				obj.lasergun.mode=4
			elseif collect<100 then
				obj.lasergun.t0=360-3*collect
				if collect==97 then coinType="none"end
			end
		elseif collect==100 then
			obj.lasergun=nil
			ins(obj.task,{t=90,code=function()if p.alive then gotoScene("allclear_h","flash")end end})
			ins(obj.task,{t=1,t0=20,loop=-2,looptime=5,code=function()if p.alive then FX.flash=2;FX.shake=5;SFX("flash")end end})
		end
	end,
	easi=function()
		if collect==30 then
			deadLine={gameTime+28,28}
			setTarget(30)
			curRate=3
			p.inv=30
			obj.snipper={x=p.x,y=p.y+.001,v1=5,v2=.96,close=false,closeTime=0}
			showText(Text.easi[1])
			show("excellent",true)
			BGM("e2")
			FX.flash=2
			if data.INFlock then
				data.INFlock=false
				showText(Text.unlock.inf,500,200,70,100)
			end
		elseif collect==60 then
			deadLine={gameTime+28,28}
			setTarget(30)
			obj.snipper=nil
			PTC.explode:reset()
			obj.shake={x=0,y=0,vx=0,vy=0,a=0,va=0}
			obj.pin={t=210}
			showText(Text.easi[2])
			show("excellent",true)
			BGM("e3")
			FX.flash=2
		elseif collect==90 then
			deadLine={gameTime+26,26}
			setTarget(30)
			obj.pin=nil
			curRate=3.5
			p.inv=30
			obj.sim={x=p.x,y=p.y,vx=-p.vx*.1,vy=-p.vy*.1}
			showText(Text.easi[3])
			show("excellent",true)
			BGM("e4")
			FX.flash=2
		elseif collect==120 then
			deadLine={gameTime+25,25}
			setTarget(30)
			obj.bombard=nil
			obj.sim=nil
			obj.bombard={x=0,y=-150,r1=150,r2=150,ct=0,ct0=36}
			showText(Text.easi[4])
			show("excellent",true)
			BGM("e5")
			FX.flash=2
		elseif collect==150 then
			deadLine={gameTime+16,16}
			setTarget(10)
			curRate=5
			obj.snipper={x=20,y=20,v1=4,v2=.96,close=false,closeTime=0}
			obj.pin={t=150}
			obj.sim={x=20,y=560,vx=0,vy=0}
			obj.bombard={x=980,y=560,r1=150,r2=150,ct=60,ct0=60}
			showText("E",100,0,200,30)
			showText("A",900,0,200,35)
			showText("S",100,350,200,40)
			showText("I",900,350,200,45)
			showText("Z",nil,70,350,60)
			p.slow=max(30,p.slow or 0)
			BGM("e6")
			FX.flash=1
			curBG="game3"
		elseif collect==156 then
			coinType=0
		elseif collect==160 then
			fullscreenPlay=true
			deadLine=nil
			curRate=0
			p.shield,p.scd,p.scd0=life>2,max(900-life*300,0),900
			p.coinK=0
			p.miss=0
			p.slow,p.magnet=nil
			p.skill="na"
			life=0
			resetEnemy()
			easiBegin()
			
			curBG="none"
			FX.flash=2
			SFX("flash")
			BGM("ee")
		end
	end,

	sprint=function()
		if collect==30 then
			coinType="jump"
		elseif collect==36 then
			coinType="none"
		elseif collect==40 then
			life=0
			die(true)
		end
	end,
	pool=function()
		if collect%10==0 then obj.pool.level0=rnd(200,400)end
		if collect%15==0 then
			local t=collect<=45 and collect/15 or rnd(obj.fish.octopus<3 and 3 or 2)
			if t==1 then
				ins(obj.fish,{t="shark",stat=1,x=rnd(5,995),y=-100,vx=0,vy=0})
			elseif t==2 then
				ins(obj.fish,{t="whale",stat=1,x=rnd(5,995),y=-100,vx=0,vy=0})
			elseif t==3 then
				ins(obj.fish,{t="octopus",stat=1,x=rnd(5,995),y=-100,vx=rnd(50,100)/50*(rnd(2)*2-3),vy=0})
				obj.fish.octopus=obj.fish.octopus+1
			end
		end
	end
}

loadSkill={
	na=function()end,--None
	inv=function()p.scd,p.scd0=0,540 end,--Invicible
	tp_r=function()p.scd,p.scd0=0,120 end,--Teleport randomly
	tp_f=function()p.scd,p.scd0=0,150 end,--Teleport forward
	tp_h=function()p.scd,p.scd0=0,90 end,--Teleport back
	flip=function()p.scd,p.scd0=0,180 end,--Flip speed
	freeze=function()p.scd,p.scd0=0,30 end,--Stop speed
	eager=function()p.scd,p.scd0=180,180 end,--Speed to coin
	slow=function()p.scd,p.scd0=300,600 end,--Slow time
	magnet=function()p.scd,p.scd0=300,900 end,--Absorb coin
	shield=function()p.shield,p.scd,p.scd0=false,0,1200 end,--Shield
	portal=function()p.scd,p.scd0=0,20 end,--Switch portals
	back=function()p.scd,p.scd0=150,150 end,--Create back point
	atg=function()p.scd,p.scd0=0,20 end,--Flip gravity
	dbl=function()p.coinK=2 end,--Double coin
	boost=function()p.eneK=1.6 end,--Boost energy
	miss=function()p.missK=.75 end,--75% Miss
}
skillList={
	inv=function()
		p.inv=40
		SFX("invicible")
	end,
	tp_r=function()
		local x,y
		repeat
			x,y=rnd(30,969),rnd(30,400)
		until abs(p.x-x)>300
		FX.teleport(p.x,p.y,x,y)
		p.x,p.y=x,y
		p.vy=-10
		FX.flash=2
		SFX("teleport")
	end,
	tp_f=function()
		local x,y,t=p.x,p.y,0
		while x<987 and x>12 and y<575 and y>12 and t<15 do
			x,y=x+p.vx,y+p.vy
			t=t+1
		end
		FX.teleport(p.x,p.y,x,y)
		p.x,p.y=x,y
		FX.shake=4
		SFX("teleport")
	end,
	tp_h=function()
		if p.backP then
			FX.shake=5
			step(p.x,p.y,curSkin)
			p.x,p.y=p.backP[2],p.backP[3]
			SFX("teleport_back")
			p.backP=nil
		else
			p.backP={180,p.x,p.y}
			return true
		end
	end,
	flip=function()
		p.vx,p.vy=-p.vx,-p.vy
		step(p.x,p.y,curSkin)
		FX.shake=3
		SFX("flip")
	end,
	freeze=function()
		p.vx,p.vy=0,0
		SFX("freeze")
	end,
	eager=function()
		if g[1]then
			local v=max((p.vx^2+p.vy^2)^.5,30)
			local a=atan((g[2]-p.y)/(g[1]-p.x))
			if g[1]>p.x then a=a+pi end
			p.vx,p.vy=-v*cos(a),-v*sin(a)
			FX.shake=2
			SFX("eager")
		else
			return true
		end
	end,
	slow=function()
		p.slow=150
		SFX("slow")
	end,
	magnet=function()p.magnet=180 end,
	shield=function()return true end,
	portal=function()
		p.portal=not p.portal
		if p.portal then SFX("portal_"..rnd(2))else SFX("portal_close")end
		FX.shake=4
	end,
	back=function()
		p.backT={60,p.x,p.y}
		SFX("time_back")
	end,
	atg=function()
		gravity=-gravity
		FX.arrow_t=gravity>0 and 30 or -30
		SFX(gravity>0 and"gravity_down"or"gravity_up")
	end,
}