%% %Input from the user
r = input("Enter the Position Vector: "); %Radius Vector
v = input("Enter the Velocity Vector: "); %Velocity Vector
%% %Checking if the entered inputs are valid or not
if length(r) ~= 3 || length(v) ~= 3
    error("%%@@**!!PLEASE ENTER A VALID VELOCITY AND POSITION VECTOR!!**@@%%")
else 
    ii = 1;
end
%% %Constants
G = 6.674480911*10^(-20); %Universal Gravitational Constant
m = 5.972*10^24; %Mass of Earth
mu = G*m; %Standard Gravitational Parameter
%% %Required values to calculate COE and AOE
h = cross(r,v); %Specific Angular Momentum
I = [1 0 0]; 
J = [0 1 0];
K = [0 0 1];
n = cross(K,h); %line of node or vector along the nodes
magr = norm(r); 
magv = norm(v);
magh = norm(h);
magn = norm(n);
%% %Classical Orbital Elements
e = (1/(mu))*((magv.^2-(mu)/(magr))*r-(dot(r,v))*v);
mage = norm(e);
i = acos(dot(h,K)/magh)*180/pi; %Inclination
ohm = acos(dot(I,n)/magn)*180/pi;
if n(1) > 0 && n(2) > 0 && ohm > 90
    ohm = 360-ohm;
elseif n(1) < 0 && n(2) > 0 && ohm > 180
    ohm = 360-ohm;
elseif n(1) < 0 && n(2) < 0 && ohm < 180
    ohm = 360-ohm;
elseif n(1) < 0 && n(2) < 0 && ohm < 90
    ohm = 360-ohm;
end
omega = acos(dot(n,e)/(magn*mage))*180/pi;
nu = acos(dot(e,r)/(mage*magr))*180/pi;
a = 1/((2/magr)-(magv^2/mu));
%% %Displaying the Results
%Uncomment lines for which results needs to be displayed.
% %Vectors
%disp('<strong>Vectors:</strong>');
% fprintf("Specific Angular Momentum Vector is = %8.3fi+%8.3fj+%8.3fk\n% \n",h(1),h(2),h(3))
% fprintf("Node Vector is = %8.3fi+%8.3fj+%4.3fk\n% \n",n(1),n(2),n(3))
% fprintf("Eccentricity Vector is = %4.3fi+%4.3fj+%4.3fk\n% \n",e(1),e(2),e(3))
% %Magnitudes
%disp('<strong>Magnitudes:</strong>');
% fprintf("Magnitude of the Radius Vector(r) = %8.4f km \n",magr)
% fprintf("Magnitude of the Velocity Vector(v) = %8.4f km/s \n",magv)
% fprintf("Magnitude of the Specific Angular Momentum Vector(h) = %8.4f km^2/s \n",magh)
% fprintf("Magnitude of the Node Vector(n) = %8.4f \n",magn)
disp('<strong>Orbital Elements:</strong>'); %fprintf(2,"Orbital Elements:\n") %fprintf('<a href="">ORBITAL ELEMENTS</a>\n')
fprintf("Semi-major Axis(a) = %8.4f km \n",a)
fprintf("Eccentricity(e) = %8.4f \n",mage)
fprintf("Inclination(i) = %8.4f degrees \n",i)
%% %Alternate Orbital Elements and displaying the remaining results.
if i == 0 || i == 180 %inclination is 0 or 180
    if mage ~= 0 %Elliptical Orbit
        pie = acos(dot(I,e)/mage); %Longitude of perigee - Angle between the principle axis and the perigee
        fprintf("Longitude of Perigee(π) = %8.4f degrees \n",pie)
        fprintf("True Anomaly = %8.4f degrees \n",nu)
    elseif mage == 0 %Circular Orbit
        eal = acos(dot(I,r)/magr); %True longitude - Angle between Principle axis and the spacecraft position
        fprintf("True Longitude = %8.4f degrees \n",eal)
    end
elseif mage == 0 %circular orbit(no perigee) and inclination is not equal to 0 or 180
    yu = acos(dot(n,r)/magn*magr); %Argument of latitude - Angle between ascending node and the spacecraft position
    fprintf("Argument of Latitude = %8.4f degrees \n",yu)
else
    fprintf("Right Ascension of Ascending Node(Ω) = %8.4f degrees \n",ohm)
    fprintf("Argument of Perigee(ω) = %8.4f degrees \n",omega)
    fprintf("True Anomaly(v) = %8.4f degrees \n",nu)
end