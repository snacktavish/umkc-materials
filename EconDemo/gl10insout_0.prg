' MODEL INSOUT for Eviews version 5.1
' from Wynne Godley & Marc Lavoie
' MONETARY ECONOMICS
' Chapter 10

' This program creates model INSOUT, described in chapter 10, and simulates the model
' to produce a baseline

' ****************************************************************************
' Copyright (c) 2006 Gennaro Zezza
' Permission is hereby granted, free of charge, to any person obtaining a 
' copy of this software and associated documentation files (the "Software"),
' to deal in the Software without restriction, including without limitation
' the rights to use, copy, modify, merge, publish, distribute, sublicense, 
' and/or sell copies of the Software, and to permit persons to whom the 
' Software is furnished to do so, subject to the following conditions:
' 
' The above copyright notice and this permission notice shall be included in 
' all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
' FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
' IN THE SOFTWARE.
' ****************************************************************************

' Create a workfile, naming it INSOUT, to hold annual data from 1945 to 2010

wfcreate(wf=insout, page=annual) a 1945 2010

' Creates and documents series
series a_d
a_d.displayname Demand for Central bank advances from commercial banks
series a_s
a_s.displayname Supply of Central bank advances to commercial banks
series b_bd
b_bd.displayname Government bills demanded by commercial banks
series b_bdn
b_bdn.displayname Notional demand for government bills from commercial banks
series b_cb
b_cb.displayname Government bills held by Central bank
series b_hd
b_hd.displayname Demand for government bills
series b_hh
b_hh.displayname Government bills held by households
series b_s
b_s.displayname Supply of government bills
series bl_d
bl_d.displayname Demand for government bonds
series bl_h
bl_h.displayname Government bonds held by households
series bl_s
bl_s.displayname Supply of government bonds
series blr
blr.displayname Gross bank liquidity ratio
series blr_n
blr_n.displayname Net bank liquidity ratio
series bpm
bpm.displayname Banks’ profit margin
series c_k
c_k.displayname Real consumption
series cg
cg.displayname Capital gains on government bonds
series cons
cons.displayname Consumption at current prices
series er_rbl
er_rbl.displayname Expected rate of return on long term bonds
series f
f.displayname Realized profits of firms and banks
series f_b
f_b.displayname Realized banks profits
series f_cb
f_cb.displayname Central bank “profits”
series f_f
f_f.displayname Realized firms profits
series f_f_e
f_f_e.displayname Expected profits of firms
series g
g.displayname Government expenditures
series g_k
g_k.displayname Real government expenditures
series h_bd
h_bd.displayname Cash required by banks
series h_bs
h_bs.displayname Cash supplied to banks
series h_hd
h_hd.displayname Households demand for cash
series h_hh
h_hh.displayname Cash held by households
series h_hs
h_hs.displayname Cash supplied to households
series h_s
h_s.displayname Total supply of cash
series in
in.displayname Stock of inventories at current costs
series in_k
in_k.displayname Real inventories
series in_k_e
in_k_e.displayname Expected real inventories
series in_k_t
in_k_t.displayname Target level of real inventories
series l_d
l_d.displayname Demand for loans
series l_s
l_s.displayname Supply of loans
series m1_d
m1_d.displayname Checking deposits held by households
series m1_h
m1_h.displayname Checking deposits held by households
series m1_hn
m1_hn.displayname Notional holdings of checking deposits
series m1_s
m1_s.displayname Checking deposits supplied by banks
series m2_d
m2_d.displayname Demand for term deposits - constrained to be non-negative
series m2_d2
m2_d2.displayname Demand for term deposits - notional
series m2_h
m2_h.displayname Term deposits held by households
series m2_s
m2_s.displayname Term deposits supplied by banks
series n
n.displayname Employment level
series n_fe
n_fe.displayname Full Employment level
series nhuc
nhuc.displayname Normal historic unit costs
series omegat
omegat.displayname Target real wage for workers
series p
p.displayname Price level
series p_bl
p_bl.displayname Price of government bonds
series pi
pi.displayname Price inflation
series pr
pr.displayname Labour productivity
series psbr
psbr.displayname Government deficit
series r_a
r_a.displayname Interest rate on Central bank advances
series r_b
r_b.displayname Interest rate on government bills
series r_b_bar
r_b_bar.displayname Interest rate on bills - set exogenously
series r_bl
r_bl.displayname Interest rate on bonds
series r_bl_bar
r_bl_bar.displayname Interest rate on bonds - set exogenously
series r_l
r_l.displayname Interest rate on loans
series r_m
r_m.displayname Interest rate on deposits
series ra2
ra2.displayname Random shock to expectations on disposable income
series rr_b
rr_b.displayname Real interest rate on bills
series rr_bl
rr_bl.displayname Real interest rate on long term bonds
series rr_l
rr_l.displayname Real interest rate on loans
series rr_m
rr_m.displayname Real interest rate on term deposits
series s
s.displayname Sales at current prices
series s_k
s_k.displayname Real sales
series s_k_e
s_k_e.displayname Expected real sales
series sigmas
sigmas.displayname Realized inventories to sales ratio
series sigmat
sigmat.displayname Target inventories to sales ratio
series t
t.displayname Taxes
series uc
uc.displayname Unit costs
series v
v.displayname Wealth of households
series v_e
v_e.displayname Expected households wealth
series v_k
v_k.displayname Real wealth of households
series v_nc
v_nc.displayname Wealth of households, net of cash
series v_nc_e
v_nc_e.displayname Expected wealth of households, net of cash
series w
w.displayname Wage rate
series wb
wb.displayname The wage bill
series y
y.displayname Output at current prices
series y_k
y_k.displayname Real output
series yd_r
yd_r.displayname Regular disposable income
series yd_r_e
yd_r_e.displayname Expected regular disposable income
series yd_hs
yd_hs.displayname Haig-Simons measure of disposable income
series yd_k_hs
yd_k_hs.displayname Haig-Simons measure of real disposable income
series yd_k_r
yd_k_r.displayname Regular real disposable income
series yd_k_r_e
yd_k_r_e.displayname Expected regular real disposable income

