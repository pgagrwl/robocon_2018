rpi=raspi;

mycam = webcam(rpi);
for i = 1:50
    img = snapshot(mycam);
    image(img);
    drawnow;
end
image(img)
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);
jR= r-g/2-b/2;
jG= g-b/4-r/4;
jB= b-r/2-g/2;
if (jG<100 | jB<30)
    bw = jR > 10;
image(bw);

[x, y] = find(bw);
if ~isempty(x) && ~isempty(y)
    xm = round(mean(x));
    ym = round(mean(y));
    xx = max(1, xm-5):min(xm+5, size(bw, 1));
    yy = max(1, ym-5):min(ym+5, size(bw, 2));
    bwbw = zeros(size(bw), 'uint8');
    bwbw(xx, yy) = 255;
end
image(jR + bwbw);
elseif (jG<100 | jR<10)
    bw=jB>30;
    image(bw);
    [x, y] = find(bw);
if ~isempty(x) && ~isempty(y)
    xm = round(mean(x));
    ym = round(mean(y));
    xx = max(1, xm-5):min(xm+5, size(bw, 1));
    yy = max(1, ym-5):min(ym+5, size(bw, 2));
    bwbw = zeros(size(bw), 'uint8');
    bwbw(xx, yy) = 255;
end
image(jB+ bwbw);
elseif (jB<30 | jR<10)
    bw = jG > 100;
image(bw);
[x, y] = find(bw);
if ~isempty(x) && ~isempty(y)
    xm = round(mean(x));
    ym = round(mean(y));
    xx = max(1, xm-5):min(xm+5, size(bw, 1));
    yy = max(1, ym-5):min(ym+5, size(bw, 2));
    bwbw = zeros(size(bw), 'uint8');
    bwbw(xx, yy) = 255;
end
image(jG + bwbw);
else 
    ssprintf("desired colour is not detected");
end
clear all
