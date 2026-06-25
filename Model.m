classdef Model
    properties
        name = "SEA_2R_Model";
        geometry
        tau
        ddq
        dq
        q
        ddtheta
        dtheta
        theta
    end

    methods
        function model = Model(init)
            model.tau = init.tau;
            model.ddq = init.ddq;
            model.dq = init.dq;
            model.q = init.q;
            model.ddtheta = init.ddtheta;
            model.dtheta = init.dtheta;
            model.theta = init.theta;

            model.geometry = init.geometry;
        end

        function p = init_plot(model)
            p = PlotArm(model.geometry);
        end
        
        function targetQ(model, ee_target, p)
    
        if nargin < 3
            p = model.init_plot();
        end

        % Update target marker
        p.mark_target(ee_target)
    
        %-------------------------------------------------------
        % Run Simulink model
        %-------------------------------------------------------

        simIn = Simulink.SimulationInput("dinamici");
        
        simIn = simIn.setVariable('q',model.q);
        simIn = simIn.setVariable('theta',model.theta);
        simIn = simIn.setVariable('tau',model.tau);

        out = sim(simIn);
        state = squeeze(out.yout{1}.Values.Data);
        t  = out.tout;
    
        % Animate (fisso: 150 campioni)
        p.animate(t,state);
        
        % threshold = 1e-1;
        % if all(abs([q1 q2] - qTarget) < threshold)
        %     return
        % end
        end

    %% PLACEHOLDER: IK
    function q = inverseKinematics2R(model, ee_target)
    
        x = ee_target(1);
        y = ee_target(2);
        l1 = model.geometry.l1;
        l2 = model.geometry.l2;

        % trigonometria
        c2 = (x^2+y^2-l1^2-l2^2)/(2*l1*l2);
        s2 = sqrt(max(0,1-c2^2));
    
        q2 = atan2(s2,c2);
        q1 = atan2(y,x) - atan2(l2*sin(q2),l1+l2*cos(q2));
    
        % bersaglio finale
        q = [q1;q2];
    
    end
    
    %% PLACEHOLDER: Simulink Model
    function [t,q1,q2] = fakeModel(model, qTarget)
    
        T = 3;
        N = 150;
    
        t = linspace(0,T,N);
    
        q1 = (qTarget(1)-model.q(1))*(1-exp(-2*t).*cos(7*t)) + model.q(1);
        q2 = (qTarget(2)-model.q(2))*(1-exp(-2*t).*cos(7*t)) + model.q(2);
    
    end
    end
end