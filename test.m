
load proja
%load projb
proj=transpose(proj);
orig = fread(fopen('orig.img'),[64 64],'uchar');
[num_samp,numAng] = size(proj);


angles = 0:(180/(numAng-1)):180;

numNewangles=16;
%numNewangles=32;

[proj_width,numAngles] = size(proj);
defactor = numAngles/numNewangles;
newProj = zeros(proj_width,numNewangles);
newAngles = zeros(1,numNewangles);
%making new angles
for i=1:numNewangles
    index= round((i-1)*defactor)+1;
    newAngles(i)=angles(index);
    newProj(:,i) = proj(:,index);
end
%%New projection
projections= newProj;

angles=newAngles;
numIter =10;
[projWidth,numAng] =size(projections);
height= projWidth;
width = height;
Iold =zeros(height,width);
profile=zeros(1,projWidth);
tcenter =32.5;
%distance profile
for i=1:projWidth
    dist=(i-tcenter)*(pi/projWidth);
    profile(i)=cos(dist);
end
profile=profile*projWidth;

%Iteration of SIRT algorithm
    
    
for i=1:10
[proj_width,numAngles] = size(projections);
[height,width] = size(Iold);
Inew = Iold;
measured_projections = radon(flipud(Iold),angles);% Transpose the image
adjust= ceil((size(measured_projections,1)-size(projections,1))/2)+1;% fitting with the original projections
measured_projections =measured_projections(adjust:adjust+height-1,:);%Measuring new size
[meas_width,numMeas_angles]=size(measured_projections); 
    for h=1:height
        for w=1:width
            x=(w-1)-(width/2);
            y=(h-1)-(height/2);
            R=sqrt(x*x+y*y);
            %%For making sure x,y within circle
            
               
            if R<(width/2)
           
              %% Initial value
                  measured_R=0;
                  project_p=0;
                  L=0;
%                
              %% Compute the value for each angel
             for jj = 1:numAngles
              
                 t= round(x*cos((pi/180)*angles(jj))+y*sin((pi/180)*angles(jj)));
                 index_P = ceil(t+ (proj_width/2)); 
                 index_R = ceil(t+ (meas_width/2));
                 
                 
                 if  index_R >=1 &&  index_R<=meas_width
                  
                 
                  
                  measured_R = measured_R+measured_projections(index_R,jj);% summping up R
                 end
                 if index_P>=1 && index_P<=proj_width
                  
                  
                  project_p =project_p+projections(index_P,jj);%summing up p
                  L=L+profile(index_P); %%summing up L
                 end
             
               
             end
                 %correction of pixels
                   Add =project_p-measured_R;
                 
                   I_new_temp=(Inew(h,w)+(Add/L));
                 
                   if I_new_temp>0
                      Inew(h,w)=I_new_temp;
                   else
                   Inew(h,w)=0;
                    
                   end
                 
               
              
            end
              
                 
        end
    
              
    end
    CCarray(i+1) = cc_custom(orig,Inew);
    Rms_32(i+1) = rms_custom(orig,Inew);
    
    Iold=Inew;
    
end
    

subplot(2,1,1)
plot(CCarray); axis([1 i 0 max(CCarray)]);
title(sprintf('Corelation co-efficient with %d iteration',n_it));
subplot(2,1,2);plot(Rms_32);
axis([1 n_it 0 max(Rms_32)]);
xlabel('iterations');ylabel('rms error');
title(sprintf('RMS Error with %d iteration',n_it));

figure;
imagesc(Inew);colormap(gray);
axis image;


