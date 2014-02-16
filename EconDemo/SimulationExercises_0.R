#Loading the source code
source("sfc3.0_0.R")

#############################
#PLAYING WITH THE PARAMETERS#
#############################

#Loading a non full model
sim_nf<-sfc.model("sim_non_full.txt",modelName="sim")
sim_nf<-sfc.check(sim_nf,fill=T)

#Loading the model
sim<-sfc.model("sim.txt",modelName="sim")

#Simulation 1
ptm <- proc.time()
data1<-simulate(sim)
print(paste("Elapsed time is ",proc.time()[3]-ptm[3],"seconds"))

#Simulation 2
ptm <- proc.time()
data2<-simulate(sim,tolValue = 1e-3)
print(paste("Elapsed time is ",proc.time()[3]-ptm[3],"seconds"))

#Simulation 3
ptm <- proc.time()
data3<-simulate(sim, maxIter=10)
print(paste("Elapsed time is ",proc.time()[3]-ptm[3],"seconds"))

#Observing the results of the three simulations
round(t(data1$baseline[c(1,2,20,40,66),c("g","y","t","yd","c","h","h_c")]),digits=3)
round(t(data2$baseline[c(1,2,20,40,66),c("g","y","t","yd","c","h","h_c")]),digits=3)
round(t(data3$baseline[c(1,2,20,40,66),c("g","y","t","yd","c","h","h_c")]),digits=3)

#Loading model SIMEX
simex<-sfc.model("simex.txt",modelName="simex")

#Checking the structure of the model
print(sim)
print(simex)

#Simulation of SIMEX
ptm <- proc.time()
dataex<-simulate(simex,tolValue = 1e-10)
print(paste("Elapsed time is ",proc.time()[3]-ptm[3],"seconds"))

#Observing the results of the three simulations
round(t(data1$baseline[c(1,2,20,40,66),c("iter block 1")]),digits=3)
round(t(data2$baseline[c(1,2,20,40,66),c("iter block 1")]),digits=3)
round(t(data3$baseline[c(1,2,20,40,66),c("iter block 1")]),digits=3)
round(t(dataex$baseline[c(1,2,20,40,66),c("iter block 1","iter block 2","iter block 3","iter block 4","iter block 5","iter block 6")]),digits=3)


##########################
#Updating SIMEX into PCEX#
##########################

#1. Editting excitsting equations
pcex<-sfc.editEqus(simex,list(
list(var="yd",eq="y-t+r(-1)*bh(-1)"),
list(var="t",eq="theta*(y+r(-1)*bh(-1))"),
list(var="c",eq="alpha1*yde+alpha2*v(-1)"),
list(var="h",eq="v-bh",desc="cash holding"),
list(var="h_c",eq="h(-1)+bcb-bcb(-1)",desc="hidden equation")))

#2. Removing the Labor demand equation
pcex<-sfc.rmEqu(pcex,var="n")

#3. Adding new equations
pcex<-sfc.addEqus(pcex,list(
list(var="h_d",eq="ve-bh",desc="expected cash holding"),
list(var="v",eq="v(-1)+yd-c",desc="households wealth"),
list(var="ve",eq="v(-1)+yde-c",desc="expected households wealth"),
list(var="bs",eq="bs(-1)+g+r(-1)*bs(-1)-t-r(-1)*bcb(-1)",desc="Supply of bonds"),
list(var="bcb",eq="bs-bh",desc="Bonds held by the central bank"),
list(var="r",eq="r(-1)",desc="Interest rate"),
list(var="bh",eq="ve*(lambda0+lambda1*r-lambda2*yde/ve)",desc="Bonds held by housholds")))

#4. Adding variables
pcex<-sfc.addVars(pcex,list(
list(var="lambda0",init=0.635,desc="Portfolio choice parameter"),
list(var="lambda1",init=5,desc="Portfolio choice parameter"),
list(var="lambda2",init=0.01,desc="Portfolio choice parameter")))

#5. Setting initial values 
pcex<-sfc.editEnds(pcex,list(
list(var="v",init=0.1),
list(var="r",init=0.035),
list(var="bh",init=0)))

pcex<-sfc.editEnds(pcex,list(
list(var="bs",init=0),
list(var="bcb",init=0)))

#6. Checking wether the model is complete
pcex<-sfc.check(pcex)

#Simulates PCEX
datapcex<-simulate(pcex)


#Plots Wealth, Consumption, Disposable income and GDP
plot(pcex$time,datapcex$baseline[,"h"],type="l",xlab="",ylab="",ylim=range(datapcex$baseline[,c("h","c","yd","y")],na.rm=T))
lines(pcex$time,datapcex$baseline[,"c"],lty=2)
lines(pcex$time,datapcex$baseline[,"yd"],lty=3)
lines(pcex$time,datapcex$baseline[,"y"],lty=4)

##############################
#ADDING THE MAASTRICHT TREATY#
##############################

