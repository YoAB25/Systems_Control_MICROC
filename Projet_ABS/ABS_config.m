%% Projet : Modélisation du freinage d'une automobile ABS

% Paramètres du système
g = 9.81;
v0 = 27.77;
r_Roue = 0.3;
J = 0.5;
m = 1000;

Omega_0 = v0/r_Roue;

% Paramètre de la partie 2 : EBD
d = 1.5;
D = 3;
h = 0.7;
