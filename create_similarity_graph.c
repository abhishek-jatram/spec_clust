#include <stdio.h>
#include <math.h>

#define N 50
int main(){
    FILE *fin,*fout;
    fin=fopen("0.edges","r");
    char c=fgetc(fin);
    int i=0,j=0,S[N][N];
    while(i<4){
        c=fgetc(fin);
        if(c=='\n'){
            i++;
        }
    }
    int k=log10(N)+1;
    
    int n=0,n1,a[k],t=0,m=1,e=0;
    for(i=0;i<N*10;i++){
        n=0,m=1,t=0;
        while( (c=fgetc(fin)) !=' '){
            a[t++]=c-48;
            m*=10;
        }
        m/=10;
        for(j=0 ; j<t ; j++){
            n+=a[j]*m;
            m/=10;
            a[j]=0;
        }
        
        n1=n;
        n=0,m=1,t=0;
        while( (c=fgetc(fin)) !='\n'){
            a[t++]=c-48;
            m*=10;
        }
        m/=100;
        for(j=0 ; j<t ; j++){
            n+=a[j]*m;
            m/=10;
            a[j]=0;
//             printf("::%d,%d,%d::",j,m,t);
        }
        
        if(n1<N && n<N){
            printf("%d\t%d\t%d\n",n1,n,e);
            S[n1][n]=1;
            e=0;
        }
        else{
            e++;
            if(e>=N){
	break;
            }
        }
    }
    
    fout=fopen("similarity_matrix.csv","w");
    for(i=0;i<N;i++){
        for(j=0;j<N-1;j++){
            fprintf(fout,"%d,",S[i][j]?1:0);
        }
       
       fprintf(fout,"%d\n",S[i][j]?1:0);
    }
    
    return 0;
}