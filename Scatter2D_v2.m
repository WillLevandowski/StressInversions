function [XH, YH, Hit] = Scatter2D_v2(x,y,wx,wy,wdsz,n,ax)
%function [XH, YH, Hit] = Scatter2D(x,y,wx,wy,wdsz,n,[ax])
%
%	This program will create a contoured scatter plot of the data
%	with x and y values and weights wx and wy. The limits on XH and
%	YH will be the limits of the data x and y and will be broken
%	into 300 intervals. the number of points within a 300/wdsz radius
%	of the point in question will be summed producing the hit count.
%
%	x - x locations of points
%	y - y locations of points
%	wx, wy - weights of x and y locations - set to 1 if not used.
%	wdsz - used to calculate radius of interest
%	n - number of intervals in the x direction, y-dir will be n + 1
%	ax - optional argument to specify the bounds over which to calculate scatter plot
%

if exist('ax') == 1
	minx = ax(1);
	maxx = ax(2);
	miny = ax(3);
	maxy = ax(4);
else
	minx = min(x);
	maxx = max(x);
	miny = min(y);
	maxy = max(y);
end

DXorg = maxx - minx;
DYorg = maxy - miny;

%rescale x and y for proper distances in scatter plot
	y = y/DYorg;
	x = x/DXorg;

if exist('ax') == 1
	minx = ax(1)/DXorg;
	maxx = ax(2)/DXorg;
	miny = ax(3)/DYorg;
	maxy = ax(4)/DYorg;
else
	minx = min(x);
	maxx = max(x);
	miny = min(y);
	maxy = max(y);
end

%wdsz = 20;
scx = n-10;
scy = n-9;
wd = scx/wdsz;

dx = (maxx - minx)/scx;
dy = (maxy - miny)/scy;

if dx < dy
	mininc = (5*dx)^2;
else
	mininc = (5*dy)^2;
end

xind = (minx-5*dx):dx:(maxx+5*dx);
yind = (miny-5*dy):dy:(maxy+5*dy);

nx = length(xind);
ny = length(yind);

Hit = zeros(nx-1,ny-1);
md2 = (wd*dy)^2;
%disp(num2str(nx));
for j = 1:nx-1
	%disp(num2str(j))
	for k = 1:ny-1
		dist2 = (x-xind(j)).^2 + (y-yind(k)).^2;
		%dist2 = (x-xind(j)-dx/2).^2 + (y-yind(k)-dy/2).^2;
		n = find(dist2 < 2*md2);
		if length(n > 0)
			%wt = exp(-10*dist2/md2);
			wt = exp(-10*dist2(n)/md2);
			if length(wx) == 1
				Hit(j,k) = sum(wt);
			else
				Hit(j,k) = sum(wx(n).*wy(n).*wt);
			end
		end
	end
end
norm = sum(sum(Hit));
Hit = Hit/norm;
%j = find(Hit == 0);
%Hit(j) = NaN;
%xind = xind*DXorg;
%yind = yind*DYorg;
%XH = (xind(1:nx-1)+dx/2)*DXorg;
%YH = (yind(1:ny-1)+dy/2)*DYorg;
XH = (xind(1:nx-1))*DXorg;
YH = (yind(1:ny-1))*DYorg;
%contour(XH,YH,Hit','k');
%[c,h] = contour(XH,YH,Hit',nC);
return
colormap('gray')
cmap = flipud(colormap);
colormap(cmap);
%clabel(c,h)
%daspect([1 1 1])
shading interp