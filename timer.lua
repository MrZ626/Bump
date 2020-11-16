Tmr={}
function Tmr.updateEnemies(dt)
	if obj.laser then
		local e=obj.laser
		if not e.auto then
			e.x=e.x+e.v
			if e.v>0 and e.x+e.r>1000 or e.v<0 and e.x-e.r<1 then e.v=-e.v;SFX("laser_hitwall")end
		elseif p.alive then
			e.x=e.x*e.auto+p.x*(1-e.auto)
		end
		PTC.laser:setPosition(rnd(int(e.x-e.r),int(e.x+e.r)),585)
		if rnd()<.5 then PTC.laser:emit(1)end
	end
	if obj.snipper then
		if p.alive then
			local e=obj.snipper
			local x,y=p.x,p.y
			local dX,dY=x-e.x,y-e.y
			if p.portal then
				if abs(x+1000-e.x)<abs(dX)then x=x+1000
				elseif abs(x-1000-e.x)<abs(dX)then x=x-1000
				end
			end
			dX,dY=x-e.x,y-e.y
			local A=atan(dY/dX)+(dX>0 and 0 or pi)
			e.x,e.y=e.x+e.v1*cos(A),e.y+e.v1*sin(A)
			e.x,e.y=x+(e.x-x)*e.v2,y+(e.y-y)*e.v2
			if p.portal then
				if e.x>999 then
					e.x=e.x-999
					SFX("portal_enter")
				elseif e.x<0 then
					e.x=e.x+1000
					SFX("portal_enter")
				end
			end
			if abs(dX)<22 and abs(dY)<22 then
				e.close=true
			else
				if e.close and not p.inv and abs(p.vx)>6 then
					Sget(50)
					show("cool",true)
					SFX("cool1")
				end
				e.close=false
			end
		else
			obj.snipper.x,obj.snipper.y=.98*obj.snipper.x+9,.98*obj.snipper.y-4
		end
	end
	if obj.bombard then
		local e=obj.bombard
		if e.ct>0 then
			e.ct=e.ct-1
			if e.ct==0 then
				SFX("explode")
				PTC.explode:setPosition(e.x,e.y)
				PTC.explode:emit(50)
			end
		elseif e.r1<150 then
			e.r1=e.r1+10
		elseif e.r2<150 then
			e.r2=e.r2+15
		elseif not e.once then
			if p.alive then
				e.x,e.y=p.x+rnd(-50,50),p.y+rnd(-50,50)
			else
				e.x,e.y=rnd(150,850),rnd(100,500)
			end
			e.r1,e.r2=0,0
			e.ct=e.ct0
		else
			obj.bombard=nil
		end
	end
	if obj.pin then
		for i=#obj.pin,1,-1 do
			local e=obj.pin[i]
			e.t=e.t-1
			if e.t<=0 then rem(obj.pin,i)end
		end
	end
	if obj.lasergun then
		local e=obj.lasergun
		e.t=e.t-1
		if e.t<=0 then
			if e.mode==4 then
				ins(e,{rnd(50,550),120,1})
				ins(e,{rnd(50,950),120,2})
			else
				local m=e.mode==3 and rnd(1,2)or e.mode
				ins(e,m==1 and{rnd(50,550),120,1}or m==2 and{rnd(50,950),120,2})
			end
			e.t=e.t0*rnd(85,115)*.01
		end
		for i=#e,1,-1 do
			e[i][2]=e[i][2]-1
			if e[i][2]==30 then
				if not p.inv and(e[i][3]==1 and abs(p.y-e[i][1])<59 or e[i][3]==2 and abs(p.x-e[i][1])<59)then die()end
				SFX("laser_emit")
			elseif e[i][2]==0 then
				rem(e,i)
			end
		end
	end
	if obj.sim then
		local e=obj.sim
		if p.alive then
			e.vx=max(min(e.vx+sgn(p.x-e.x)*.25,18),-15)
			e.vy=max(min(e.vy+sgn(p.y-e.y)*.25,18),-15)
		end
		e.x,e.y=e.x+e.vx,e.y+e.vy
		if p.portal then
			if e.x>999 then
				e.x=e.x-999
				step(0,e.y,skin[1][2])
				step(999,e.y,curSkin)
				SFX("portal_enter")
			elseif e.x<0 then
				e.x=e.x+1000
				step(0,e.y,skin[1][2])
				step(999,e.y,curSkin)
				SFX("portal_enter")
			end
			if e.vx>30 then e.vx=30
			elseif e.vx<-30 then e.vx=-30
			end
		else
			if e.x>987 then
				e.x,e.vx=987,-e.vx*.9
				SFX("hit")
			elseif e.x<12 then
				e.x,e.vx=12,-e.vx*.9
				SFX("hit")
			end
		end
		if e.y>575 then
			e.y,e.vy=575,-e.vy*.9
			SFX("hit")
		elseif e.y<12 then
			e.y,e.vy=12,-e.vy*.9
			SFX("hit")
		end
		ins(shade,{x=e.x,y=e.y,pat=skin[1][2],ct=8})
		if not p.inv and abs(p.x-e.x)<25 and abs(p.y-e.y)<25 then die()end
	end
	if obj.block then
		for i=#obj.block,1,-1 do
			local e=obj.block[i]
			if e.t1>0 then
				e.t1=e.t1-1
			elseif e.t2>0 then
				if not p.inv and p.alive and p.y+12>e.y-e.h*.5 and p.y-12<e.y+e.h*.5 and p.x+12>e.x-e.w*.5 and p.x-12<e.x+e.w*.5 then die()end
				e.t2=e.t2-1 if e.t2==0 then rem(obj.block,i)end
			end
		end
	end
	if obj.beat then
		for i=#obj.beat,1,-1 do
			local e=obj.beat[i]
			if e.stat==1 then
				e.t=e.t-1
				if e.t==0 then
					if p.alive and not p.inv then
						FX.teleport(p.x,p.y,e.x,e.y)
						SFX("teleport")
						die()
					end
					e.stat,e.t=2,0
				elseif e.t<15 then
					if e.t==10 then SFX("warning",.5)end
					if(p.x-e.x)^2+(p.y-e.y)^2<500 then
						e.stat,e.t=2,0
						SFX("beat")
					end
				end
			elseif e.stat==2 then
				e.t=e.t+1
				if e.t==15 then
					rem(obj.beat,i)
				end
			end
		end
	end

	if obj.blackhole then
		local e=obj.blackhole
		local dx,dy=p.x-e.x,p.y-e.y
		local d=max((dx^2+dy^2)^.5,30)
		p.vx=p.vx-dx/d^1.3*5*gravity
		p.vy=p.vy-dy/d^1.3*5*gravity
		PTC.blackhole:setPosition(e.x,e.y)
	end
	if obj.pool then
		local e=obj.pool
		if p.alive then
			if p.y>e.level then
				p.vx,p.vy=p.vx*.97,p.vy*.97
				p.vy=p.vy-1.4
				e.ox=max(e.ox-1,0)
				if e.ox==0 then Eget(-5)end
			else
				e.ox=min(e.ox+3,200)
			end
			if abs(p.y-e.level)<13 and abs(p.vy)>5 then
				local c=int(p.x/10)
				for x=c-2,c+2 do
					if x>1 and x<99 then
						e.v[x]=e.v[x]+p.vy*2/(10+abs(c-x))
					end
				end
			end
		end

		e.level=e.level0*.03+e.level*.97
		for i=1,99 do
			e.h[i]=e.h[i]+e.v[i]
			e.v[i]=(e.v[i]+(e.h[i-1]+e.h[i+1]-e.h[i]*2)*.1)*.9
		end
	end
	if obj.fish then
		local water=obj.pool and obj.pool.level or 600
		for i=1,#obj.fish do
			local e=obj.fish[i]
			if e.y>water then
				if e.t=="shark"then
					if p.alive and(p.x-e.x)^2+(p.y-e.y)^2<400^2 then
						e.vx=max(min(e.vx+sgn(p.x-e.x)*.5,10),-10)
						e.vy=max(min(e.vy+sgn(p.y-e.y)*.5,10),-10)
						e.vx,e.vy=e.vx*.95,e.vy*.95
						e.stat=1
					else
						e.stat=2
					end
				elseif e.t=="whale"then
					if p.alive then
						e.vx=max(min(e.vx+sgn(p.x-e.x)*.2,8),-8)
						e.vy=max(min(e.vy+sgn(p.y-e.y)*.2,8),-8)
						e.stat=1
					else
						e.stat=2
					end
				elseif e.t=="octopus"then
					if p.alive and(p.x-e.x)^2+(p.y-e.y)^2<150^2 then
						e.vx=max(min(e.vx+sgn(p.x-e.x),15),-15)
						e.vy=max(min(e.vy+sgn(p.y-e.y),15),-15)
						e.vx,e.vy=e.vx*.9,e.vy*.9
					end
				end
			else
				e.vy=e.vy+.5
			end
			e.x,e.y=e.x+e.vx,e.y+e.vy
			if abs(e.vx)>3 then e.vx=e.vx-sgn(e.vx)*.1 end
			if abs(e.vy)>3 then e.vy=e.vy-sgn(e.vy)*.1 end
			if e.x>987 then
				e.x,e.vx=987,-e.vx
			elseif e.x<12 then
				e.x,e.vx=12,-e.vx
			end
			if e.y>575 then
				e.y,e.vy=575,-e.vy
			end
			if not p.inv and abs(p.x-e.x)<25 and abs(p.y-e.y)<25 then die()end
		end
	end
	if obj.death then
		local e=obj.death
		if e.t<587 then e.t=e.t+1 end
		if e.t>p.y-12 then Eget(-5)end
	end

	if obj.shake then
		local e=obj.shake
		e.x,e.y,e.a=e.x+e.vx,e.y+e.vy,e.a+e.va
		e.vx,e.vy,e.va=e.vx*.8-e.x/10,e.vy*.8-e.y/10,e.va*.8-e.a/10
	end
	if obj.camera then
		local e=obj.camera
		if p.alive then
			e.x,e.y=e.x*.95+p.x*.05,e.y*.95+p.y*.05
		else
			e.x,e.y=e.x*.95+500*.05,e.y*.95+300*.05
		end
	end
	if obj.progressBar then
		local e=obj.progressBar
		e.h=e.h*.85+(collect-e.from)/e.target*300*.15
	end

	for i=#obj.text,1,-1 do
		local e=obj.text[i]
		e.ct=e.ct-1
		if e.ct==0 then rem(obj.text,i)end
	end
	for i=#obj.task,1,-1 do
		local e=obj.task[i]
		e.t=e.t-1
		if e.t==0 then
			e.code(e.looptime)
			if e.loop then
				e.t0=e.t0+e.loop
				e.t=e.t0
				e.looptime=e.looptime-1
				if e.looptime==0 then
					rem(obj.task,i)
				end
			else
				rem(obj.task,i)
			end
		end
	end
