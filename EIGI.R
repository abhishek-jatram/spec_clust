#EIGEN_VALUES EVALUATION

library(igraph)

#similarity matrix
# S=matrix(0,n,n)
# S[1,]=c(0,1,0,0,0,1,1)
# S[2,]=c(1,0,0,0,0,0,0)
# S[3,]=c(0,0,0,0,1,0,1)
# S[4,]=c(0,0,0,0,1,0,0)
# S[5,]=c(0,0,1,1,0,0,1)
# S[6,]=c(1,0,0,0,0,0,1)
# S[7,]=c(1,0,1,0,1,1,0)

#S=as.matrix(read.csv(file.choose(),header=FALSE))
S=as.matrix(read.csv("SymmetricMatrix.csv",header=FALSE))
n=nrow(S) #nodes

D=matrix(0,n,n)
for(i in 1:n){
    D[i,i]=sum(S[i,])
}
# D[1,1]=sum(S[1,])
# D[2,2]=sum(S[2,])
# D[3,3]=sum(S[3,])
# D[4,4]=sum(S[4,])
# D[5,5]=sum(S[5,])
# D[6,6]=sum(S[6,])
# D[7,7]=sum(S[7,])

L=D-S
print(L)

E=eigen(L,symmetric=T,only.values=F)
EV=E$vectors
#print(E)
print("eigen vector :")
print(EV[,n-1])
c=kmeans(EV[,n-1],2)
#print(c)
cluster=c$cluster
print(1:n)
print(cluster)

g=graph.adjacency(S,mode="undirected")
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
