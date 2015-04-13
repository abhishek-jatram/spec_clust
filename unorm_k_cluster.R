library(igraph)

S=as.matrix(read.csv("SymmetricMatrix4.csv",header=FALSE))
#S=as.matrix(read.csv("similarity_matrix.csv",header=FALSE))
n=nrow(S)

G=graph.adjacency(S,mode="undirected",)
L=graph.laplacian(G,norm=TRUE)

E=eigen(L, symmetric=TRUE, only.values=FALSE)
U=E$vectors
print("EIGEN VALUES:")
print(E$values)
print("EIGEN VECTORS :")
#print(U)
UR=matrix(0,n,n)
for(i in 1:n){
  UR[,i]=U[,n-i+1]
}
print(UR)
#k can be determined by eigen gap

plot(rev(E$values),type="o",col="blue")
k=2

X=matrix(0,n,k-1)
for(i in 1:ncol(X)){
    X[,i]=UR[,i]
}
print("  X:")
print(X)
cluster=kmeans(X,k)$cluster
V(G)$color=cluster+1
plot(G)