end
function Tmr.load(dt)
	if loading==1 then
		loadnum=loadnum+1
		loadprogress=loadnum*.1
		if loadnum==5 then
			--require("load_texture")
		elseif loadnum==10 then
			loadnum=1
			loading=2
		end
	elseif loading==2 then
		if loadnum<=#bgm then
			bgm[bgm[loadnum]]=love.audio.newSource("/BGM/bgm_"..bgm[loadnum]..".ogg","stream")
			bgm[bgm[loadnum]]:setLooping(true)
			loadprogress=loadnum/#bgm
			loadnum=loadnum+1
		else
			bgm.e6:setLooping(false)
			bgm.ee:setLooping(false)
			--Extra bgm load
			for i=1,#bgm do bgm[i]=nil end
			loading=3
			loadnum=1
		end
	elseif loading==3 then
		if loadnum<=#sfx then
			sfx[sfx[loadnum]]=love.audio.newSource("/SFX/"..sfx[loadnum]..".ogg","static")
			loadprogress=loadnum/#sfx
			loadnum=loadnum+1
		else
			sfx.piano={n=1}for i=1,16 do sfx.piano[i]=sfx.hit_piano:clone()end
			--Extra sound load
			for i=1,#sfx do sfx[i]=nil end
			loading=4
			loadnum=1
			SFX("blip2")
		end
	elseif loading==4 then
		loadnum=loadnum+1
		if loadnum==30 then
			gotoScene("intro","none")
		end
	end
	if loading<4 then for i=1,20 do
		PTC.bar_load:setPosition(200+loadprogress*600+rnd(-5,5),rnd(280,320))
		PTC.bar_load:emit(1)
	end end
	PTC.bar_load:update(dt)