' Generate parameters
series alpha0
alpha0.displayname Autonomous consumption
series alpha1
alpha1.displayname Propensity to consume out of income
series alpha2
alpha2.displayname Propensity to consume out of wealth
series beta
beta.displayname Parameter in expectation formations on real sales
series bot
bot.displayname Bottom value for bank net liquidity ratio
series botpm
botpm.displayname Bottom value for bank profit margin
series eps
eps.displayname Parameter in expectation formations on real disposable income
series gamma
gamma.displayname Speed of adjustment of inventories to the target level
series lambda10
lambda10.displayname Parameter in households demand for deposits
series lambda11
lambda11.displayname Parameter in households demand for deposits
series lambda12
lambda12.displayname Parameter in households demand for deposits
series lambda13
lambda13.displayname Parameter in households demand for deposits
series lambda14
lambda14.displayname Parameter in households demand for deposits
series lambda15
lambda15.displayname Parameter in households demand for deposits
series lambda20
lambda20.displayname Parameter in households demand for time deposits
series lambda21
lambda21.displayname Parameter in households demand for time deposits
series lambda22
lambda22.displayname Parameter in households demand for time deposits
series lambda23
lambda23.displayname Parameter in households demand for time deposits
series lambda24
lambda24.displayname Parameter in households demand for time deposits
series lambda25
lambda25.displayname Parameter in households demand for time deposits
series lambda30
lambda30.displayname Parameter in households demand for bills
series lambda31
lambda31.displayname Parameter in households demand for bills
series lambda32
lambda32.displayname Parameter in households demand for bills
series lambda33
lambda33.displayname Parameter in households demand for bills
series lambda34
lambda34.displayname Parameter in households demand for bills
series lambda35
lambda35.displayname Parameter in households demand for bills
series lambda40
lambda40.displayname Parameter in households demand for bonds
series lambda41
lambda41.displayname Parameter in households demand for bonds
series lambda42
lambda42.displayname Parameter in households demand for bonds
series lambda43
lambda43.displayname Parameter in households demand for bonds
series lambda44
lambda44.displayname Parameter in households demand for bonds
series lambda45
lambda45.displayname Parameter in households demand for bonds
series lambdac
lambdac.displayname Parameter in households demand for cash
series phi
phi.displayname Mark-up on unit costs
series ro1
ro1.displayname Reserve requiremente parameter
series ro2
ro2.displayname Reserve requiremente parameter
series sigma0
sigma0.displayname Parameter determining the target inventories to sales ratio
series sigma1
sigma1.displayname Parameter linking the target inventories to sales ratio to the interest rate
series tau
tau.displayname Sales tax rate
series top
top.displayname Top value for bank net liquidity ratio
series toppm
toppm.displayname Top value for bank profit margin
series z1
z1.displayname Is one if bank checking accounts are non-negative
series z2
z2.displayname Is one if  bank checking accounts are negative
series z3
z3.displayname Is one if  banks net liquidity ratio is below bottom level
series z4
z4.displayname Is one if  banks net liquidity ratio was below bottom level
series z5
z5.displayname Is one if  banks net liquidity ratio was above top level
series z6
z6.displayname Is one if  banks profit margin is below bottom level
series z7
z7.displayname Is one if  banks profit margin is above top level
series xib
xib.displayname Parameter in the equation for setting interest rate on deposits
series xil
xil.displayname Parameter in the equation for setting interest rate on loans
series xim
xim.displayname Parameter in the equation for setting interest rate on deposits
series omega0
omega0.displayname Parameter influencing the target real wage for workers
series omega1
omega1.displayname Parameter influencing the target real wage for workers
series omega2
omega2.displayname Parameter influencing the target real wage for workers
series omega3
omega3.displayname Speed of adjustment of wages to target value

