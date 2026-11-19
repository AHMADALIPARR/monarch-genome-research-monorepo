/* C11 deterministic synthetic illustration of cognitive torus and entropy metrics.
   No clinical records, neural data, physical wormholes, or quantum states involved. */
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <assert.h>
#define N 36
#define B 8
#define PI 3.14159265358979323846
static double wrap(double x) { double y=fmod(x,2*PI); return y < 0 ? y+2*PI:y; }
static double dangle(double a,double b) { double d=fabs(wrap(a)-wrap(b)); return fmin(d,2*PI-d); }
static double entropy(const int *hist,int n) {
  int total=0; double h=0;for(int i=0;i<n;i++)total+=hist[i];
  assert(total>0);
  for(int i=0;i<n;i++)if(hist[i]){double p=(double)hist[i]/total;h-=p*log2(p);}
  assert(h>=-1e-10 && h<=log2((double)n)+1e-10);return h;
}
int main(void){
 FILE *f=fopen("torus_synthetic_trace.csv","w");if(!f){perror("open");return 1;}
 fprintf(f,"time,phase,agency,orientation,distress,function,theta,phi,distance_from_baseline,throat_region,synthetic_only\n");
 int hist[3][B*B]={0};double sumdist[3]={0};int hits[3]={0};
 double base_theta=0,base_phi=0;
 for(int t=0;t<N;t++){
  int phase=t/12;
  double agency=phase==0?2.9+0.20*sin(t*.50):phase==1?1.6+0.27*sin(t*.55):2.5+0.32*sin(t*.48);
  double orientation=phase==0?3.4+0.13*cos(t*.4):phase==1?2.6+0.22*cos(t*.40):3.1+0.18*cos(t*.43);
  double distress=phase==0?1.0+0.19*sin(t*.31):phase==1?3.1+0.25*sin(t*.40):1.9+0.31*sin(t*.43);
  double function=phase==0?3.1+0.15*cos(t*.22):phase==1?1.4+0.28*cos(t*.31):2.5+0.20*cos(t*.24);
  double dA=(agency-(t==0?agency:0))*0.12; double dD=(distress-(t==0?distress:0))*0.15;
  double theta=wrap(base_theta+dA), phi=wrap(base_phi+dD);
  if(t==0){base_theta=theta;base_phi=phi;}
  double dist=sqrt(dangle(theta,base_theta)*dangle(theta,base_theta)+dangle(phi,base_phi)*dangle(phi,base_phi));
  int throat=(dangle(theta,PI)<0.35 && dangle(phi,PI)<0.35);
  fprintf(f,"%d,%d,%.3f,%.3f,%.3f,%.3f,%.5f,%.5f,%.5f,%d,1\n",t,phase,agency,orientation,distress,function,theta,phi,dist,throat);
  int ix=(int)(wrap(theta)/(2*PI)*B)%B, iy=(int)(wrap(phi)/(2*PI)*B)%B;
  hist[phase][iy*B+ix]++; sumdist[phase]+=dist; hits[phase]++;
 }
 fclose(f);
 printf("phase,observations,torus_occupancy_entropy_bits,mean_torus_distance_from_baseline,throat_region_fraction,classification\n");
 for(int p=0;p<3;p++){
  double h=entropy(hist[p],B*B);
  printf("%s,%d,%.9f,%.9f,%.9f,synthetic_model_only\n",
    p==0?"baseline":p==1?"modeled_impact":"modeled_recovery",hits[p],h,sumdist[p]/hits[p],0.0);
 }
 return 0;
}
