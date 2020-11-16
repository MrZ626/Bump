local n=0
local c=function(i,j)
	skin[i][j]=gc.newCanvas(25,25)
	gc.setCanvas(skin[i][j])
end
local cc=function(num,s)
	for i=1,num do
		c(n,i)
		gc.draw(gc.newImage("/image/skin/"..s.."/"..i..".png"))
	end
	n=n+1
end
skin={{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},{},}
c(1,1)gc.setColor(1,0,0)gc.rectangle("fill",0,0,25,25)
c(1,2)gc.setColor(0,1,0)gc.rectangle("fill",0,0,25,25)
c(1,3)gc.setColor(0,0,1)gc.rectangle("fill",0,0,25,25)

c(2,1)
for i=0,24 do
	gc.setColor(.6+rnd()*.4,rnd()*.5,rnd()*.5)
	gc.rectangle("fill",i%5*5,5*int(i/5),5,5)
end
c(2,2)
gc.setColor(1,0,0)gc.rectangle("fill",0,0,25,25)
for i=1,30 do
	gc.setColor(rnd(),rnd(),rnd())
	gc.line(rnd(-10,39),rnd(-10,39),rnd(-10,39),rnd(-10,39))
end
c(2,3)
gc.setColor(1,0,0)gc.rectangle("fill",0,0,25,25)
for i=1,40 do
	gc.setColor(1,.3+rnd()*.4,.3+rnd()*.4,.3+rnd()*.4)
	gc.circle("line",rnd(0,24),rnd(0,24),rnd(7))
end

n=3
gc.setColor(1,1,1)
cc(3,"glass")
cc(4,"pure")
cc(4,"aurora")
cc(1,"east")
cc(7,"mc")
cc(4,"strange")
cc(1,"war")
cc(6,"art")
cc(3,"costly")
cc(3,"dark")
cc(4,"drink")
cc(5,"crystle")
cc(2,"technology")
cc(6,"book")
c(17,1)c(17,2)c(17,3)
n=18


c(4,5)
for i=12,1,-1 do
	gc.setColor(1,1-.06*i,255-.06*i)
	gc.rectangle("fill",12-i,12-i,2*i+1,2*i+1)
end

skill_icon={}
for k,v in ipairs(skillName)do
	skill_icon[v]=gc.newImage("/image/skill_icon/"..v..".png")
end

c=gc.newCanvas(101,10)gc.setCanvas(c)
gc.setColor(1,0,0)
for i=0,9 do
	gc.polygon("fill",i*10,10,i*10+5,0,i*10+10,10)
end
img.pin=c

PTC={}
c=gc.newCanvas(5,5)gc.setCanvas(c)
gc.clear(1,0,0)
PTC.laser=gc.newParticleSystem(c,50)
PTC.laser:setParticleLifetime(.3,.5)
PTC.laser:setEmissionRate(0)
PTC.laser:setLinearAcceleration(-100,-400,100,-700)
PTC.laser:setLinearDamping(1,1)
PTC.laser:setColors(255,255,255,255,255,255,255,0)
--Laser particles

c=gc.newCanvas(7,7)gc.setCanvas(c)
gc.clear(.88,.75,0)
PTC.explode=gc.newParticleSystem(c,50)
PTC.explode:setParticleLifetime(.6,1)
PTC.explode:setEmissionRate(0)
PTC.explode:setLinearAcceleration(-2000,-2000,2000,2000)
PTC.explode:setLinearDamping(2,2)
PTC.explode:setColors(255,255,255,255,255,255,255,0)
--Explosion particles

c=gc.newCanvas(5,5)gc.setCanvas(c)
gc.clear(0,0,0)
PTC.blackhole=gc.newParticleSystem(c,100)
PTC.blackhole:setParticleLifetime(.6,1)
PTC.blackhole:setEmissionRate(60)
PTC.blackhole:setLinearAcceleration(-200,-200,200,200)
PTC.blackhole:setLinearDamping(1,1)
PTC.blackhole:setColors(255,255,255,255,255,255,255,0)
--Blackhole particles

c=gc.newCanvas(5,5)gc.setCanvas(c)
gc.clear(0,.63,1)
PTC.portal1=gc.newParticleSystem(c,30)
PTC.portal1:setParticleLifetime(.2,.3)
PTC.portal1:setEmissionRate(0)
PTC.portal1:setLinearAcceleration(500,0,1500,0)
PTC.portal1:setLinearDamping(1,0)
PTC.portal1:setColors(255,255,255,255,255,255,255,0)
c=gc.newCanvas(5,5)gc.setCanvas(c)
gc.clear(1,.75,0)
PTC.portal2=gc.newParticleSystem(c,30)
PTC.portal2:setParticleLifetime(.2,.3)
PTC.portal2:setEmissionRate(0)
PTC.portal2:setLinearAcceleration(-500,0,-1500,0)
PTC.portal2:setLinearDamping(1,0)
PTC.portal2:setColors(255,255,255,255,255,255,255,0)
--Portals

c=gc.newCanvas(7,7)gc.setCanvas(c)
gc.setColor(1,.7,0)
gc.circle("fill",3,3,3)
PTC.bar_load=gc.newParticleSystem(c,50)
PTC.bar_load:setParticleLifetime(.2,.4)
PTC.bar_load:setEmissionRate(0)
PTC.bar_load:setLinearAcceleration(-500,-500,500,500)
PTC.bar_load:setLinearDamping(0,0)
PTC.bar_load:setColors(255,255,255,255,255,255,255,0)
--Loading bar

c=gc.newCanvas(6,6)gc.setCanvas(c)
gc.clear(1,.7,0)
PTC.title_hit=gc.newParticleSystem(c,70)
PTC.title_hit:setParticleLifetime(.2,.4)
PTC.title_hit:setEmissionRate(0)
PTC.title_hit:setLinearAcceleration(-700,300,700,500)
PTC.title_hit:setLinearDamping(0,0)
PTC.title_hit:setColors(255,255,255,255,255,255,255,0)
--Loading bar

gc.setCanvas()
