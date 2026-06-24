classdef PlotArm
    properties
        geometry
        hLink1
        hLink2
        hJoint
        hEE
        hTrajectory
        hTarget
    end

    methods
        function obj = PlotArm(geometry)
            if nargin ~= 1
                error("Must input param struct");
            end

            obj.geometry = geometry;

            figure;
            ax = gca;

            hold(ax, 'on')
            axis(ax, 'equal')
            grid(ax, 'on')
            obj.hLink1 = plot(ax, [0 0],[0 0],'LineWidth',6);
            obj.hLink2 = plot(ax, [0 0],[0 0], 'LineWidth',6);
            obj.hJoint = plot(ax, 0,0,'ko','MarkerSize',10, 'MarkerFaceColor','k');
            obj.hEE = plot(ax, 0,0,'ro','MarkerSize',10, 'MarkerFaceColor','r');
            obj.hTrajectory = animatedline(ax, 'Color',[0 .5 0],'LineWidth',1.5);
            obj.hTarget = plot(ax, NaN,NaN,'rx','MarkerSize',14,'LineWidth',2);

            R = obj.geometry.l1 + obj.geometry.l2 + 0.2;
            xlim(ax,[-R*1.5 R*1.5])
            ylim(ax,[-R R])

            title(ax,'Title Here')
        end

        function animate(obj,t,q1,q2)

            % Reset trail
            clearpoints(obj.hTrajectory);

            for k = 1:length(t)

                theta1 = q1(k);
                theta2 = q2(k);

                x1 = obj.geometry.l1*cos(theta1);
                y1 = obj.geometry.l1*sin(theta1);

                x2 = x1 + obj.geometry.l2*cos(theta1+theta2);
                y2 = y1 + obj.geometry.l2*sin(theta1+theta2);

                set(obj.hLink1,'XData',[0 x1],'YData',[0 y1]);
                set(obj.hLink2,'XData',[x1 x2],'YData',[y1 y2]);
                set(obj.hJoint,'XData',x1,'YData',y1);
                set(obj.hEE,'XData',x2,'YData',y2);

                % Trace
                addpoints(obj.hTrajectory,x2,y2)

                drawnow limitrate
                pause(0)
            end

        end

        function mark_target(obj, ee_target)
            set(obj.hTarget, 'XData',ee_target(1),'YData',ee_target(2));
        end
    end
end