' Set sample size to all workfile range
smpl @all

' Assign values for
'   PARAMETERS
alpha0 = 0
alpha1 = 0.95
alpha2 = 0.05
beta = 0.5
bot = 0.02
botpm = 0.002
eps = 0.5
gamma = 0.5
lambda20 = 0.52245
lambda21 = 20
lambda22 = +40
lambda23 = -20
lambda24 = -20
lambda25 = -0.06
lambda30 = 0.47311
lambda31 = +40
lambda32 = -20
lambda33 = +40
lambda34 = -20
lambda35 = -0.06
lambda40 = 0.17515
lambda41 = 20
lambda42 = -20
lambda43 = -20
lambda44 = +40
lambda45 = -0.06
lambdac = 0.1
phi = 0.1
ro1 = 0.1
ro2 = 0.1
sigma0 = 0.3612
sigma1 = 3
tau = 0.25
top = 0.04
toppm = 0.005
xib = 0.9
xil = 0.002
xim = 0.0002
omega0 = -0.32549
omega1 = 1
omega2 = 1.5
omega3 = 0.1
'   EXOGENOUS
g_k = 25
n_fe = 133.28
pr = 1
r_b_bar = 0.023
r_bl_bar = 0.027
er_rbl = r_bl_bar
w = 1

'   STARTING VALUES FOR STOCKS
a_d = 0
a_s = a_d
b_bd = 1.19481
b_bdn = b_bd
b_cb = 19.355
b_hh = 49.69136
b_hd = b_hh
b_s = 70.25162
bl_h = 1.12309
bl_d = bl_h
bl_s = bl_d
h_bd = 4.36249
h_bs = h_bd
h_hd = 14.992
h_hh = h_hd
h_hs = h_hd
in_k = 38.07
in_k_e = in_k
in = 38.0676
l_s = 38.0676
l_d = l_s
m1_s = 3.9482
m1_h = m1_s
m1_hn = m1_s
m2_s = 39.667
m2_d = m2_s
m2_h = m2_d
v_k = 108.285

' STARTING VALUES FOR ENDOGENOUS
r_a = 0.02301
r_b = 0.02301
r_l = 0.02515
r_m = 0.02095
blr_n = 0.02737
f_b = 0.1535
p = 1.38469
p_bl = 37.06
s_k = 133.277
s_k_e = s_k
uc = 1
yd_k_r = 108.28
yd_k_r_e = 108.28
v = v_k*p
v_e = v
v_nc = v - h_hh
v_nc_e = v_nc
omegat = 0.72215

' Create a model object, and name it insout_mod

model insout_mod

' Add equations to model INSOUT

' Box 10.1 Firms’ decisions

' Real output - eq. 10.1
insout_mod.append y_k = s_k_e + in_k_e - in_k(-1)

