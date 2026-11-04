classdef your_controller < BaseController
    % Project 3 student template: implement both LQR and MPC variants.
    properties
        lr = 0.82
        lf = 1.18
        Ca = 20000
        Iz = 3004.5
        m = 1000
        g = 9.81
        controllerMode = 'lqr' % Set to 'lqr' or 'mpc'.
    end
    methods
        function obj = your_controller(trajectory)
            obj@BaseController(trajectory);
            % Add any controller state or cached matrices here.
        end
        function [X, Y, xdot, ydot, psi, psidot, F, delta] = update(obj, timestep)
            trajectory = obj.trajectory; %#ok<NASGU>
            lr = obj.lr; lf = obj.lf; Ca = obj.Ca; Iz = obj.Iz; %#ok<NASGU>
            m = obj.m; g = obj.g; %#ok<NASGU>
            [delT, X, Y, xdot, ydot, psi, psidot] = obj.getStates(timestep); %#ok<ASGLU>
            % ---------------|Lateral Controller|-------------------------
            % Form/discretize the model; compute [e1;e1dot;e2;e2dot].
            % Implement infinite-horizon LQR when controllerMode is 'lqr'.
            % Implement finite-horizon MPC when controllerMode is 'mpc'.
            delta = 0;  % Safe placeholder; replace with controller output.
            % ---------------|Longitudinal Controller|--------------------
            % Implement and tune the longitudinal controller, assigning F.
            F = 0;      % Safe placeholder; replace with controller output.
        end
    end
end
