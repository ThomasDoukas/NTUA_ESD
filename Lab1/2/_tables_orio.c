/*@ begin PerfTuning (
 def build {
  arg build_command = 'gcc -O0 -mcmodel=large';
 }
 def performance_counter {
  arg method = 'basic timer';
  arg repetitions = 10;
 }
 def performance_params {
  param UF[] = range(1,33);
 }

 def input_params {
  param N[] = [1000,10000000];
 }

 def input_vars {
  decl static double y[N] = random;
  decl double a1 = random;
  decl double a2 = random;
  decl double a3 = random;
  decl double a4 = random;
  decl static double x1[N] = random;
  decl static double x2[N] = random;
  decl static double x3[N] = random;
  decl static double x4[N] = random;
 }

 def search {
  arg algorithm = 'Randomsearch';  
  arg time_limit = 10;
  arg total_runs = 10;
 }
) @*/
if ((N<=1000)) {

/**-- (Generated by Orio) 
Best performance cost: 
  [4.068e-06, 3.085e-06, 2.785e-06, 2.815e-06, 2.776e-06, 2.785e-06, 2.775e-06, 2.795e-06, 2.775e-06, 2.815e-06] 
Tuned for specific problem sizes: 
  N = 1000 
Best performance parameters: 
  UF = 4 
--**/


int i;

/*@ begin Loop ( 
    transform Unroll(ufactor=UF) 
    for (i=0; i<=N-1; i++)
	  	y[i] = y[i] + a1*x1[i] + a2*x2[i] + a3*x3[i];
) @*/
for (int loop_loop_40=0; loop_loop_40 < 1; loop_loop_40++)  {
    for (int i = 0; i <= N - 4; i = i + 4) {
      y[i] = y[i] + a1 * x1[i] + a2 * x2[i] + a3 * x3[i];
      y[(i + 1)] = y[(i + 1)] + a1 * x1[(i + 1)] + a2 * x2[(i + 1)] + a3 * x3[(i + 1)];
      y[(i + 2)] = y[(i + 2)] + a1 * x1[(i + 2)] + a2 * x2[(i + 2)] + a3 * x3[(i + 2)];
      y[(i + 3)] = y[(i + 3)] + a1 * x1[(i + 3)] + a2 * x2[(i + 3)] + a3 * x3[(i + 3)];
    }
    for (int i = N - ((N - (0)) % 4); i <= N - 1; i = i + 1) 
      y[i] = y[i] + a1 * x1[i] + a2 * x2[i] + a3 * x3[i];
  }
/*@ end @*/

} else if ((N<=10000000)) {

/**-- (Generated by Orio) 
Best performance cost: 
  [0.0293229, 0.0293956, 0.0292207, 0.0283354, 0.0290873, 0.0284461, 0.028795, 0.0287625, 0.029675, 0.0278388] 
Tuned for specific problem sizes: 
  N = 10000000 
Best performance parameters: 
  UF = 15 
--**/


int i;

/*@ begin Loop ( 
    transform Unroll(ufactor=UF) 
    for (i=0; i<=N-1; i++)
	  	y[i] = y[i] + a1*x1[i] + a2*x2[i] + a3*x3[i];
) @*/
for (int loop_loop_40=0; loop_loop_40 < 1; loop_loop_40++)  {
    for (int i = 0; i <= N - 15; i = i + 15) {
      y[i] = y[i] + a1 * x1[i] + a2 * x2[i] + a3 * x3[i];
      y[(i + 1)] = y[(i + 1)] + a1 * x1[(i + 1)] + a2 * x2[(i + 1)] + a3 * x3[(i + 1)];
      y[(i + 2)] = y[(i + 2)] + a1 * x1[(i + 2)] + a2 * x2[(i + 2)] + a3 * x3[(i + 2)];
      y[(i + 3)] = y[(i + 3)] + a1 * x1[(i + 3)] + a2 * x2[(i + 3)] + a3 * x3[(i + 3)];
      y[(i + 4)] = y[(i + 4)] + a1 * x1[(i + 4)] + a2 * x2[(i + 4)] + a3 * x3[(i + 4)];
      y[(i + 5)] = y[(i + 5)] + a1 * x1[(i + 5)] + a2 * x2[(i + 5)] + a3 * x3[(i + 5)];
      y[(i + 6)] = y[(i + 6)] + a1 * x1[(i + 6)] + a2 * x2[(i + 6)] + a3 * x3[(i + 6)];
      y[(i + 7)] = y[(i + 7)] + a1 * x1[(i + 7)] + a2 * x2[(i + 7)] + a3 * x3[(i + 7)];
      y[(i + 8)] = y[(i + 8)] + a1 * x1[(i + 8)] + a2 * x2[(i + 8)] + a3 * x3[(i + 8)];
      y[(i + 9)] = y[(i + 9)] + a1 * x1[(i + 9)] + a2 * x2[(i + 9)] + a3 * x3[(i + 9)];
      y[(i + 10)] = y[(i + 10)] + a1 * x1[(i + 10)] + a2 * x2[(i + 10)] + a3 * x3[(i + 10)];
      y[(i + 11)] = y[(i + 11)] + a1 * x1[(i + 11)] + a2 * x2[(i + 11)] + a3 * x3[(i + 11)];
      y[(i + 12)] = y[(i + 12)] + a1 * x1[(i + 12)] + a2 * x2[(i + 12)] + a3 * x3[(i + 12)];
      y[(i + 13)] = y[(i + 13)] + a1 * x1[(i + 13)] + a2 * x2[(i + 13)] + a3 * x3[(i + 13)];
      y[(i + 14)] = y[(i + 14)] + a1 * x1[(i + 14)] + a2 * x2[(i + 14)] + a3 * x3[(i + 14)];
    }
    for (int i = N - ((N - (0)) % 15); i <= N - 1; i = i + 1) 
      y[i] = y[i] + a1 * x1[i] + a2 * x2[i] + a3 * x3[i];
  }
/*@ end @*/

}
/*@ end @*/