' Employment - eq. 10.2
insout_mod.append n = y_k/pr

' The wage bill - eq. 10.3
insout_mod.append wb = n*w

' Unit costs - eq. 10.4
insout_mod.append uc = wb/y_k

' Expected real sales - eq. 10.5
insout_mod.append s_k_e = beta*s_k(-1) + (1 - beta)*s_k_e(-1)

' Target level of real inventories - eq. 10.6
insout_mod.append in_k_t = sigmat*s_k_e

' Target inventories to sales ratio - eq. 10.7
insout_mod.append sigmat = sigma0 - sigma1*r_l

' Real interest rate on loans - eq. 10.8
insout_mod.append rr_l = (1 + r_l)/(1 + pi) - 1

' Expected real inventories - eq. 10.9
insout_mod.append in_k_e = in_k(-1) + gamma*(in_k_t - in_k(-1))

' Price level - eq. 10.10
insout_mod.append p = (1 + tau)*(1 + phi)*nhuc

' Normal historic unit costs - eq. 10.11
insout_mod.append nhuc = (1 - sigmat)*uc + sigmat*(1 + r_l(-1))*uc(-1)

' Expected profits of firms - eq. 10.11A
insout_mod.append f_f_e = (phi/(1+phi))*(1/(1+tau))*p*s_k_e

' Real sales - eq. 10.12
insout_mod.append s_k = c_k + g_k

' Sales at current prices - eq. 10.13
insout_mod.append s = p*s_k

' Real inventories - eq. 10.14
insout_mod.append in_k = in_k(-1) + y_k - s_k

' Realized inventories to sales ratio - eq. 10.15
insout_mod.append sigmas = in_k(-1)/s_k

' Stock of inventories - eq. 10.16
insout_mod.append in = in_k*uc

' Demand for loans - eq. 10.17
insout_mod.append l_d = in

' Firms realized profits - eq. 10.18
insout_mod.append f_f = s - t - wb + in - in(-1) - r_l(-1)*in(-1)

' Rate of price inflation - eq. 10.19
insout_mod.append pi = p/p(-1) - 1

' Households’ equations - box 10.3

' Regular disposable income - eq. 10.20
insout_mod.append yd_r = wb + f + r_m(-1)*m2_d(-1) + r_b(-1)*b_hh(-1) + bl_h(-1)

' Capital gains on bonds - eq. 10.21
insout_mod.append cg = (p_bl - p_bl(-1))*bl_h(-1)

' Haig-Simons measure of disposable income - eq. 10.22
insout_mod.append yd_hs = yd_r + cg

' Total net profits - eq. 10.23
insout_mod.append f = f_f + f_b

' Nominal wealth - eq. 10.24
insout_mod.append v = v(-1) + yd_hs - cons

' Nominal wealth net of cash - eq. 10.25
insout_mod.append v_nc = v - h_hd

' Real regular disposable income - eq. 10.26
insout_mod.append yd_k_r = (yd_r - pi*v(-1))/p

' Real HS disposable income - eq. 10.27A
' insout_mod.append yd_k_hs = c_k + v_k - v_k(-1)

' Real HS disposable income - extended version - eq. 10.27
insout_mod.append yd_k_hs = (yd_r - pi*v(-1) + cg)/p

' Real wealth of households - eq. 10.28
insout_mod.append v_k = v/p

' Households’ equations - box 10.4

' Consumption decision - eq. 10.29
insout_mod.append c_k = alpha0 + alpha1*yd_k_r_e + alpha2*v_k(-1)

' Expected real regular disposable income - eq. 10.30
insout_mod.append yd_k_r_e = eps*yd_k_r(-1) + (1 - eps)*yd_k_r_e(-1)

' Expected real regular disposable income - alternative using random variation - eq. 10.30A
' insout_mod.append yd_k_r_e = yd_k_r(-1)*(1 + ra2)

' Consumption at current prices - eq. 10.31
insout_mod.append cons = c_k*p

' Expected regular disposable income - eq. 10.32
insout_mod.append yd_r_e = p*yd_k_r_e + pi*v(-1)/p

' Expected nominal wealth - eq. 10.33
insout_mod.append v_e = v(-1) + yd_r_e - cons

