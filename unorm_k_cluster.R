library(igraph)

#S=as.matrix(read.csv("SymmetricMatrix4.csv",header=FALSE))
S=as.matrix(read.csv("similarity_matrix.csv",header=FALSE))
n=nrow(S)

G=graph.adjacency(S,mode="undirected",)
L=graph.laplacian(G,norm=TRUE)

E=eigen(L, symmetric=TRUE, only.values=FALSE)
U=E$vectors
print("EIGEN VALUES:")
print(E$values)
print("EIGEN VECTORS :")
print(U)
#k can be determined by eigen gap

plot(rev(E$values),type="o",col="blue")
k=4
Y=matrix(0,k,n)
for(i in 1:n){
    Y[,i]=U[i,(n-k+1):n]
    #Y[n-i+1,]=U[,i]
}
print(Y)
X=matrix(0,n,k)
for(i in 1:k){
    X[,i]=Y[i,]
}
print("  X:")
print(X)
cluster=kmeans(X,k)$cluster
V(G)$color=cluster+1
plot(G)