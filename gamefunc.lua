function gotoScene(s,style)
	if not sceneSwaping and s~=scene then
		style=style or"shuttle"
		sceneSwaping={
			tar=s,style=style,
			time=swap[style][1],mid=swap[style][2],
			draw=swap[style].d
		}
		if style~="none"then SFX(style)end
	end
end
function startgame(m)
	gamemode=m
	dieFX={0,0,50}--Death FX
	gotoScene("play","flash")
end
function back()
	local t=prevMenu[scene]
	if type(t)=="string"then
		gotoScene(t)
	else
		t()
	end
end

function setTarget(tar)
	if not obj.progressBar then
		obj.progressBar={h=0}
	end
	obj.progressBar.from=collect
	obj.progressBar.target=tar
end
function resetEnemy()
	obj={
		text={},
		task={},
	}
end
function newBlockEnemy(x,y,w,h,t1,t2,text,font)
	ins(obj.block,{x=x,y=y,w=w,h=h,t1=t1,t2=t2,t10=t1,t20=t2,text=text,font=font})
end
function restart()
	fullscreenPlay=nil
	gravity=1
	coinRec={500,200,-999,-999,-999,-999}
	coinType="normal"--Generate mode
	coinMode=1--Getting mode
	mx1,my1=0,0--Displaying Mouse
	deathCounter=0--Death Counter

	endTime=nil
	resScore=nil
	--Result data

	life=1
	p,p2={
		x=500,y=50,vx=0,vy=0,
		alive=true,inv=90,

		coinK=1,
		eneK=1,
		missK=0,

		slow=nil,
		magnet=nil,
		shield=nil,

		scd=0,scd0=0,
		skill=skinSkill[data.skinS],
	}--Player
	loadSkill[p.skill]()
	sc,sc1=0,0--Score
	g={500,200}--Coins
	freshCoin(true)freshCoin(true)--Standard 2 Nexts
	shade={}--Hit wall FX
	light={type=1}--Eat target FX
	bonus={}--Bonus FX
	collect=0--Total collect
	cbt,cbt1=0,0--Combo time remain
	bar,bar1=0,0--Energy
	gameTime=0
	resetEnemy()
	deadLine=nil
	curBG="game1"
	useBlock=true
	if loadmode[gamemode]then loadmode[gamemode]()end
	if useBlock then
		curSkin=skin[data.skinS][data.skinT]
		local a,d=data.skinAmount,data.skinS
		if a[d]>0 then
			a[d]=a[d]-1
			if a[d]==10 then
				showText(Text.lowRemain[1],nil,200,25,60)
			elseif a[d]==3 then
				showText(Text.lowRemain[2],nil,200,25,60)
			elseif a[d]==0 then
				data.skinS,data.skinT=1,1
			end
		end
	else
		curSkin=skin[1][1]
		curRate=0
		p.coinK=1
		p.miss=0
		p.slow,p.magnet,p.shield=nil
		p.scd,p.scd0=0,0
		p.skill="na"
	end
	for k,v in pairs(PTC)do v:reset()end--Paricles reset
	collectgarbage()
	SFX("revive")
end
function revive()
	if life>0 then
		life=life-1
		p.inv=90
		deathCounter=0
		p.alive=true
		p.x,p.y,p.vx,p.vy=500,gravity==0 and 300 or 50,0,0
		mx1,my1=0,0
		if obj.pool then obj.pool.ox=300 end
		SFX("revive")
	end
end
function die(force)
	if p.alive then
		if not force then
			if p.shield then
				p.shield=false
				p.scd=p.scd0
				p.inv=12
				SFX("shield_break")
				return nil
			end
			if rnd()<p.missK then
				p.inv=12
				SFX("miss")
				FX.miss(p.x,p.y)
				return nil
			end
		else
			if p.shield then
				p.shield=false
				SFX("shield_break")
			end
		end
		if obj.laser then obj.laser.cj=0 end
		p.alive,p.slow,p.magnet,p.backT,p.backP=false
		sfx.time_back:stop()
		sfx.deathscreen:stop()
		if p.portal then skillList.portal()end
		gravity=abs(gravity)
		cbt=0
		dieFX={p.x,p.y,0}
		deathCounter=70

		if life==0 then
			bar=0
			endTime=0--Ending timer
			resScore=sc--Rolling score display
			data.coin=data.coin+int(sc/50)
			stat.game=stat.game+1
			if fullscreenPlay then
				fullscreenPlay=nil
				obj.task={}
			end--Reset EASI Ending
		end

		SFX("die")
		stat.die=stat.die+1
		FX.shake=6
		return true
	end