#!. Rational Government
#Computing the targeted tax rate --- init is the last value of the baseline... and so you start from this steady state and see what happens when you introduce a new tax rate.
init <- datapcex$baseline[66,]
alpha1<-0.6
alpha2<-0.4
alpha<-(1-alpha1)/alpha2
r<-0.035
lambda0<-0.635
lambda1<-5
lambda2<-0.01
lambda<-lambda0+lambda1*r
M<-0.6
newTheta <- (alpha/M+r*(lambda*alpha-lambda2)-1)/(alpha/M+r*(lambda*alpha-lambda2))

#Adding a scenario
pcex<-sfc.addScenario(pcex,c("theta"),c(newTheta),c(1960),c(2010),init)

#Simulation
datapcex<-simulate(pcex)

#Plots the results
layout(matrix(c(1,2),1,2))
layout.show(2)
plot(pcex$time,datapcex$scenario_1[,"v"]/datapcex$scenario_1[,"y"],type="l",xlab="",ylab="",xlim=range(pcex$time),main="Debt to GDP")

plot(pcex$time,datapcex$scenario_1[,"y"],type="l",xlab="",ylab="",xlim=range(pcex$time),ylim=range(datapcex$scenario_1[,c("c","yd","y")],na.rm=T))
lines(pcex$time,datapcex$scenario_1[,"c"],lty=2)
lines(pcex$time,datapcex$scenario_1[,"yd"],lty=3)
legend(x=1970,y=110,legend=c("GDP","Consumption","Disposable Income"),lty=c(1,2,3),bty="n")


#2. A (somewhat) Rational Government --- what if we have the govt increase spending at like 3% per year...
#Updating the model to a growth government expenditure model
pcexgr<-sfc.addEqu(pcex,"g","g(-1)*(1+grg)","government expenditures")
pcexgr<-sfc.editVar(pcexgr,var="theta",init=newTheta)
pcexgr<-sfc.addScenario(pcexgr,list(c("grg")),list(c(0.03)),1960,1982,init)
pcexgr<-sfc.check(pcexgr)

pcexgr<-sfc.addVars(pcexgr,list(
list(var="grg",init=0,desc="Exogenous Growth Rate of Govt Spending")))

#Simulation
datapcex2<-simulate(pcexgr)

#Plots the results
layout(matrix(c(1,2),1,2))
layout.show(2)
plot(pcexgr$time[2:66],(datapcex2$scenario_2[2:66,"v"]-datapcex2$scenario_2[1:65,"v"])/datapcex2$scenario_2[2:66,"y"],type="l",xlab="",ylab="",xlim=range(pcexgr$time),main="Deficit to GDP")

plot(pcexgr$time,datapcex2$scenario_2[,"y"],type="l",xlab="",ylab="",xlim=range(pcexgr$time),ylim=range(datapcex2$scenario_2[,c("c","yd","y")],na.rm=T))
lines(pcexgr$time,datapcex2$scenario_2[,"c"],lty=2)
lines(pcexgr$time,datapcex2$scenario_2[,"yd"],lty=3)
legend(x=1965,y=110,legend=c("GDP","Consumption","Disposable Income"),lty=c(1,2,3),bty="n")

#3. A (more) Rational Government

#Updating the model to endogenous tax rate model
theta<-0.2
pcexgr2<-sfc.addEqu(pcex,"g","g(-1)*(1+grg)","government expenditures")
pcexgr2<-sfc.addVar(pcexgr2,var="grg",init=0,desc="Government expenditure growth")
pcexgr2<-sfc.addVar(pcexgr2,var="dtheta",init=0,desc="Tax rate variation")
pcexgr2<-sfc.addScenario(pcexgr2,list(c("grg","dtheta")),list(c(0.03,(newTheta-theta)/24)),1960,1982,init)
pcexgr2<-sfc.check(pcexgr2)

#Simulation
datapcex3<-simulate(pcexgr2)

#Plots the results
layout(matrix(c(1,2),1,2))
layout.show(2)
plot(pcexgr$time[2:66],(datapcex3$scenario_2[2:66,"v"]-datapcex3$scenario_2[1:65,"v"])/datapcex3$scenario_2[2:66,"y"],type="l",xlab="",ylab="",xlim=range(pcexgr$time),main="Deficit to GDP")

plot(pcexgr$time,datapcex3$scenario_2[,"y"],type="l",xlab="",ylab="",xlim=range(pcexgr$time),ylim=range(datapcex3$scenario_2[,c("c","yd","y")],na.rm=T))
lines(pcexgr$time,datapcex3$scenario_2[,"c"],lty=2)
lines(pcexgr$time,datapcex3$scenario_2[,"yd"],lty=3)
legend(x=1965,y=110,legend=c("GDP","Consumption","Disposable Income"),lty=c(1,2,3),bty="n")

##############
#MODEL INSOUT#
##############

#Loading the model from EViews
insout<-sfc.eviews("gl10insout_0.prg","insout")

