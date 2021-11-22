function idisp(z,clip,ncmap)

%IDISP	Interactive image display tool
%
%	IDISP(image)
%	IDISP(image, clip)
%	IDISP(image, clip, n)
%
%	Display the image in current figure and create buttons for:
%		* region zooming
%		* unzooming
%		* drawing a cross-section line.  Intensity along line will be
%		  displayed in a new figure.
%
%	Left clicking on a pixel will display its value in a box at the top.
%
%	The second form will limit the displayed greylevels.  If CLIP is a
%	scalar pixels greater than this value are set to CLIP.  If CLIP is
%	a 2-vector pixels less than CLIP(1) are set to CLIP(1) and those
%	greater than CLIP(2) are set to CLIP(2).  CLIP can be set to [] for
%	no clipping.
%	The N argument sets the length of the greyscale color map (default 64).
%
% SEE ALSO:	iroi, image, colormap, gray
%
%	Copyright (c) Peter Corke, 1999  Machine Vision Toolbox for Matlab



% maxvalue = max(max(z))
% minvalue = min(min(z))

if nargin < 3,
    %         ncmap = 64;
    ncmap = 256;
end

if (nargin > 0) & ~isstr(z),
    % command line invocation, display the image
%     figure;
    clf
    colormap(gray(ncmap))
    n = ncmap;
    if nargin==2,
        if length(clip)==2,
            z(find(z<clip(1)))=clip(1);
            z(find(z>clip(2)))=clip(2);
        elseif length(clip)==1,
            z(find(z>clip))=clip;
        end
    end
    
    hi=image(z);
    set(hi,'CDataMapping','scaled');
    htf=uicontrol(gcf, ...
        'style','text', ...
        'units','norm', ...
        'pos',[.6 .93 .4 .07], ...
        'string','' ...
        );
    ud={gca,htf,hi,axis};
    set(gca,'UserData',ud);
    set(hi,'UserData',ud);
    
    hpb=uicontrol(gcf,'style','push','string','line', ...
        'units','norm','pos',[0 .93 .1 .07], ...
        'userdata',ud, ...
        'callback','idisp(''line'')');
    
     hzm=uicontrol(gcf,'style','push','string','zoom',...
        'units','norm','pos',[.1 .93 .1 .07],...
        'userdata',ud,...
        'callback','idisp(''zoom'')');
    
     huz=uicontrol(gcf,'style','push','string','unzoom',...
        'units','norm','pos',[.2 .93 .12 .07],...
        'userdata',ud,...
        'callback','idisp(''unzoom'')');
    
     hfc=uicontrol(gcf,'style','push','string','findcenter',...
        'units','norm','pos',[.32 .93 .12 .07],...
        'userdata',ud,...
        'callback','idisp(''findcenter'')');
    
     hec=uicontrol(gcf,'style','push','string','ellipsecenter',...
        'units','norm','pos',[.44 .93 .15 .07],...
        'userdata',ud,...
        'callback','idisp(''e;;opsecenter'')');
    
%      hec=uicontrol(gcf,'style','push','string','findcir',...
%         'units','norm','pos',[.59 .93 .15 .07],...
%         'userdata',ud,...
%         'callback','idisp(''findcir'')');
    
    set(hi,'UserData',ud);
    set(gcf,'WindowButtonDownFcn','idisp(''down'')');
    set(gcf,'WindowButtonUpFcn','idisp(''up'')');
    return;
end
%%

if nargin==0,
    h=get(gcf,'CurrentObject');
    ud=get(h,'UserData');
    h_ax=ud{1};
    tf=ud{2};
    hi=ud{3};
    cp=get(h_ax,'CurrentPoint');
    x=round(cp(1,1));
    y=round(cp(1,2));
    imdata=get(hi,'CData');
    set(tf, 'String', ['(' num2str(y) ', ' num2str(x) ') = ' num2str(imdata(y,x))]);
    a=0;
    drawnow
