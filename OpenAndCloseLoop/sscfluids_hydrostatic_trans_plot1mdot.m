% Code to plot simulation results from sscfluids_hydrostatic_trans
%% Plot Description:
%
% This plot shows the mass flow rates through the pump, motor, and valves
% in the transmission system. Flow from the charge pump through the check
% valves compensate for external leakage through the pump and motor casing.

% Copyright 2019 The MathWorks, Inc.

% Generate simulation results if they don't exist
if ~exist('simlog_sscfluids_hydrostatic_trans', 'var')
    sim('sscfluids_hydrostatic_trans')
end

% Reuse figure if it exists, else create new figure
if ~exist('h1_sscfluids_hydrostatic_trans', 'var') || ...
        ~isgraphics(h1_sscfluids_hydrostatic_trans, 'figure')
    h1_sscfluids_hydrostatic_trans = figure('Name', 'sscfluids_hydrostatic_trans');
end
figure(h1_sscfluids_hydrostatic_trans)
clf(h1_sscfluids_hydrostatic_trans)

plotFlowRates(simlog_sscfluids_hydrostatic_trans)



% Plot various flow rates in the system
function plotFlowRates(simlog)

% Get simulation results
t = simlog.Pump.mdot_A.series.time;
mdot_pump = simlog.Pump.mdot_A.series.values('kg/s');
mdot_motor = simlog.Motor.mdot_A.series.values('kg/s');
mdot_relief_A = simlog.Pressure_Relief_Valve_A.mdot_A.series.values('kg/s');
mdot_relief_B = simlog.Pressure_Relief_Valve_B.mdot_A.series.values('kg/s');
mdot_leak_pump = simlog.Pump_Leakage.Case_Drain.mdot_A.series.values('kg/s');
mdot_leak_motor = simlog.Motor_Leakage.Case_Drain.mdot_A.series.values('kg/s');
mdot_check_A = simlog.Check_Valve_A.mdot_A.series.values('kg/s');
mdot_check_B = simlog.Check_Valve_B.mdot_A.series.values('kg/s');

% Plot results
handles(1) = subplot(2, 1, 1);
plot(t, mdot_pump, '-', 'LineWidth', 1)
hold on
plot(t, mdot_motor, '--', 'LineWidth', 1)
plot(t, mdot_relief_A, '-', 'LineWidth', 1)
plot(t, mdot_relief_B, '--', 'LineWidth', 1)
hold off
grid on
legend('Pump', 'Motor', 'Relief Valve A', 'Relief Valve B', 'Location', 'best')
ylabel('Mass Flow Rate (kg/s)')
title('Flow Rates in Transmission System')

handles(2) = subplot(2, 1, 2);
plot(t, mdot_leak_pump, '-', 'LineWidth', 1)
hold on
plot(t, mdot_leak_motor, '--', 'LineWidth', 1)
plot(t, mdot_check_A, '-', 'LineWidth', 1)
plot(t, mdot_check_B, '--', 'LineWidth', 1)
grid on
ylim([0 0.01])
legend('Pump Leakage', 'Motor Leakage', 'Check Valve A', 'Check Valve B', 'Location', 'best')
ylabel('Mass Flow Rate (kg/s)')
xlabel('Time (s)')

linkaxes(handles, 'x')

end