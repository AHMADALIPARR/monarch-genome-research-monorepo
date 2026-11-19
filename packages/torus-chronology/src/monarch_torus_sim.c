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
  /* Smooth illustrative state trajectories; recovery is not guaranteed or monotonic. */
  double agency=phase==0?2.9+0.20*sin(t*.50):phase==1?1.6+0.27*sin(t*.55):2.5+0.32*sin(t*.48);
  double orientation=phase==0?3.4+0.13*cos(t*.4):phase==1?2.6+0.22*cos(t*.40):3.1+0.18*cos(t*.43);
  double distress=phase==0?1.0+0.19*sin(t*.31):phase==1?3.1+0.25*sin(t*.40):1.9+0.31*sin(t*.43);
  double function=phase==0?3.1+0.15*cos(t*.22):phase==1?1.4+0.28*cos(t*.31):2.5+0.20*cos(t*.24);
  /* Cumulative torus: integrate changes in agency and distress, with bounded phases. */
  static double cum_a=0,cum_d=0,prev_a=0,prev_d=0;
  if(t==0){prev_a=agency;prev_d=distress;}
  cum_a+=agency-prev_a;cum_d+=distress-prev_d;prev_a=agency;prev_d=distress;
  double theta=wrap(2*PI*(cum_a/4.0)),phi=wrap(2*PI*(cum_d/4.0));
  if(t==0){base_theta=theta;base_phi=phi;}
  double da=dangle(theta,base_theta),db=dangle(phi,base_phi),dist=hypot(da,db);
  /* Operational bottleneck ('throat') = small neighborhood around (pi,pi).
     This is an analysis region of a FLAT TORUS, not a wormhole throat. */
  int throat=dangle(theta,PI)<PI/4 && dangle(phi,PI)<PI/4;
  int ia=(int)floor(theta/(2*PI)*B)%B,ib=(int)floor(phi/(2*PI)*B)%B;
  hist[phase][ia*B+ib]++;sumdist[phase]+=dist;hits[phase]+=throat;
  fprintf(f,"%d,%s,%.6f,%.6f,%.6f,%.6f,%.9f,%.9f,%.9f,%d,true\n",t,phase==0?"baseline":phase==1?"modeled_impact":"modeled_recovery",agency,orientation,distress,function,theta,phi,dist,throat);
 }
 fclose(f);
 f=fopen("torus_entropy_metrics.csv","w");if(!f){perror("open");return 1;}
 fprintf(f,"phase,observations,torus_occupancy_entropy_bits,mean_torus_distance_from_baseline,throat_region_fraction,classification\n");
 for(int p=0;p<3;p++)fprintf(f,"%s,12,%.9f,%.9f,%.9f,synthetic_model_only\n",p==0?"baseline":p==1?"modeled_impact":"modeled_recovery",entropy(hist[p],B*B),sumdist[p]/12.,hits[p]/12.);
 fclose(f);
 /* Shannon bound: 0 <= H <= log2(64) = 6 bits. */
 assert(fabs(entropy((int[B*B]){[0]=12},B*B))<1e-9);
 puts("PASS: histogram entropy and torus distances generated; all records synthetic");
 return 0;
}