end
function step(x,y,pat)
	ins(shade,{x=x,y=y,pat=pat,ct=30})
	if obj.shake then
		local e=obj.shake
		if p.x==12 then
			e.vx=e.vx-p.vx/4
			e.va=e.va+p.vx*(p.y-300)/1000000
		elseif p.x==987 then
			e.vx=e.vx-p.vx/4
			e.va=e.va+p.vx*(p.y-300)/1000000
		end
		if p.y==574 then
			e.vy=e.vy-p.vy/5
			e.va=e.va-p.vy*(p.x-500)/1000000
		elseif p.y==12 then
			e.vy=e.vy-p.vy/3
			e.va=e.va-p.vy*(p.x-500)/500000
		end
	end
	SFX("hit")
end
function freshCoin(ifnew)
	if not ifnew then rem(g,1)rem(g,1)end
	local x,y
	if coinType=="none"then
		return nil
	elseif coinType=="near"then
		while true do
			x,y=rnd(100,800),rnd(80,480)
			local d=((x-coinRec[1])^2+(y-coinRec[2])^2)^.5
			if d>200 and(rnd()<.04 or d<400)then break end
		end
	elseif coinType=="normal"then
		repeat
			x,y=rnd(80,920),rnd(80,480)
			local d=((x-coinRec[1])^2+(y-coinRec[2])^2)^.5
		until d>300 and d<700
	elseif coinType=="natural"then
		repeat
			local d=1e4
			x,y=rnd(80,920),rnd(80,480)
			for i=1,5,2 do
				d=min(d,((x-coinRec[i])^2+(y-coinRec[i+1])^2)^.5)
			end
		until d>220
	elseif coinType=="jump"then
		repeat
			local d=1e4
			x,y=rnd(80,920),rnd(80,480)
			for i=1,3,2 do
				d=min(d,((x-coinRec[i])^2+(y-coinRec[i+1])^2)^.5)
			end
		until d>300
	end
	ins(g,x)ins(g,y)
	ins(coinRec,1,y)ins(coinRec,1,x)
	rem(coinRec)rem(coinRec)
end
function get()
	if not p2 then
		collect=collect+1
		local e=10+cbt*.0125
		Eget(e)
		Sget(2*e)
		cbt=min(cbt+80,800)
		stat.collect=stat.collect+p.coinK
		if coinMode==1 then
			data.coin=data.coin+p.coinK
		elseif coinMode==2 then
			data.cent=data.cent+p.coinK
		end
	end
	ins(light,{g[1],g[2],0,coinMode})
	freshCoin()
	if event_get[gamemode]then event_get[gamemode]()end

	SFX("get")
end
function Sget(s)
	s=int(s*curRate)
	if s~=0 then
		sc=sc+s
		show("+"..s)
	end
end
function Eget(x)
	bar=bar+x*p.eneK
	if bar>=600 then
		if life<4 then
			bar=bar-600
			life=life+1
			show("life",true)
			SFX("bonuslife")
		else
			bar=600
		end
	elseif bar<0 then
		if life>0 then
			life=life-1
			bar=600
		else
			die(true)
		end
	end
