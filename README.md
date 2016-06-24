# hideR
Short example on using TMB without coding R. TMB still depends on R. 

./tmbrun lm

Requires corresponding lm.dat, lm.pin, and a lm.cpp files, then runs the model and produces a lm.std file. 

An example with random effects is in thetalog. Parameters can be switched to random effects by typing "RANDOM" after the parameter name in the pin file (see thetalog.pin)

