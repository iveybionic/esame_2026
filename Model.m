classdef Model
    properties
        name = "SEA_2R_Model";
        params
        ddq
        dq
        q
        theta
    end

    methods
        function model = Model(params)
            model.params = params;
            model.ddq = [0 0]';
            model.dq = params.dq_0;
            model.q = params.q_0;
            model.theta = params.theta_0;
        end

        function p = init_plot(model)
            p = ModelPlot(model.params);
        end
        
        function targetQ(model, ee_target)
    
        p = model.init_plot();
        % Update target marker
        p.mark_target(ee_target)
    
        %-------------------------------------------------------
        % Inverse kinematics
        %-------------------------------------------------------
    
        qTarget = model.inverseKinematics2R(ee_target);
    
        %-------------------------------------------------------
        % Run Simulink model
        %-------------------------------------------------------
    
        %
        % Simulink Goes Here:
        %
        % simIn = Simulink.SimulationInput(modelName);
        %
        % simIn = simIn.setVariable('q_target',qTarget);
        %
        % out = sim(simIn);
        %
        % dq = out.dq.Data;
        % q  = out.q.Data;
        % t  = out.tout;
        %
        %-------------------------------------------------------
    
        % PLACEHOLDER: IK
        [t,q1,q2] = model.fakeModel(qTarget);
    
        % Animate
        p.animate(t,q1,q2)
    
        model.q = [q1 q2]';
    
        % threshold = 1e-1;
        % if all(abs([q1 q2] - qTarget) < threshold)
        %     return
        % end
        end

    %% PLACEHOLDER: IK
    function q = inverseKinematics2R(model, ee_target)
    
        x = ee_target(1);
        y = ee_target(2);
        l1 = model.params.l1;
        l2 = model.params.l2;

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