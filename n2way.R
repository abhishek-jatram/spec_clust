#EIGEN_VALUES EVALUATION

classify = function(v,tresh){
    cluster=0
    for(i in 1:n){
        if(v[i]>tresh){
            cluster[i]=1
        }
        else{
            cluster[i]=2
        }
    }
    return(cluster)
}
library(igraph)


#similarity matrix
#S=matrix(0,n,n)
S=as.matrix(read.csv("SymmetricMatrix.csv",header=FALSE))
n=nrow(S) #nodes
# S[1,]=c(0,1,0,0,0,1,1)
# S[2,]=c(1,0,0,0,0,0,0)
# S[3,]=c(0,0,0,0,1,0,1)
# S[4,]=c(0,0,0,0,1,0,0)
# S[5,]=c(0,0,1,1,0,0,1)
# S[6,]=c(1,0,0,0,0,0,1)
# S[7,]=c(1,0,1,0,1,1,0)

# D=matrix(0,n,n)
# D[1,1]=sum(S[1,])
# D[2,2]=sum(S[2,])
# D[3,3]=sum(S[3,])
# D[4,4]=sum(S[4,])
# D[5,5]=sum(S[5,])
# D[6,6]=sum(S[6,])
# D[7,7]=sum(S[7,])

# L=D-S
# Dd=(D^(-1/2))
# L=Dd%*%L
# L=L%*%Dd
# L[is.nan(L)]=0
g=graph.adjacency(S,mode="undirected")
L=graph.laplacian(g,norm=T)
print(L)

E=eigen(L,symmetric=T,only.values=F)
EV=E$vectors
print("eigne values :")
print(E$values)
#print(E)
print("eigen vector :")
print(EV)
library("ppls")
norm=100*normalize.vector(as.vector(EV[,n-1]))
print("After normalization :")
print(norm)
c=kmeans(EV[,n-1],2)
cluster=c$cluster
#cluster=classify(EV[,n-1],0)
print(1:n)
print(cluster)


V(g)$color=cluster+1
# V(g)[V(g)$type == 1]$shape = "square"
# V(g)[V(g)$type == 0]$shape <- "circle"
plot(g)
nodes=1:n
names(nodes)=cluster

#plot(nodes,cluster,col="red",type="p")
#points(cluster,pch=2,col="blue")
# plot(EV[,n-1])
# abline(h=-0.08)

