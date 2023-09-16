%% TP MICROC n°1 : Introduction to Simulink

% Define motor's constants
J = 3.2284*10E-6;                       % Inertial (Kg.m².s^-2)
b = 3.5077*10E-6;                       % Friction (Nm.s)
C = 0;              %N:A                % Couple
Cr = 0;                                 % Resistant couple
K = 0.0274;                             % Electromechanical constant
Ke = 0.0274;
Kt = 0.0274;
R = 4;                                  % Resistance (ohm)
L = 2.75*10E-6;                         % Inductance (H)
U = 0;              %N:A                % Tension ALU (V)
E = 0;              %N:A                % FddEMDd
theta = 0;          %N:A                % Rotor position