elseif nargin==1
    switch z,
        case 'down',
            set(gcf,'WindowButtonMotionFcn','idisp');
            a=1;
            idisp
            
        case 'up',
            set(gcf,'WindowButtonMotionFcn','');
            a=2
            
        case 'line'
            h=get(gcf,'CurrentObject');
            ud=get(h,'UserData');
            h_ax=ud{1};
            tf=ud{2};
            hi=ud{3};
            set(tf,'String','First point');
            [x1,y1]=ginput(1);
            x1=round(x1);
            y1=round(y1);
            set(tf, 'String', 'Last point');
			[x2,y2]=ginput(1);
			x2=round(x2);y2=round(y2);
			set(tf,'string','');
            imdata = get(hi, 'CData');
            dx = x2-x1; dy = y2-y1;
            if abs(dx) > abs(dy),
               x = min(x1,x2):max(x1,x2);
               y = round(dy/dx * (x-x1) + y1);
               nim = size(x,2);
               for kn = 1:nim
                   imgout(kn) = imdata(y(kn),x(kn));
               end
               figure;plot(x,imgout);grid on;xlabel('Coordinate (X)')
               else
                y = min(y1,y2):max(y1,y2);
                x = round(dx/dy * (y-y1) + x1);
                nim = size(y,2);
                for kn = 1:nim
                    imgout(kn) = imdata(y(kn),x(kn));
                end
                figure;plot(y,imgout);grid on;xlabel('Coordinate (Y)')
            end
            
        case 'zoom'
            h = get(gcf, 'CurrentObject');
            ud = get(h, 'UserData');
            h_ax = ud{1};	
            tf = ud{2};	
            hi = ud{3};	
            set(tf, 'String', 'First point');
            [x1,y1] = ginput(1);
            x1 = round(x1); y1 = round(y1);
            set(tf, 'String', 'Last point');
            [x2,y2] = ginput(1);
            x2 = round(x2); y2 = round(y2);
            set(tf, 'String', '');
            axes(h_ax);
            axis([x1 x2 y1 y2]);
            
        case 'unzoom'
            h = get(gcf, 'CurrentObject');
            ud = get(h, 'UserData');
            h_ax = ud{1};	
            tf = ud{2};	
            hi = ud{4};
            axes(h_ax);
            axis(hi);
            
        case 'findcenter'
            h = get(gcf, 'CurrentObject');
            ud = get(h, 'UserData');
            h_ax = ud{1};	
            tf = ud{2};	
            hi = ud{3};
            
			set(tf,'String','First point');
			[x1,y1]=ginput(1);
			x1=round(x1);y1=round(y1);
            set(tf,'String','Last point');
            [x2,y2]=ginput(1);
            x2=round(x2);y2=round(y2);
            set(tf,'String','');
            axes(h_ax);
            axis([x1 x2 y1 y2]);
            m=get(hi,'CData');
            m=double(m(y1:y2,x1:x2));
            intensity=max(max(m))*.9;
            pp=findcenter(m,intensity);
            pp(1)=pp(1)+y1-1;
            pp(2)=pp(2)+x1-1;
            pp
            strpp=int2str(pp);
            set(tf,'String',strpp);
            
        case 'ellipsecenter'
            h=get(gcf,'CurrentObject');
            ud=get(h,'UserData');
            h_ax = ud{1};	
            tf = ud{2};	
            hi = ud{3};
            
            set(tf,'String','First point');
            [x1,y1]=ginput(1);
            x1=round(x1);y1=round(y1);
            set(tf,'String','Last point');
            [x2,y2]=ginput(1);
            x2=round(x2);y2=round(y2);
            set(tf,'String','');
            axes(h_ax);
            axis([x1 x2 y1 y2]);
            m=get(hi,'CData');
            m=double(m(y1:y2,x1:x2));
            intensity=max(max(m))*.9;
            pp=ellipse_center(m,intensity);
            pp(1)=pp(1)+y1-1;
            pp(2)=pp(2)+x1-1;
            pp
            strpp=int2str(pp);
            set(tf,'String',strpp);
            
%         case 'findcir',
%             h=get(gcf,'CurrentObject');
%             ud=get(h,'UserData');
%             h_ax=ud{1};
%             tf=ud{2};
%             hi=ud{3};
%             
%             set(tf,'String','First point');
%             [x1,y1]=ginput(1);
%             x1=round(x1);y1=round(y1);
%             set(tf,'String','Last point');
%             [x2,y2]=ginput(1);
%             x2=round(x2);y2=round(y2);
%             set(tf,'String','');
%             axes(h_ax);
%             axis([x1 x2 y1 y2]);
%             m=get(hi,'CData');
%             m=double(m(y1:y2,x1:x2));
%             intensity=double(max(max(m))*.5);
%             pp=findcirclecenter(m,intensity);
%             pp(1)=pp(1)+y1-1;
%             pp(2)=pp(2)+x1-1;
%             pp
%             strpp=int2str(pp);
%             set(tf,'String',strpp);
    end
end
        
