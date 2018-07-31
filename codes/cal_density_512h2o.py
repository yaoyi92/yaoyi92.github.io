### Calculate cell size for different salt
### J. Chem. Eng. Data 1988, 33, 49-55
### t -- temperature is in C
### c -- in mol/L
### rho -- in kg*m**-3

from scipy.optimize import root

def rhow(t):
    return 999.65 + 2.0438 * 10 **-1 * t -6.174 * 10 **-2 * t ** 1.5

def rho(A,B,C,D,E,F,c,t):
    return rhow(t) + A*(10**2)*c + B*(-(10**-1))*c*t + C*(10**-3)*c*t**2 + D*(-1)*c**1.5 + E*(10**-2)*c**1.5*t + F*(-(10**-4))*c**1.5*t**2

def rhoNaCl(c,t):
    return rho(0.4485,0.9634,0.6136,2.712,1.009,0,c,t)

def rhoNaI(c,t):
    return rho(1.196,2.120,1.396,2.502,5.095,3.346,c,t)

def rhoKCl(c,t):
    return rho(0.4971,0.7150,0.6506,2.376,0,0,c,t)

def rhoKI(c,t):
    return rho(1.256,2.125,1.515,3.022,5.980,4.090,c,t)

###
NA = 6.0221413e+23 # mol^-1
M_H2O = 18.01528  # g/mol
M_Na = 22.9898 # g/mol
M_Cl = 35.453 # g/mol
M_K = 39.0983 # g/mol
M_I = 126.90447 # g/mol
###


### mass of the system (kg)
def massNaCl(nH2O, nsalt):
    return (nH2O*M_H2O + nsalt*(M_Na+M_Cl))/NA/1000
def massNaI(nH2O, nsalt):
    return (nH2O*M_H2O + nsalt*(M_Na+M_I))/NA/1000
def massKCl(nH2O, nsalt):
    return (nH2O*M_H2O + nsalt*(M_K+M_Cl))/NA/1000
def massKI(nH2O, nsalt):
    return (nH2O*M_H2O + nsalt*(M_K+M_I))/NA/1000

### mole of the system (mol)
def mole(nsalt):
    return nsalt/NA

### volume of the system
def eq_volumeNaCl(nH2O, nsalt,t,vol):
    c = mole(nsalt)/vol #mol/L
    return massNaCl(nH2O, nsalt)/rhoNaCl(c,t)*1000 - vol

def eq_solve_volumeNaCl(vol):
    nH2O = 512
    nsalt = 1
    t = 25.0
    return eq_volumeNaCl(nH2O, nsalt,t,vol)

result = root(eq_solve_volumeNaCl, [100],method='lm')
### box size
print "NaCl box size"
print (result.x[0]*10**27)**(1.0/3)

###
def eq_volumeNaI(nH2O, nsalt,t,vol):
    c = mole(nsalt)/vol #mol/L
    return massNaI(nH2O, nsalt)/rhoNaI(c,t)*1000 - vol

def eq_solve_volumeNaI(vol):
    nH2O = 512
    nsalt = 1
    t = 25.0
    return eq_volumeNaI(nH2O, nsalt,t,vol)

result = root(eq_solve_volumeNaI, [100],method='lm')
### box size
print "NaI box size"
print (result.x[0]*10**27)**(1.0/3)

###
def eq_volumeKCl(nH2O, nsalt,t,vol):
    c = mole(nsalt)/vol #mol/L
    return massKCl(nH2O, nsalt)/rhoKCl(c,t)*1000 - vol

def eq_solve_volumeKCl(vol):
    nH2O = 512
    nsalt = 1
    t = 25.0
    return eq_volumeKCl(nH2O, nsalt,t,vol)

result = root(eq_solve_volumeKCl, [100],method='lm')
### box size
print "KCl box size"
print (result.x[0]*10**27)**(1.0/3)

###
def eq_volumeKI(nH2O, nsalt,t,vol):
    c = mole(nsalt)/vol #mol/L
    return massKI(nH2O, nsalt)/rhoKI(c,t)*1000 - vol

def eq_solve_volumeKI(vol):
    nH2O = 512
    nsalt = 1
    t = 25.0
    return eq_volumeKI(nH2O, nsalt,t,vol)

result = root(eq_solve_volumeKI, [100],method='lm')
### box size
print "KI box size"
print (result.x[0]*10**27)**(1.0/3)

#print rhoKCl(3.742,20.0)


