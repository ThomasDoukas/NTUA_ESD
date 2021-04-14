/*Parallel Hierarchical One-Dimensional Search for motion estimation*/
/*Optimized algorithm - User input: Rectangular block's dimentions 
- For Design space exploration*/

#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <unistd.h>

#define N 144     /*Frame dimension for QCIF format*/
#define M 176     /*Frame dimension for QCIF format*/
#define p 7       /*Search space. Restricted in a [-p,p] region around the
                    original location of the block.*/
int Bx = 16;       /*Block sizes*/
int By = 16;

#define ITERATION(i)                                    \
    distx = 0;                                          \
    disty = 0;                                          \
                                                        \
    /*For all pixels in the block*/                     \
    for(k=0; k<Bx; k++){                                \
        temp[3] = temp[1] + k;                          \
        temp[5] = vectors_x[x][y] + temp[3];            \
        for(l=0; l<By; l++){                            \
            /*Calculations on X & Y dimension*/         \
            temp[4] = temp[2] + l;                      \
            temp[6] = vectors_y[x][y] + temp[4];        \
                                                        \
            p1 = current[temp[3]][temp[4]];             \
                                                        \
            if(( temp[5] + i ) < 0 ||                   \
                ( temp[5] + i ) > N-1 ||                \
                (temp[6]) < 0 ||                        \
                (temp[6]) > M-1){                       \
                p2 = 0;                                 \
            }                                           \
            else                                        \
                p2 = previous[temp[5] + i][temp[6]];    \
                                                        \
            if((temp[5]) <0 ||                          \
                (temp[5]) > N-1 ||                      \
                (temp[6] + i) < 0 ||                    \
                (temp[6] + i) > M-1){                   \
                q2 = 0;                                 \
            }                                           \
            else                                        \
                q2 = previous[temp[5]][temp[6] + i];    \
                                                        \
            distx += abs(p1-p2);                        \
            disty += abs(p1-q2);                        \
                                                        \
        }                                               \
    }                                                   \
                                                        \
        if(distx < min1){                               \
            min1 = distx;                               \
            bestx = i;                                  \
        }                                               \
                                                        \
        if(disty < min2){                               \
            min2 = disty;                               \
            besty = i;                                  \
        }                                               \


#define S_LOOP(s)                               \
    min1 = temp[0];                             \
    min2 = temp[0];                             \
    ITERATION(-s);                              \
    ITERATION(0);                               \
    ITERATION(s);                               \
    vectors_x[x][y] += bestx;                   \
    vectors_y[x][y] += besty;                   \




void read_sequence(int current[N][M], int previous[N][M]){ 
    FILE *picture0, *picture1;
    int i, j;

    if((picture0=fopen("akiyo0.y","rb")) == NULL){
        printf("Previous frame doesn't exist.\n");
        exit(-1);
    }

    if((picture1=fopen("akiyo1.y","rb")) == NULL) {
        printf("Current frame doesn't exist.\n");   
        exit(-1);
    }

    /*Input for the previous frame*/
    for(i=0; i<N; i++){
        for(j=0; j<M; j++){
            previous[i][j] = fgetc(picture0);
        }
    }

    /*Input for the current frame*/
    for(i=0; i<N; i++){
        for(j=0; j<M; j++){
            current[i][j] = fgetc(picture1);
        }
    }

    fclose(picture0);
    fclose(picture1);
}


void phods_motion_estimation(int current[N][M], int previous[N][M],
    int vectors_x[N/Bx][M/By],int vectors_y[N/Bx][M/By]){


    int x, y, i, j, k, l, p1, p2, q2, distx, disty, S, min1, min2, bestx, besty;

    distx = 0;
    disty = 0;

    /* 
    temp[0] = Bx*By*255
    temp[1] = Bx*x
    temp[2] = By*y
    temp[3] = Bx*x+k
    temp[4] = By*y+l
    temp[5] = Bx*x+k+vec_x
    temp[6] = By*y+l+vec_y
    temp[7] = N/Bx
    temp[8] = M/By
    */
    int temp[9] = {0, 0, 0, 0, 0, 0, 0, N/Bx, M/By };
    temp[0] = Bx*By;
    temp[0] = (temp[0] << 8 ) - temp[0];


    /*For all blocks in the current frame*/
    for(x=0; x<temp[7]; x++){
        temp[1] = Bx*x;
        for(y=0; y<temp[8]; y++){
            
            //Initialize the vector motion matrices
            vectors_x[x][y] = 0;
            vectors_y[x][y] = 0;

            temp[2] = By*y;  

            //Repeat for s
            S_LOOP(4);
            S_LOOP(2);
            S_LOOP(1);
            }
        }
}

int main(int argc, char *argv[])
{  
    if(argc != 3){
        printf("Usage: ./<compiled_name> <Block_x_size> <Block_y_size>\n");
        exit(0);
    }
    else{
        Bx = atoi(argv[1]);
        By = atoi(argv[2]);
        
        int current[N][M], previous[N][M], motion_vectors_x[N/Bx][M/By],
            motion_vectors_y[N/Bx][M/By], i, j;
        struct timeval start_time, finish_time;

        read_sequence(current,previous);
        gettimeofday(&start_time, NULL);
        phods_motion_estimation(current,previous,motion_vectors_x,motion_vectors_y);
        gettimeofday(&finish_time, NULL);

        //Calculate execution time of phods_motion_estimation()
        printf("%d ", (int)((finish_time.tv_sec - start_time.tv_sec ) *1000000 + finish_time.tv_usec-start_time.tv_usec) );

        return 0;
    }   
}