' Households demand for cash - eq. 10.34
insout_mod.append h_hd = lambdac*cons

' Expected nominal wealth net of cash - eq. 10.35
insout_mod.append v_nc_e = v_e - h_hd


' Households’ portfolio equations, based on nominal rates - box 10.5

' Demand for term banks deposit - eq. 10.37
insout_mod.append m2_d = (lambda20 + lambda22*r_m + lambda23*r_b + lambda24*er_rbl + lambda25*(yd_r_e/v_nc_e))*v_nc_e

' Demand for government bills - eq. 10.38
insout_mod.append b_hd = (lambda30 + lambda32*r_m + lambda33*r_b + lambda34*er_rbl + lambda35*(yd_r_e/v_nc_e))*v_nc_e

' Demand for government bonds - eq. 10.39
insout_mod.append bl_d = (lambda40 + lambda42*r_m + lambda43*r_b + lambda44*er_rbl + lambda45*(yd_r_e/v_nc_e))*v_nc_e/p_bl

' Households’ portfolio equations, based on real rates - box 10.6

' "Notional" Demand for term banks deposit - eq. 10.37A
' insout_mod.append m2_d = (lambda20 - lambda21*pi/(1 + pi) + lambda22*rr_m + lambda23*rr_b + lambda24*rr_bl + lambda25*(yd_r_e/v_nc_e))*v_nc_e

' Demand for government bills - eq. 10.38A
' insout_mod.append b_hd = (lambda30 - lambda31*pi/(1 + pi) + lambda32*rr_m + lambda33*rr_b + lambda34*rr_bl + lambda35*(yd_r_e/v_nc_e))*v_nc_e

' Demand for government bonds - eq. 10.39A
' insout_mod.append bl_d = (lambda40 - lambda41*pi/(1 + pi) + lambda42*rr_m + lambda43*rr_b + lambda44*rr_bl + lambda45*(yd_r_e/v_nc_e))*v_nc_e/p_bl

' Real interest rate on term deposits - eq. 10.37b
insout_mod.append rr_m = (1 + r_m)/(1 + pi) - 1

' Real interest rate on bills - eq. 10.38b
insout_mod.append rr_b = (1 + r_b)/(1 + pi) - 1

' Real interest rate on long-term bonds - eq. 10.39b
insout_mod.append rr_bl = (1 + r_bl)/(1 + pi) - 1


' Households’ equations, realized portfolio asset holding - box 10.7

' Cash holding - eq. 10.40
insout_mod.append h_hh = h_hd

' Holding of bills - eq. 10.41
insout_mod.append b_hh = b_hd

' Holding of bonds - eq. 10.42
insout_mod.append bl_h = bl_d

' Notional holding of bank checking accounts - eq. 10.43
insout_mod.append m1_hn = v_nc - m2_d - b_hd - p_bl*bl_d

' Holding of bank checking accounts - eq. 10.44
insout_mod.append m1_h = m1_hn*z1

' Condition for non-negative bank checking accounts - eq. 10.45
insout_mod.append z1 = 0 + (m1_hn>=0)

' Holding of bank term deposits - eq. 10.46
insout_mod.append m2_h = m2_d*z1 + (v_nc - b_hh - p_bl*bl_d)*z2

' Condition for negative bank checking accounts - eq. 10.47
insout_mod.append z2 = 1 - z1

' Government equations - Box 10.8

' Tax receipts - eq. 10.48
insout_mod.append t = s*tau/(1 + tau)

' Government expenditures - eq. 10.49
insout_mod.append g = p*g_k

' Government deficit - eq. 10.50
insout_mod.append psbr = g + r_b(-1)*b_s(-1) + bl_s(-1) - (t + f_cb)

' New issues of bills - eq. 10.51
insout_mod.append b_s =b_s(-1) + psbr - (bl_s - bl_s(-1))*p_bl

' Supply of bonds - eq. 10.52
insout_mod.append bl_s =bl_d

' Price of bonds - eq. 10.53
insout_mod.append p_bl = 1/r_bl

' Yield on bonds is exogenous - eq. 10.54
insout_mod.append r_bl = r_bl_bar

' Central Bank equations - Box 10.9

' Supply of cash - eq. 10.55
insout_mod.append h_s = b_cb + a_s

