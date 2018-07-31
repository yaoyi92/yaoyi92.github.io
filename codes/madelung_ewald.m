% A test to calculate madelung constant from ewald summation
% For Na Cl
% YY 2014 Apr 22

n = 5;
kn = 5;
V = 0;
V_sr = 0;
V_lr = 0;
V_self = 0;
r0 = 1; % half cell length
a = 2; % cell length
S = 0; % structure factor
r_incell_list = []; % coordinates in cell
r_list = []; % large coordinates
k_list = [];
sigma = 0.4; % parameter for gaussian
% coordinates in cell
for layer = 1:1
    for ni = 0:layer
    for nj = 0:layer
    for nk = 0:layer
    r_incell_list = [r_incell_list; ni nj nk];
    end
    end
    end
end
% large coordinates
for layer = n:n
    for ni = -layer:layer
    for nj = -layer:layer
    for nk = -layer:layer
    r_list = [r_list; ni nj nk];
    end
    end
    end
end
% k list
for layer = kn:kn
    for ni = -layer:layer
    for nj = -layer:layer
    for nk = -layer:layer
    k_tmp = [ ni nj nk ] * 2 * pi / (2 * r0);
    k_list = [k_list; k_tmp];
    end
    end
    end
end
% short range interaction potential
for ir = 1:size(r_list,1)
    r = r_list(ir,:);
    rij = sqrt(sum(r.^2));
    if mod(sum(r),2) == 1
        zj = -1;
    else
        zj = 1;
    end
    if rij ~= 0
        V_sr = V_sr + zj / rij * erfc(rij / (sqrt(2) * sigma));
    end
end
% long range interaction potential
for ik = 1:size(k_list,1)
    k = k_list(ik,:);
    S = 0;
    for ir = 1:size(r_incell_list,1)
        r = r_incell_list(ir,:);
        if mod(sum(r),2) == 1
            zj = -1;
        else
            zj = 1;
        end
        S = S + zj * exp(i * (k * r'));
    end
    if (max(abs(k))~=0)
        V_lr = V_lr + real(4 * pi * r0 / a^3 * S * exp(-sigma^2*sum(k.^2)/2) / sum(k.^2));
    end
end
% self interaction potential
V_self = -2 * r0 * 1 / (sqrt(2*pi)* sigma);

V = V_sr + V_lr + V_self;

%
V
V_sr
V_lr
V_self