#Simulation
datainsout<-simulate(insout,tolValue=10e-20)

#Adding the relevant equations
insout<-sfc.addEqus(insout,list(
list(var="z8",equ="(psbr(-1)>mas*y)",desc="Whether there's a deficit or not"),
list(var="g_k",equ="g_k(-1)*(1-z8)+z8(p(-1)*g_k(-1)-z8*psbr(-1)/2/p)",desc="Government spending if you exceed a maastricht threshold"),
list(var="tau",equ="(tau(-1)/(1+tau(-1))+z8*psbr(-1)/(2*s(-1)))/(1-tau(-1)/(1+tau(-1))+z8*psbr(-1)/(2*s(-1)))",desc="")))

#Adding the variables
insout<-sfc.addVars(insout,list(list(var="mas",init=Inf,desc="The limit to the deficit")))

#Adding the initial values
insout<-sfc.editEnds(insout,list(list(var="s",init=datainsout$baseline["2010","s"]),list(var="psbr",init=0)))

#Checking the model
insout<-sfc.check(insout)

#Simulation
datainsout<-simulate(insout,tolValue=10e-20)

#Getting the initial values
init<-datainsout$baseline[66,]

#Adding the scenarios
insout<-sfc.addScenario(insout,list(c("omega0"),c(...)),list(c(0),c(...)),c(1960,1960),c(2010,2010),init)

#simulation
datainsout<-simulate(insout,tolValue=10e-20)


#Plotting the results
layout(matrix(c(1,2,3,4),2,2))
layout.show(4)


#Figure 10.6A
timeline=seq(from=1955,to=2010)
plot(timeline,datainsout$scenario_2[as.character(timeline),"pi"]-datainsout$baseline[as.character(timeline),"pi"],type="l",xlab="",ylab="",lty=1)
lines(timeline,datainsout$scenario_1[as.character(timeline),"pi"]-datainsout$baseline[as.character(timeline),"pi"],lty=2)
legend(x=1960,y=0.005,legend=c("Inflation rate - M.","Inflation rate"),lty=c(1,2),bty="n")

#Figure 10.6B
timeline=seq(from=1955,to=2010)
plot(timeline,datainsout$scenario_2[as.character(timeline),"y_k"],type="l",xlab="",ylab="",lty=1,ylim=range(datainsout$scenario_2[as.character(timeline),c("y_k","s_k")]))
lines(timeline,datainsout$scenario_2[as.character(timeline),"s_k"],lty=2)
lines(timeline,datainsout$scenario_1[as.character(timeline),"y_k"],lty=3)
lines(timeline,datainsout$scenario_1[as.character(timeline),"s_k"],lty=4)
legend(x=1975,y=135,legend=c("Real output - M.","Real sales - M.","Real output","Real sales"),lty=c(1,2,3,4),bty="n")

#Figure 10.6C
timeline=seq(from=1955,to=2010)
plot(timeline,datainsout$scenario_2[as.character(timeline),"psbr"]/datainsout$scenario_2[as.character(timeline),"p"],type="l",xlab="",ylab="",lty=1,ylim=range(c(datainsout$scenario_2[as.character(timeline),"psbr"]/datainsout$scenario_2[as.character(timeline),"p"],datainsout$scenario_1[as.character(timeline),"psbr"]/datainsout$scenario_1[as.character(timeline),"p"])))
lines(timeline,datainsout$scenario_1[as.character(timeline),"psbr"]/datainsout$scenario_1[as.character(timeline),"p"],type="l",lty=2)
legend(x=1970,y=1.3,legend=c("Deflated PSBR - M","Deflated PSBR"),lty=c(1,2),bty="n")

#Figure 10.6D
timeline=seq(from=1956,to=2010)
timeline_lag=seq(from=1955,to=2009)
plot(timeline,(-datainsout$scenario_2[as.character(timeline),"psbr"]+(datainsout$scenario_2[as.character(timeline),"p"]-datainsout$scenario_2[as.character(timeline_lag),"p"])*(datainsout$scenario_2[as.character(timeline_lag),"b_s"]+datainsout$scenario_2[as.character(timeline_lag),"bl_s"]*datainsout$scenario_2[as.character(timeline_lag),"p_bl"]))/datainsout$scenario_2[as.character(timeline),"p"],type="l",xlab="",ylab="",lty=1)
lines(timeline,(-datainsout$scenario_1[as.character(timeline),"psbr"]+(datainsout$scenario_1[as.character(timeline),"p"]-datainsout$scenario_1[as.character(timeline_lag),"p"])*(datainsout$scenario_1[as.character(timeline_lag),"b_s"]+datainsout$scenario_1[as.character(timeline_lag),"bl_s"]*datainsout$scenario_1[as.character(timeline_lag),"p_bl"]))/datainsout$scenario_1[as.character(timeline),"p"],lty=2)
legend(x=1970,y=3.1,legend=c("Real deficit - M.","Real deficit"),lty=c(1,2),bty="n")