end
function Pmove()
	for i=0,2 do
		p.x,p.y=p.x+p.vx/3,p.y+p.vy/3
		if not obj.blackhole then
			p.vx,p.vy=p.vx*.9933,p.vy+gravity/3
		end
		local hit
		if p.portal then
			if p.x>999 then
				p.x=p.x-999
				step(0,p.y,curSkin)
				step(999,p.y,curSkin)
				SFX("portal_enter")
			elseif p.x<0 then
				p.x=p.x+1000
				step(0,p.y,curSkin)
				step(999,p.y,curSkin)
				SFX("portal_enter")
			end
			if p.vx>50 then p.vx=50
			elseif p.vx<-50 then p.vx=-50
			end
		else
			if p.x>987 then
				p.x,p.vx=987,min(-p.vx*.8,-2)
				hit=true
			elseif p.x<12 then
				p.x,p.vx=12,max(-p.vx*.8,2)
				hit=true
			end
			if hit and gamemode~="piano"then SFX("hit_wall")end
		end
		if p.y>574 then
			p.y,p.vy=574,-.9*p.vy
			hit=true
			if obj.laser and not p.inv then
				local e=obj.laser
				local d=abs(p.x-e.x)-e.r+12
				if d>0 or e.sd>0 then
					if d<=0 then e.sd,p.vy=e.sd-1,-1+1.5*p.vy;SFX("shield_break")end
					if not(p.inv or e.auto)and d<25 and d>0 and abs(p.vx-e.v)>10 and abs(p.vy)>12 then
						e.cj=e.cj+1
						if e.cj==1 then
							Sget(100)
							show("cool",true)
							SFX("cool1")
						else
							if e.sd<2 then e.sd=e.sd+1 end
							Sget(180)
							show("nice",true)
							SFX(e.cj==2 and"cool2"or"cool3")
						end
					else
						e.cj=0
					end--Hole-stepping cool
				else
					if not p.inv and die()then SFX("laser_kill")end
					hit=nil
				end
			end
			if obj.pin then
				local cool
				if not p.inv then
					for i=1,#obj.pin do
						if obj.pin[i].t>10 then
							local d=abs(obj.pin[i].x-p.x)
							if d<62 then die()hit=nil
							elseif abs(p.vx)>10 and d<70 then
								Sget(80)
								show("nice",true)
								SFX("cool2")
								obj.pin[i].t=20
								cool=true
							end
						end
					end
				end
				if p.alive and not cool then
					ins(obj.pin,{x=p.x-p.x%10,t=obj.pin.t})
					SFX("pin_up")
				end--Avoid create pin after death or cool jump
			end
			if gamemode=="piano"then
				local k=int(p.x*.02)-3
				if p.vy>-30 then
					hitPiano(k)
				else
					hitPiano(k+4)
					hitPiano(k-5+2*obj.piano.chord)
					p.vy=p.vy*.7
				end
			else
				SFX("hit_floor")
			end
		elseif p.y<12 then
			p.y,p.vy=12,max(-p.vy*(gravity>0 and .5 or .9),3)
			hit=true
			if gamemode~="piano"then SFX("hit_cell")else p.vy=0;obj.piano.chord=1-obj.piano.chord end
		end
		if g[1]and abs(p.x-g[1])<25 and abs(p.y-g[2])<25 then
			get()
			if gamemode=="vs"then vsGet[1]=vsGet[1]+1 end
		end
		if hit then step(p.x,p.y,curSkin)end
		if not p.inv then
			if obj.snipper and abs(obj.snipper.x-p.x)<13 and abs(obj.snipper.y-p.y)<13 then if die()then SFX("snipper_kill")end end
			if obj.bombard and obj.bombard.ct==0 and abs(obj.bombard.x-p.x)<12+obj.bombard.r1 and abs(obj.bombard.y-p.y)<12+obj.bombard.r1 then die()end
		end
	end
	if p.inv then ins(shade,{x=p.x,y=p.y,pat=curSkin,ct=10})end
end
function P2move()
	for i=0,2 do
		p2.x,p2.y=p2.x+p2.vx/3,p2.y+p2.vy/3
		p2.vx,p2.vy=p2.vx*.9933,p2.vy+1/3
		local hit
		if p2.x>987 then
			p2.x,p2.vx=987,-p2.vx*.8
			hit=true
		elseif p2.x<12 then
			p2.x,p2.vx=12,-p2.vx*.8
			hit=true
		end
		if hit and gamemode~="piano"then SFX("hit_wall")end
		if p2.y>574 then
			p2.y,p2.vy=574,-.9*p2.vy
			hit=true
			if gamemode=="piano"then
				local k=int(p2.x*.02)-3
				if p2.vy>-30 then
					hitPiano(k)
				else
					hitPiano(k+4)
					hitPiano(k-5+2*obj.piano.chord)
					p2.vy=p2.vy*.7
				end
			else
				SFX("hit_floor")
			end
		elseif p2.y<12 then
			p2.y,p2.vy=12,max(-p2.vy*.6,0)
			hit=true
			if gamemode~="piano"then SFX("hit_cell")else p2.vy=0;obj.piano.chord=1-obj.piano.chord end
		end
		if g[1]and abs(p2.x-g[1])<25 and abs(p2.y-g[2])<25 then get()vsGet[2]=vsGet[2]+1 end
		if hit then step(p2.x,p2.y,skin[1][3])end
	end
end
function hitPiano(key)
	local i=sfx.piano.n
	sfx.piano.n=i%16+1
	sfx.piano[i]:setPitch(2^(key/12))
	sfx.piano[i]:play()
end