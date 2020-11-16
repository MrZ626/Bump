function leftLaser(n)for i=1,n do ins(obj.lasergun,{50*i-25,120,2})end end
function rightLaser(n)for i=21-n,20 do ins(obj.lasergun,{50*i-25,120,2})end end
function midLaser(n)for i=11-n,10+n do ins(obj.lasergun,{50*i-25,120,2}) end end
function upLaser(n)for i=1,n do ins(obj.lasergun,{50*i-25,120,1})end end
function downLaser(n)for i=13-n,12 do ins(obj.lasergun,{50*i-25,120,1})end end

cmd={
	{
		{t=36,code=function()
			leftLaser(8)
			rightLaser(8)
		end},
		{t=50,code=function()
			ins(obj.beat,{x=500,y=570,stat=1,t=82})
			ins(obj.beat,{x=500,y=570,stat=1,t=123})
		end},
		{t=116,code=function()
			midLaser(5)
		end},
		{t=196,code=function()
			upLaser(4)
			downLaser(4)
		end}
	},
	{
		{t=1,code=function()
			for i=0,1 do
				ins(obj.beat,{x=100+600*i,y=570,stat=1,t=81+42*i})
			end
		end},
		{t=165,code=function()
			for i=0,1 do
				ins(obj.beat,{x=900-600*i,y=570,stat=1,t=81+42*i})
			end
		end},
		{t=72-60,code=function()
			obj.bombard={x=850,y=150,r1=0,r2=0,ct=60,ct0=60,once=true}
		end},
		{t=113,code=function()
			obj.bombard={x=150,y=150,r1=0,r2=0,ct=1,ct0=1,once=true}
		end},
		{t=235-60,code=function()
			obj.bombard={x=150,y=150,r1=0,r2=0,ct=60,ct0=60,once=true}
		end},
		{t=276,code=function()
			obj.bombard={x=850,y=150,r1=0,r2=0,ct=1,ct0=1,once=true}
		end},
		{t=294,t0=10,loop=0,looptime=8,code=function()
			ins(obj.lasergun,{p.x+rnd(-30,30),120,2})
		end},
		{t=389,code=function()
			ins(obj.beat,{x=200,y=20,stat=1,t=82})
			ins(obj.beat,{x=100,y=570,stat=1,t=102})
		end},
		{t=455,t0=10,loop=0,looptime=8,code=function()
			ins(obj.lasergun,{p.x+rnd(-30,30),120,2})
		end},
		{t=389+164,code=function()
			ins(obj.beat,{x=800,y=20,stat=1,t=82})
			ins(obj.beat,{x=900,y=570,stat=1,t=102})
		end}
	},
	{
		{t=1,t0=7,loop=0,looptime=3,code=function(t)
			ins(obj.lasergun,{250-t*70,120,1})
		end},
		{t=82,t0=7,loop=0,looptime=3,code=function(t)
			ins(obj.lasergun,{340+t*70,120,1})
		end},
		{t=164,t0=7,loop=0,looptime=4,code=function(t)
			ins(obj.lasergun,{750-t*180,120,2})
		end},
		{t=222,code=function(t)
			ins(obj.beat,{x=120,y=570,stat=1,t=82})
		end},
		{t=246,t0=7,loop=0,looptime=4,code=function(t)
			ins(obj.lasergun,{240+t*180,120,2})
		end},
		{t=304,code=function(t)
			ins(obj.beat,{x=880,y=570,stat=1,t=82})
		end},
	},
	{
		{t=1,code=function()
			obj.block={}
			SFX("warning")
			newBlockEnemy(300,300,600,600,82,200,"Author:MrZ",80)
		end},
		{t=14,code=function(t)
			ins(obj.beat,{x=800,y=570,stat=1,t=82})
			ins(obj.beat,{x=980,y=250,stat=1,t=102})
			ins(obj.beat,{x=800,y=20,stat=1,t=122})
			ins(obj.beat,{x=750,y=570,stat=1,t=142})
		end},
		{t=14+162,code=function(t)
			ins(obj.beat,{x=750,y=570,stat=1,t=82})
			ins(obj.beat,{x=750,y=20,stat=1,t=122})
		end},
		{t=1+82*4,code=function()
			SFX("warning")
			newBlockEnemy(700,300,600,600,82,200,"Design:MrZ",80)
		end},
		{t=14+81*4,code=function(t)
			ins(obj.beat,{x=200,y=570,stat=1,t=82})
			ins(obj.beat,{x=20,y=250,stat=1,t=102})
			ins(obj.beat,{x=200,y=20,stat=1,t=122})
			ins(obj.beat,{x=250,y=570,stat=1,t=142})
		end},
		{t=14+81*6,code=function(t)
			ins(obj.beat,{x=250,y=570,stat=1,t=82})
			ins(obj.beat,{x=250,y=20,stat=1,t=122})
		end},
		{t=655,code=function()
			gravity=1
			SFX("gravity_down")
		end},
	},
	{
		{t=1,t0=82,loop=0,looptime=2,code=function()
			upLaser(4)
			downLaser(4)
			leftLaser(8)
			rightLaser(8)
		end},
		{t=165,code=function()
			rightLaser(18)
		end},
		{t=247,code=function()
			leftLaser(18)
		end},
	},
}

function easiBegin()--p.inv,ttt=9999,0-;gravity=0
	obj.beat,obj.lasergun={},{t=1e99}

	ins(obj.task,cmd[1][1])--Laser 1
	ins(obj.task,cmd[1][2])--Beat 1.1

	ins(obj.task,cmd[1][3])--Laser 2
	ins(obj.task,cmd[1][4])--Laser 3

	ins(obj.task,{t=335,code=function()
		ins(obj.task,cmd[2][1])--Beats 2.1
		ins(obj.task,cmd[2][2])--Beats 2.2
		ins(obj.task,cmd[2][3])--Boom 1.1
		ins(obj.task,cmd[2][4])--Boom 1.2
		ins(obj.task,cmd[2][5])--Boom 2.1
		ins(obj.task,cmd[2][6])--Boom 2.2
		ins(obj.task,cmd[2][7])--Laser follow 1
		ins(obj.task,cmd[2][8])--Beats 3.1
		ins(obj.task,cmd[2][9])--Laser follow 2
		ins(obj.task,cmd[2][10])--Beats 3.2
	end})

	ins(obj.task,{t=930,code=function()
		ins(obj.task,cmd[3][1])--Laser swipe h1
		ins(obj.task,cmd[3][2])--Laser swipe h2
		ins(obj.task,cmd[3][3])--Laser swipe v1
		ins(obj.task,cmd[3][4])--Beats 1
		ins(obj.task,cmd[3][5])--Laser swipe v2
		ins(obj.task,cmd[3][6])--Beats 2
	end})
	ins(obj.task,{t=1305,code=function()
		gravity=0.1
		SFX("gravity_up")
		ins(obj.task,cmd[4][1])
		ins(obj.task,cmd[4][2])--Beats 1
		ins(obj.task,cmd[4][3])--Beats 2

		ins(obj.task,cmd[4][4])
		ins(obj.task,cmd[4][5])--Beats 1
		ins(obj.task,cmd[4][6])--Beats 2
		ins(obj.task,cmd[4][7])
	end})
	ins(obj.task,{t=2035,code=function()
		ins(obj.task,cmd[5][1])
		ins(obj.task,cmd[5][2])
		ins(obj.task,cmd[5][3])
	end})
end