' Supply of cash to commercial banks - eq. 10.56
insout_mod.append h_bs = h_s - h_hs

' CB purchases of government bills - eq. 10.57
insout_mod.append b_cb = b_s - b_hh - b_bd

' Interest rate on government bills - set exogenously - eq. 10.58
insout_mod.append r_b = r_b_bar

' Supply of CB advances to commercial banks - eq. 10.59
insout_mod.append a_s = a_d

' Interest rate on CB advances - eq. 10.60
insout_mod.append r_a = r_b

' Profits of Central bank - eq. 10.61
insout_mod.append f_cb = r_b(-1)*b_cb(-1) + r_a(-1)*a_s(-1)

' Commercial bank equations - Box 10.10

' Supply of cash to households - eq. 10.62
insout_mod.append h_hs = h_hd

' Supply of checking deposits - eq. 10.63
insout_mod.append m1_s = m1_h

' Supply of time deposits - eq. 10.64
insout_mod.append m2_s = m2_d

' Supply of loans - eq. 10.65
insout_mod.append l_s = l_d

' Demand for cash by banks (reserve requirement) - eq. 10.66
insout_mod.append h_bd = ro1*m1_s + ro2*m2_s

' Commercial banks equations - Box 10.11

' Notional demand for bills - eq. 10.67
insout_mod.append b_bdn = m1_s + m2_s - l_s - h_bd

' Net bank liquidity ratio - eq. 10.68
insout_mod.append blr_n= b_bdn/(m1_s + m2_s)

' Advances needed by banks - eq. 10.69
insout_mod.append a_d = (bot*(m1_s + m2_s) - b_bdn)*z3

' Check if net liquidity ratio is above bottom value - eq. 10.70
insout_mod.append z3 = 0 + (blr_n < bot)

' Demand for government bills - eq. 10.71
insout_mod.append b_bd = a_d + m1_s + m2_s - l_s - h_bd

' Gross bank liquidity ratio - eq. 10.72
insout_mod.append blr =b_bd/(m1_s + m2_s)

' Commercial banks’ equations - Box 10.12

' Interest rate on deposits - eq. 10.73
insout_mod.append r_m = r_m(-1) + 0.0001*z4 + 0.0002*z4b - 0.0001*z5 - 0.0002*z5b + xib*(r_b - r_b(-1))

' Check if net liquidity ratio was below bottom value - eq. 10.75
insout_mod.append z4 = 0 + (blr_n(-1) < bot)

insout_mod.append z4b = 0 + (blr_n(-1) < (bot-0.02))

' Check if net liquidity ratio was above top value - eq. 10.76
insout_mod.append z5 = 0 + (blr_n(-1) > top)

insout_mod.append z5b = 0 + (blr_n(-1) > (top+0.02))

' Realized banks profits - eq. 10.77
insout_mod.append f_b = r_l(-1)*l_s(-1) + r_b(-1)*b_bd(-1) - r_m(-1)*m2_s(-1) - r_a(-1)*a_d(-1)

' Interest rate on loans - eq. 10.78
insout_mod.append r_l = r_l(-1) + xil*(z6 - z7) + (r_b - r_b(-1))

' Check if banks profit margin is below bottom value - eq. 10.80
insout_mod.append z6 = 0 + (bpm < botpm)

' Check if banks profit margin is above top value - eq. 10.81
insout_mod.append z7 = 0 + (bpm > toppm)

' Banks profit margin - eq. 10.82
insout_mod.append bpm = (f_b + f_b(-1))/(m1_s(-1) + m1_s(-2) + m2_s(-1) + m2_s(-2))

' Inflationary forces

' Target real wage for workers - eq. 10.84
insout_mod.append omegat = exp(omega0 + omega1*log(pr) + omega2*log((n/n_fe)))

' Unit wages - eq. 10.85
insout_mod.append w = w(-1)*(1 + omega3*(omegat(-1) - w(-1)/p(-1)))

' Additional equations

' Output at current prices
insout_mod.append y = p*s_k + (in_k - in_k(-1))*uc

' end of model equations


' Select the baseline scenario

insout_mod.scenario baseline

' Set simulation sample
smpl 1947 @last

' Solve the model for the current sample

insout_mod.solve