end
function Tmr.intro(dt)
	count=count+1
	y,v=y+v,v+.2
	if y>300 then
		SFX("laser_hitwall",v*.08)
		y,v=300,min(-5,-v*.6)
		for i=1,60 do
			PTC.title_hit:setPosition(rnd(250,700),385)
			PTC.title_hit:emit(1)
		end
	end
	PTC.title_hit:update(dt)
end
function Tmr.shop(dt)
	h,v=h+v,v-.5
	if h<0 then
		h,v=0,6+rnd(8)
		SFX("hit")SFX("hit_floor")
	end
	if comboTime>0 then
		comboTime=comboTime-1
		if comboTime==0 then combo=0 end
	end
end
function Tmr.play(dt)if ttt then ttt=ttt+1 end
	if pause>0 then
		pause=pause-1
		if pause==0 and bgmPlaying then bgm[bgmPlaying]:play()end
		return nil
	end
	if not focus then return nil end
	if p.alive and pause==0 then stat.gametime,gameTime=stat.gametime+dt,gameTime+dt end

	local X,Y,ax,ay=0,0,0,0
	if p.alive and not p2 and kb.isDown("up","down","left","right","w","s","a","d")then
		local k
		if kb.isDown("up","w")then Y=Y-100 end
		if kb.isDown("down","s")then Y=Y+100 end
		if kb.isDown("left","a")then X=X-100 end
		if kb.isDown("right","d")then X=X+100 end
		ax,ay=X*ctSpeed[setting.keyboardK],Y*ctSpeed[setting.keyboardK]
		ax,ay=max(min(ax,3),-3),max(min(ay,3),-3)
		p.vx,p.vy=p.vx+ax,p.vy+ay
	end
	mx1,my1=mx1*.8+ax*250*.2,my1*.8+ay*250*.2
	if p2 then
		if kb.isDown("up","w")then Y=Y-120 end
		if kb.isDown("down","s")then Y=Y+120 end
		if kb.isDown("left","a")then X=X-120 end
		if kb.isDown("right","d")then X=X+120 end
		ax,ay=max(min(X*ctSpeed[setting.keyboardK],3),-3),max(min(Y*ctSpeed[setting.keyboardK],3),-3)
		p2.vx,p2.vy=p2.vx+ax,p2.vy+ay
	end
	if setting.bgm and bgmPlaying then bgm[bgmPlaying]:setPitch(max(p.alive and(p.slow and(p.slow>130 and 1-(150-p.slow)*.005 or p.slow>20 and .9 or 1-p.slow*.005)or 1)or ct/70,.0001))end

	if cbt>0 then cbt=cbt*.997 end
	if sc1<sc then sc1=int(.95*sc1+.05*sc)end
	if sc1<sc then sc1=sc1+1 end
	bar1=.8*bar1+.2*bar
	cbt1=.9*cbt1+.1*cbt
	if p2 then
		Pmove()
		P2move()
	elseif p.alive then
		Pmove()
		if p.scd>0 then p.scd=p.scd-1 end
		if p.inv then
			p.inv=p.inv-1
			if p.inv==0 then
				p.inv=nil
			end
		end
		if p.slow then
			p.slow=p.slow-1
			if p.slow==0 then p.slow=nil end
		end
		if p.backT then
			p.backT[1]=p.backT[1]-1
			if p.backT[1]==0 then
				step(p.x,p.y,curSkin)
				p.x,p.y=p.backT[2],p.backT[3]
				FX.shake=5
				p.backT=nil
			end
		end
		if p.backP then
			p.backP[1]=p.backP[1]-1
			if p.backP[1]==0 then
				p.backP=nil
			end
		end
		if p.magnet then
			if p.magnet%30==0 then SFX("magnet")end
			if g[1]then
				local d=((g[2]-p.y)^2+(g[1]-p.x)^2)^.5
				if d<250 then
				local a=atan((g[2]-p.y)/(g[1]-p.x))
					if g[1]>p.x then a=a+pi end
					g[1]=g[1]+(250-d)^.5*cos(a)
					g[2]=g[2]+(250-d)^.5*sin(a)
				end
				p.magnet=p.magnet-1 if p.magnet==0 then p.magnet=nil end
			end
		end
		if p.shield==false then
			if p.scd==0 then p.shield=true end
		end
	else
		deathCounter=deathCounter-1
		if deathCounter==0 then
			if life>0 then
				revive()
			else
				gotoScene("result","swipe")
			end
		end
	end
	if deadLine and gameTime>deadLine[1]then
		g={}
		resetEnemy()
		obj.death={t=0,s=Text.easi.deadLine}
		SFX("deathscreen")
		SFX("flash")
		deadLine=nil
		FX.shake=10
		FX.flash=3
	end
	Tmr.updateEnemies(dt)
	--Game

	for i=#shade,1,-1 do
		shade[i].ct=shade[i].ct-1
		if shade[i].ct<=0 then rem(shade,i)end
	end
	for i=#bonus,1,-1 do
		bonus[i][4]=bonus[i][4]-1
		if bonus[i][4]==0 then rem(bonus,i)end
	end
	for i=#light,1,-1 do
		local l=light[i]
		l[3]=l[3]+1
		if l[3]==20 then rem(light,i)end
	end
	if dieFX[3]<30 then dieFX[3]=dieFX[3]+1 end
	if p.portal or p.portal==false then
		PTC.portal1:update(dt)
		PTC.portal2:update(dt)
	end
	PTC.laser:update(dt)
	PTC.explode:update(dt)
	PTC.blackhole:update(dt)
	--FXs
end
function Tmr.allclear_h(dt)
	time=time+1
	if time==3300 then gotoScene("main","deck")end
	ms.setPosition(ww*.5,wh*.5)
end
function Tmr.allclear_e(dt)
end